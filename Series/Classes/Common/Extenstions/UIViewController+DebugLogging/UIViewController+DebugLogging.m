//
//  UIViewController+DebugLogging.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "UIViewController+DebugLogging.h"

@import ObjectiveC.runtime;

@implementation UIViewController (DebugLogging)

#ifdef DEBUG

+ (void)load
{
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL initSelector = @selector(initWithNibName:bundle:);
        SEL initLoggerSelector = @selector(logged_initWithNibName:bundle:);
        swizzle([self class], initSelector, initLoggerSelector);
        
        SEL initCoderSelector = @selector(initWithCoder:);
        SEL initCoderLoggerSelector = @selector(logged_initWithCoder:);
        swizzle([self class], initCoderSelector, initCoderLoggerSelector);
    });
}

- (id)logged_initWithCoder:(NSCoder *)aDecoder
{
    DDLogVerbose(@"initWithCoder: %@", [self class]);
    return [self logged_initWithCoder:aDecoder];
}

- (instancetype)logged_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
    DDLogVerbose(@"initWithNibName: %@", [self class]);
    return [self logged_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

static void swizzle(Class c, SEL orig, SEL patch)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method patchMethod = class_getInstanceMethod(c, patch);
    
    BOOL added = class_addMethod(c, orig,
                                 method_getImplementation(patchMethod),
                                 method_getTypeEncoding(patchMethod));
    
    if (added) {
        class_replaceMethod(c, patch,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
        
    } else {
        method_exchangeImplementations(origMethod, patchMethod);
    }
}

#endif

@end
