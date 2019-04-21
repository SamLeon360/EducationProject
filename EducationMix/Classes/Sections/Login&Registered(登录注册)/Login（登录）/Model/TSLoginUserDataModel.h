//
//  TSLoginUserDataModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/20.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSLoginUserDataModel : NSObject

@property(nonatomic, strong)NSString *token;

@property(nonatomic, assign)NSInteger user_id;
@property(nonatomic, assign)NSInteger member_id;
@property(nonatomic, assign)NSInteger school_id;
@property(nonatomic, assign)NSInteger user_type;
@property(nonatomic, assign)NSInteger exp;

@end

NS_ASSUME_NONNULL_END
