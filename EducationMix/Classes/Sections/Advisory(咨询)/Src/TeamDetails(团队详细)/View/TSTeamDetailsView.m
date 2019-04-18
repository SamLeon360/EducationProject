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
    
    if(!_model){
        _model = model;
    }
    
    _team_name.text = model.team_name;
    _professional_field.text = [NSString getProfessionalField:[model.professional_field integerValue]];

    _unit_name.text = model.unit_name;
    _team_profile.text = model.team_profile;
    _scientific_research_achievements.text = model.scientific_research_achievements;
    
    _team_leader_number.text = model.team_leader_number;
    _team_leaders_name.text = model.team_leaders_name;
    _research_direction.text = model.research_direction;
    _team_contact.text = model.team_contact;
    _contact_number.text = model.contact_number;
    
    _email.text = model.email;
    _research_subject.text = model.research_subject_new;
    _unit_type.text = [NSString getUnitType:model.unit_type];
    
    
    //多张图片处理。但：为快速上线，先只显示第一张图片
    NSArray *photoArr = [model.team_photo componentsSeparatedByString:@"|"]; //字符串按照【分隔成数组
    if(photoArr.count > 0){
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,photoArr[0]];
        [_team_photo sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    } else {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.team_photo];
        [_team_photo sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    }

}
- (IBAction)telAction:(id)sender {
    
    NSString *string = [NSString stringWithFormat:@"telprompt://%@",self.model.contact_number];
    
    NSURL *url = [NSURL URLWithString:string];
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
