//
//  TSStudentListTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSStudentListTableViewCell.h"

@interface TSStudentListTableViewCell ()

@property (nonatomic, strong)IBOutlet UIImageView *studentImageView;

@property (strong, nonatomic) IBOutlet UILabel *student_name;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *major;

@property (strong, nonatomic) IBOutlet UILabel *gradution_time;

@end

@implementation TSStudentListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(TSStudentListModel *)model {
    
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
