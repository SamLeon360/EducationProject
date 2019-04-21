//
//  TSMeTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/17.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSMeTableViewCell.h"

@interface TSMeTableViewCell ()

@property(nonatomic, strong)IBOutlet UILabel *title;
@property(nonatomic, strong)IBOutlet UIImageView *iconImage;


@end

@implementation TSMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSMeTableViewCellModel *)model {
    
    _title.text = model.title;
    _iconImage.image = [UIImage imageNamed:model.imageName];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    

    // Configure the view for the selected state
}

@end
