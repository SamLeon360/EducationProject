//
//  YKNavigationController.m
//  HireAssistant
//
//  Created by zohar on 16/9/24.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "YKNavigationController.h"

@interface YKNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation YKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 往右滑动实现返回，要先成为代理
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRGB:0x363738],NSForegroundColorAttributeName,nil]];
    
    self.navigationBar.translucent = NO;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = [UIColor colorWithRGB:0xd3d3d3];
    [[UINavigationBar appearance] setShadowImage:[self convertViewToImage:lineView]];
}

-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  重写push方法，当使用了push方法时就会调用
 *  先调用这个方法，再调用里面super的方法
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断，当当前子控制器不是栈顶控制器时，就将自定义的返回键添加到控制器View上
    if (self.childViewControllers.count > 0) {
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        backButton.tintColor = [UIColor whiteColor];
        [backButton setImage:[[[UIImage imageNamed:@"navi_back"] scaleToSize:CGSizeMake(15, 20)] imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [backButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.7] forState:UIControlStateNormal];
        @weakify(self);
        [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            // 统一设置，以后push出来的控制器，点击返回键都能返回
            [self popViewControllerAnimated:YES];
        }];
        
        UIBarButtonItem *leftBackButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.navigationItem.leftBarButtonItem = leftBackButton;
        // push出来的View隐藏底部工具条
        viewController.hidesBottomBarWhenPushed = YES;
       
    }
    // 调用原先的push方法
    [super pushViewController:viewController animated:YES];
}

#pragma mark - UIGestureRecognizerDelegate 实现往右滑动的代理方法
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ([NSStringFromClass([gestureRecognizer.view class]) isEqualToString:@"YKTransportViewController"]) {
//        return NO;
//    }
//    // 如果是栈顶控制器就不能实现滑动
//    return NO;
//}
- (void)pushAnimationDidStop {
}

- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition {
    [self pushViewController:controller animated:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    UIViewController* poppedController = [self popViewControllerAnimated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    [UIView commitAnimations];
    
    return poppedController;
}

- (UIViewController*)childViewControllerForStatusBarStyle

{
    
    return self.topViewController;
    
}


@end
