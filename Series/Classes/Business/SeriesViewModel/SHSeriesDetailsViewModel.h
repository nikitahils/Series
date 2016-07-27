//
//  SHSeriesDetailsViewModel.h
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@class SHSeriesAPIService, Actor, Series;

@interface SHSeriesDetailsViewModel : NSObject

@property (nonatomic, strong, readonly) Series *series;
@property (nonatomic, copy, readonly) NSArray<Actor*> *actors;

@property (nonatomic, strong, readonly) SHSeriesAPIService *seriesAPIService;

@property (nonatomic, assign, readonly) BOOL isFetching;
@property (nonatomic, assign, readonly) BOOL fetched;

- (void)fetch;
- (void)stop;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSeriesIdentifier:(NSNumber *)identifier
                       seriesAPISerivice:(SHSeriesAPIService *)seriesAPIService NS_DESIGNATED_INITIALIZER;

@end
