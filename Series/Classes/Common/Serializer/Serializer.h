//
//  Serializer.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Foundation;

@protocol Serializer <NSObject>

@required

- (id)serialize:(id)object
          error:(NSError **)error;

@end
