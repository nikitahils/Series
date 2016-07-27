//
//  SHSerializingComponents.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Typhoon;

@protocol Serializer;

@interface SHSerializingComponents : TyphoonAssembly

- (id<Serializer>)serverResponseSerializer;
- (id<Serializer>)tokenSerializer;

- (id<Serializer>)seriesSerializer;
- (id<Serializer>)actorSerializer;

@end
