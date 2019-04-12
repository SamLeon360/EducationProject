//
//  TSTechnicalRequirementsDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTechnicalRequirementsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSTechnicalRequirementsDetailViewModel : NSObject

@property (nonatomic, assign)NSInteger technology_id;
@property (nonatomic, assign)NSInteger commerce_id;


@property (nonatomic, strong)TSTechnicalRequirementsDetailModel *model;


- (instancetype)initWithTechnology_id:(NSInteger)technology_id Commerce_id:(NSInteger)commerce_id;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
