//
//  TSTeamDetailsView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeamDetailsView.h"

@interface TSTeamDetailsView ()

@property(nonatomic,strong)IBOutlet UILabel *team_name;
@property(nonatomic,strong)IBOutlet UILabel *formation_date;
@property(nonatomic,strong)IBOutlet UILabel *professional_field;
@property(nonatomic,strong)IBOutlet UILabel *unit_name;
@property(nonatomic,strong)IBOutlet UILabel *team_profile;

@property(nonatomic,strong)IBOutlet UILabel *scientific_research_achievements;
@property(nonatomic,strong)IBOutlet UILabel *team_leader_number;
@property(nonatomic,strong)IBOutlet UILabel *team_leaders_name;
@property(nonatomic,strong)IBOutlet UILabel *research_direction;
@property(nonatomic,strong)IBOutlet UILabel *responsible_jobtitle;

@property(nonatomic,strong)IBOutlet UILabel *need_talent;
@property(nonatomic,strong)IBOutlet UILabel *personnel_demand_quantity;
@property(nonatomic,strong)IBOutlet UILabel *personnel_requirements;
@property(nonatomic,strong)IBOutlet UILabel *team_contact;
@property(nonatomic,strong)IBOutlet UILabel *contact_number;

@property(nonatomic,strong)IBOutlet UILabel *email;
@property(nonatomic,strong)IBOutlet UIImageView *team_photo;
@property(nonatomic,strong)IBOutlet UILabel *research_subject;
@property(nonatomic,strong)IBOutlet UILabel *unit_type;

@end

@implementation TSTeamDetailsView

- (void)setModel:(TSTeamDetailsModel *)model {
    
    _team_name.text = model.team_name;
    _professional_field.text = model.professional_field;
    _unit_name.text = model.unit_name;
    _team_profile.text = model.team_profile;
    _scientific_research_achievements.text = model.scientific_research_achievements;
    
    _team_leader_number.text = model.team_leader_number;
    _team_leaders_name.text = model.team_leaders_name;
    _research_direction.text = model.research_direction;
    _team_contact.text = model.team_contact;
    _contact_number.text = model.contact_number;
    
    _email.text = model.email;
    _research_subject.text = model.research_subject;
    _unit_type.text = model.unit_type;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
