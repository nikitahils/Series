//
//  SHAuthAssembly.h
//  Shows
//
//  Created by nikitahils on 21/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

@import Typhoon;

@protocol SHAuthRouter;

@interface SHAuthAssembly : TyphoonAssembly

- (UIStoryboard *)authStoryboard;
- (UIViewController *)storyboardAuthInitialViewController;

- (UIViewController *)authViewController;

- (id<SHAuthRouter>)authRouter;

@end