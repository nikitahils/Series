//
//  NSObject+IsKindOfClassWithError.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "NSObject+IsKindOfClassWithError.h"
#import "NSMutableDictionary+NSNull.h"

@implementation NSObject (IsKindOfClassWithError)

- (BOOL)isKindOfClass:(Class)aClass
                error:(NSError **)error
               domain:(NSString *)domain
                 code:(NSInteger)code
{
    if ([self isKindOfClass:aClass]) {
        return YES;
    } else {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        NSString *description = [NSString stringWithFormat:@"Incorrect object class type: %@", [self class]];
        userInfo[NSLocalizedDescriptionKey] = description;
        *error = [NSError errorWithDomain:domain
                                     code:code
                                 userInfo:userInfo];
        return NO;
    }
}
@end
