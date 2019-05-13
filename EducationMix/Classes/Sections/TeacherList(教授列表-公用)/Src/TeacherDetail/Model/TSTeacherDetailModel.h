//
//  TSTeacherDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/3.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTeacherDetailModel : NSObject


@property (nonatomic, strong)NSString *expert_name;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *affiliation_name;
@property (nonatomic, strong)NSString *department_name;
@property (nonatomic, strong)NSString *major_field;

@property (nonatomic, strong)NSString *industrial_field;
@property (nonatomic, strong)NSString *highest_education;
@property (nonatomic, strong)NSString *graduate_school;
@property (nonatomic, strong)NSString *personal_profile;
@property (nonatomic, strong)NSString *scientific_research;

@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *solve_ability;
@property (nonatomic, strong)NSString *research_direction;
@property (nonatomic, strong)NSString *photo;

@property (nonatomic, strong)NSString *mobile_phone;
@property (nonatomic, strong)NSString *academy_logo;
@property (nonatomic, strong)NSString *academy_name;

@property (nonatomic, assign)NSInteger expert_id;
@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger sex;
@property (nonatomic, assign)NSInteger age;

@property (nonatomic, assign)NSInteger expert_type;
@property (nonatomic, assign)NSInteger academic_title;
@property (nonatomic, assign)NSInteger affiliation_type;
@property (nonatomic, assign)NSInteger active_count;




//
//"expert_id":596,
//"expert_name":"刘昆毅",
//"academy_id":1,
//"member_id":596,
//"sex":1,
//"age":null,
//"birthday":"1983-04-07",
//"expert_type":1,
//"academic_title":2,
//"affiliation_type":3,
//"affiliation_name":"中山大学",
//"department_name":"数学学院",
//"major_field":"数学",
//"industrial_field":"3",
//"highest_education":"研究生",
//
//"graduate_school":"中山大学",
//"personal_profile":"中山大学副教授",
//"scientific_research":"数学类",
//"phone":"13802446017",
//"email":"1@163.com",
//"active_count":null,
//"solve_ability":null,
//"research_direction":null,
//"photo":null,
//"mobile_phone":null,
//"academy_logo":"/uploads/academy/1/1.jpg",
//"academy_name":"中山大学"

@end

NS_ASSUME_NONNULL_END
