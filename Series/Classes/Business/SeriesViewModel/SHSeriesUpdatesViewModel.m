//
//  SHSeriesUpdatesViewModel.m
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHSeriesUpdatesViewModel.h"
#import "SHSeriesDetailsViewModel.h"
#import "SHUpdatesAPIService.h"
#import "Series.h"
#import "NSDate+Helper.h"

@interface SHSeriesUpdatesViewModel ()

@property (nonatomic, assign, readwrite) BOOL isFetching;
@property (nonatomic, assign, readwrite) BOOL fetched;
@property (nonatomic, strong, readwrite) NSArray<SHSeriesDetailsViewModel*> *seriesDetailsViewModels;
@property (nonatomic, strong, readwrite) SHUpdatesAPIService *updatesAPIService;
@property (nonatomic, strong, readwrite) SHSeriesAPIService *seriesAPIService;
@property (nonatomic, strong) RACSignal *stopSignal;

@end

@implementation SHSeriesUpdatesViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isFetching = NO;
        _fetched = NO;
        _stopSignal = [self rac_signalForSelector:@selector(stop)];
    }
    return self;
}

- (void)fetch
{
    @weakify(self);
    if (!self.isFetching && !self.fetched) {
        [[[[[self.updatesAPIService updatesWithFromTime:[NSDate dayAgo]
                                                 toTime:nil] takeUntil: self.stopSignal]
           initially:^{
               @strongify(self);
               self.isFetching = YES;
           }] finally:^{
               @strongify(self);
               self.isFetching = NO;
           }]
         subscribeNext:^(NSArray<Series*> *seriesArray) {
             @strongify(self);
             NSMutableArray *viewModels = [NSMutableArray array];
             for (Series *series in seriesArray) {
                 SHSeriesDetailsViewModel *model = [[SHSeriesDetailsViewModel alloc] initWithSeriesIdentifier:series.identifier seriesAPISerivice:self.seriesAPIService];
                 [viewModels addObject:model];
             }
             self.isFetching = NO;
             self.seriesDetailsViewModels = [viewModels copy];
             self.fetched = YES;
         }];
    }
}

- (void)stop
{
    //
}

@end
