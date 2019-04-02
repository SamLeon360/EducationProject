//
//  TSStudentDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/2.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSStudentDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSStudentDetailViewModel : NSObject

@property (nonatomic, assign)NSInteger student_id;

@property (nonatomic, strong)TSStudentDetailModel *model;


- (instancetype)initWithStudent_id:(NSInteger)student_id;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
