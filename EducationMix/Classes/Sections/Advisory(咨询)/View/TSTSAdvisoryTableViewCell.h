//
//  TSTSAdvisoryTableViewCell.h
//  EducationMix
//
//  Created by Taosky on 2019/4/8.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSAdvisoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSTSAdvisoryTableViewCell : UITableViewCell

@property (nonatomic, strong)TSAdvisoryModel *model;

@property(nonatomic, strong)IBOutlet UILabel *name;
@property(nonatomic, strong)IBOutlet UILabel *user_name;
@property(nonatomic, strong)IBOutlet UILabel *time;
@property(nonatomic, strong)IBOutlet UILabel *type;


//"id":74,
//"name":"挖掘机自动摇臂",
//"user_name":"王磊",
//"member_id":558,
//"time":"2018-09-29 17:07:29",
//"type":6


@end

NS_ASSUME_NONNULL_END
