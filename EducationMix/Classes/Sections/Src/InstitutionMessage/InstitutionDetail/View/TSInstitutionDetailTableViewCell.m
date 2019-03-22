//
//  TSInstitutionDetailTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailTableViewCell.h"

@interface TSInstitutionDetailTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel  *institutionType;
@property (strong, nonatomic) IBOutlet UILabel  *institutionAddress;


@property (strong, nonatomic) IBOutlet UIView *line;

@end


@implementation TSInstitutionDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _line.backgroundColor = TSColor_RGB(244, 244, 244);
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
