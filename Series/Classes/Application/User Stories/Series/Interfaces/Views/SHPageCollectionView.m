//
//  SHPageCollectionView.m
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHPageCollectionView.h"
#import "SHPageCollectionViewLayout.h"

@interface SHPageCollectionView ()

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SHPageCollectionView

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.decelerationRate                          = UIScrollViewDecelerationRateFast;
    self.showsHorizontalScrollIndicator            = NO;
    self.flowLayout = [[SHPageCollectionViewLayout alloc] initWithItemSize:CGSizeMake(256, 335)];
    self.collectionViewLayout = self.flowLayout;
}

#pragma mark - Other

- (NSInteger)currentIndex
{
    CGSize itemSize = self.flowLayout.itemSize;
    CGFloat startOffset = (self.bounds.size.width - itemSize.width) / 2;
    CGFloat minimumLineSpacing = self.flowLayout.minimumLineSpacing;
    return ((self.contentOffset.x + startOffset + itemSize.width / 2) / (itemSize.width + minimumLineSpacing));
}

@end
