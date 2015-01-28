//
//  GetUserlist.m
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "GetUserlist.h"
#import "GetUserlistReceived.h"

@implementation GetUserlist


- (id)init{
    self = [super init];
    if(self){
        self._type = @"m1_get_user";
        self.message = [[GetUserlistMessage alloc] init];
        self.message.account = @"";
    }
    return self;
}


- (void)httpPostMethodStart:(JSONObjectBlock)completeBlock{
    [super httpPostMethodStart:completeBlock];//一定不能少这个
    
    //NSString *xmlStr = @"<?xml version=\"1.0\" encoding=\"utf-8\" ?><response  id=\"fbec5bd2-bae0-407c-90f0-3993035463cf\" type=\"m1_get_user\" version=\"1.0.0\"><result><code>0</code><desc>success</desc></result><message><userinfos><userinfo><ispid>910000187</ispid><loginname></loginname><username>tucao</username><contactphone>13638648520</contactphone></userinfo></userinfos></message></response>";
    //    NSString *xmlStr = @"<?xml version=\"1.0\" encoding=\"utf-8\" ?><response  id=\"fbec5bd2-bae0-407c-90f0-3993035463cf\" type=\"m1_get_user\" version=\"1.0.0\"><result><code>0</code><desc>success</desc></result><message><userinfos><userinfo><ispid>910000187</ispid><loginname>dadd</loginname><username>tucao</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000188</ispid><loginname></loginname><username>tucao4</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000192</ispid><loginname></loginname><username>tucao6</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000216</ispid><loginname></loginname><username>test1</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000220</ispid><loginname></loginname><username>tucao1</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000247</ispid><loginname>fffdfdfd</loginname><username>tucao8</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000248</ispid><loginname></loginname><username>tucao9</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000278</ispid><loginname>测试老师</loginname><username>tucao007</username><contactphone>13638648520</contactphone></userinfo><userinfo><ispid>910000424</ispid><loginname></loginname><username>tucao2</username><contactphone>13638648520</contactphone></userinfo></userinfos></message></response>";
    //
    
    //    NSDictionary *dic = [NSDictionary dictionaryWithXMLString:xmlStr];
    //    GetUserlistReceived *obj = [self creatWithModelDictionary:dic modelClass:[GetUserlistReceived class]];;
    //    completeBlock(obj,nil);
    
    [JSONHTTPClient postJSONFromURLWithString:GET_USERLIST_URL bodyString:m_RequestXml completion:^(id json, JSONModelError *err) {
        NSString *xmlStr = json;
        NSDictionary *dic = [NSDictionary dictionaryWithXMLString:xmlStr];
        GetUserlistReceived *obj = [self creatWithModelDictionary:dic modelClass:[GetUserlistReceived class]];;
        completeBlock(obj,nil);
    }];
}

@end

@implementation GetUserlistMessage

@end
