//
//  SHAuthRouterImplementation.m
//  Shows
//
//  Created by nikitahils on 21/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHAuthRouterImplementation.h"
#import "SHStoryboardIdentifiers.h"
#import "UIViewController+Routing.h"

@implementation SHAuthRouterImplementation

- (void)showSeriesViewControllerFromSourceController:(UIViewController *)sourceController
{
    [sourceController performSegueWithIdentifier:SH_Series
                                          sender:self
                                preparationBlock:nil];
}

@end