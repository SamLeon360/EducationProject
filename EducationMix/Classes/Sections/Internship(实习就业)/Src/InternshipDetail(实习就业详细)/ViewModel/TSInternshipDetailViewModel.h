//
//  TSInternshipDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSInternshipDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSInternshipDetailViewModel : NSObject

@property (nonatomic, assign)NSInteger talent_id;

@property (nonatomic, strong)TSInternshipDetailModel *model;


- (instancetype)initWithTalent_id:(NSInteger)talent_id;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
