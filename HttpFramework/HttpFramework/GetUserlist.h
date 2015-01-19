//
//  GetUserlist.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "BaseHttpRequestModel.h"

@class SendOtherObject;
@interface GetUserlist : BaseHttpRequestModel

@end



@interface GetUserlistMessage : SendMessage

@property (nonatomic,strong) NSString<Optional> *account;

@end
