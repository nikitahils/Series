//
//  SHUpdatesViewController.h
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

@class SHSeriesUpdatesViewModel;
@protocol SHSeriesRouter;

@interface SHUpdatesViewController : UIViewController

@property (nonatomic, strong) id<SHSeriesRouter> router;
@property (nonatomic, strong) SHSeriesUpdatesViewModel *seriesUpdatesViewModel;

@end