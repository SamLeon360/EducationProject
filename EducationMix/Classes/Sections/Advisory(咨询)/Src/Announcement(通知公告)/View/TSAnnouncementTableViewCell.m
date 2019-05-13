//
//  TSAnnouncementTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAnnouncementTableViewCell.h"

@interface TSAnnouncementTableViewCell ()

@property(nonatomic, strong)IBOutlet UILabel *notify_title;
@property(nonatomic, strong)IBOutlet UILabel *publish_name;
@property(nonatomic, strong)IBOutlet UILabel *create_time;


//"notify_title":"平台公告",
//"notify_img":null,
//"notify_content":"<p>10月27日至30日，由中国诗经学会主办、广西大学承办、上海大学中国古代文学与文化研究中心协办的“中国诗经学会第十二",
//"publish_id":1,
//"publish_name":"kunyi",
//"create_time":"2018-10-10 00:00:00",

@end

@implementation TSAnnouncementTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(TSAnnouncementModel *)model {
    
    _notify_title.text = model.notify_title;
    _publish_name.text = model.publish_name;
    _create_time.text = model.create_time;
    
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
