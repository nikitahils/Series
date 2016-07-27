//
//  HTTPMethodType.h
//  Shows
//
//  Created by iam on 21/07/16.
//  Copyright © 2016 nikitahils. All rights reserved.
//

typedef NS_ENUM(NSUInteger, HTTPMethodType)
{
    GET,
    POST
};

NSString * HTTPMethodStringFromHTTPMethodType(HTTPMethodType methodType);
