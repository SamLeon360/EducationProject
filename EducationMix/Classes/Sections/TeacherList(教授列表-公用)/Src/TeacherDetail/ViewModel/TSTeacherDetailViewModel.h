//
//  TSTeacherDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/3.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTeacherDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSTeacherDetailViewModel : NSObject

@property (nonatomic, assign)NSInteger expert_id;

- (instancetype)initWithexpert_id:(NSInteger)expert_id;

@property (nonatomic, strong)TSTeacherDetailModel *model;


/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;


@end

NS_ASSUME_NONNULL_END
