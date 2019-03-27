//
//  TSMainNavigationController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/26.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSMainNavigationController.h"

@interface TSMainNavigationController ()

@end

@implementation TSMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




+ (void)initialize
{
    // 当导航栏用在XMGNavigationController中, appearance设置才会生效
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setBarTintColor:[UIColor whiteColor]];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [bar setBarStyle:UIBarStyleBlack];
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
