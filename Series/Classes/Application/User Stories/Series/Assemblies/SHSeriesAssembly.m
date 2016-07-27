//
//  SHSeriesAssembly.m
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHSeriesAssembly.h"
#import "SHSeriesRouterImplementation.h"
#import "SHUpdatesViewController.h"
#import "SHFavoritesViewController.h"
#import "SHSeriesDetailsViewController.h"
#import "SHStoryboardIdentifiers.h"
#import "SHSeriesUpdatesViewModel.h"
#import "SHSeriesDetailsViewModel.h"
#import "SHNetworkComponents.h"

@interface SHSeriesAssembly ()

@property (nonatomic, strong) SHNetworkComponents *networkComponents;

@end

@implementation SHSeriesAssembly

#pragma mark - Storyboard

- (UIStoryboard *)seriesStoryboard
{
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                parameters:^(TyphoonMethod *initializer)
                 {
                     [initializer injectParameterWith:SHSeriesStoryboardName];
                     [initializer injectParameterWith:self];
                     [initializer injectParameterWith:[NSBundle mainBundle]];
                 }];
                definition.scope = TyphoonScopeLazySingleton;
            }];
}

- (UIViewController *)storyboardSeriesInitialViewController
{
    return [TyphoonDefinition withFactory:[self seriesStoryboard]
                                 selector:@selector(instantiateInitialViewController)];
}

- (UIViewController *)storyboardSeriesDetailsViewControllerWithModel:(SHSeriesDetailsViewModel *)model
{
    return [TyphoonDefinition withFactory:[self seriesStoryboard]
                                 selector:@selector(instantiateViewControllerWithIdentifier:)
                               parameters:^(TyphoonMethod *factoryMethod) {
                                   [factoryMethod injectParameterWith:SHSeriesDetailsViewControllerIdentifier];
                               } configuration:^(TyphoonFactoryDefinition *definition) {
                                   [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesDetailsViewController.new, seriesDetailsViewModel))
                                                         with:model];
                               }];
}

#pragma mark - ViewControllers

- (UIViewController *)seriesDetailsViewControllerWithModel:(SHSeriesDetailsViewModel *)model
{
    return [TyphoonDefinition withClass:[SHSeriesDetailsViewController class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesDetailsViewController.new, router))
                                      with:[self seriesRouter]];
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesDetailsViewController.new, seriesDetailsViewModel))
                                      with:model];
            }];
}

- (UIViewController *)updatesViewController
{
    return [TyphoonDefinition withClass:[SHUpdatesViewController class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHUpdatesViewController.new, router))
                                      with:[self seriesRouter]];
                [definition injectProperty:NSSelectorFromString(@keypath(SHUpdatesViewController.new, seriesUpdatesViewModel))
                                      with:[self seriesUpdatesViewModel]];
            }];
}

- (UIViewController *)favoritesViewController
{
    return [TyphoonDefinition withClass:[SHFavoritesViewController class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHFavoritesViewController.new, router))
                                      with:[self seriesRouter]];
            }];
}


#pragma mark - model

- (SHSeriesUpdatesViewModel *)seriesUpdatesViewModel
{
    return [TyphoonDefinition withClass:[SHSeriesUpdatesViewModel class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesUpdatesViewModel.new, updatesAPIService))
                                      with:[self.networkComponents updatesAPIService]];
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesUpdatesViewModel.new, seriesAPIService))
                                      with:[self.networkComponents seriesAPIService]];
            }];
}

#pragma mark - Router

- (id<SHSeriesRouter>)seriesRouter
{
    return [TyphoonDefinition withClass:[SHSeriesRouterImplementation class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHSeriesRouterImplementation.new, assembly))
                                      with:self];
            }];
}

@end
