//
//  GetAreaView.h
//  TXProject
//
//  Created by Sam on 2019/4/9.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SelectStringCallBack)(NSString *str);
@interface GetAreaView : UIView

@property (weak, nonatomic) IBOutlet UITableView *provinceTable;
@property (weak, nonatomic) IBOutlet UITableView *cityTable;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (nonatomic) SelectStringCallBack selectStringCallBack;
@property (nonatomic) NSString *selectProvince;
@property (nonatomic) NSString *selecCity;
-(void)setupTableView;
@end

NS_ASSUME_NONNULL_END
