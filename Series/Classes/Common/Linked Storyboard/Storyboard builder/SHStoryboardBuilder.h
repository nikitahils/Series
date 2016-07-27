//
//  SHStoryboardBuilder.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@interface SHStoryboardBuilder : NSObject

@property (nonatomic, strong, readonly) id factory;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFactory:(id)factory NS_DESIGNATED_INITIALIZER;

- (UIStoryboard *)storyboardWithName:(NSString *)name;

@end
