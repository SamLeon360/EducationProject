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

@interface TSMainTabBarViewController ()

@end

@implementation TSMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MainView" bundle:[NSBundle mainBundle]];
    
    
    
    HomeViewController *homeVC = [story instantiateViewControllerWithIdentifier:@"HomeViewController"];
    homeVC.title = @"产教融";
    
    InstitutionViewController *tmpVC1 = [[InstitutionViewController alloc]init];
    tmpVC1.title = @"咨询";
    
    UIViewController *tmpVC2 = [[UIViewController alloc]init];
    tmpVC2.title = @"聊天";
    
    EduMeViewController *meVC = [story instantiateViewControllerWithIdentifier:@"EduMeViewController"];
    meVC.title = @"我的";
    
    self.viewControllers = @[[[TSMainNavigationController alloc]initWithRootViewController:homeVC]
                             ,[[TSMainNavigationController alloc]initWithRootViewController:tmpVC1]
                             ,[[TSMainNavigationController alloc]initWithRootViewController:tmpVC2]
                             ,[[TSMainNavigationController alloc]initWithRootViewController:meVC]];

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
