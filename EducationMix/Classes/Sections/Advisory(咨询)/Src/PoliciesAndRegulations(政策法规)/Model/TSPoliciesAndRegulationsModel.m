//
//  TSPoliciesAndRegulationsModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/11.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSPoliciesAndRegulationsModel.h"

@implementation TSPoliciesAndRegulationsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"Id":@"id"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (oldValue == [NSNull null]) {
        if ([oldValue isKindOfClass:[NSArray class]]) {
            return  @[];
        }else if([oldValue isKindOfClass:[NSDictionary class]]){
            return @{};
        }else{
            return @"";
        }
    }
    return oldValue;
}
@end
