//
//  SHLoggingComponents.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Typhoon;

@class DDLog;
@protocol DDLogger;

@interface SHLoggingComponents : TyphoonAssembly

- (DDLog *)logger;

- (id<DDLogger>)ttyLogger;
- (id<DDLogger>)fileLogger;

@end
