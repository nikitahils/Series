//
//  SHAuthAssembly.m
//  Shows
//
//  Created by nikitahils on 21/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHAuthAssembly.h"
#import "SHAuthRouterImplementation.h"
#import "SHAuthViewController.h"
#import "SHStoryboardIdentifiers.h"

@implementation SHAuthAssembly

#pragma mark - Storyboard

- (UIStoryboard *)authStoryboard
{
    return [TyphoonDefinition withClass:[TyphoonStoryboard class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(storyboardWithName:factory:bundle:)
                                parameters:^(TyphoonMethod *initializer)
                 {
                     [initializer injectParameterWith:SHAuthStoryboardName];
                     [initializer injectParameterWith:self];
                     [initializer injectParameterWith:[NSBundle mainBundle]];
                 }];
                definition.scope = TyphoonScopeLazySingleton;
            }];
}

- (UIViewController *)storyboardAuthInitialViewController
{
    return [TyphoonDefinition withFactory:[self authStoryboard]
                                 selector:@selector(instantiateInitialViewController)];
}

#pragma mark - ViewControllers

- (UIViewController *)authViewController
{
    return [TyphoonDefinition withClass:[SHAuthViewController class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHAuthViewController.new, router))
                                      with:[self authRouter]];
            }];
}

#pragma mark - Router

- (id<SHAuthRouter>)authRouter
{
    return [TyphoonDefinition withClass:[SHAuthRouterImplementation class]];
}

@end
