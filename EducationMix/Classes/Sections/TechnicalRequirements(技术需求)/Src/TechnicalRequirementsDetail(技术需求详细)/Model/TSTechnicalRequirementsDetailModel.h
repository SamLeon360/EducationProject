//
//  TSTechnicalRequirementsDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTechnicalRequirementsDetailModel : NSObject

@property(nonatomic, strong)NSString *technology_name;
@property(nonatomic, strong)NSString *demand_reason;
@property(nonatomic, strong)NSString *demand_method;
@property(nonatomic, strong)NSString *technology_description;
@property(nonatomic, strong)NSString *contacts_person;

@property(nonatomic, strong)NSString *contacts_phone;
@property(nonatomic, strong)NSString *create_time;
@property(nonatomic, strong)NSString *enterprise_name;


@property(nonatomic, assign)NSInteger technology_id;
@property(nonatomic, assign)NSInteger commerce_id;
@property(nonatomic, assign)NSInteger domain;
@property(nonatomic, assign)NSInteger demand_type;
@property(nonatomic, assign)NSInteger budget_money;

@property(nonatomic, assign)NSInteger allow_publish;
@property(nonatomic, assign)NSInteger enterprise_id;
@property(nonatomic, assign)NSInteger enterprise_type;
@property(nonatomic, assign)NSInteger member_id;




@end

NS_ASSUME_NONNULL_END
