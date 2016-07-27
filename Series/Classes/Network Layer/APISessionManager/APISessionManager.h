//
//  APISessionManager.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "HTTPMethodType.h"

@import Foundation;

@class RACSignal;

@protocol APISessionManager <NSObject>

@required

/*
 @return (id)data or nil
 or (NSError *)error during reques/parsing
 */
- (RACSignal *)signalForDataWithHTTPMethod:(HTTPMethodType)method
                                   URLPath:(NSString *)urlPath
                                parameters:(id)parameters;

@end
