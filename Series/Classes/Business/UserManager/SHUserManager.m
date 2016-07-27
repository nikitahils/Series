//
//  SHUserManager.m
//  Shows
//
//  Created by iam on 23/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHUserManager.h"
#import <Google/SignIn.h>
#import "User.h"
#import "UserEntity.h"

@import Realm;
@import Mantle;

static NSString * const NSUserDefaultsUserIdentifierKey = @"NSUserDefaultsUserIdentifierKey";
static NSString * const NSUserDefaultsUserisLoggedKey = @"NSUserDefaultsUserisLoggedKey";

@interface SHUserManager ()

@end

@implementation SHUserManager {
    User *_user;
}

+ (instancetype)shared
{
    static SHUserManager *current = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        current = [[self alloc] init];
    });
    return current;
}

- (User *)user
{
    if (!_user) {
        if (self.isLogged) {
            _user = [User userWithIdentifier:self.loggedUserEntity.identifier];
            return _user;
        }
    }
    return _user;
}

- (UserEntity *)loggedUserEntity
{
    NSString *where = [NSString stringWithFormat:@"%@ == true", @keypath(UserEntity.new, isLogged)];
    RLMResults<UserEntity*> *users = [UserEntity objectsWhere:where];
    return users.firstObject;
}

- (BOOL)isLogged
{
    return [GIDSignIn sharedInstance].hasAuthInKeychain;
}

- (void)logout
{
    [[GIDSignIn sharedInstance] signOut];
    
    [[RLMRealm defaultRealm] beginWriteTransaction];
    self.loggedUserEntity.isLogged = NO;
    [[RLMRealm defaultRealm] commitWriteTransaction];
}

- (void)didSignInWithGoogleUser:(GIDGoogleUser *)googleUser
{
    User *user = [User userWithIdentifier:@(googleUser.userID.hash)];
    
    UserEntity *userEntity = [UserEntity objectForPrimaryKey:user.identifier];
    if (!userEntity) {
        userEntity = [UserEntity new];
        userEntity.identifier = user.identifier;
    }
    [[RLMRealm defaultRealm] beginWriteTransaction];
    userEntity.isLogged = YES;
    [UserEntity createOrUpdateInDefaultRealmWithValue:userEntity];
    [[RLMRealm defaultRealm] commitWriteTransaction];
    
    _user = user;
}

@end
