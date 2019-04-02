//
//  TSStudentDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/2.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//
//"student_id":3140,
//"member_id":3140,
//"academy_id":3,
//"sex":1,
//"student_name":"蔡恒远",
//"email":"ss@qq.cc",
//"birthday":"1998-05-22",
//"education":4,
//"major":"家具设计",
//"expect_jobs":"期望工作",
//"expect_salary":10000,
//"expect_deadline":"2019",
//"work_experience":"null",
//"project_experience":"工作经验",
//"rewards":"所获奖励",
//"certificate":null,
//"major_skill":"专业技能",
//"region":"广东省|中山市|",
//"scholarship":"奖学金",
//"campus_jobtitle":"校内职务",
//"internship_company":"实习公司",
//"internship_positions":"期望职位",
//"internship_time":"0000-00-00",
//"internship_evaluation":"实习单位评价",
//"self_evaluation":"自我评价",
//"language_skills":"语言能力",
//"phone":"13589465822",
//"photo":"/uploads/student/3140/3140.jpg",
//"attach":null,
//"academy_name":"中山职业技术学院"


@interface TSStudentDetailModel : NSObject

@property (nonatomic, strong)NSString *student_name;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *major;
@property (nonatomic, strong)NSString *expect_jobs;

@property (nonatomic, strong)NSString *expect_deadline;
@property (nonatomic, strong)NSString *work_experience;
@property (nonatomic, strong)NSString *project_experience;
@property (nonatomic, strong)NSString *rewards;
@property (nonatomic, strong)NSString *major_skill;

@property (nonatomic, strong)NSString *region;
@property (nonatomic, strong)NSString *scholarship;
@property (nonatomic, strong)NSString *campus_jobtitle;
@property (nonatomic, strong)NSString *internship_company;
@property (nonatomic, strong)NSString *internship_positions;

@property (nonatomic, strong)NSString *internship_time;
@property (nonatomic, strong)NSString *internship_evaluation;
@property (nonatomic, strong)NSString *self_evaluation;
@property (nonatomic, strong)NSString *language_skills;
@property (nonatomic, strong)NSString *phone;

@property (nonatomic, strong)NSString *academy_name;


@property (nonatomic, assign)NSInteger student_id;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, assign)NSInteger sex;
@property (nonatomic, assign)NSInteger education;

@property (nonatomic, assign)NSInteger expect_salary;
@property (nonatomic, assign)NSInteger certificate;
@property (nonatomic, assign)NSInteger attach;




@end

NS_ASSUME_NONNULL_END
