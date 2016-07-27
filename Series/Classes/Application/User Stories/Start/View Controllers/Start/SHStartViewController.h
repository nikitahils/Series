//
//  SHStartViewController.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import UIKit;

@protocol SHStartRouter;

@interface SHStartViewController : UIViewController

@property (nonatomic, strong) id<SHStartRouter> router;

@end
