//
//  SHBaseAPIService.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHBaseAPIService.h"
#import "APISessionManager.h"
#import "Serializer.h"
#import "NSObject+IsKindOfClassWithError.h"
#import "NSMutableDictionary+NSNull.h"

NSString * const SHBaseAPIServiceErrorDomain = @"SHBaseAPIServiceErrorDomain";
const NSInteger SHBaseAPIServiceInvalidServerResponse = 3243;

@interface SHBaseAPIService ()

@property (nonatomic, strong, readwrite) id<APISessionManager>APISessionManager;

@end

@implementation SHBaseAPIService

#pragma mark - Lifecycle

- (instancetype)initWithAPISessionManager:(id<APISessionManager>)APISessionManager
{
    NSParameterAssert(APISessionManager);
    
    if (self = [super init]) {
        _APISessionManager = APISessionManager;
    }
    return self;
}

#pragma mark - Public

- (RACSignal *)modelObjectWithAPIPath:(NSString *)apiPath
                               method:(HTTPMethodType)method
                           parameters:(id)parameters
                           serializer:(id<Serializer>)serializer
{
    return [[[[self.APISessionManager signalForDataWithHTTPMethod:method
                                                          URLPath:apiPath
                                                       parameters:parameters]
              deliverOn:[RACScheduler scheduler]] flattenMap:^RACStream *(id serverResponseData) {
                 return [self signalForModelObjectWithServerResponseData:serverResponseData
                                                              serializer:serializer];
             }] deliverOnMainThread];
}

- (RACSignal *)listOfModelObjectsWithAPIPath:(NSString *)apiPath
                                      method:(HTTPMethodType)method
                                  parameters:(id)parameters
                                  serializer:(id<Serializer>)serializer
{
    return [[[[self.APISessionManager signalForDataWithHTTPMethod:method
                                                          URLPath:apiPath
                                                       parameters:parameters] deliverOn:[RACScheduler scheduler]]
             flattenMap:^RACStream *(id serverResponseData) {
                 return [self signalForListOfModelObjectWithServerResponseData:serverResponseData
                                                                    serializer:serializer];
             }] deliverOnMainThread];
}

#pragma mark - Private

/*
 @return (id)model object or nil (only when no serilizer passed)
 or (NSError *)error when can't parse server response data
 */
- (RACSignal *)signalForModelObjectWithServerResponseData:(id)serverResponseData
                                               serializer:(id<Serializer>)serializer
{
    if (serializer) {
        if (!serverResponseData) {
            NSError *error = [NSError errorWithDomain:SHBaseAPIServiceErrorDomain
                                                 code:SHBaseAPIServiceInvalidServerResponse
                                             userInfo:nil];
            return [RACSignal error:error];
        } else {
            NSError *serializerError;
            id modelObject = [serializer serialize:serverResponseData
                                             error:&serializerError];
            if (serializerError) {
                return [RACSignal error:serializerError];
            } else {
                return [RACSignal return:modelObject];
            }
        }
    } else {
        return [RACSignal return:nil];
    }
}

/*
 @return array (empty or mapped objects)
 or (NSError *)error when can't parse server response data
 */
- (RACSignal *)signalForListOfModelObjectWithServerResponseData:(id)serverResponseData
                                                     serializer:(id<Serializer>)serializer
{
    if (serializer) {
        NSError *serializerError;
        if ([serverResponseData isKindOfClass:[NSArray class]
                                        error:&serializerError
                                       domain:SHBaseAPIServiceErrorDomain
                                         code:SHBaseAPIServiceInvalidServerResponse]) {
            NSArray *response = serverResponseData;
            NSMutableArray *results = [NSMutableArray new];
            for (id object in response) {
                id modelObject = [serializer serialize:object
                                                 error:&serializerError];
                if (serializerError) {
                    return [RACSignal error:serializerError];
                } else {
                    [results addObject:modelObject];
                }
            }
            return [RACSignal return:results];
        } else {
            if ([serverResponseData isEqual:[NSNull null]]) {
                return [RACSignal return:@[]];
            } else {
                return [RACSignal error:serializerError];
            }
        }
    } else {
        return [RACSignal return:nil];
    }
}

@end
