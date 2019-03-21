//
//  TSInstitutionDetailViewController.h
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

@interface TSInstitutionDetailViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
