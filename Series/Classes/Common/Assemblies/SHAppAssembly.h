//
//  SHAppAssembly.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Typhoon;

@class SHStoryboardBuilder;

@interface SHAppAssembly : TyphoonAssembly

- (UIViewController *)storyboardPlaceholder;
- (SHStoryboardBuilder *)storyboardBuilder;

@end
