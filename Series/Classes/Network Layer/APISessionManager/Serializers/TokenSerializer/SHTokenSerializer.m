//
//  SHTokenSerializer.m
//  Shows
//
//  Created by iam on 22/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHTokenSerializer.h"
#import "NSObject+IsKindOfClassWithError.h"
#import "Actor.h"

@import Mantle;

NSString * const SHTokenSerializerErrorDomain = @"SHTokenSerializerErrorDomain";
const NSInteger SHTokenSerializerInvalidObject = 2400;

@implementation SHTokenSerializer

- (id)serialize:(id)object
          error:(NSError **)error
{
    NSString *token;
    if ([object isKindOfClass:[NSDictionary class]
                        error:error
                       domain:SHTokenSerializerErrorDomain
                         code:SHTokenSerializerInvalidObject]) {
        token = object[@"token"];
        if (![token isKindOfClass:[NSString class]
                            error:error
                           domain:SHTokenSerializerErrorDomain
                             code:SHTokenSerializerInvalidObject]) {
            DDLogError(@"Invalid JWT value");
        }
    }
    return token;
}

@end
