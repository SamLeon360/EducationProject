//
//  TSAdvisoryModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/7.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAdvisoryModel.h"

@implementation TSAdvisoryModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"ID":@"id"
             };
}

@end
