//
//  SHSerializingComponents.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//
#import "SHSerializingComponents.h"
#import "SHServerResponseSerializer.h"
#import "SHActorSerializer.h"
#import "SHTokenSerializer.h"
#import "SHSeriesSerializer.h"

@implementation SHSerializingComponents

- (id<Serializer>)serverResponseSerializer
{
    return [TyphoonDefinition withClass:[SHServerResponseSerializer class]];
}

- (id<Serializer>)seriesSerializer
{
    return [TyphoonDefinition withClass:[SHSeriesSerializer class]];
}

- (id<Serializer>)actorSerializer
{
    return [TyphoonDefinition withClass:[SHActorSerializer class]];
}

- (id<Serializer>)tokenSerializer
{
    return [TyphoonDefinition withClass:[SHTokenSerializer class]];
}

@end
