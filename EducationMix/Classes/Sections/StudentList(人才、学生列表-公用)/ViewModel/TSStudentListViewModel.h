//
//  TSStudentListViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSStudentListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSStudentListViewModel : NSObject

@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, strong)NSArray *modelArr;

@property (nonatomic, strong)TSStudentListModel *model;

- (instancetype)initWithModel:(TSStudentListModel *)model;


/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
