//
//  SHStartRouter.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "Router.h"

@import UIKit;

@protocol SHStartRouter <Router>

@required

- (void)showAuthViewControllerFromSourceController:(UIViewController *)sourceController;
- (void)showSeriesViewControllerFromSourceController:(UIViewController *)sourceController;

@end
