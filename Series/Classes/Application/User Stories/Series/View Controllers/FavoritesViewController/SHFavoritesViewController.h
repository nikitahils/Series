//
//  SHFavoritesViewController.h
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@protocol SHSeriesRouter;

@interface SHFavoritesViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, strong) id<SHSeriesRouter> router;

@end

