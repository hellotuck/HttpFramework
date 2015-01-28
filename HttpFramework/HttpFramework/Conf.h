//
//  Conf.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import <Foundation/Foundation.h>


#define GET_REGISTADD_URL  @"58.213.155.170:9195"
#define GET_USERLIST_URL [NSString stringWithFormat:@"http:/%@/plugins/datacollection/getUserListWithAccout",GET_REGISTADD_URL]







@interface Conf : NSObject

@end
