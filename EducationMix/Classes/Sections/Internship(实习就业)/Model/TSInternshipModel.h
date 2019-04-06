//
//  TSInternshipModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInternshipModel : NSObject

@property (nonatomic, strong)NSString *member_name;
@property (nonatomic, strong)NSString *job_name;
@property (nonatomic, strong)NSString *enterprise_name;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *area;

@property (nonatomic, strong)NSString *work_address;
@property (nonatomic, strong)NSString *start_time;
@property (nonatomic, strong)NSString *end_time;
@property (nonatomic, strong)NSString *age_limit;
@property (nonatomic, strong)NSString *welfare;

@property (nonatomic, assign)NSInteger talent_id;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger commerce_id;
@property (nonatomic, assign)NSInteger work_life;
@property (nonatomic, assign)NSInteger work_type;

@property (nonatomic, assign)NSInteger job_type;
@property (nonatomic, assign)NSInteger enterprise_id;
@property (nonatomic, assign)NSInteger allow_publish;
@property (nonatomic, assign)NSInteger salary_min;
@property (nonatomic, assign)NSInteger salary_max;

@property (nonatomic, assign)NSInteger experience_equirements;

//"talent_id":72,
//"member_name":"徐先生",
//"member_id":3377,
//"commerce_id":246,
//"job_name":"外贸跟单",
//"work_life":1,
//"work_type":1,
//"job_type":4,
//"enterprise_id":2044,
//"enterprise_name":"中山市嘉诚文具有限公司",
//"allow_publish":1,
//"create_time":"2019-02-28 17:46:26",
//"salary_min":4000,
//"salary_max":5500,
//"area":"广东省|中山市|",
//"work_address":"小榄镇永宁洪联路146号（小榄车站乘8路、5路路洪联路口站下车）",
//"experience_equirements":null,
//"start_time":"2019-02-28",
//"age_limit":null,
//"end_time":"2019-04-28",
//"welfare":"话补"

@end

NS_ASSUME_NONNULL_END
