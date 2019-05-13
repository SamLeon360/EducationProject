//
//  TSTeacherListTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeacherListTableViewCell.h"

@interface TSTeacherListTableViewCell ()

@property (nonatomic, strong)IBOutlet UIImageView *teacherImageView;

@property (nonatomic, strong)IBOutlet UILabel *name;
@property (nonatomic, strong)IBOutlet UILabel *type;
@property (nonatomic, strong)IBOutlet UILabel *professionalDirection;
@property (nonatomic, strong)IBOutlet UILabel *professionalField;

@end

@implementation TSTeacherListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(TSTeacherListModel *)model {
    
    _name.text = model.expert_name;
    _type.text = model.major_field;
    
    _professionalField.text = [NSString getProfessionalField:[model.industrial_field integerValue]];
    _professionalDirection.text = model.major_field;
    
    if (model.photo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.photo];
        
        [_teacherImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    }
    //    _professionalField.text = model.major_field
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
