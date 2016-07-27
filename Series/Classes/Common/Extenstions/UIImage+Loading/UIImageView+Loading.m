//
//  UIImageView+Loading.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "UIImageView+Loading.h"
#import <AFNetworking/UIKit+AFNetworking.h>

static const NSTimeInterval kAnimationDuration = 0.2;
static const UIViewAnimationOptions kAnimationOptions = UIViewAnimationOptionBeginFromCurrentState   |
                                                        UIViewAnimationOptionCurveEaseInOut          |
                                                        UIViewAnimationOptionTransitionCrossDissolve;


@implementation UIImageView (Loading)

- (void)setImageWithURL:(NSURL *)imageURL completion:(void (^)(BOOL))block
{
    if (imageURL) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageURL];
        [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
        [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        @weakify(self);
        [self setImageWithURLRequest:request
                    placeholderImage:nil
                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                 @strongify(self);
                                 [UIView transitionWithView:self
                                                   duration:kAnimationDuration
                                                    options:kAnimationOptions
                                                 animations:^{
                                                     self.image = image;
                                                 }
                                                 completion:^(BOOL finished) {
                                                     if (block) {
                                                         block(YES);
                                                     }
                                                 }];
                             }
                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                 @strongify(self);
                                 self.image = nil;
                                 if (block) {
                                     block(NO);
                                 }
                             }];
    } else {
        if (block) {
            block(NO);
        }
    }
}

- (void)prepareForReuse
{
    [self cancelImageRequestOperation];
    self.image = nil;
}

@end
