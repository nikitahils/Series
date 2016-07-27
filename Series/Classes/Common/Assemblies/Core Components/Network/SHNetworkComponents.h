//
//  SHNetworkComponents.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Typhoon;

@class SHUpdatesAPIService, SHSeriesAPIService;
@protocol APISessionManager, HTTPSessionManager;

@interface SHNetworkComponents : TyphoonAssembly

- (id<APISessionManager>)apiSessionManager;

- (SHUpdatesAPIService *)updatesAPIService;
- (SHSeriesAPIService *)seriesAPIService;

@end
