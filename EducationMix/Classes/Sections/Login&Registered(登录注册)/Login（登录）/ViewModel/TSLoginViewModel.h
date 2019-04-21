//
//  TSLoginViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSLoginModel.h"
#import "TSLoginUserDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSLoginViewModel : NSObject

@property(nonatomic, strong)TSLoginModel *loginModel;

@property(nonatomic, strong)TSLoginUserDataModel *userDataModel;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */

/**
 从网络获取获取信息

 @param model 请求接口数据模型
 */
- (void)loadDataArrFromNetworkWithLoginModel:(TSLoginModel *)model;

@end

NS_ASSUME_NONNULL_END
