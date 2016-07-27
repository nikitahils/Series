//
//  SHStoryboardBuilder.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHStoryboardBuilder.h"

@import Typhoon;

@interface SHStoryboardBuilder ()

@property (nonatomic, strong, readwrite) id factory;

@end

@implementation SHStoryboardBuilder

- (instancetype)initWithFactory:(id)factory
{
    self = [super init];
    if (self) {
        _factory = factory;
    }
    return self;
}

- (UIStoryboard *)storyboardWithName:(NSString *)name
{
    return [UIStoryboard storyboardWithName:name
                                     bundle:[NSBundle bundleForClass:[self class]]];
}

@end
