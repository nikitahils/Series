//
//  SHSeriesAPIService.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHSeriesAPIService.h"
#import "NSMutableDictionary+NSNull.h"

@interface SHSeriesAPIService ()

@property(nonatomic, strong, readwrite) id<Serializer>seriesSerializer;
@property(nonatomic, strong, readwrite) id<Serializer>actorSerializer;

@end

@implementation SHSeriesAPIService

- (RACSignal *)seriesWithIdentifier:(NSNumber *)identifier
{
    NSString *path = [NSString stringWithFormat:@"series/%zd", identifier.integerValue];
    return [self modelObjectWithAPIPath:path
                                 method:GET
                             parameters:nil
                             serializer:self.seriesSerializer];
}

- (RACSignal *)actorsWithSeriesIdentifier:(NSNumber *)identifier
{
    NSString *path = [NSString stringWithFormat:@"series/%zd/actors", identifier.integerValue];
    return [self listOfModelObjectsWithAPIPath:path
                                        method:GET
                                    parameters:nil
                                    serializer:self.actorSerializer];
}

@end
