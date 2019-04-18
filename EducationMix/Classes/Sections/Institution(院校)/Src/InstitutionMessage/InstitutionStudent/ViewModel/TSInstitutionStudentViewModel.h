//
//  TSInstitutionStudentViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSInstitutionStudentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSInstitutionStudentViewModel : NSObject

@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, strong)NSArray *modelArr;

@property (nonatomic, strong)TSInstitutionStudentModel *model;

- (instancetype)initWithModel:(TSInstitutionStudentModel *)model;


/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
