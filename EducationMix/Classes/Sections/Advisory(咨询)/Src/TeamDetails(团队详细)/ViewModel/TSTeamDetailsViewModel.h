//
//  TSTeamDetailsViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSTeamDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSTeamDetailsViewModel : NSObject

@property(nonatomic, assign)NSInteger team_id;

@property (nonatomic, strong)TSTeamDetailsModel *model;


- (instancetype)initWithTeam_id:(NSInteger)team_id;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
