//
//  TSStudentListModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSStudentListModel : NSObject

@property (nonatomic, strong)NSString *student_name;
@property (nonatomic, strong)NSString *major;
@property (nonatomic, strong)NSString *academy_name;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *graduation_time;
@property (nonatomic, strong)NSString *affiliated_area;

@property (nonatomic, strong)NSString *photo;

@property (nonatomic, strong)NSString *sex;
@property (nonatomic, assign)NSInteger student_id;

@end

NS_ASSUME_NONNULL_END
