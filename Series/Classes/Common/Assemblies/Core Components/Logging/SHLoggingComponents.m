//
//  SHLoggingComponents.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHLoggingComponents.h"
#import "DDLog+Helper.h"

static NSString * const SHLoggingConfigurationFileName = @"LoggingConfiguration.plist";
static NSString * const SHLoggingColorKey              = @"logging.colors";
static NSString * const SHLoggingRollingFrequencyKey   = @"logging.rollingFrequency";
static NSString * const SHLoggingLevelKey              = @"logging.level";

@implementation SHLoggingComponents

#pragma mark - Logger

- (DDLog *)logger
{
    return [TyphoonDefinition withClass:[DDLog class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(class)];
                
                [definition injectMethod:@selector(addLogger:withLevelName:)
                              parameters:^(TyphoonMethod *method)
                 {
                     [method injectParameterWith:[self ttyLogger]];
                     [method injectParameterWith:TyphoonConfig(SHLoggingLevelKey)];
                 }];
                
                [definition injectMethod:@selector(addLogger:withLevelName:)
                              parameters:^(TyphoonMethod *method)
                 {
                     [method injectParameterWith:[self fileLogger]];
                     [method injectParameterWith:TyphoonConfig(SHLoggingLevelKey)];
                 }];
                
                definition.scope = TyphoonScopeSingleton;
            }];
}

- (id<DDLogger>)ttyLogger
{
    return [TyphoonDefinition withClass:[DDTTYLogger class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(sharedInstance)];
                [definition injectProperty:NSSelectorFromString(@keypath(DDTTYLogger.new, colorsEnabled))
                                      with:TyphoonConfig(SHLoggingColorKey)];
            }];
}

- (id <DDLogger>)fileLogger
{
    return [TyphoonDefinition withClass:[DDFileLogger class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(init)];
                [definition injectProperty:NSSelectorFromString(@keypath(DDFileLogger.new, rollingFrequency))
                                      with:TyphoonConfig(SHLoggingRollingFrequencyKey)];
            }];
}

#pragma mark - Configuration

- (id)configurer
{
    return [TyphoonDefinition
            withConfigName:SHLoggingConfigurationFileName];
}

@end
