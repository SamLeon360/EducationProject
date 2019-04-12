//
//  TSTechnicalRequirementsModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTechnicalRequirementsModel : NSObject

@property(nonatomic, strong)NSString *technology_name;
@property(nonatomic, assign)NSInteger domain;
@property(nonatomic, assign)NSInteger demand_type;
@property(nonatomic, strong)NSString *budget_money;
@property(nonatomic, strong)NSString *create_time;

@property(nonatomic, strong)NSString *enterprise_id;
@property(nonatomic, strong)NSString *enterprise_name;
@property(nonatomic, strong)NSString *enterprise_type;
@property(nonatomic, strong)NSString *member_name;

@property(nonatomic, assign)NSInteger technology_id;
@property(nonatomic, assign)NSInteger commerce_id;
@property(nonatomic, assign)NSInteger member_id;


//"technology_id":25,
//"technology_name":"网页开发",
//"commerce_id":158,
//"domain":7,
//"demand_type":5,
//"budget_money":5,
//"create_time":"2019-02-22 00:00:00",
//"enterprise_id":1871,
//"enterprise_name":"测试",
//"enterprise_type":7,
//"member_id":3142,
//"member_name":"李"

@end

NS_ASSUME_NONNULL_END
