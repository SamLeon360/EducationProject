//
//  TSMainTabBarViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/21.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSMainTabBarViewController.h"

#import "TSMainNavigationController.h"

#import "HomeViewController.h"
#import "TSINSTMsgViewController.h"
#import "EduMeViewController.h"
#import "InstitutionViewController.h"
#import "TSINSTMsgViewController.h"
#import "TSAdvisoryViewController.h"
#import "TSIMViewController.h"
#import "TSMeViewController.h"

#import "TSIMLoginTool.h"

@interface TSMainTabBarViewController ()

@end

@implementation TSMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainView" bundle:[NSBundle mainBundle]];
    
    HomeViewController *homeVC = [story instantiateViewControllerWithIdentifier:@"HomeViewController"];
    homeVC.title = @"主页";
    
    TSIMViewController *IMVC = [[TSIMViewController alloc]init];
    IMVC.title = @"聊天";
    
    TSAdvisoryViewController *VC3 = [[TSAdvisoryViewController alloc] init];
    
    TSMeViewController *meVC = [[TSMeViewController alloc] init];
    meVC.title = @"我的";
    VC3.title = @"咨询";
    
//    EduMeViewController *meVC = [story instantiateViewControllerWithIdentifier:@"EduMeViewController"];
//    meVC.title = @"我的";
    
    
    self.viewControllers = @[[[UINavigationController alloc]initWithRootViewController:homeVC]
                             ,[[UINavigationController alloc]initWithRootViewController:IMVC]
                             ,[[UINavigationController alloc]initWithRootViewController:VC3]
                             ,[[UINavigationController alloc]initWithRootViewController:meVC]];
    
    
    UITabBar *tabbar = self.tabBar;
    
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    item1.selectedImage = [[UIImage imageNamed:@"主页点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item1.image = [[UIImage imageNamed:@"主页未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    item2.selectedImage = [[UIImage imageNamed:@"聊天点击后"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"聊天未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
    item3.selectedImage = [[UIImage imageNamed:@"咨询点击后"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"咨询未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
    item4.selectedImage = [[UIImage imageNamed:@"个人点击后"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"个人未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:TSColor_RGB(252, 102, 32),UITextAttributeTextColor, nil] forState:UIControlStateSelected];

    
    [[TSIMLoginTool shareManager] login];
    
    
    
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
