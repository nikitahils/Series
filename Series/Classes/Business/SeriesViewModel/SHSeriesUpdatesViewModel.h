//
//  SHSeriesUpdatesViewModel.h
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@class SHUpdatesAPIService, SHSeriesDetailsViewModel, SHSeriesAPIService;

@interface SHSeriesUpdatesViewModel : NSObject

@property (nonatomic, assign, readonly) BOOL isFetching;
@property (nonatomic, assign, readonly) BOOL fetched;

@property (nonatomic, strong, readonly) NSArray<SHSeriesDetailsViewModel*> *seriesDetailsViewModels;
@property (nonatomic, strong, readonly) SHUpdatesAPIService *updatesAPIService;
@property (nonatomic, strong, readonly) SHSeriesAPIService *seriesAPIService;

- (void)fetch;
- (void)stop;

@end
