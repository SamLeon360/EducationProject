//
//  AlertView.m
//  TXProject
//
//  Created by Sam on 2018/12/27.
//  Copyright © 2018年 sam. All rights reserved.
//

#import "AlertView.h"
#import "AlertViewModel.h"
@interface AlertView(){
    AlertViewModel *alertviewModel;
}
@end

static AlertView * alertView;
@implementation AlertView
-(instancetype)init{
    self = [super init];
    if (self) {
        alertviewModel = [[AlertViewModel alloc] initWithFrame:CGRectMake(0, 0, 216*kScale, 49*kScale)];
        [alertviewModel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
        alertviewModel.alertLabel = [[UILabel alloc] init];
        alertviewModel.alertLabel.textColor = [UIColor whiteColor];
        alertviewModel.alertLabel.font = [UIFont systemFontOfSize:15];
        alertviewModel.alertLabel.textAlignment = NSTextAlignmentCenter;
        alertviewModel.alertLabel.frame = CGRectMake(0, 0,216*kScale, 49*kScale);
        alertviewModel.alertLabel.center = alertviewModel.center;
        
        [alertviewModel addSubview:alertviewModel.alertLabel];
        
        
    }
    return self;
}
+(void)showYMAlertView:(UIView *)view andtitle:(NSString *)title{
    
    if (!alertView) {
        alertView = [[AlertView alloc] init];
    }
    [alertView showAlertViewModel:view andTitle:title];
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView hideBottomView];
        });
    
    
}

-(void)showAlertViewModel:(UIView *)view andTitle:(NSString *)title{
    
    if (alertviewModel) {
        [alertviewModel removeFromSuperview];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window.rootViewController.view addSubview:alertviewModel];
    UIViewController *current = [self getCurrentVC];
    NSLog(@"%@",current.navigationController.viewControllers);
    alertviewModel.center = view.center;
    alertviewModel.alertLabel.text = title;
    [UIView animateWithDuration:0.3 animations:^{
        self->alertviewModel.alpha = 1;
    }];
    
}

-(void)hideBottomView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self->alertviewModel.alpha = 0;
    }];
    
    
}
-(UIViewController *)getCurrentVC {
    
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        nextResponder = [tempView nextResponder];
    }
    return  (UIViewController *)nextResponder;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
