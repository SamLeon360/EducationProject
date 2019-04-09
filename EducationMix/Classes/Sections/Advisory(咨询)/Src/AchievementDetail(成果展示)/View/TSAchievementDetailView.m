//
//  TSAchievementDetailView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/8.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAchievementDetailView.h"

@interface TSAchievementDetailView ()


@property(nonatomic, strong)IBOutlet UILabel *results_name;
@property(nonatomic, strong)IBOutlet UILabel *research_get_date;
@property(nonatomic, strong)IBOutlet UILabel *research_introduction;
@property(nonatomic, strong)IBOutlet UILabel *research_scene;
@property(nonatomic, strong)IBOutlet UILabel *advantages;

@property(nonatomic, strong)IBOutlet UILabel *own_name;
@property(nonatomic, strong)IBOutlet UILabel *major;
@property(nonatomic, strong)IBOutlet UILabel *responsible_person;
@property(nonatomic, strong)IBOutlet UILabel *transfer_mode;
@property(nonatomic, strong)IBOutlet UILabel *complete_unit;

@property(nonatomic, strong)IBOutlet UILabel *region;
@property(nonatomic, strong)IBOutlet UILabel *complete_time;
@property(nonatomic, strong)IBOutlet UILabel *innovation_points;
@property(nonatomic, strong)IBOutlet UILabel *technical_indicators;
@property(nonatomic, strong)IBOutlet UILabel *patent_situation;

@property(nonatomic, strong)IBOutlet UILabel *other_instructions;
@property(nonatomic, strong)IBOutlet UILabel *contact;
@property(nonatomic, strong)IBOutlet UILabel *contact_phone;
@property(nonatomic, strong)IBOutlet UILabel *contact_email;
@property(nonatomic, strong)IBOutlet UILabel *address;

@property(nonatomic, strong)IBOutlet UILabel *combined_service;
@property(nonatomic, strong)IBOutlet UILabel *domain;
@property(nonatomic, strong)IBOutlet UILabel *research_level;
@property(nonatomic, strong)IBOutlet UILabel *own_type;

@property(nonatomic, strong)IBOutlet UIImageView *research_pictures;

@end

@implementation TSAchievementDetailView


- (void)setModel:(TSAchievementDetailModel *)model {
    
    _results_name.text = model.results_name;
    _research_introduction.text = model.research_introduction;
    _transfer_mode.text = model.transfer_mode;
    _complete_unit.text = model.complete_unit;
    _region.text = model.region;
    
    _complete_time.text = model.complete_time;
    _innovation_points.text = model.innovation_points;
    _technical_indicators.text = model.technical_indicators;
    _patent_situation.text = model.patent_situation;
    _contact.text = model.contact;
    
    _contact_phone.text = model.contact_phone;
    _contact_email.text = model.contact_email;
    _combined_service.text = model.combined_service;
    _domain.text = [NSString getProfessionalField:model.domain];
    _research_level.text = [NSString getResearchLevel:model.research_level];
    _own_type.text = [NSString getOwnType:model.own_type];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.research_pictures];
    
    [_research_pictures sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
