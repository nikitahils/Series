//
//  SeriesEntity.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SeriesEntity.h"
#import "Series.h"

@implementation SeriesEntity

+ (NSString *)primaryKey
{
    return @keypath(SeriesEntity.new, identifier);
}

+ (SeriesEntity *)entityWithSeriesModel:(Series *)series
{
    SeriesEntity *entity = [SeriesEntity new];
    entity.identifier = series.identifier;
    entity.overview = series.overview;
    entity.name = series.name;
    entity.posterURLString = series.posterURL.absoluteString;
    return entity;
}

- (Series *)buildModel
{
    Series *series = [Series seriesWithIdentifier:self.identifier];
    series.name = self.name;
    series.overview = self.overview;
    series.posterURL = [NSURL URLWithString:self.posterURLString];
    return series;
}

@end
