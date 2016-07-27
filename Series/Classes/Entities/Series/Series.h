//
//  Series
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Mantle;

@class Actor;

@interface Series : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *overview;
@property (nonatomic, copy) NSURL *posterURL;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, copy) NSArray<Actor*> *actors;

+ (instancetype)seriesWithIdentifier:(NSNumber *)identifier;

@end
