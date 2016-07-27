//
//  SHActorSerializer.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHActorSerializer.h"
#import "NSObject+IsKindOfClassWithError.h"
#import "Actor.h"

@import Mantle;

NSString * const SHActorSerializerErrorDomain = @"SHActorSerializerErrorDomain";
const NSInteger SHActorSerializerInvalidObject = 2400;

@implementation SHActorSerializer

- (id)serialize:(id)object
          error:(NSError **)error
{
    Actor *actor;
    if ([object isKindOfClass:[NSDictionary class]
                        error:error
                       domain:SHActorSerializerErrorDomain
                         code:SHActorSerializerInvalidObject]) {
        actor = [MTLJSONAdapter modelOfClass:[Actor class]
                          fromJSONDictionary:object
                                       error:error];
    }
    return actor;
}

@end
