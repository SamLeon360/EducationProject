//
//  TSAnnouncementDetailViewModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TSAnnouncementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAnnouncementDetailViewModel : NSObject

- (instancetype)initWithModel:(TSAnnouncementModel *)model;

@property(nonatomic, strong)TSAnnouncementModel *model;

@end

NS_ASSUME_NONNULL_END
