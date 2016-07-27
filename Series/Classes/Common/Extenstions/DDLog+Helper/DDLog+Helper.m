//
//  DDLog+Helper.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "DDLog+Helper.h"

@implementation DDLog (Helper)

+ (void)addLogger:(id<DDLogger>)logger withLevelName:(NSString *)levelName
{
    DDLogLevel level = DDLogLevelFromNSString(levelName);
    [self addLogger:logger withLevel:level];
}

static DDLogLevel DDLogLevelFromNSString(NSString *logLevelString)
{
    static NSDictionary *mapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapping = @{@"DDLogLevelOff"     : @(DDLogLevelOff),
                    @"DDLogLevelError"   : @(DDLogLevelError),
                    @"DDLogLevelDebug"   : @(DDLogLevelDebug),
                    @"DDLogLevelVerbose" : @(DDLogLevelVerbose)};
    });
    
    NSNumber *logLevel = mapping[logLevelString];
    if (logLevel == nil) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Cannot convert %@ string to ddLogLevel number", logLevelString];
    }
    
    return (DDLogLevel)[logLevel unsignedIntegerValue];
}

@end
