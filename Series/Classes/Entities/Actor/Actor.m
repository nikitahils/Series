//
//  Actor.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "Actor.h"
#import "Constants.h"

NSString * const ActorModelErrorDomain = @"ActorModelErrorDomain";

@implementation Actor

#pragma mark - MTLJSONSerializing

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    static dispatch_once_t onceToken;
    static NSDictionary *mapping;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @keypath(Actor.new, identifier)       : @"id",
                    @keypath(Actor.new, seriesIdentifier) : @"seriesIdentifier",
                     @keypath(Actor.new, name)            : @"name",
                     @keypath(Actor.new, role)            : @"role",
                     @keypath(Actor.new, imageURL)        : @"image",
                     };
    });
    return mapping;
}

+ (NSValueTransformer *)imageURLJSONTransformer {
    return [MTLValueTransformer transformerUsingReversibleBlock:^ id (id value, BOOL *success, NSError **error) {
        if (![value isKindOfClass:[NSString class]]) return nil;
        NSString *path = value;
        NSURL *url = [NSURL URLWithString:SHBannerBasePathURLString];
        if (path.length > 0) {
            return [url URLByAppendingPathComponent:value];
        } else {
            return nil;
        }
    }];
}

@end
