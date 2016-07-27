//
//  TokenStore.h
//  Shows
//
//  Created by iam on 22/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Foundation;

@protocol TokenStore <NSObject>

@required

@property (readwrite) NSString *token;

@end
