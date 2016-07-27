//
//  NSObject+DebugLogging.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "NSObject+DebugLogging.h"

static char * const prefix = "SH";

@import ObjectiveC.runtime;

@implementation NSObject (DebugLogging)

#ifdef DEBUG

+ (void)load
{
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL deallocSelector = NSSelectorFromString(@"dealloc");
        SEL deallocLoggedSelector = @selector(logged_dealloc);
        swizzle([self class], deallocSelector, deallocLoggedSelector);
    });
}

- (void)logged_dealloc
{
    NSString *className = NSStringFromClass([self class]);
    if (className && className.length > 2) {
        const char *name = class_getName([self class]);
        if (name[0] == prefix[0] && name[1] == prefix[1]) {
            DDLogWarn(@"(<-) dealloc: %@", className);
        }
    }
    [self logged_dealloc];
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
