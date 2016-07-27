//
//  SHJWTTokenStore.m
//  Shows
//
//  Created by iam on 22/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHJWTTokenStore.h"

@import FXKeychain;

static NSString * const SHJWTTokenStoreKey = @"SHJWTTokenStoreKey";

static dispatch_queue_t token_sync_queue() {
    static dispatch_queue_t token_sync_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        token_sync_queue = dispatch_queue_create("com.token.sync", DISPATCH_QUEUE_SERIAL);
    });
    return token_sync_queue;
}

@implementation SHJWTTokenStore {
    NSString *_jwtToken;
}

#pragma mark - acessors

- (NSString *)token
{
    __block NSString *token;
    dispatch_sync(token_sync_queue(), ^{
        if (!_jwtToken) {
            _jwtToken = [[FXKeychain defaultKeychain] objectForKey:SHJWTTokenStoreKey];
        }
        token = _jwtToken;
    });
    return token;
}

- (void)setToken:(NSString *)token
{
    dispatch_async(token_sync_queue(), ^{
        DDLogWarn(@"token updated: %@", token);
        [[FXKeychain defaultKeychain] setObject:token forKey:SHJWTTokenStoreKey];
        _jwtToken = token;
    });
}

@end
