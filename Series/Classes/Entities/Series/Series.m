//
//  Series.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "Series.h"
#import "Constants.h"

NSString * const SeriesModelErrorDomain = @"SeriesModelErrorDomain";

@implementation Series

+ (instancetype)seriesWithIdentifier:(NSNumber *)identifier
{
    Series *series = [Series new];
    series.identifier = identifier;
    return series;
}

#pragma mark - MTLJSONSerializing

+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    static dispatch_once_t onceToken;
    static NSDictionary *mapping;
    dispatch_once(&onceToken, ^{
        mapping = @{
                    @keypath(Series.new, identifier) : @"id",
                    @keypath(Series.new, name)       : @"seriesName",
                     @keypath(Series.new, posterURL) : @"banner",
                     @keypath(Series.new, rating)    : @"siteRating",
                     @keypath(Series.new, overview)  : @"overview"
                     };
    });
    return mapping;
}

+ (NSValueTransformer *)posterURLJSONTransformer {
    return [MTLValueTransformer transformerUsingReversibleBlock:^ id (id value, BOOL *success, NSError **error) {
        if (![value isKindOfClass:[NSString class]]) return nil;
        NSString *path = value;
        NSURL *url = [NSURL URLWithString:SHBannerBasePathURLString];
        if (path.length > 0) {
            return [url URLByAppendingPathComponent:value];
        } else {
            return nil;
        }
    }];
}

@end
