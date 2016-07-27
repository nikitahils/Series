//
//  User.h
//  Shows
//
//  Created by iam on 23/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Mantle;

@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSNumber *identifier;

+ (instancetype)userWithIdentifier:(NSNumber *)identifier;

@end
