//
//  TSTSAdvisoryTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/8.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTSAdvisoryTableViewCell.h"


@implementation TSTSAdvisoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSAdvisoryModel *)model {
    
    _name.text = model.name;
    _user_name.text = model.user_name;
    _type.text = [NSString getProfessionalField:model.type];
    _time.text = model.time;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    //frame.origin.x += 10;
    //frame.origin.y += 8;
    frame.size.height -= 8;
    //frame.size.width -= 20;
    [super setFrame:frame];
}


@end
