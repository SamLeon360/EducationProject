//
//  TSLibraryTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/15.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSLibraryTableViewCell.h"

@implementation TSLibraryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 8;
    frame.size.height -= 8;
    frame.size.width -= 20;
    [super setFrame:frame];
}

@end
