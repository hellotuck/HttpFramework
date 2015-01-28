//
//  ModelStorage.m
//  HttpFramework
//
//  Created by 涂操 on 15/1/28.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "ModelUtil.h"
#import <objc/runtime.h>

@implementation ModelUtil


+ (NSString *)filePath:(NSString *)filename {
    if (!filename) {
        return nil;
    }
    if(![filename hasSuffix:@".plist"]) {
        filename = [filename stringByAppendingString:@".plist"];
    }
    NSString* libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask, YES)[0];
    NSString *filePath = [libraryDir stringByAppendingPathComponent:filename];
    return filePath;
}

+ (void)saveModelToFile:(id)modelObj filename:(NSString *)filename {
    if (!filename) {
        filename = NSStringFromClass([modelObj class]);
    }
    [[modelObj toDictionary] writeToFile:[self filePath:filename] atomically:YES];
}

+ (id)loadModelFromFile:(Class)modelObjClass filename:(NSString *)filename {
    if (!filename) {
        filename = NSStringFromClass(modelObjClass);
    }
    NSDictionary* object = [NSDictionary dictionaryWithContentsOfFile:[self filePath:filename]];
    JSONModelError* initError;
    id modelObj = [[modelObjClass alloc] initWithDictionary: object error:&initError];
    if (!modelObj) {
        modelObj = [[modelObjClass alloc] init];
    }
    return modelObj;
}


//查找类中的NSArray数组的属性名称
+ (NSArray *)getClassArrayTypePropertyNames:(Class)class keysArray:(NSMutableArray *)keysArray propertyName:(NSString *)superPropertyName{
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
                    NSArray* protocolArray = [protocolStr componentsSeparatedByString:@"<"];
                    for (NSString *prName in protocolArray) {
                        if(![prName isEqualToString:@"Optional"]&&![prName isEqualToString:@"Index"]
                           &&![prName isEqualToString:@"ConvertOnDemand"]&&![prName isEqualToString:@"Ignore"]){
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

//xml转换成dictionary后,xml中的数组如果是单行数据转换出来的对象不是数组，需要做以下处理
+ (void)transformDictionary:(NSDictionary *)tempDic superKey:(NSString *)superKey keysArray:(NSArray *)keysArray{
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
