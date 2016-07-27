//
//  SHUpdatesAPIService.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHBaseAPIService.h"

@protocol Serializer;

@interface SHUpdatesAPIService : SHBaseAPIService

@property(nonatomic, strong, readonly) id<Serializer>seriesSerializer;

- (RACSignal *)updatesWithFromTime:(NSDate *)fromTime
                            toTime:(NSDate *)toTime;

@end
