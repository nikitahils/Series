//
//  SHJWTTokenStore.h
//  Shows
//
//  Created by iam on 22/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "TokenStore.h"

@interface SHJWTTokenStore : NSObject <TokenStore>

@property (readwrite) NSString *token;

@end
