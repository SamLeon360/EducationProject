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
//
//case '1':
//return '电子信息';
//case '2':
//return '装备制造';
//case '3':
//return '能源环保';
//case '4':
//return '生物技术与医药';
//case '5':
//return '新材料';
//case '6':
//return '现代农业';
//case '7':
//return '其他';

+ (NSString *)getProfessionalField:(NSInteger)professionalFieldId {
    
    NSString *result = [[NSString alloc] init];
    
    switch (professionalFieldId) {
        case 1:
            result = @"电子信息";
            break;
        case 2:
            result = @"装备制造";
            break;
        case 3:
            result = @"能源环保";
            break;
        case 4:
            result = @"生物技术与医药";
            break;
        case 5:
            result = @"新材料";
            break;
        case 6:
            result = @"现代农业";
            break;
        case 7:
            result = @"其他";
            break;
            
        default:
            result = @"其他";

            break;
    }
    
    return result;
    
}

@end
