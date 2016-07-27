//
//  SHSeriesAssembly.h
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

@import Typhoon;

@class SHSeriesDetailsViewModel;
@protocol SHSeriesRouter;

@interface SHSeriesAssembly : TyphoonAssembly

- (UIStoryboard *)seriesStoryboard;
- (UIViewController *)storyboardSeriesInitialViewController;
- (UIViewController *)storyboardSeriesDetailsViewControllerWithModel:(SHSeriesDetailsViewModel *)model;

- (UIViewController *)updatesViewController;
- (UIViewController *)favoritesViewController;
- (UIViewController *)seriesDetailsViewControllerWithModel:(SHSeriesDetailsViewModel *)model;

- (id<SHSeriesRouter>)seriesRouter;

@end