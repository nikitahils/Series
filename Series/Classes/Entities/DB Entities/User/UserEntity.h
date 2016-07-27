//
//  UserEntity.h
//  Shows
//
//  Created by iam on 23/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Realm;

#import "SeriesEntity.h"

@interface UserEntity : RLMObject

@property NSNumber<RLMInt> *identifier;
@property BOOL isLogged;

@property RLMArray<SeriesEntity *><SeriesEntity> *favoritesSeries;

@end
