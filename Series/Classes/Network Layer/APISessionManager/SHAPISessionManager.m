//
//  SHAPISessionManager.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHAPISessionManager.h"
#import "NSMutableDictionary+NSNull.h"
#import "Serializer.h"
#import "SHJWTTokenStore.h"

static NSString * const SHAPISessionManagerAPIKey = @"3349F1D32F314DE9";
static NSString * const SHAPISessionManagerTokenHTTPHeaderField = @"Authorization";

NSString * const SHAPISessionManagerErrorDomain = @"SHAPISessionManagerErrorDomain";
const NSInteger SHAPISessionManagerErrorSerializedJSONNilValue = 7483;

@interface SHAPISessionManager ()

@property (nonatomic, strong, readwrite) id<Serializer>serverResponseSerializer;
@property (nonatomic, strong, readwrite) id<Serializer>tokenSerializer;

@property (nonatomic, strong) id<TokenStore>tokenStore;

@end

@implementation SHAPISessionManager

#pragma mark - Lifecycle

- (void)dealloc
{
    [self invalidateSessionCancelingTasks:YES];
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL:url]) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        _tokenStore = [SHJWTTokenStore new];
        [self initOrUpdateTokenHeaderValue];
    }
    return self;
}

#pragma mark - APISessionManager protocol

/*
 @return (id)data or nil
 or (NSError *)error during reques/parsing
 */
- (RACSignal *)signalForDataWithHTTPMethod:(HTTPMethodType)method
                                   URLPath:(NSString *)urlPath
                                parameters:(id)parameters
{
    RACSignal *signal = [self signalForSerializedJSONWithHTTPMethod:method
                                                            URLPath:urlPath
                                                         parameters:parameters];
    
    return [[[[signal catch:^(NSError *error) {
        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
        NSInteger statusCode = response.statusCode;
        if (statusCode == 401) {
            return [[[self refreshToken] ignoreValues] concat:signal];
        }
        return [RACSignal error:error];
    }] deliverOn:[RACScheduler scheduler]]
             flattenMap:^RACStream *(id serializedJSON) {
                 return [self signalForDataWithSerializedJSON:serializedJSON];
             }] deliverOnMainThread];
}

/*
 @return (id)data or nil
 or (NSError *)error when can't parse response json from server
 */
- (RACSignal *)signalForDataWithSerializedJSON:(id)serializedJSON
{
    if (serializedJSON) {
        NSError *serializerError;
        id data = [self.serverResponseSerializer serialize:serializedJSON
                                                     error:&serializerError];
        if (serializerError) {
            return [RACSignal error:serializerError];
        } else {
            return [RACSignal return:data];
        }
    } else {
        return [RACSignal error:[NSError errorWithDomain:SHAPISessionManagerErrorDomain
                                                    code:SHAPISessionManagerErrorSerializedJSONNilValue
                                                userInfo:nil]];
    }
}

/*
 @return (id)serializedJSON or nil when http status code is acceptable (2XX)
 or (NSError *)error (unnacceptable http status code, no json in reponse,...)
 */
- (RACSignal *)signalForSerializedJSONWithHTTPMethod:(HTTPMethodType)method
                                             URLPath:(NSString *)urlPath
                                          parameters:(id)parameters
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
                         {
                             void (^success)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id serializedJSON)
                             {
                                 [subscriber sendNext:serializedJSON];
                                 [subscriber sendCompleted];
                             };
                             
                             void (^failure)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, NSError *error)
                             {
                                 [subscriber sendError:error];
                             };
                             
                             
                             NSURLSessionDataTask *task;
                             switch (method) {
                                 case GET:
                                     task = [self GET:urlPath
                                           parameters:parameters
                                              success:success
                                              failure:failure];
                                     break;
                                 case POST:
                                     task = [self POST:urlPath
                                           parameters:parameters
                                              success:success
                                              failure:failure];
                             }
                             
                             return [RACDisposable disposableWithBlock:^{
                                 [task cancel];
                             }];
                         }];
    
    return signal;
}

- (RACSignal *)refreshToken
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters sh_setObject:SHAPISessionManagerAPIKey forKey:@"apikey"];
    [parameters sh_setObject:@"" forKey:@"username"];
    [parameters sh_setObject:@"" forKey:@"userkey"];
    
    return [[self signalForSerializedJSONWithHTTPMethod:POST
                                               URLPath:@"login"
                                             parameters:parameters] doNext:^(id serializedJSON) {

        if (serializedJSON) {
            NSError *serializerError;
            NSString *token = [self.tokenSerializer serialize:serializedJSON
                                                       error:&serializerError];
            self.tokenStore.token = token;
            [self initOrUpdateTokenHeaderValue];
        }
    }];
}

#pragma mark - helper

- (void)initOrUpdateTokenHeaderValue
{
    [self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", self.tokenStore.token]
                  forHTTPHeaderField:SHAPISessionManagerTokenHTTPHeaderField];
}

@end
