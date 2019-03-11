//
//  UINavigationController+Category.m
//  PengKa
//
//  Created by zohar on 16/3/29.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "UINavigationController+Category.h"

@implementation UINavigationController (Category)

- (void)pushAnimationDidStop {
}

- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition {
    [self pushViewController:controller animated:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    UIViewController* poppedController = [self popViewControllerAnimated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    [UIView commitAnimations];
    
    return poppedController;
}


//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item{
//    
////    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
////    item.backBarButtonItem = back;
//////    [back setImageInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
////    [back setBackButtonBackgroundVerticalPositionAdjustment:5 forBarMetrics:UIBarMetricsDefault];
////    [back setBackgroundVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
////    
////    back.imageInsets
////    navigationBar.backIndicatorImage = [UIImage imageNamed:@"navi_back"];
////    navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navi_back"];
//    
//    
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    backButton.tintColor = [UIColor whiteColor];
//    [backButton setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
//    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
//    [backButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.7] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//   
//    item.backBarButtonItem = back;
//    
//    return YES;
//    
//}
@end
