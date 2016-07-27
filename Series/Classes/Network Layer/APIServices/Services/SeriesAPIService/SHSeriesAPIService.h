//
//  SHSeriesAPIService.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHBaseAPIService.h"

@protocol Serializer;

@interface SHSeriesAPIService : SHBaseAPIService

@property(nonatomic, strong, readonly) id<Serializer>seriesSerializer;
@property(nonatomic, strong, readonly) id<Serializer>actorSerializer;

- (RACSignal *)seriesWithIdentifier:(NSNumber *)identifier;
- (RACSignal *)actorsWithSeriesIdentifier:(NSNumber *)identifier;

@end
