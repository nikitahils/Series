//
//  SHSeriesSerializer.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHSeriesSerializer.h"
#import "NSObject+IsKindOfClassWithError.h"
#import "Series.h"

@import Mantle;

NSString * const SHSeriesSerializerErrorDomain = @"SHSeriesSerializerErrorDomain";
const NSInteger SHSeriesSerializerInvalidObject = 2400;

@implementation SHSeriesSerializer

- (id)serialize:(id)object
          error:(NSError **)error
{
    Series *series;
    if ([object isKindOfClass:[NSDictionary class]
                        error:error
                       domain:SHSeriesSerializerErrorDomain
                         code:SHSeriesSerializerInvalidObject]) {
        series = [MTLJSONAdapter modelOfClass:[Series class]
                         fromJSONDictionary:object
                                      error:error];
    }
    return series;
}

@end
