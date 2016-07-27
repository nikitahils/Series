//
//  SHSeriesRouter.h
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "Router.h"

@class SHSeriesDetailsViewModel;

@protocol SHSeriesRouter <Router>

@required

- (void)showAuthViewControllerFromSourceController:(UIViewController *)sourceController;
- (void)showSeriesDetailsViewControllerFromSourceController:(UIViewController *)sourceController
                                                      model:(SHSeriesDetailsViewModel *)model;
- (void)showFavoritesViewControllerFromSourceController:(UIViewController *)sourceController;

@end