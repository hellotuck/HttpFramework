//
//  GetUserlistReceived.m
//  HttpFramework
//
//  Created by 涂操 on 15/1/16.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "GetUserlistReceived.h"

@implementation GetUserlistReceived

@end


@implementation GetUserlistReceivedMessage

@end


@implementation UserListInfos

@end


@implementation UserListInfo

- (id)init{
    self = [super init];
    if(self){
        _contactphone = @"";
        _loginname = @"";
        _ispid = @"";
        _username = @"";
    }
    return self;
}

@end
