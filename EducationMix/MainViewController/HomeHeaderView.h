//
//  HomeHeaderView.h
//  EducationMix
//
//  Created by Sam on 2019/3/12.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBackBlcok) (NSDictionary *dic);//1
typedef void(^HeaderTagCallBackBlcok) (NSInteger index);//1


@interface HomeHeaderView : UIView
///轮播图
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
///商协会
@property (weak, nonatomic) IBOutlet UIView *oneView;
///实习就业
@property (weak, nonatomic) IBOutlet UIView *twoView;
///技术需求
@property (weak, nonatomic) IBOutlet UIView *threeView;
///院校
@property (weak, nonatomic) IBOutlet UIView *fourView;
///成果交易
@property (weak, nonatomic) IBOutlet UIView *fiveView;
///双创中心
@property (weak, nonatomic) IBOutlet UIView *sixeView;
///全媒中心
@property (weak, nonatomic) IBOutlet UIView *sevenView;
///行业搜索
@property (weak, nonatomic) IBOutlet UIView *eightView;
///滚动内容
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic) NSArray *postArray;

-(void)setupTableView;

@property (nonatomic,copy)CallBackBlcok callBackBlock;//2

@property (nonatomic,copy)HeaderTagCallBackBlcok headerTagCallBackBlcok;//2

@end

NS_ASSUME_NONNULL_END
