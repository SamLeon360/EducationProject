//
//  TSInstitutionTeacherTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionTeacherTableViewCell.h"

@interface TSInstitutionTeacherTableViewCell ()

@property (nonatomic, strong)IBOutlet UIImageView *teacherImageView;

@property (nonatomic, strong)IBOutlet UILabel *name;
@property (nonatomic, strong)IBOutlet UILabel *type;
@property (nonatomic, strong)IBOutlet UILabel *professionalDirection;
@property (nonatomic, strong)IBOutlet UILabel *professionalField;

@end

@implementation TSInstitutionTeacherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.imageView.bounds.size];
//
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
//    //设置大小
//    maskLayer.frame = self.imageView.bounds;
//    //设置图形样子
//    maskLayer.path = maskPath.CGPath;
//    self.imageView.layer.mask = maskLayer;

    // Initialization code
}

- (void)setModel:(TSInstitutionTeacherModel *)model {
    
    
    
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
