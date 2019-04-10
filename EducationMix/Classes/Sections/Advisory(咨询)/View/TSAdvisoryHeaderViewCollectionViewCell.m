//
//  TSAdvisoryHeaderViewCollectionViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/7.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAdvisoryHeaderViewCollectionViewCell.h"

@interface TSAdvisoryHeaderViewCollectionViewCell ()

@property(nonatomic, strong)IBOutlet UILabel *name;
@property(nonatomic, strong)IBOutlet UILabel *engName;
@property(nonatomic, strong)IBOutlet UIImageView *iconImageView;


@end

@implementation TSAdvisoryHeaderViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSAdvisoryHeaderViewCollectionViewCellModel *)model {
    
    _name.text = model.name;
    _engName.text = model.englishName;
    _iconImageView.image = [UIImage imageNamed:model.image];
    
}


@end
