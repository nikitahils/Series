//
//  NSMutableDictionary+NSNull.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "NSMutableDictionary+NSNull.h"

@implementation NSMutableDictionary (NSNull)

- (void)sh_setObject:(id)object forKey:(id<NSCopying>)key
{
    if (object != nil) {
        [self setObject:object forKey:key];
    } else {
        [self setObject:[NSNull null] forKey:key];
    }
}

@end
