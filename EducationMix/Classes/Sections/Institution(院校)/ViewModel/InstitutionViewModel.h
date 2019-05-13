//
//  InstitutionViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstitutionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InstitutionViewModel : NSObject

@property (nonatomic, strong)InstitutionModel *model;

@property (nonatomic, copy)NSArray *modelArr;

- (instancetype)initWithModel:(InstitutionModel *)model;

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;

@end

NS_ASSUME_NONNULL_END
