//
//  TSInstitutionStudentViewController.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
#define SCALE_6                                                   (SCREEN_WIDTH / 375)

NS_ASSUME_NONNULL_BEGIN

typedef void(^CallBackBlcok) (NSInteger student_id);//1


@interface TSInstitutionStudentViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy)CallBackBlcok callBackBlock;//2


@end

NS_ASSUME_NONNULL_END
