//
//  SHSeriesRouterImplementation.h
//  Shows
//
//  Created by nikitahils on 23/07/16.
//  Copyright (c) 2016 iam. All rights reserved.
//

#import "SHBaseRouter.h"
#import "SHSeriesRouter.h"

@class SHSeriesAssembly;

@interface SHSeriesRouterImplementation : SHBaseRouter <SHSeriesRouter>

@property (nonatomic, strong) SHSeriesAssembly* assembly;

@end