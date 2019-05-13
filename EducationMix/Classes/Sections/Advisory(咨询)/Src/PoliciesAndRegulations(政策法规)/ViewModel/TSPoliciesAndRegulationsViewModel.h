//
//  TSPoliciesAndRegulationsViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/11.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSPoliciesAndRegulationsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPoliciesAndRegulationsViewModel : NSObject

@property (nonatomic, strong)NSArray *modelArr;


@property(nonatomic, strong)TSPoliciesAndRegulationsModel *model;


/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
