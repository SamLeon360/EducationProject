//
//  TSTechnicalRequirementsTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTechnicalRequirementsTableViewCell.h"

@interface TSTechnicalRequirementsTableViewCell ()

@property(nonatomic, strong)IBOutlet UILabel *technology_name;
@property(nonatomic, strong)IBOutlet UILabel *budget_money;
@property(nonatomic, strong)IBOutlet UILabel *demand_type;
@property(nonatomic, strong)IBOutlet UILabel *create_time;
@property(nonatomic, strong)IBOutlet UILabel *enterprise_name;

@property(nonatomic, strong)IBOutlet UILabel *domain;



//"technology_id":25,
//"technology_name":"网页开发",
//"commerce_id":158,
//"domain":7,
//"demand_type":5,
//"budget_money":5,
//"create_time":"2019-02-22 00:00:00",
//"enterprise_id":1871,
//"enterprise_name":"测试",
//"enterprise_type":7,
//"member_id":3142,
//"member_name":"李"
@end

@implementation TSTechnicalRequirementsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSTechnicalRequirementsModel *)model {
    
    _technology_name.text = model.technology_name;
    _domain.text = [NSString getFltEnterpriseQualifications:model.domain];
    _budget_money.text = [NSString stringWithFormat:@"%@ (万)",model.budget_money];
    _create_time.text = model.create_time;
    _enterprise_name.text = model.enterprise_name;
    _demand_type.text = [NSString getProfessionalField:model.demand_type];
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 8;
    frame.size.height -= 8;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
