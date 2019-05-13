//
//  TSMeModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/17.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSMeTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSMeModel : NSObject

@property(nonatomic, strong)NSArray *modelArr;


@property(nonatomic, strong)NSString *student_name;
@property(nonatomic, strong)NSString *email;
@property(nonatomic, strong)NSString *birthday;
@property(nonatomic, strong)NSString *certificate;
@property(nonatomic, strong)NSString *major;

@property(nonatomic, strong)NSString *expect_jobs;
@property(nonatomic, strong)NSString *expect_deadline;
@property(nonatomic, strong)NSString *phone;
@property(nonatomic, strong)NSString *photo;
@property(nonatomic, strong)NSString *attach;

@property(nonatomic, strong)NSString *teacher_name;
@property(nonatomic, strong)NSString *teacher_phone;
@property(nonatomic, strong)NSString *campus_jobtitle;
@property(nonatomic, strong)NSString *internship_company;
@property(nonatomic, strong)NSString *internship_positions;

@property(nonatomic, strong)NSString *internship_time;
@property(nonatomic, strong)NSString *internship_evaluation;
@property(nonatomic, strong)NSString *self_evaluation;
@property(nonatomic, strong)NSString *scholarship;
@property(nonatomic, strong)NSString *graduation_time;

@property(nonatomic, strong)NSString *language_skills;
@property(nonatomic, strong)NSString *major_skill;
@property(nonatomic, strong)NSString *work_experience;
@property(nonatomic, strong)NSString *project_experience;
@property(nonatomic, strong)NSString *rewards;

@property(nonatomic, strong)NSString *region;
@property(nonatomic, strong)NSString *native_place;
@property(nonatomic, strong)NSString *mobile_phone;

@property(nonatomic, assign)NSInteger student_id;
@property(nonatomic, assign)NSInteger member_id;
@property(nonatomic, assign)NSInteger academy_id;
@property(nonatomic, assign)NSInteger sex;
@property(nonatomic, assign)NSInteger education;

@property(nonatomic, assign)NSInteger expect_salary;

@property(nonatomic, strong)NSArray *meTableViewCellModelArr;

//"student_id":498,
//"member_id":498,
//"academy_id":2,
//"sex":1,
//"student_name":"李健",
//"email":"ffhjbcbm@ccvyyvu.cn",
//"birthday":"1997-06-11",
//"certificate":"/uploads/student/498/certificate_0.jpg|/uploads/student/498/certificate_1.jpg|/uploads/student/498/certificate_2.jpg|/uploads/student/498/certificate_3.jpg",
//"education":4,
//"major":"物联网",
//"expect_jobs":"程序员",
//"expect_salary":5000,
//"expect_deadline":"3个月",
//"phone":"13200001111",
//"photo":"/uploads/student/498/498.jpg",
//"attach":null,
//"teacher_id":null,
//"teacher_name":"张志",
//"teacher_phone":"13112345678",
//"campus_jobtitle":"学生会干事",
//"internship_company":"中山市首度信息科技有限公司",
//"internship_positions":"实习生",
//"internship_time":"2018-09-30",
//"internship_evaluation":"在实习期间表现良好，积极主动，做事仔细",
//"self_evaluation":"本人积极上进，能按时完成上级分配的任务。",
//"scholarship":"获得过国家奖学金",
//"graduation_time":"2018-09-01",
//"language_skills":"英语4级",
//"major_skill":"C语言、java",
//"work_experience":"以前在一家网络公司当过实习生。 ",
//"project_experience":"暑期在网络公司工作过",
//"rewards":"",
//"region":"台湾|嘉义市|其它区",
//"native_place":"广州",
//"mobile_phone":"13200001111"

@end

NS_ASSUME_NONNULL_END
