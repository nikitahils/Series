//
//  User.m
//  Shows
//
//  Created by iam on 23/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic, strong, readwrite) NSNumber *identifier;

@end

@implementation User

+ (instancetype)userWithIdentifier:(NSNumber *)identifier
{
    User *user = [User new];
    user.identifier = identifier;
    return user;
}

#pragma mark - MTLJSONSerializing

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    static dispatch_once_t onceToken;
    static NSDictionary *mapping;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @keypath(User.new, identifier) : @"id",
                     };
    });
    return mapping;
}

@end
