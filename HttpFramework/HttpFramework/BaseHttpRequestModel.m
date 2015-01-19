//
//  BaseHttpRequestModel.m
//  HttpFramework
//
//  Created by 涂操 on 15/1/15.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "BaseHttpRequestModel.h"
#import <objc/runtime.h>

@implementation BaseHttpRequestModel

- (id)init{
    self = [super init];
    if(self){
        ___name = @"request";
        __version = @"1.0.0";
        _authorize = [[Authorize alloc] init];
        __type = @"";
        __id = @"FBEC5BD2-BAE0-407C-90F0-3993035463CF";
    }
    return self;
}

- (id)initWithMessageObject:(SendMessage *)msgObject{
    self = [self init];
    if(self){
        _message = msgObject;
    }
    return self;
}

- (void)httpPostMethodStart:(JSONObjectBlock)completeBlock{
    NSDictionary *dic = [self toDictionary];
    NSString *xmlStr = [dic XMLString];
    m_RequestXml = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>%@",xmlStr];
}

- (void)httpGetMethodStart:(JSONObjectBlock)completeBlock{
    
}

- (id)checkModelDictionary:(NSDictionary *)dictionary modelClass:(Class)class{
    NSArray *keysArray = [self getClassArrayTypePropertyNames:class keysArray:nil propertyName:nil];
    if(keysArray.count>0){
        [self transformDictionary:dictionary superKey:NSStringFromClass(class) keysArray:keysArray];
    }
    return [[class alloc] initWithDictionary:dictionary error:NULL];
}


//查找类中的NSArray数组的属性名称
- (NSArray *)getClassArrayTypePropertyNames:(Class)class keysArray:(NSMutableArray *)keysArray propertyName:(NSString *)superPropertyName{
    if(!keysArray){
        keysArray = [[NSMutableArray alloc] init];
    }
    if(!superPropertyName){
        superPropertyName = NSStringFromClass(class);
    }
    while (class != [JSONModel class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
        Ivar * ivars = class_copyIvarList(class, nil);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *nsPropertyName = @(propertyName);
            const char *type = ivar_getTypeEncoding(ivars[i]);
            NSString *propertyType = @(type);
            if([propertyType hasPrefix:@"@"]&&propertyType.length>3){
                NSString *pType = [propertyType substringWithRange:NSMakeRange(2, propertyType.length-3)];
                NSRange rang = [pType rangeOfString:@"<"];
                NSString *protocolName;
                if(rang.location!=NSNotFound){
                    NSString *protocolStr = [pType substringFromIndex:rang.location];
                    protocolStr = [protocolStr stringByReplacingOccurrencesOfString:@">" withString:@""];
                    NSArray *protocolArray = [protocolStr componentsSeparatedByString:@"<"];
                    NSArray *excludeProtocolArray = @[@"Optional",@"Index",@"ConvertOnDemand",@"Ignore"];
                    for (NSString *prName in protocolArray) {
                        if(![excludeProtocolArray containsObject:prName]){
                            protocolName = prName;
                        }
                    }
                    pType = [pType substringToIndex:rang.location];
                }
                Class aClass = NSClassFromString(pType);
                if([aClass isSubclassOfClass:[NSArray class]]||[aClass isSubclassOfClass:[NSMutableArray class]]){
                    NSDictionary *keysDic = @{superPropertyName:nsPropertyName};
                    [keysArray addObject:keysDic];
                    //数组对象里面再套数组
                    if(protocolName.length>0){
                        [self getClassArrayTypePropertyNames:NSClassFromString(protocolName) keysArray:keysArray propertyName:nsPropertyName];
                    }
                }else if ([aClass isSubclassOfClass:[JSONModel class]]){
                    [self getClassArrayTypePropertyNames:aClass keysArray:keysArray propertyName:nsPropertyName];
                }
            }
        }
        free(properties);
        class = [class superclass];
    }
    return [NSArray arrayWithArray:keysArray];
}

- (void)transformDictionary:(NSDictionary *)tempDic superKey:(NSString *)superKey keysArray:(NSArray *)keysArray{
    NSArray *allKeys = tempDic.allKeys;
    for (NSString *key in allKeys) {
        id objDic = tempDic[key];
        for (NSDictionary *checkDic in keysArray) {
            NSString *checkKeyStr = checkDic.allKeys[0];
            NSString *checkValueStr = checkDic[checkKeyStr];
            if([key isEqualToString:checkValueStr]){
                if([checkKeyStr isEqualToString:superKey]&&[checkValueStr isEqualToString:key]){
                    if(objDic&&![objDic isKindOfClass:[NSArray class]]&&![objDic isKindOfClass:[NSMutableArray class]]){
                        NSArray *array = @[objDic];
                        [tempDic setValue:array forKey:key];
                        objDic = array;
                        break;
                    }
                }
            }
        }
        if([objDic isKindOfClass:[NSDictionary class]]||[objDic isKindOfClass:[NSMutableDictionary class]]){
            [self transformDictionary:objDic superKey:key keysArray:keysArray];
        }else if([objDic isKindOfClass:[NSArray class]]||[objDic isKindOfClass:[NSMutableArray class]]){
            for (id obj in objDic) {
                if([obj isKindOfClass:[NSDictionary class]]||[obj isKindOfClass:[NSMutableDictionary class]]){
                    [self transformDictionary:obj superKey:key keysArray:keysArray];
                }
            }
        }
    }
}

@end



//Authorize

@implementation Authorize

- (id)init{
    self = [super init];
    if(self){
        _endpoint = @"MDUxMTA4NDAxNjIwMTJmamVzZW5vemN6eHVzZ3ZobGtrcA==";
        _authkey = @"OWYzZDVkYTU1NDM3Nzc0MTExZmM1ZGYzMDQ3N2U4M2U=";
        _time = @"MjAxNTAxMTUwNDQxMjk=";
    }
    return self;
}
@end



//Message

@implementation SendMessage

@end


