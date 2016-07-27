//
//  UIImageView+Loading.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

@interface UIImageView (Loading)

- (void)setImageWithURL:(NSURL *)imageURL completion:(void (^)(BOOL))block;
- (void)prepareForReuse;

@end
