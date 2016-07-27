//
//  UserEntity.m
//  Shows
//
//  Created by iam on 23/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "UserEntity.h"

@interface UserEntity ()

@end

@implementation UserEntity

+ (NSString *)primaryKey
{
    return @keypath(UserEntity.new, identifier);
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@keypath(UserEntity.new, isLogged) : @NO};
}

@end
