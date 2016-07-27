//
//  SHStartAssembly.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Typhoon;

@protocol SHStartRouter;

@interface SHStartAssembly : TyphoonAssembly

- (UIStoryboard *)startStoryboard;
- (UIViewController *)storyboardStartInitialViewController;

- (UIViewController *)startViewController;

- (id<SHStartRouter>)startRouter;

@end
