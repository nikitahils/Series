//
//  SHOverviewTableViewCell.m
//  Shows
//
//  Created by iam on 26/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHOverviewTableViewCell.h"

@interface SHOverviewTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;

@end

@implementation SHOverviewTableViewCell

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

- (void)configureWithText:(NSString *)text
                    color:(UIColor *)color;
{
    [self.overviewLabel setTextColor:color];
    self.overviewLabel.text = text;
}

@end
