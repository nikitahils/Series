//
//  SHPageCollectionViewCell.h
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHSeriesDetailsViewModel;

@interface SHPageCollectionViewCell : UICollectionViewCell

- (void)configureWith:(SHSeriesDetailsViewModel *)viewModel;

@end
