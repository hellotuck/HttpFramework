//
//  BaseHttpRequestModel.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "JSONModel.h"
#import "Conf.h"
#import "XMLDictionary.h"
#import "JSONHTTPClient.h"




@class Authorize,SendMessage;
@interface BaseHttpRequestModel : JSONModel{
    NSString *m_RequestXml;
}

@property (nonatomic,strong) NSString *__name;
@property (nonatomic,strong) NSString *_id;
@property (nonatomic,strong) NSString *_type;
@property (nonatomic,strong) NSString *_version;
@property (nonatomic,strong) Authorize *authorize;
@property (nonatomic,strong) SendMessage *message;


- (id)initWithMessageObject:(SendMessage *)msgObject;

- (void)httpPostMethodStart:(JSONObjectBlock)completeBlock;

- (void)httpGetMethodStart:(JSONObjectBlock)completeBlock;

- (id)checkModelDictionary:(NSDictionary *)dictionary modelClass:(Class)aClass;

@end



@interface Authorize : JSONModel

@property (nonatomic,strong) NSString *endpoint;
@property (nonatomic,strong) NSString *authkey;
@property (nonatomic,strong) NSString *time;

@end


@interface SendMessage : JSONModel

@end

