//
//  SHBaseRouter.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHBaseRouter.h"

@interface SHBaseRouter ()

@end

@implementation SHBaseRouter

#pragma mark - prepareForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *sourceViewController = segue.sourceViewController;
    SHPreparationBlock block = [sourceViewController preparationBlockForSegue:segue];
    
    if (block) {
        block(segue);
    }
}

#pragma mark - Dismissing View Controller

- (void)dismissCurrentViewController:(UIViewController *)viewController
                            animated:(BOOL)animated
{
    if (viewController.presentingViewController) {
        [viewController dismissViewControllerAnimated:animated
                                           completion:nil];
    } else {
        [viewController.navigationController popViewControllerAnimated:animated];
    }
}

@end