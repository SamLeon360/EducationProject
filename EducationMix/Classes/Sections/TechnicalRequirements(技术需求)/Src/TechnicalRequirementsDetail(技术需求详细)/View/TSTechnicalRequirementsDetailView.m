//
//  TSTechnicalRequirementsDetailView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTechnicalRequirementsDetailView.h"

@interface TSTechnicalRequirementsDetailView ()

@property(nonatomic,strong)IBOutlet UILabel *technology_name;
@property(nonatomic,strong)IBOutlet UILabel *domain;
@property(nonatomic,strong)IBOutlet UILabel *demand_type;
@property(nonatomic,strong)IBOutlet UILabel *demand_reason;
@property(nonatomic,strong)IBOutlet UILabel *name;

@property(nonatomic,strong)IBOutlet UILabel *demand_method;
@property(nonatomic,strong)IBOutlet UILabel *budget_money;
@property(nonatomic,strong)IBOutlet UILabel *technology_description;
@property(nonatomic,strong)IBOutlet UILabel *contacts_person;
@property(nonatomic,strong)IBOutlet UILabel *contacts_phone;

@property(nonatomic,strong)IBOutlet UILabel *allow_publish;
@property(nonatomic,strong)IBOutlet UILabel *create_time;
@property(nonatomic,strong)IBOutlet UILabel *enterprise_id;
@property(nonatomic,strong)IBOutlet UILabel *enterprise_name;
@property(nonatomic,strong)IBOutlet UILabel *enterprise_type;

@property(nonatomic,strong)IBOutlet UILabel *member_id;



@end

@implementation TSTechnicalRequirementsDetailView

- (void)setModel:(TSTechnicalRequirementsDetailModel *)model {
    
    _technology_name.text = model.technology_name;
    _domain.text = [NSString getProfessionalField:model.domain];
    _demand_type.text = [NSString getOwnType:model.demand_type];
    _demand_reason.text = model.demand_reason;
    _demand_method.text = model.demand_method;
    
    _budget_money.text = [NSString stringWithFormat:@"%d(万元)",model.budget_money];
    _technology_description.text = model.technology_description;
    _contacts_phone.text = model.contacts_phone;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
