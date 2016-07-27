//
//  SHAuthRouter.h
//  Shows
//
//  Created by nikitahils on 21/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "Router.h"

@protocol SHAuthRouter <Router>

@required

- (void)showSeriesViewControllerFromSourceController:(UIViewController *)sourceController;

@end