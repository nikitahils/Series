//
//  SHAPISessionManager.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import AFNetworking;

#import "APISessionManager.h"

@protocol Serializer, TokenStore;

@interface SHAPISessionManager : AFHTTPSessionManager <APISessionManager>

@property (nonatomic, strong, readonly) id<Serializer>serverResponseSerializer;
@property (nonatomic, strong, readonly) id<Serializer>tokenSerializer;

@end