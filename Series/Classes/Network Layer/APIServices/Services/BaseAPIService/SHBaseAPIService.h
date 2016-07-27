//
//  SHBaseAPIService.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "HTTPMethodType.h"

@import Foundation;

extern NSString * const SHBaseAPIServiceErrorDomain;
extern const NSInteger SHBaseAPIServiceInvalidServerResponse;

@class RACSignal;
@protocol APISessionManager, Serializer;

@interface SHBaseAPIService : NSObject

@property (nonatomic, strong, readonly) id<APISessionManager>APISessionManager;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAPISessionManager:(id<APISessionManager>)APISessionManager NS_DESIGNATED_INITIALIZER;

/*
 @return (id)model object or nil (only when no serilizer passed)
 or (NSError *)error when can't parse server response data
 */
- (RACSignal *)modelObjectWithAPIPath:(NSString *)apiPath
                               method:(HTTPMethodType)method
                           parameters:(id)parameters
                           serializer:(id<Serializer>)serializer;

/*
 @return array (empty or mapped objects)
 or (NSError *)error when can't parse server response data
 */
- (RACSignal *)listOfModelObjectsWithAPIPath:(NSString *)apiPath
                                      method:(HTTPMethodType)method
                                  parameters:(id)parameters
                                  serializer:(id<Serializer>)serializer;

@end
