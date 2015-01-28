//
//  GetUserlistReceived.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/16.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "BaseHttpReceivedModel.h"

@class GetUserlistReceivedMessage;
@interface GetUserlistReceived : BaseHttpReceivedModel<NSCoding>

@property (nonatomic,strong) GetUserlistReceivedMessage<Optional> *message;

@end


/**************************** message ****************************/
@class UserListInfos;
@interface GetUserlistReceivedMessage : JSONModel

@property (nonatomic,strong) UserListInfos *userinfos;

@end


/**************************** userinfos ****************************/
@protocol UserListInfo
@end

@interface UserListInfos : JSONModel

@property (nonatomic,strong) NSArray<UserListInfo> *userinfo;

@end


/**************************** userinfo_array ****************************/

@interface UserListInfo : JSONModel

@property (strong, nonatomic) NSString<Optional> *ispid;
@property (strong, nonatomic) NSString<Optional> *loginname;
@property (strong, nonatomic) NSString<Optional> *username;
@property (strong, nonatomic) NSString<Optional> *contactphone;

@end




