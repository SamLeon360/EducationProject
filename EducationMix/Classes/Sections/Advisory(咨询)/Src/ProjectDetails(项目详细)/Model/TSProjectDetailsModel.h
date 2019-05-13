//
//  TSProjectDetailsModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSProjectDetailsModel : NSObject

@property(nonatomic, strong)NSString *project_name;
@property(nonatomic, strong)NSString *project_area;
@property(nonatomic, strong)NSString *own_name;
@property(nonatomic, strong)NSString *principal_name;
@property(nonatomic, strong)NSString *project_create_time;

@property(nonatomic, strong)NSString *project_address;
@property(nonatomic, strong)NSString *progress_stage;
@property(nonatomic, strong)NSString *project_introduction;
@property(nonatomic, strong)NSString *project_prospects;
@property(nonatomic, strong)NSString *project_pictures;

@property(nonatomic, strong)NSString *base_demand;
@property(nonatomic, strong)NSString *technology_demand;
@property(nonatomic, strong)NSString *equipment_demand;
@property(nonatomic, strong)NSString *cooperation_method;
@property(nonatomic, strong)NSString *contact;

@property(nonatomic, strong)NSString *contact_phone;
@property(nonatomic, strong)NSString *contact_email;
@property(nonatomic, strong)NSString *publish_time;

@property(nonatomic, assign)NSInteger project_id;
@property(nonatomic, assign)NSInteger project_type;
@property(nonatomic, assign)NSInteger member_id;
@property(nonatomic, assign)NSInteger funds_demand;
@property(nonatomic, assign)NSInteger publish_type;

@property(nonatomic, assign)NSInteger project_create_type;


//
//
//"project_id":62,
//"project_name":"微信自媒体平台的ERP沙盘实验开放制度研究",
//"project_area":"广东省|中山市|",
//"project_type":3,
//"member_id":555,
//"own_name":"中山职业技术学院",
//"principal_name":"刘老师",
//"project_create_time":"2018-11-02 16:06:44",
//"project_address":"",
//"progress_stage":"2",
//"project_introduction":"",
//"project_prospects":"",
//"project_pictures":"/uploads/EnterpriseInfo/20190329/1553848181388951527.jpg",
//"funds_demand":85,
//"base_demand":"无",
//"technology_demand":"无",
//"equipment_demand":"无",
//"cooperation_method":"投资",
//"contact":"文教授",
//"contact_phone":"13549933482",
//"contact_email":"445131@qq.com",
//"publish_time":"2019-03-29 00:00:00",
//"publish_type":1,
//"project_create_type":2
@end

NS_ASSUME_NONNULL_END
