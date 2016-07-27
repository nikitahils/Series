//
//  SHLinkedStoryboardFadeReplaceSegue.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHLinkedStoryboardFadeReplaceSegue.h"

static const CGFloat SHLinkedStoryboardFadeReplaceSegueAnimationDuration = 0.5f;
static const CGFloat SHLinkedStoryboardFadeReplaceSegueDestinationViewScaleFactor = 0.7f;
static const CGFloat SHLinkedStoryboardFadeReplaceSegueSourceViewScaleFactor = 2.0f;

@implementation SHLinkedStoryboardFadeReplaceSegue

- (UIViewAnimationOptions)animationOptions
{
    return UIViewAnimationOptionTransitionCrossDissolve;
}

- (void)perform
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *sourceView = ((UIViewController *)self.sourceViewController).view;
    UIView *destinationView = ((UIViewController *)self.destinationViewController).view;
    
    [window insertSubview:destinationView belowSubview:sourceView];
    
    destinationView.transform = CGAffineTransformMakeScale(SHLinkedStoryboardFadeReplaceSegueDestinationViewScaleFactor,
                                                           SHLinkedStoryboardFadeReplaceSegueDestinationViewScaleFactor);
    [UIView animateWithDuration:SHLinkedStoryboardFadeReplaceSegueAnimationDuration
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         destinationView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         sourceView.alpha = 0.0f;
                         sourceView.transform = CGAffineTransformMakeScale(SHLinkedStoryboardFadeReplaceSegueSourceViewScaleFactor,
                                                                           SHLinkedStoryboardFadeReplaceSegueSourceViewScaleFactor);
                     } completion:^(BOOL finished) {
                         window.rootViewController = self.destinationViewController;
                     }];
    
}

@end
