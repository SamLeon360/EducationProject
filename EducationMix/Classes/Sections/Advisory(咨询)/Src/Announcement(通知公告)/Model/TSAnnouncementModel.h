//
//  TSAnnouncementModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSAnnouncementModel : NSObject


@property(nonatomic, strong)NSString *notify_title;
@property(nonatomic, strong)NSString *notify_img;
@property(nonatomic, strong)NSString *notify_content;
@property(nonatomic, assign)NSInteger publish_id;
@property(nonatomic, strong)NSString *publish_name;

@property(nonatomic, strong)NSString *create_time;


//"notify_title":"平台公告",
//"notify_img":null,
//"notify_content":"<p>10月27日至30日，由中国诗经学会主办、广西大学承办、上海大学中国古代文学与文化研究中心协办的“中国诗经学会第十二",
//"publish_id":1,
//"publish_name":"kunyi",
//"create_time":"2018-10-10 00:00:00",

@end

NS_ASSUME_NONNULL_END
