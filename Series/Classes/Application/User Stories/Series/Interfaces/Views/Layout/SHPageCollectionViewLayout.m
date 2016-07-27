//
//  SHPageCollectionViewLayout.m
//  Shows
//
//  Created by iam on 24/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHPageCollectionViewLayout.h"

@interface SHPageCollectionViewLayout ()

@property (nonatomic, assign) CGSize lastCollectionViewSize;
@property (nonatomic, assign) CGFloat scalingOffset;
@property (nonatomic, assign) CGFloat minimumScaleFactor;
@property (nonatomic, assign) CGFloat minimumAlphaFactor;
@property (nonatomic, assign) BOOL scaleItems;

@end

@implementation SHPageCollectionViewLayout

#pragma mark - init

- (instancetype)initWithItemSize:(CGSize)itemSize
{
    if (self = [super init]) {
        self.itemSize = itemSize;
        self.minimumLineSpacing = 25;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _scalingOffset = 200;
        _minimumAlphaFactor = 0.3;
        _minimumScaleFactor = 0.9;
        _scaleItems = YES;
        _lastCollectionViewSize = CGSizeZero;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    @throw @"Not implemented";
}

#pragma mark - overrides

- (void)invalidateLayoutWithContext:(UICollectionViewLayoutInvalidationContext *)context
{
    [super invalidateLayoutWithContext:context];
    
    if (!self.collectionView) return;
    
    if (!CGSizeEqualToSize(self.collectionView.bounds.size, self.lastCollectionViewSize)) {
        [self configureInset];
        self.lastCollectionViewSize = self.collectionView.bounds.size;
    }
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if (!self.collectionView) return proposedContentOffset;
    
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *layoutAttributes = [self layoutAttributesForElementsInRect:proposedRect];
    if (!layoutAttributes) {
        return proposedContentOffset;
    }
    
    UICollectionViewLayoutAttributes *candidateAttributes;
    CGFloat proposedContentOffsetCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributes) {
        if (attributes.representedElementCategory != UICollectionElementCategoryCell) {
            continue;
        }
        
        if (!candidateAttributes) {
            candidateAttributes = attributes;
            continue;
        }
        
        if (fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
            candidateAttributes = attributes;
        }
    }
    
    
    if (!candidateAttributes) {
        return proposedContentOffset;
    }

    
    CGFloat newOffsetX = candidateAttributes.center.x - self.collectionView.bounds.size.width / 2;
    CGFloat offset = newOffsetX - self.collectionView.contentOffset.x;
    
    if ((velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0)) {
        CGFloat pageWidth = self.itemSize.width + self.minimumLineSpacing;
        newOffsetX += velocity.x > 0 ? pageWidth : (-1) * pageWidth;
    }
    
    return CGPointMake(newOffsetX, proposedContentOffset.y);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    if (!self.collectionView || !superAttributes)
        return [super layoutAttributesForElementsInRect:rect];
    
    if (self.scaleItems == NO) {
        return [super layoutAttributesForElementsInRect:rect];
    }
    
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGSize size = self.collectionView.bounds.size;
    
    CGRect visibleRect = CGRectMake(contentOffset.x, contentOffset.y, size.width, size.height);
    CGFloat visibleCenterX = CGRectGetMidX(visibleRect);
    
    NSArray *newAttributesArray = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    if (!newAttributesArray) {
        return nil;
    }
    
    [newAttributesArray enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distanceFromCenter = visibleCenterX - obj.center.x;
        CGFloat absDistanceFromCenter = MIN(fabs(distanceFromCenter), self.scalingOffset);
        CGFloat scale = absDistanceFromCenter * (self.minimumScaleFactor - 1) / self.scalingOffset + 1;
        obj.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
        
        CGFloat alpha = absDistanceFromCenter * (self.minimumAlphaFactor - 1) / self.scalingOffset + 1;
        obj.alpha = alpha;
    }];

    return newAttributesArray;
}

#pragma mark - helpers


- (void)configureInset
{
    if (!self.collectionView) return;
    
    CGFloat inset = self.collectionView.bounds.size.width/2 - self.itemSize.width/2;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.collectionView.contentOffset = CGPointMake((-1) * inset, 0);
}

@end
