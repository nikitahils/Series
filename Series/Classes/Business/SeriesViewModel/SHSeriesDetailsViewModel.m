//
//  SHSeriesDetailsViewModel.m
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHSeriesDetailsViewModel.h"
#import "SHSeriesAPIService.h"
#import "Series.h"
#import "Actor.h"

#import "SHNetworkComponents.h"

@import Typhoon.TyphoonAutoInjection;

@interface SHSeriesDetailsViewModel ()

@property (nonatomic, strong, readwrite) Series *series;
@property (nonatomic, copy, readwrite) NSArray<Actor*> *actors;

@property (nonatomic, assign, readwrite) BOOL isFetching;
@property (nonatomic, assign, readwrite) BOOL fetched;

@property (nonatomic, strong, readwrite) SHSeriesAPIService *seriesAPIService;

@property (nonatomic, strong) RACSignal *stopSignal;
@property (nonatomic, strong) NSNumber *identifier;

@end

@implementation SHSeriesDetailsViewModel

- (instancetype)initWithSeriesIdentifier:(NSNumber *)identifier
                       seriesAPISerivice:(SHSeriesAPIService *)seriesAPIService
{
    if (self = [super init]) {
        _seriesAPIService = seriesAPIService;
        _identifier = identifier;
        _isFetching = NO;
        _fetched = NO;
        _series = [Series seriesWithIdentifier:identifier];
        _stopSignal = [self rac_signalForSelector:@selector(stop)];
    }
    return self;
}

- (void)fetch
{
    @weakify(self);
    if (!self.isFetching && !self.fetched) {
        RACSignal *seriesDetailsSignal = [self.seriesAPIService seriesWithIdentifier:self.identifier];
        RACSignal *seriesActorsSignal = [self.seriesAPIService actorsWithSeriesIdentifier:self.identifier];
        RACSignal *combined = [RACSignal
                               zip:@[seriesDetailsSignal, seriesActorsSignal]
                               reduce:^(Series *series, NSArray *actors) {
                                   series.actors = actors;
                                   return series;
                               }];
           [[[[combined takeUntil: self.stopSignal]
           initially:^{
               @strongify(self);
               self.isFetching = YES;
           }] finally:^{
               @strongify(self);
               self.isFetching = NO;
           }]
         subscribeNext:^(Series *series) {
             @strongify(self);
             self.series = series;
             self.fetched = YES;
         } error:^(NSError *error) {
         }];
    }
}

- (void)stop
{

}

@end
