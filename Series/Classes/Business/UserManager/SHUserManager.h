//
//  SHUserManager.h
//  Shows
//
//  Created by iam on 23/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@class GIDGoogleUser, User;

@interface SHUserManager : NSObject

+ (instancetype)shared;

- (void)logout;
- (void)didSignInWithGoogleUser:(GIDGoogleUser *)googleUser;

@property (nonatomic, readonly) User *user;
@property (nonatomic, readonly) BOOL isLogged;

@end
