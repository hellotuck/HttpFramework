//
//  BaseHttpReceivedModel.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "JSONModel.h"

@class ReceivedResult,ReceivedMessage;
@interface BaseHttpReceivedModel : JSONModel

@property (nonatomic,strong) NSString *__name;
@property (nonatomic,strong) NSString *_id;
@property (nonatomic,strong) NSString *_type;
@property (nonatomic,strong) NSString *_version;
@property (nonatomic,strong) ReceivedResult *result;

@end



@interface ReceivedResult : JSONModel

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *desc;

@end




@interface ReceivedMessage : JSONModel

@end
