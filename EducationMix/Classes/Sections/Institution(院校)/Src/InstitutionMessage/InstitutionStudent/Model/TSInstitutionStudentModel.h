//
//  TSInstitutionStudentModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInstitutionStudentModel : NSObject

@property (nonatomic, strong)NSString *student_name;
@property (nonatomic, strong)NSString *major;
@property (nonatomic, strong)NSString *academy_name;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *graduation_time;
@property (nonatomic, strong)NSString *affiliated_area;

@property (nonatomic, strong)NSString *photo;

@property (nonatomic, strong)NSString *sex;
@property (nonatomic, assign)NSInteger student_id;

//"sex":1,
//"student_id":3387,
//"student_name":"林煜",
//"major":"UI设计",
//"academy_name":"中山火炬职业技术学院",
//"birthday":"1991-01-01",
//"graduation_time":"0000-00-00",
//"photo":null,
//"affiliated_area":"广东省||"

@end

NS_ASSUME_NONNULL_END
