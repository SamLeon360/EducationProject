//
//  NSString+TSExtension.m
//  EducationMix
//
//  Created by Taosky on 2019/3/29.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "NSString+TSExtension.h"

@implementation NSString (TSExtension)

//$str = [0 => '未填写', 1 => '男',2=>'女',3=>'保密',''=>'未填写','男'=>'男','女'=>'女','保密'=>'保密'];
+ (NSString *)getSexWithSexData:(NSString *)sex {
    
    NSString *sexStr = [[NSString alloc] init];

  
    if([sex isEqualToString:@"0"] ||[sex isEqualToString:@""]) {
        sexStr = @"未填写";
    } else if ([sex isEqualToString:@"1"]) {
        sexStr = @"男";

    } else if ([sex isEqualToString:@"2"]) {
        sexStr = @"女";

    } else if ([sex isEqualToString:@"3"]) {
        sexStr = @"保密";

    } else {
        sexStr = sex;

    }

    
    return sexStr;
}

@end
