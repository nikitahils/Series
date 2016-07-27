//
//  SHLinkedStoryboardBaseSegue.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHLinkedStoryboardBaseSegue.h"
#import "SHStoryboardPlaceholderViewController.h"
#import "SHStoryboardBuilder.h"

static NSString * const SHLinkedStoryboardBaseSegueSeparator = @"_";

@implementation SHLinkedStoryboardBaseSegue

+ (UIViewController *)sceneNamed:(NSString *)identifier
           withStoryboardBuilder:(SHStoryboardBuilder *)storyboardBuilder
{
    NSArray *info = [identifier componentsSeparatedByString:SHLinkedStoryboardBaseSegueSeparator];
    
    NSString *sceneName = info[0];
    NSString *storyboardName = info[1];
    
    UIStoryboard *storyboard = [storyboardBuilder storyboardWithName:storyboardName];
    UIViewController *scene = nil;
    
    if (sceneName.length == 0) {
        scene = [storyboard instantiateInitialViewController];
    }
    else {
        scene = [storyboard instantiateViewControllerWithIdentifier:sceneName];
    }
    
    return scene;
}

- (id)initWithIdentifier:(NSString *)identifier
                  source:(UIViewController *)source
             destination:(UIViewController *)destination
{
    SHStoryboardPlaceholderViewController *placeholderViewController = (SHStoryboardPlaceholderViewController *)destination;
    return [super initWithIdentifier:identifier
                              source:source
                         destination:[[self class] sceneNamed:identifier
                                        withStoryboardBuilder:placeholderViewController.storyboardBuilder]];
}

- (void)perform
{
    DDLogDebug(@"%@.m file: You must override '%@' method in a subclass", [self class], NSStringFromSelector(_cmd));
}

@end
