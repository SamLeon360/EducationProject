//
//  TSInstitutionDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSInstitutionDetailModel.h"
#import "TSTSInstitutionDetailAdvanceSubjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSInstitutionDetailViewModel : NSObject


@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, strong)TSInstitutionDetailModel *model;
@property (nonatomic, strong)NSArray *modelArr;

- (instancetype)initWithModel:(TSInstitutionDetailModel *)model;



/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

/** 从网络获取获取信息 */
- (void)loadDataArrFromNetwork;


@end

NS_ASSUME_NONNULL_END
