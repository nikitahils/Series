//
//  SHFavoritesManager.h
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@class Series;

@interface SHFavoritesManager : NSObject

+ (instancetype)shared;

@property (nonatomic, readonly) NSArray<Series*> *series;

- (BOOL)isFavoriteWithSeriesIdentifier:(NSNumber *)identifier;

- (void)addToFavorites:(Series *)series;
- (void)removeFromFavorites:(Series *)series;

@end
