//
//  SHAppAssembly.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHAppAssembly.h"
#import "SHStoryboardPlaceholderViewController.h"
#import "SHStoryboardBuilder.h"

@implementation SHAppAssembly

#pragma mark - Storyboard

- (UIViewController *)storyboardPlaceholder
{
    return [TyphoonDefinition withClass:[SHStoryboardPlaceholderViewController class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition injectProperty:NSSelectorFromString(@keypath(SHStoryboardPlaceholderViewController.new, storyboardBuilder))
                                      with:[self storyboardBuilder]];
            }];
}

- (SHStoryboardBuilder *)storyboardBuilder
{
    return [TyphoonDefinition withClass:[SHStoryboardBuilder class]
                          configuration:^(TyphoonDefinition *definition)
            {
                [definition useInitializer:@selector(initWithFactory:)
                                parameters:^(TyphoonMethod *initializer)
                 {
                     [initializer injectParameterWith:self];
                 }];
            }];
}

@end
