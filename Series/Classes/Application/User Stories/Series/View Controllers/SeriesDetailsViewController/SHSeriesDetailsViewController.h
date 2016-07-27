//
//  SHSeriesDetailsViewController.h
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@class SHSeriesDetailsViewModel;
@protocol SHSeriesRouter;

@interface SHSeriesDetailsViewController : UIViewController

@property (nonatomic, strong) id<SHSeriesRouter> router;
@property (nonatomic, strong) SHSeriesDetailsViewModel *seriesDetailsViewModel;

@end

