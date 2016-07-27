//
//  SHStartViewController.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHStartViewController.h"
#import "SHStartRouter.h"
#import "SHUserManager.h"

@interface SHStartViewController ()

@end

@implementation SHStartViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self configureNavigationBar];
    
    if ([SHUserManager shared].isLogged) {
        [self.router showSeriesViewControllerFromSourceController:self];
    } else {
        [self.router showAuthViewControllerFromSourceController:self];
    }
}


- (void)configureNavigationBar
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].translucent = YES;
    
    NSShadow *shadow = [NSShadow new];
    shadow.shadowOffset = CGSizeMake(0, 2);
    shadow.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSShadowAttributeName : shadow};
}

@end
