//
//  GetUserlist.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "BaseHttpRequestModel.h"

@class GetUserlistMessage;
@interface GetUserlist : BaseHttpRequestModel

@property (nonatomic,strong) GetUserlistMessage *message;

@end

@interface GetUserlistMessage : JSONModel

@property (nonatomic,strong) NSString<Optional> *account;

@end
