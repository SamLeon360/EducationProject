//
//  TSTechnicalRequirementsViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTechnicalRequirementsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSTechnicalRequirementsViewModel : NSObject

@property (nonatomic, strong)NSArray *modelArr;

@property (nonatomic, strong)TSTechnicalRequirementsModel *model;

//- (instancetype)initWithMapping_type:(NSInteger)mapping_type;


/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
