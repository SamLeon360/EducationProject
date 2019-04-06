//
//  TSTeacherListModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTeacherListModel : NSObject

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


@end

NS_ASSUME_NONNULL_END
