//
//  TSMeViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/17.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSMeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSMeViewModel : NSObject

@property(nonatomic, strong)TSMeModel *model;

@property(nonatomic, strong)NSArray *meCellModelArr;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
