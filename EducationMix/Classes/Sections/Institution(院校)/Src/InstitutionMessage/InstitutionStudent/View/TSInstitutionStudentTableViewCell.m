//
//  TSInstitutionStudentTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionStudentTableViewCell.h"

@interface TSInstitutionStudentTableViewCell ()

@property (nonatomic, strong)IBOutlet UIImageView *studentImageView;

@property (strong, nonatomic) IBOutlet UILabel *student_name;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *major;

@property (strong, nonatomic) IBOutlet UILabel *gradution_time;

@end

@implementation TSInstitutionStudentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.imageView.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.imageView.layer.mask = maskLayer;
}


- (void)setModel:(TSInstitutionStudentModel *)model {
    
    if (model.photo) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.photo];
        
        [_studentImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
    }
    
    
    _student_name.text = model.student_name;
    _sex.text = [NSString getSexWithSexData:model.sex];
    _major.text = model.major;
    
    _gradution_time.text = [NSString stringWithFormat:@"%ld 年",(long)[NSDate getDateTimeIntervalWithStartDate:model.graduation_time]];
    

    
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
