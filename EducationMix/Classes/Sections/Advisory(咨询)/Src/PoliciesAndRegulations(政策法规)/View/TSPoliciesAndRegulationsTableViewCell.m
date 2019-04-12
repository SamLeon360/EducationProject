//
//  TSPoliciesAndRegulationsTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/11.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSPoliciesAndRegulationsTableViewCell.h"

@interface TSPoliciesAndRegulationsTableViewCell ()


@property(nonatomic, strong)IBOutlet UILabel *headlines;
@property(nonatomic, strong)IBOutlet UILabel *headlines2;
@property(nonatomic, strong)IBOutlet UILabel *publish_time;
@property(nonatomic, strong)IBOutlet UIImageView *headlines_img;

//"headlines":"国务院办公厅关于同意建立自然灾害防治工作部际联席会议制度的函",
//"headlines2":"国办函〔2019〕30号",
//"headlines_img":null,
//"publish_time":"2019-04-10 00:00:00"

@end

@implementation TSPoliciesAndRegulationsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSPoliciesAndRegulationsModel *)model {
    
    _headlines.text = model.headlines;
    _headlines2.text = model.headlines2;
    _publish_time.text = model.publish_time;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.headlines_img];
    
    [_headlines_img sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil options:SDWebImageLowPriority];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame{
    //frame.origin.x += 10;
    //frame.origin.y += 8;
    frame.size.height -= 8;
    //frame.size.width -= 20;
    [super setFrame:frame];
}


@end
