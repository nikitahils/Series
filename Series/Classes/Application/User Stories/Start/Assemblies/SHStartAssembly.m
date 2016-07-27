//
//  SHStartAssembly.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHStartAssembly.h"
#import "SHStartRouterImplementation.h"
#import "SHStoryboardIdentifiers.h"
#import "SHStartViewController.h"

@implementation SHStartAssembly

#pragma mark - Storyboard

- (UIStoryboard *)startStoryboard
{
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                parameters:^(TyphoonMethod *initializer)
                 {
                     [initializer injectParameterWith:SHStartStoryboardName];
                     [initializer injectParameterWith:self];
                     [initializer injectParameterWith:[NSBundle mainBundle]];
                 }];
                definition.scope = TyphoonScopeLazySingleton;
            }];
}

- (UIViewController *)storyboardStartInitialViewController
{
    return [TyphoonDefinition withFactory:[self startStoryboard]
                                 selector:@selector(instantiateInitialViewController)];
}

#pragma mark - ViewControllers

- (UIViewController *)startViewController
{
    return [TyphoonDefinition withClass:[SHStartViewController class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHStartViewController.new, router))
                                      with:[self startRouter]];
            }];
}

#pragma mark - Router

- (id<SHStartRouter>)startRouter
{
    return [TyphoonDefinition withClass:[SHStartRouterImplementation class]];
}

@end
