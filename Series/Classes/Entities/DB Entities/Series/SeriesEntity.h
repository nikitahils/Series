//
//  SeriesEntity.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Realm;

@class Series;

@interface SeriesEntity : RLMObject

@property NSNumber<RLMInt> *identifier;
@property NSString *name;
@property NSString *overview;
@property NSString *posterURLString;

+ (SeriesEntity *)entityWithSeriesModel:(Series *)series;
- (Series *)buildModel;

@end

RLM_ARRAY_TYPE(SeriesEntity)