//
//  SHServerResponseSerializer.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "SHServerResponseSerializer.h"
#import "NSObject+IsKindOfClassWithError.h"

@import Mantle;

NSString * const SHServerResponseSerializerErrorDomain = @"SHServerResponseSerializerErrorDomain";
const NSInteger SHServerResponseSerializerInvalidObject = 2332;

@implementation SHServerResponseSerializer

- (id)serialize:(id)object
          error:(NSError **)error
{
    id data = nil;
    if ([object isKindOfClass:[NSDictionary class]
                        error:error
                       domain:SHServerResponseSerializerErrorDomain
                         code:SHServerResponseSerializerInvalidObject]) {
        
        data = object[@"data"];
    }
    
    return data;
}

@end
