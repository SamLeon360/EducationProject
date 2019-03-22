//
//  TSInstitutionTeacherTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionTeacherTableViewCell.h"

@implementation TSInstitutionTeacherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
