//
//  BaseHttpRequestModel.m
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "BaseHttpRequestModel.h"

@implementation BaseHttpRequestModel

- (id)init{
    self = [super init];
    if(self){
        ___name = @"request";
        __version = @"1.0.0";
        __type = @"";
        __id = @"FBEC5BD2-BAE0-407C-90F0-3993035463CF";
        
        _authorize = [[Authorize alloc] init];
        _authorize.endpoint = @"MDUxMTA4NDAxNjIwMTJmamVzZW5vemN6eHVzZ3ZobGtrcA==";
        _authorize.authkey = @"OWYzZDVkYTU1NDM3Nzc0MTExZmM1ZGYzMDQ3N2U4M2U=";
        _authorize.time = @"MjAxNTAxMTUwNDQxMjk=";
    }
    return self;
}

- (void)httpPostMethodStart:(JSONObjectBlock)completeBlock{
    NSString *xmlStr = [[self toDictionary] XMLString];
    m_RequestXml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>%@",xmlStr];
}

- (void)httpGetMethodStart:(JSONObjectBlock)completeBlock{
    
}

//http_xml
- (id)creatWithModelDictionary:(NSDictionary *)dictionary modelClass:(Class)class{
    NSArray *keysArray = [ModelUtil getClassArrayTypePropertyNames:class keysArray:nil propertyName:nil];
    if(keysArray.count>0){
        [ModelUtil transformDictionary:dictionary superKey:NSStringFromClass(class) keysArray:keysArray];
    }
    return [[class alloc] initWithDictionary:dictionary error:NULL];
}

@end

//Authorize

@implementation Authorize

@end