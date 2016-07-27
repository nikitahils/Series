//
//  NSDate+Helper.m
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "NSDate+Helper.h"

@import DateTools;

@implementation NSDate (Helper)

+ (NSDate*)dayAgo
{
    return [[NSDate date] dateBySubtractingDays:1];
}

@end
