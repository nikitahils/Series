//
//  SHFavoritesManager.m
//  Shows
//
//  Created by iam on 25/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHFavoritesManager.h"
#import "SHUserManager.h"
#import "User.h"
#import "UserEntity.h"
#import "SeriesEntity.h"
#import "Series.h"

@import Realm;

@implementation SHFavoritesManager

+ (instancetype)shared
{
    static SHFavoritesManager *current = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        current = [[self alloc] init];
    });
    return current;
}

- (BOOL)isFavoriteWithSeriesIdentifier:(NSNumber *)identifier
{
    User *user = [SHUserManager shared].user;
    if (user) {
        UserEntity *userEntity = [UserEntity objectForPrimaryKey:user.identifier];
        NSString *where = [NSString stringWithFormat:@"%@ = %@", @keypath(SeriesEntity.new, identifier), identifier];
        if ([userEntity.favoritesSeries indexOfObjectWhere:where] != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (void)addToFavorites:(Series *)series
{
    User *user = [SHUserManager shared].user;
    if (user) {
        UserEntity *userEntity = [UserEntity objectForPrimaryKey:user.identifier];
        SeriesEntity *seriesEntity = [SeriesEntity objectForPrimaryKey:series.identifier];
        if (!seriesEntity) {
            seriesEntity = [SeriesEntity entityWithSeriesModel:series];
        }
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [userEntity.favoritesSeries addObject:seriesEntity];
        [UserEntity createOrUpdateInDefaultRealmWithValue:userEntity];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

- (void)removeFromFavorites:(Series *)series
{
    User *user = [SHUserManager shared].user;
    if (user) {
        SeriesEntity *seriesEntity = [SeriesEntity objectForPrimaryKey:series.identifier];
        if (seriesEntity) {
            [[RLMRealm defaultRealm] beginWriteTransaction];
            [[RLMRealm defaultRealm] deleteObject:seriesEntity];
            [[RLMRealm defaultRealm] commitWriteTransaction];
        }
    }
}

- (NSArray<Series *>*)series
{
    User *user = [SHUserManager shared].user;
    if (user) {
        NSMutableArray *array = [NSMutableArray array];
        UserEntity *userEntity = [UserEntity objectForPrimaryKey:user.identifier];
        RLMArray<SeriesEntity *> *favorites= userEntity.favoritesSeries;
        for (SeriesEntity *seriesEntity in favorites) {
            Series *series = [seriesEntity buildModel];
            [array addObject:series];
        }
        return [array copy];
    }
    return @[];
}

@end
