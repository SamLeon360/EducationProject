//
//  TSInternshipDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInternshipDetailModel : NSObject


@property (nonatomic, strong)NSString *member_name;
@property (nonatomic, strong)NSString *welfare;
@property (nonatomic, strong)NSString *work_address;
@property (nonatomic, strong)NSString *job_name;
@property (nonatomic, strong)NSString *job_description;

@property (nonatomic, strong)NSString *enterprise_name;
@property (nonatomic, strong)NSString *start_time;
@property (nonatomic, strong)NSString *contacts_phone;
@property (nonatomic, strong)NSString *area;
@property (nonatomic, strong)NSString *create_time;

@property (nonatomic, strong)NSString *end_time;

@property (nonatomic, assign)NSInteger talent_id;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger work_life;
@property (nonatomic, assign)NSInteger work_type;
@property (nonatomic, assign)NSInteger commerce_id;

@property (nonatomic, assign)NSInteger salary_min;
@property (nonatomic, assign)NSInteger salary_max;
@property (nonatomic, assign)NSInteger education;
@property (nonatomic, assign)NSInteger receive_fresh_graduate;
@property (nonatomic, assign)NSInteger job_type;

@property (nonatomic, assign)NSInteger enterprise_id;
@property (nonatomic, assign)NSInteger domain;
@property (nonatomic, assign)NSInteger allow_publish;
@property (nonatomic, assign)NSInteger experience_equirements;
@property (nonatomic, assign)NSInteger age_limit;


//
//"talent_id":72,
//"member_name":"徐先生",
//"member_id":3377,
//"work_life":1,
//"work_type":1,
//"commerce_id":246,
//"salary_min":4000,
//"salary_max":5500,
//"education":4,
//"receive_fresh_graduate":2,
//"welfare":"话补",
//"work_address":"小榄镇永宁洪联路146号（小榄车站乘8路、5路路洪联路口站下车）",
//"job_name":"外贸跟单",
//"job_type":4,
//"job_description":"有外贸跟单业务经验1年以上优先，应届生英语6级以上，善于沟通，刻苦上进，有业务天赋。",
//"enterprise_id":2044,
//"enterprise_name":"中山市嘉诚文具有限公司",
//"contacts_phone":"15625380913",
//"enterprise_type":7,
//"domain":7,
//"area":"广东省|中山市|",
//"allow_publish":1,
//"create_time":"2019-02-28 17:46:26",
//"experience_equirements":null,
//"age_limit":null,
//"start_time":"2019-02-28",
//"end_time":"2019-04-28"

@end

NS_ASSUME_NONNULL_END
