//
//  Actor.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Mantle;

@interface Actor : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSNumber *seriesIdentifier;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSURL *imageURL;

@end
