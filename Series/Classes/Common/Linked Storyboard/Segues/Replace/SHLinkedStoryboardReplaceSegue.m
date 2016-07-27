//
//  SHLinkedStoryboardReplaceSegue.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//


#import "SHLinkedStoryboardReplaceSegue.h"

static const CGFloat SHLinkedStoryboardReplaceSegueAnimationDuration = 0.4f;

@implementation SHLinkedStoryboardReplaceSegue

- (UIViewAnimationOptions)animationOptions
{
    return UIViewAnimationOptionTransitionCrossDissolve;
}

- (void)perform
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *sourceView = ((UIViewController *)self.sourceViewController).view;
    UIView *destinationView = ((UIViewController *)self.destinationViewController).view;
    
    window.rootViewController = self.destinationViewController;
    [window addSubview:sourceView];
    
    [UIView transitionFromView:sourceView
                        toView:destinationView
                      duration:SHLinkedStoryboardReplaceSegueAnimationDuration
                       options:self.animationOptions
                    completion:nil];
}

@end
