//
//  SHInvertableButton.m
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHInvertableButton.h"

@interface SHInvertableButton ()

@end

@implementation SHInvertableButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setupButton];
}

- (void)setupButton
{
    [self addTarget:self
             action:@selector(didTouchButton)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTouchButton
{
    self.selected = !self.selected;
}


@end
