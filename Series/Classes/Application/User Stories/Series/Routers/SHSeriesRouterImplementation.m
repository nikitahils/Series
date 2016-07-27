//
//  SHSeriesRouterImplementation.m
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHSeriesRouterImplementation.h"
#import "SHStoryboardIdentifiers.h"
#import "SHSeriesAssembly.h"
#import "SHSeriesDetailsViewController.h"

@class SHSeriesRouterImplementation;

@interface SHSeriesRouterImplementation ()

@end

@implementation SHSeriesRouterImplementation

- (void)showAuthViewControllerFromSourceController:(UIViewController *)sourceController
{
    [sourceController performSegueWithIdentifier:SH_Auth
                                          sender:self
                                preparationBlock:nil];
}

- (void)showSeriesDetailsViewControllerFromSourceController:(UIViewController *)sourceController
                                                      model:(SHSeriesDetailsViewModel *)model
{
    [sourceController performSegueWithIdentifier:SHToSeriesDetailsViewController
                                          sender:self
                                preparationBlock:^(UIStoryboardSegue *segue) {
                                    SHSeriesDetailsViewController *destination = segue.destinationViewController;
                                    if ([destination isKindOfClass:[SHSeriesDetailsViewController class]]) {
                                        destination.seriesDetailsViewModel = model;
                                    }
                                }];
}

- (void)showFavoritesViewControllerFromSourceController:(UIViewController *)sourceController
{
    [sourceController performSegueWithIdentifier:SHToFavoritesViewController
                                          sender:self
                                preparationBlock:nil];
}

@end