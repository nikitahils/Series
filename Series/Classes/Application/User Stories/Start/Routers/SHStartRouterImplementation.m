//
//  SHStartRouterImplementation.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHStartRouterImplementation.h"
#import "SHStoryboardIdentifiers.h"
#import "UIViewController+Routing.h"

@implementation SHStartRouterImplementation

- (void)showAuthViewControllerFromSourceController:(UIViewController *)sourceController
{
    [sourceController performSegueWithIdentifier:SH_Auth
                                          sender:self
                                preparationBlock:nil];
}

- (void)showSeriesViewControllerFromSourceController:(UIViewController *)sourceController
{
    [sourceController performSegueWithIdentifier:SH_Series
                                          sender:self
                                preparationBlock:nil];
}

@end
