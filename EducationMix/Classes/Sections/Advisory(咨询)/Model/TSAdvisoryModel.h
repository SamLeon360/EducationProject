//
//  TSAdvisoryModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/7.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSAdvisoryModel : NSObject


@property(nonatomic, strong)NSString *Id;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *user_name;
@property(nonatomic, strong)NSString *member_id;
@property(nonatomic, strong)NSString *time;

@property(nonatomic, assign)NSInteger type;


//"id":74,
//"name":"挖掘机自动摇臂",
//"user_name":"王磊",
//"member_id":558,
//"time":"2018-09-29 17:07:29",
//"type":6

@end

NS_ASSUME_NONNULL_END
