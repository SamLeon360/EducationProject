//
//  TSAchievementDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/8.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSAchievementDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAchievementDetailViewModel : NSObject

@property(nonatomic, assign)NSInteger results_id;

@property (nonatomic, strong)TSAchievementDetailModel *model;


- (instancetype)initWithTalent_id:(NSInteger)results_id;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;


@end

NS_ASSUME_NONNULL_END
