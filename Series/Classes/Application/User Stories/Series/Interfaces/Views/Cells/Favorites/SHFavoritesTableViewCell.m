//
//  SHFavoritesTableViewCell.m
//  Shows
//
//  Created by iam on 27/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHFavoritesTableViewCell.h"
#import "UIImageView+Loading.h"

@import SpinKit;
@import Masonry;

@interface SHFavoritesTableViewCell ()

@property (nonatomic, strong) RTSpinKitView *spinner;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;

@end

@implementation SHFavoritesTableViewCell

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // trick for dynamically setting cell height
    // propotional size of image banner (379 : 70)
    self.heightConstraint.constant = roundf((70.f * [UIScreen mainScreen].bounds.size.width) / 379.f);
    
    self.customTitleLabel.layer.shadowRadius = 5;
    self.customTitleLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.customTitleLabel.layer.shadowOpacity = 0.7;
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce
                                                  color:[UIColor grayColor]
                                            spinnerSize:20];
    [self addSubview:self.spinner];
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.customImageView);
    }];
    [self.spinner startAnimating];
}

- (void)configureWithImageURL:(NSURL *)url
                        title:(NSString *)title
{
    self.customTitleLabel.text = title;
    [self.customImageView setImageWithURL:url completion:^(BOOL success) {
        [self.spinner stopAnimating];
    }];
}

- (void)prepareForReuse
{
    [self.customImageView prepareForReuse];
}

@end
