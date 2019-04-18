//
//  TSInstitutionTeacherModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInstitutionTeacherModel : NSObject

@property (nonatomic, strong)NSString *expert_name;
@property (nonatomic, strong)NSString *industrial_field;
@property (nonatomic, strong)NSString *academy_name;
@property (nonatomic, strong)NSString *major_field;
@property (nonatomic, strong)NSString *photo;

@property (nonatomic, assign)NSInteger expert_id;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger expert_type;
@property (nonatomic, assign)NSInteger academic_title;
@property (nonatomic, assign)NSInteger academy_id;

//"expert_name": "王磊",
//"expert_id": 558,
//"member_id": 558,
//"expert_type": 2,
//"academic_title": 3,
//"industrial_field": "1",
//"academy_id": 3,
//"academy_name": "中山职业技术学院",
//"major_field": "电子工程",
//"photo": "/uploads/expert/558/558.jpg"


@end

NS_ASSUME_NONNULL_END
