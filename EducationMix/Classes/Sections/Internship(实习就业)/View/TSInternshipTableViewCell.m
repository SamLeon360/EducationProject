//
//  TSInternshipTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInternshipTableViewCell.h"

@interface TSInternshipTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *job_name;
@property (strong, nonatomic) IBOutlet UILabel *enterprise_name;
@property (strong, nonatomic) IBOutlet UILabel *end_time;
@property (strong, nonatomic) IBOutlet UILabel *welfare;
@property (strong, nonatomic) IBOutlet UILabel *salary;

@property (strong, nonatomic) IBOutlet UILabel *area;

@end

@implementation TSInternshipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSInternshipModel *)model {
    
    _job_name.text = model.job_name;
    _enterprise_name.text = model.enterprise_name;
    _end_time.text = model.end_time;
    _welfare.text = model.welfare;
    _salary.text = [NSString stringWithFormat:@"%ld-%ld元/月",model.salary_min,model.salary_max];
    _area.text = model.area;
    
    
}

- (void)setFrame:(CGRect)frame{
    //frame.origin.x += 10;
    //frame.origin.y += 8;
    frame.size.height -= 8;
    //frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
