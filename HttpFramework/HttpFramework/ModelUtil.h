//
//  ModelStorage.h
//  HttpFramework
//
//  Created by 涂操 on 15/1/28.
//  Copyright (c) 2015年 涂操. All rights reserved.
//

#import "JSONModel.h"

@interface ModelUtil : JSONModel

+ (void)saveModelToFile:(id)modelObj filename:(NSString *)filename;

+ (id)loadModelFromFile:(Class)modelObjClass filename:(NSString *)filename;

+ (BOOL)removeModelFile:(Class)modelObjClass filename:(NSString *)filename;

+ (BOOL)saveToFileArchive:(id)modelObj filename:(NSString *)filename;

+ (id)loadFromFileArchive:(Class)modelObjClass filename:(NSString *)filename;

+ (NSArray *)getClassArrayTypePropertyNames:(Class)clazz keysArray:(NSMutableArray *)keysArray propertyName:(NSString *)superPropertyName;

+ (void)transformDictionary:(NSDictionary *)tempDic superKey:(NSString *)superKey keysArray:(NSArray *)keysArray;

@end
