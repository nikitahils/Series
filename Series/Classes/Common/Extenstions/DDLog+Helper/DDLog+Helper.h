//
//  DDLog+Helper.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@protocol DDLogger;

@interface DDLog (Helper)

+ (void)addLogger:(id<DDLogger>)logger withLevelName:(NSString *)levelName;

@end
