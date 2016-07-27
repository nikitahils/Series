//
//  SHLinkedStoryboardBaseSegue.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@class SHStoryboardBuilder;

@interface SHLinkedStoryboardBaseSegue : UIStoryboardSegue

+ (UIViewController *)sceneNamed:(NSString *)identifier
           withStoryboardBuilder:(SHStoryboardBuilder *)storyboardBuilder;

@end
