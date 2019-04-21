//
//  TSBusinessAssociationTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSBusinessAssociationTableViewCell.h"

@interface TSBusinessAssociationTableViewCell ()

@property(nonatomic, strong)IBOutlet UILabel *commerce_name;
@property(nonatomic, strong)IBOutlet UILabel *commerce_type;
@property(nonatomic, strong)IBOutlet UILabel *commerce_location;
@property(nonatomic, strong)IBOutlet UILabel *ct;

@property(nonatomic, strong)IBOutlet UIImageView *commerce_logo;


//"commerce_id":144,
//"ct":104,
//"commerce_name":"中山市贵州商会",
//"commerce_type":"4",
//"examination_grade":4,
//"commerce_logo":"/uploads/commerce/144/144.jpg",
//"commerce_location":"中山市"

@end

@implementation TSBusinessAssociationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSBusinessAssociationModel *)model {
    
    _commerce_name.text = model.commerce_name;
    _commerce_type.text = [NSString getCommerceType:[model.commerce_type integerValue]];
    _commerce_location.text = model.commerce_location;
    _ct.text = [NSString stringWithFormat:@"%d名成员",model.ct];
    
    
    if (model.commerce_logo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.commerce_logo];
        
        [_commerce_logo sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    }
    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 8;
    frame.size.height -= 8;
    frame.size.width -= 20;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
