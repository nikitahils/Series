//
//  SHAuthViewController.h
//  Shows
//
//  Created by nikitahils on 21/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

@protocol SHAuthRouter;

@interface SHAuthViewController : UIViewController

@property (nonatomic, strong) id<SHAuthRouter> router;

@end