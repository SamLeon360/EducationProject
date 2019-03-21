//
//  TSMainTabBarViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/21.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSMainTabBarViewController.h"
#import "HomeViewController.h"
#import "TSINSTMsgViewController.h"
#import "EduMeViewController.h"

#import "TSINSTMsgViewController.h"

@interface TSMainTabBarViewController ()

@end

@implementation TSMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainView" bundle:[NSBundle mainBundle]];
    
    HomeViewController *homeVC = [story instantiateViewControllerWithIdentifier:@"HomeViewController"];
    homeVC.title = @"主页";

    TSINSTMsgViewController *tmpVC1 = [[TSINSTMsgViewController alloc]init];
    tmpVC1.title = @"咨询";
    
    UIViewController *tmpVC2 = [[UIViewController alloc]init];
    tmpVC2.title = @"聊天";
    
    EduMeViewController *meVC = [story instantiateViewControllerWithIdentifier:@"EduMeViewController"];
    meVC.title = @"我的";
    
    self.viewControllers = @[homeVC,tmpVC1,tmpVC2,meVC];

    // Do any additional setup after loading the view.
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
