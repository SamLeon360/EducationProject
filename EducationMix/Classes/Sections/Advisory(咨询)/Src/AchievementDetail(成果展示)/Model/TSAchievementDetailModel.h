//
//  TSAchievementDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/8.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSAchievementDetailModel : NSObject

@property(nonatomic, strong)NSString *results_name;
@property(nonatomic, strong)NSString *research_get_date;
@property(nonatomic, strong)NSString *research_introduction;
@property(nonatomic, strong)NSString *research_pictures;
@property(nonatomic, strong)NSString *research_scene;

@property(nonatomic, strong)NSString *advantages;
@property(nonatomic, strong)NSString *own_name;
@property(nonatomic, strong)NSString *major;
@property(nonatomic, strong)NSString *responsible_person;
@property(nonatomic, strong)NSString *transfer_mode;

@property(nonatomic, strong)NSString *complete_unit;
@property(nonatomic, strong)NSString *region;
@property(nonatomic, strong)NSString *complete_time;
@property(nonatomic, strong)NSString *innovation_points;
@property(nonatomic, strong)NSString *technical_indicators;

@property(nonatomic, strong)NSString *patent_situation;
@property(nonatomic, strong)NSString *contact;
@property(nonatomic, strong)NSString *contact_phone;
@property(nonatomic, strong)NSString *contact_email;
@property(nonatomic, strong)NSString *combined_service;

@property(nonatomic, strong)NSString *cooperation_method;
@property(nonatomic, strong)NSString *address;

@property(nonatomic, assign)NSInteger results_id;
@property(nonatomic, assign)NSInteger research_level;
@property(nonatomic, assign)NSInteger domain;
@property(nonatomic, assign)NSInteger own_type;
@property(nonatomic, assign)NSInteger apply_id;






//
//"results_id":74,
//"results_name":"挖掘机自动摇臂",
//"research_get_date":"2018-09-29",
//"research_level":1,
//"domain":6,
//"own_type":1,
//"research_introduction":"利用机器学习与神经网络知识、结合挖掘机摇臂，让摇臂自动识别挖掘目标，实现挖掘机摇臂自动化功能。",
//"research_pictures":"/uploads/result/74/research_pictures_0.jpg",
//"research_scene":"建造地质工程",
//"advantages":"减少人力成本、自动化处理",
//"own_name":"王磊",
//"major":"电子信息科学与技术",
//"responsible_person":"王磊",
//"transfer_mode":"工厂研发、专利转让",
//"complete_unit":"中山火炬职业技术学院",
//"region":"广东省|中山市|",
//"complete_time":"2018-09-29",
//"innovation_points":"使用神经网络学习使挖掘机自动寻找目标",
//"technical_indicators":"神经网络、机器学习",
//"patent_situation":"无",
//"other_instructions":"应用范围广",
//"contact":"王磊",
//"contact_phone":"13658886999",
//"contact_email":"13658886999@163.com",
//"combined_service":null,
//"cooperation_method":null,
//"apply_id":558,
//"address":"火炬开发区"


@end

NS_ASSUME_NONNULL_END
