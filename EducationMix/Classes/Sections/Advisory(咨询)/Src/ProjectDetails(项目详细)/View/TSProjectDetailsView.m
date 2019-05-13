//
//  TSProjectDetailsView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSProjectDetailsView.h"

@interface TSProjectDetailsView ()

@property(nonatomic, strong)IBOutlet UILabel *project_name;
@property(nonatomic, strong)IBOutlet UILabel *project_area;
@property(nonatomic, strong)IBOutlet UILabel *project_type;
@property(nonatomic, strong)IBOutlet UILabel *member_id;
@property(nonatomic, strong)IBOutlet UILabel *own_name;

@property(nonatomic, strong)IBOutlet UILabel *principal_name;
@property(nonatomic, strong)IBOutlet UILabel *project_create_time;
@property(nonatomic, strong)IBOutlet UILabel *contact_email;
@property(nonatomic, strong)IBOutlet UILabel *project_address;
@property(nonatomic, strong)IBOutlet UILabel *progress_stage;

@property(nonatomic, strong)IBOutlet UILabel *project_introduction;
@property(nonatomic, strong)IBOutlet UILabel *project_prospects;
@property(nonatomic, strong)IBOutlet UIImageView *project_pictures;
@property(nonatomic, strong)IBOutlet UILabel *funds_demand;
@property(nonatomic, strong)IBOutlet UILabel *base_demand;

@property(nonatomic, strong)IBOutlet UILabel *technology_demand;
@property(nonatomic, strong)IBOutlet UILabel *equipment_demand;
@property(nonatomic, strong)IBOutlet UILabel *cooperation_method;
@property(nonatomic, strong)IBOutlet UILabel *contact;
@property(nonatomic, strong)IBOutlet UILabel *contact_phone;

@property(nonatomic, strong)IBOutlet UILabel *publish_time;
@property(nonatomic, strong)IBOutlet UILabel *publish_type;
@property(nonatomic, strong)IBOutlet UILabel *project_create_type;

@end

@implementation TSProjectDetailsView

- (void)setModel:(TSProjectDetailsModel *)model {
    
    _project_name.text = model.project_name;
    _project_area.text = model.project_area;
    _project_type.text = [NSString getProjectOwnerType:model.project_type];
    _own_name.text = model.own_name;
    _principal_name.text = model.principal_name;
    
    _project_create_time.text = model.project_create_time;
    _project_address.text = model.project_address;
    _project_introduction.text = model.project_introduction;
    _project_prospects.text = model.project_prospects;
    _cooperation_method.text = model.cooperation_method;
    
    _contact.text = model.contact;
    _contact_phone.text = model.contact_phone;
    _publish_time.text = model.publish_time;
//    _project_create_type.text = model.project_create_type;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.project_pictures];
    
    [_project_pictures sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    
    _project_area.text = [model.project_area stringByReplacingOccurrencesOfString:@"|" withString:@" "];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
