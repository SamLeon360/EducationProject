//
//  TSAdvisoryViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/7.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSAdvisoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAdvisoryViewModel : NSObject

@property (nonatomic, assign)NSInteger mapping_type;
@property (nonatomic, strong)NSArray *modelArr;

@property (nonatomic, strong)TSAdvisoryModel *model;

- (instancetype)initWithMapping_type:(NSInteger)mapping_type;


/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
