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



+ (NSString *)getAcademicTitle:(NSInteger)academicTitleId {
    
    NSString *result = @"";
    
    //1:教授|2:副教授|3:高级工程师|4:中级工程师|5:初级工程师

    switch (academicTitleId) {
        case 1:
            result = @"教授";
            break;
        case 2:
            result = @"副教授";

            break;
        case 3:
            result = @"高级工程师";

            break;
        case 4:
            result = @"中级工程师";

            break;
        case 5:
            result = @"初级工程师";

            break;
            
        default:
            result = @"其他";

            break;
    }
    
    return result;
    
    
}

+ (NSString *)getResearchLevel:(NSInteger)researchLevel {
    
    
    NSString *result = @"";
    
    //                         <option value="" ng-selected="search_data.research_level==''"></option>
//    <option value="1" ng-selected="search_data.research_level==1">新技术</option>
//    <option value="2" ng-selected="search_data.research_level==2">新工艺</option>
//    <option value="3" ng-selected="search_data.research_level==3">新产品</option>
//    <option value="4" ng-selected="search_data.research_level==4">新材料</option>
//    <option value="5" ng-selected="search_data.research_level==5">新装备</option>
//    <option value="6" ng-selected="search_data.research_level==6">新品种</option>
//    <option value="7" ng-selected="search_data.research_level==7">新标准</option>
//    <option value="8" ng-selected="search_data.research_level==8">其他</option>
    
    switch (researchLevel) {
        case 1:
            result = @"新技术";
            break;
        case 2:
            result = @"新工艺";
            
            break;
        case 3:
            result = @"新产品";
            
            break;
        case 4:
            result = @"新材料";
            
            break;
        case 5:
            result = @"新装备";
            
            break;
        case 6:
            result = @"新品种";
            
            break;
        case 7:
            result = @"新标准";
            
            break;
        case 8:
            result = @"其他";
            
            break;
            
        default:
            result = @"其他";
            
            break;
    }
    
    return result;
    
}



+ (NSString *)getOwnType:(NSInteger)OwnType {
    
    NSString *result = @"";
    
//    < value="1" ng-selected="search_data.own_type==1">研制阶段</option>
//    < value="2" ng-selected="search_data.own_type==2">试产阶段</option>
//    < value="3" ng-selected="search_data.own_type==3">小批量生产阶段</option>
//    < value="4" ng-selected="search_data.own_type==4">批量生产阶段</option>
//    < value="5" ng-selected="search_data.own_type==5">其他</option>
    
    switch (OwnType) {
        case 1:
            result = @"研制阶段";
            break;
        case 2:
            result = @"试产阶段";
            
            break;
        case 3:
            result = @"小批量生产阶段";
            
            break;
        case 4:
            result = @"批量生产阶段";
            
            break;
        case 5:
            result = @"其他";
            
            break;
            
        default:
            result = @"其他";
            
            break;
    }
    
    return result;
    
}

//     //                case '1':
//                    return '本科院校';
//                case '2':
//                    return '大专院校';
//                case '3':
//                    return '高职院校';
//                case '4':
//                    return '事业单位';
//                case '5':
//                    return '企业';

+(NSString *)getUnitType:(NSInteger)unitType {
    
    NSString *result = @"";
    
    switch (unitType) {
        case 1:
            result = @"本科院校";
            break;
        case 2:
            result = @"大专院校";
            
            break;
        case 3:
            result = @"高职院校";
            
            break;
        case 4:
            result = @"事业单位";
            
            break;
        case 5:
            result = @"企业";
            
            break;
            
        default:
            result = @"其他";
            
            break;
    }
    
    return result;

}

//case '1':
//return '高新技术企业';
//case '2':
//return '科技型中小企业';
//case '3':
//return '规模以上企业';
//case '4':
//return '创新型企业';
//case '5':
//return '民营科技企业';
//case '6':
//return '大中型企业';
//case '7':
//return '其他';
+(NSString *)getFltEnterpriseQualifications:(NSInteger)fltEnterpriseQualifications {
    
    NSString *result = @"";
    
    switch (fltEnterpriseQualifications) {
        case 1:
            result = @"高新技术企业";
            break;
        case 2:
            result = @"科技型中小企业";
            
            break;
        case 3:
            result = @"规模以上企业";
            
            break;
        case 4:
            result = @"创新型企业";
            
            break;
        case 5:
            result = @"民营科技企业";
            
            break;
        case 6:
            result = @"大中型企业";
            
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
//1
//return '学生';
//case '2':
//return '专家';
//case '3':
//return '团队';
+(NSString *)getFltJoinType:(NSInteger)fltJoinType {
    
    
    NSString *result = @"";
    
    switch (fltJoinType) {
        case 1:
            result = @"学生";
            break;
        case 2:
            result = @"专家";
            break;
        case 3:
            result = @"团队";
            break;
            
        default:
            result = @"其他";
            
            break;
    }
    
    return result;

}

//'全部',
//'院校',
//'孵化园',
//'团队',
//'企业',
//'个人',
//'其他',
+(NSString *)getProjectOwnerType:(NSInteger)projectOwnerType {
    
    
    NSString *result = @"";
    
    switch (projectOwnerType) {
        case 0:
            result = @"全部";
            break;
            
        case 1:
            result = @"院校";
            break;
        case 2:
            result = @"孵化园";
            
            break;
        case 3:
            result = @"团队";
            
            break;
        case 4:
            result = @"个人";
            
            break;
        case 5:
            result = @"其他";
            
            break;
            
        default:
            result = @"其他";
            
            break;
    }
    
    return result;
    
}

@end
