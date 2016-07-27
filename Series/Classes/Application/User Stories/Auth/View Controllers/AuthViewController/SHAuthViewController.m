//
//  SHAuthViewController.m
//  Shows
//
//  Created by nikitahils on 21/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHAuthViewController.h"
#import "SHAuthRouter.h"
#import "SHStoryboardIdentifiers.h"
#import "SHUserManager.h"
#import "User.h"

@import GoogleSignIn;

@interface SHAuthViewController () <GIDSignInDelegate, GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet GIDSignInButton *googleSignInButton;

@end

@implementation SHAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupInterface];
}

- (void)setupInterface
{
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
}

#pragma mark - GIDSignInDelegate

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)googleUser
     withError:(NSError *)error
{
    [[SHUserManager shared] didSignInWithGoogleUser:googleUser];
    [self.router showSeriesViewControllerFromSourceController:self];
}

@end