//
//  Router.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "UIViewController+Routing.h"

@protocol Router <SHRouter>

- (void)dismissCurrentViewController:(UIViewController *)viewController
                            animated:(BOOL)animated;

@end
