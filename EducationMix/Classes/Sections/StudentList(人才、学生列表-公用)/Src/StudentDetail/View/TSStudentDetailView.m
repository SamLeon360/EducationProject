//
//  TSStudentDetailView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/2.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSStudentDetailView.h"

@interface TSStudentDetailView ()

@property (strong, nonatomic) IBOutlet UILabel *student_name;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *birthday;
@property (strong, nonatomic) IBOutlet UILabel *major;
@property (strong, nonatomic) IBOutlet UILabel *expect_jobs;

@property (strong, nonatomic) IBOutlet UILabel *expect_deadline;
@property (strong, nonatomic) IBOutlet UILabel *work_experience;
@property (strong, nonatomic) IBOutlet UILabel *project_experience;
@property (strong, nonatomic) IBOutlet UILabel *rewards;
@property (strong, nonatomic) IBOutlet UILabel *region;

@property (strong, nonatomic) IBOutlet UILabel *scholarship;
@property (strong, nonatomic) IBOutlet UILabel *campus_jobtitle;
@property (strong, nonatomic) IBOutlet UILabel *internship_company;
@property (strong, nonatomic) IBOutlet UILabel *internship_positions;
@property (strong, nonatomic) IBOutlet UILabel *internship_time;

@property (strong, nonatomic) IBOutlet UILabel *internship_evaluation;
@property (strong, nonatomic) IBOutlet UILabel *self_evaluation;
@property (strong, nonatomic) IBOutlet UILabel *language_skills;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *academy_name;

@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *expect_salary;
@property (strong, nonatomic) IBOutlet UILabel *major_skill;

@end

@implementation TSStudentDetailView


- (void)setModel:(TSStudentDetailModel *)model {
    
    _student_name.text = model.student_name;
    _email.text = model.email;
    _birthday.text = model.birthday;
    _major.text = model.major;
    _expect_jobs.text = model.expect_jobs;
    
    _expect_deadline.text = model.expect_deadline;
    _work_experience.text = model.work_experience;
    _project_experience.text = model.project_experience;
    _rewards.text = model.rewards;
    _region.text = model.region;
    
    _scholarship.text = model.scholarship;
    _campus_jobtitle.text = model.campus_jobtitle;
    _internship_company.text = model.internship_company;
    _internship_positions.text = model.internship_positions;
    _internship_time.text = model.internship_time;
    
    _internship_evaluation.text = model.internship_evaluation;
    _self_evaluation.text = model.self_evaluation;
    _language_skills.text = model.language_skills;
    _phone.text = model.phone;
    _academy_name.text = model.academy_name;
    
    _sex.text = [NSString getSexWithSexData:[NSString stringWithFormat:@"%d",model.sex]];
    _expect_salary.text = [NSString stringWithFormat:@"%d",model.expect_salary];
    _major_skill.text = model.major_skill;

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
