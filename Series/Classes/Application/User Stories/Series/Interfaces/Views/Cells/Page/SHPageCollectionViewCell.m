//
//  SHPageCollectionViewCell.m
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHPageCollectionViewCell.h"
#import "SHSeriesDetailsViewModel.h"
#import "UIImageView+Loading.h"
#import "Constants.h"
#import "Series.h"

@import SpinKit;
@import Masonry;

@interface SHPageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;
@property (nonatomic, strong) RTSpinKitView *spinner;

@property (nonatomic, strong) SHSeriesDetailsViewModel *viewModel;

@end

@implementation SHPageCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.containerView.layer.cornerRadius = 5;
    
    self.customTitleLabel.layer.shadowRadius = 2;
    self.customTitleLabel.layer.shadowOffset = CGSizeMake(0, 3);
    self.customTitleLabel.layer.shadowOpacity = 0.2;
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce];
    [self addSubview:self.spinner];
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self.spinner startAnimating];
}

- (void)configureWith:(SHSeriesDetailsViewModel *)viewModel
{
    self.viewModel = viewModel;
    
    @weakify(self);
    [RACObserve(self.viewModel, isFetching) subscribeNext:^(NSNumber *isFetching) {
        @strongify(self);
        [self.spinner startAnimating];
        
        if (![isFetching boolValue]) {
            self.customTitleLabel.text = self.viewModel.series.name;
            
            [self.backgroundImageView setImageWithURL:self.viewModel.series.posterURL
                                       completion:^(BOOL sucess){
                [self.spinner stopAnimating];
            }];
        }
    }];
}

- (void)prepareForReuse
{
    [self.backgroundImageView prepareForReuse];
    self.customTitleLabel.text = nil;
}

@end
