//
//  NSIndexPath+DebugDescription.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "NSIndexPath+DebugDescription.h"

@import UIKit;

@implementation NSIndexPath (DebugDescription)

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"%@: [item = %zd, section = %zd, row = %zd]",
            self.class, self.section, self.item, self.row];
}

@end
