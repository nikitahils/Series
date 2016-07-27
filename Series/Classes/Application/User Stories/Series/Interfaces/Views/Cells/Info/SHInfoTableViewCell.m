//
//  SHInfoTableViewCell.m
//  Shows
//
//  Created by iam on 26/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHInfoTableViewCell.h"
#import "UIImageView+Loading.h"

@import SpinKit;
@import Masonry;

@interface SHInfoTableViewCell ()

@property (nonatomic, strong) RTSpinKitView *spinner;

@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionalDescriptionLabel;

@end

@implementation SHInfoTableViewCell

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce
                                                  color:[UIColor grayColor]
                                            spinnerSize:20];
    [self addSubview:self.spinner];
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.infoImageView);
    }];
    [self.spinner startAnimating];
}

- (void)configureWithImageURL:(NSURL *)url
                        title:(NSString *)title
                  description:(NSString *)description
{
    self.infoLabel.text = title;
    self.additionalDescriptionLabel.text = description;
    [self.infoImageView setImageWithURL:url completion:^(BOOL success) {
        [self.spinner stopAnimating];
    }];
}

- (void)prepareForReuse
{
    [self.infoImageView prepareForReuse];
}

@end
