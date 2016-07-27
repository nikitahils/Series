//
//  SHUpdatesAPIService.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHUpdatesAPIService.h"
#import "NSMutableDictionary+NSNull.h"

@interface SHUpdatesAPIService ()

@property(nonatomic, strong, readwrite) id<Serializer>seriesSerializer;

@end

@implementation SHUpdatesAPIService

- (RACSignal *)updatesWithFromTime:(NSDate *)fromTime
                            toTime:(NSDate *)toTime
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters sh_setObject:@(ceil([fromTime timeIntervalSince1970]))  forKey:@"fromTime"];
    if (toTime) {
        [parameters sh_setObject:@([toTime timeIntervalSince1970]) forKey:@"toTime"];
    }
    return [self listOfModelObjectsWithAPIPath:@"updated/query"
                                        method:GET
                                    parameters:parameters
                                    serializer:self.seriesSerializer];
}

@end
