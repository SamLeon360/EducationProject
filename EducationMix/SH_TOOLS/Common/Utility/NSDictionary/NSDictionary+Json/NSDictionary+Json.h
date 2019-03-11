//
//  NSDictionary+Json.h
//  PengKa
//
//  Created by zohar on 16/6/30.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Json)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSDictionary *)nullDic:(NSDictionary *)myDic;

+ (id)changeType:(id)myObj;

- (void)logDic;

- (NSString *)descriptionWithLocale:(id)locale;

@end
