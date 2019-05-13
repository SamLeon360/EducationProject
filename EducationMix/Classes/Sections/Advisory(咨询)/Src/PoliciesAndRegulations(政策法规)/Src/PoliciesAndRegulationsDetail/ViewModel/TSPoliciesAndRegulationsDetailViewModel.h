//
//  TSPoliciesAndRegulationsDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/12.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSPoliciesAndRegulationsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPoliciesAndRegulationsDetailViewModel : NSObject

@property (nonatomic, assign)NSInteger Id;


@property (nonatomic, strong)TSPoliciesAndRegulationsDetailModel *model;


- (instancetype)initWithId:(NSInteger)Id;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
