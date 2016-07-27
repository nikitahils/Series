//
//  HTTPMethodType.m
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

#import "HTTPMethodType.h"

NSString * HTTPMethodStringFromHTTPMethodType(HTTPMethodType methodType)
{
    NSString *methodString;
    switch (methodType) {
        case GET:
            methodString = @"GET";
            break;
        case POST:
            methodString = @"POST";
            break;
    }
    return methodString;
}
