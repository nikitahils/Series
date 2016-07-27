//
//  NSObject+IsKindOfClassWithError.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@import Foundation;

@interface NSObject (IsKindOfClassWithError)

- (BOOL)isKindOfClass:(Class)aClass
                error:(NSError **)error
               domain:(NSString *)domain
                 code:(NSInteger)code;

@end
