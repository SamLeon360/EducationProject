//
//  TSTeacherDetailView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/3.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeacherDetailView.h"

@interface TSTeacherDetailView ()

@property (strong, nonatomic) IBOutlet UILabel *expert_name;
@property (strong, nonatomic) IBOutlet UILabel *birthday;
@property (strong, nonatomic) IBOutlet UILabel *affiliation_name;
@property (strong, nonatomic) IBOutlet UILabel *department_name;
@property (strong, nonatomic) IBOutlet UILabel *major_field;

@property (strong, nonatomic) IBOutlet UILabel *industrial_field;
@property (strong, nonatomic) IBOutlet UILabel *highest_education;
@property (strong, nonatomic) IBOutlet UILabel *graduate_school;
@property (strong, nonatomic) IBOutlet UILabel *personal_profile;
@property (strong, nonatomic) IBOutlet UILabel *scientific_research;

@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *email;
//@property (strong, nonatomic) IBOutlet UILabel *academy_logo;
@property (strong, nonatomic) IBOutlet UILabel *academy_name;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *academic_title;

@property (strong, nonatomic) IBOutlet UILabel *solve_ability;



@end


@implementation TSTeacherDetailView

- (void)setModel:(TSTeacherDetailModel *)model {
    
    _expert_name.text = model.expert_name;
    _academic_title.text = [NSString getAcademicTitle:model.academic_title];
    _affiliation_name.text = model.affiliation_name;
    _major_field.text = model.major_field;
    _solve_ability.text = model.solve_ability;
    _phone.text = model.phone;
    _personal_profile.text = model.personal_profile;
    
    NSInteger age = [NSDate getDateTimeIntervalWithStartDate:model.birthday];
    NSString *sexStr = [NSString getSexWithSexData:[NSString stringWithFormat:@"%ld",model.sex]];
    
    _sex.text = [NSString stringWithFormat:@"%@. %ld岁",sexStr,age];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
