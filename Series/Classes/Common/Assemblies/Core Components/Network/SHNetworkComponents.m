//
//  SHNetworkComponents.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHNetworkComponents.h"
#import "SHAPISessionManager.h"
#import "SHSerializingComponents.h"
#import "SHBaseAPIService.h"
#import "SHSeriesAPIService.h"
#import "SHUpdatesAPIService.h"
#import "SHJWTTokenStore.h"

static NSString * const SHNetworkConfigurationFileName = @"NetworkConfiguration.plist";
static NSString * const SHProductionServerURLKey       = @"server.production.url";

@interface SHNetworkComponents ()

@property (nonatomic, strong) SHSerializingComponents *serializingComponents;

@end

@implementation SHNetworkComponents

- (id<APISessionManager>)apiSessionManager
{
    return [TyphoonDefinition withClass:[SHAPISessionManager class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(initWithBaseURL:) parameters:^(TyphoonMethod *initializer) {
                    [initializer injectParameterWith:TyphoonConfig(SHProductionServerURLKey)];
                }];
                [definition injectProperty:NSSelectorFromString(@keypath(SHAPISessionManager.new, serverResponseSerializer))
                                      with:[self.serializingComponents serverResponseSerializer]];
                [definition injectProperty:NSSelectorFromString(@keypath(SHAPISessionManager.new, tokenSerializer))
                                      with:[self.serializingComponents tokenSerializer]];
                definition.scope = TyphoonScopeSingleton;
            }];
}

#pragma mark - Services

- (SHBaseAPIService *)baseAPIService
{
    return [TyphoonDefinition withClass:[SHBaseAPIService class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHBaseAPIService.new, APISessionManager))
                                      with:[self apiSessionManager]];
            }];
}

- (SHUpdatesAPIService *)updatesAPIService
{
    return [TyphoonDefinition withClass:[SHUpdatesAPIService class]
                          configuration:^(TyphoonDefinition *definition)
            {
                definition.parent = [self baseAPIService];
                [definition injectProperty:NSSelectorFromString(@keypath(SHUpdatesAPIService.new, seriesSerializer))
                                      with:[self.serializingComponents seriesSerializer]];
                definition.scope = TyphoonScopeLazySingleton;
            }];
}

- (SHSeriesAPIService *)seriesAPIService
{
    return [TyphoonDefinition withClass:[SHSeriesAPIService class]
                          configuration:^(TyphoonDefinition *definition)
            {
                definition.parent = [self baseAPIService];
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesAPIService.new, seriesSerializer))
                                      with:[self.serializingComponents seriesSerializer]];
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesAPIService.new, actorSerializer))
                                      with:[self.serializingComponents actorSerializer]];
                definition.scope = TyphoonScopeLazySingleton;
            }];
}

#pragma mark - Configuration

- (id)configurer
{
    return [TyphoonDefinition
            withConfigName:SHNetworkConfigurationFileName];
}

@end
