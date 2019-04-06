//
//  TSInternshipDetailView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInternshipDetailView.h"

@interface TSInternshipDetailView ()

@property (strong, nonatomic) IBOutlet UILabel *job_name;
@property (strong, nonatomic) IBOutlet UILabel *education;
@property (strong, nonatomic) IBOutlet UILabel *welfare;
@property (strong, nonatomic) IBOutlet UILabel *work_address;
@property (strong, nonatomic) IBOutlet UILabel *job_description;

@property (strong, nonatomic) IBOutlet UILabel *enterprise_name;
@property (strong, nonatomic) IBOutlet UILabel *contacts_phone;
@property (strong, nonatomic) IBOutlet UILabel *salary;



@end

@implementation TSInternshipDetailView


- (void)setModel:(TSInternshipDetailModel *)model {
    
    _job_name.text = model.job_name;
//    _education.text = model.education;
    _welfare.text = model.welfare;
    _work_address.text = model.work_address;
    _job_description.text = model.job_description;
    _enterprise_name.text = model.enterprise_name;
    _contacts_phone.text = model.contacts_phone;
    
    _salary.text = [NSString stringWithFormat:@"%ld-%ld元/月",model.salary_min,model.salary_max];
    
    
    
    _education.text = [self getEducation:model.education withReceive_fresh_graduate:model.receive_fresh_graduate withage_limit:model.age_limit];
    
}

- (NSString *)getEducation:(NSInteger )education withReceive_fresh_graduate:(NSInteger )receive_fresh_graduate withage_limit:(NSInteger )age_limit  {
    
    NSArray *tmpArr = @[@"全部", @"博士", @"硕士", @"本科", @"大专", @"高职", @"中职", @"不限"];
    
    NSString *result = [[NSString alloc] init];
    NSString *educationString = [[NSString alloc] init];

    if (education == 7) {
        educationString = @"学历不限";
    }else{
        educationString = [NSString stringWithFormat:@"%@以上",tmpArr[education]];
    }
    NSString *requirOne = receive_fresh_graduate == 1?@"接受应届生":@"不接受应届生";
    NSString *requirTwo = [NSString stringWithFormat:@"%ld岁",age_limit];
    
    result = [NSString stringWithFormat:@"%@,%@,%@",educationString,requirOne,requirTwo];
    
    return result;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
