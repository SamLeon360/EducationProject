//
//  NoPwdLoginController.m
//  EducationMix
//
//  Created by Sam on 2019/3/12.
//  Copyright © 2019 sam. All rights reserved.
//

#import "NoPwdLoginController.h"

@interface NoPwdLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *getCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (strong,nonatomic) NSTimer *myTimer;
@property (nonatomic) NSInteger resendTime;
@property (nonatomic) BOOL sendCode;
@end

@implementation NoPwdLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.sendCode = NO;
    [self setupClickAction];
}
-(void)viewDidLayoutSubviews{
    [self setupViews];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setupViews{

}
-(void)setupClickAction{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(timerFire)
                                                  userInfo:nil
                                                   repeats:YES];
    [self.myTimer setFireDate:[NSDate distantFuture]];
    __block NoPwdLoginController *blockSelf = self;
    [self.getCodeLabel bk_whenTapped:^{
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.loginPhoneTF.text,@"phone_number", nil];
        [HTTPREQUEST_SINGLE postWithURLString:LOGIN_SEND_CODE parameters:dic withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
            [AlertView showYMAlertView:self.view andtitle:@"验证码发送 成功"];
            blockSelf.resendTime = 30;
            blockSelf.sendCode = YES;
            [blockSelf.myTimer setFireDate:[NSDate distantPast]];
        } failure:^(NSError *error) {
            ///获取失败
            [AlertView showYMAlertView:self.view andtitle:@"验证码发送失败"];
        }];
    }];
}
- (IBAction)clickToLogin:(id)sender {
    __block NoPwdLoginController *blockSelf = self;
    if (self.loginPhoneTF.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请输入账号"];
        return;
    }
    if (self.codeTF.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请输入验证码"];
        return;
    }
    if (!self.sendCode ) {
        [AlertView showYMAlertView:self.view andtitle:@"请先获取验证码"];
        return;
    }
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.loginPhoneTF.text,@"user_name",self.codeTF.text,@"verify_code",@"",@"password",@"",@"captcha_key",@"2",@"type", nil];
    [HTTPREQUEST_SINGLE postWithURLString:LOGIN_URL parameters:dic withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"]  integerValue] != -1004) {
            NSDictionary *data = responseDic[@"data"];
            [USER_SINGLE setUserDataWithDic:data];
            [AlertView showYMAlertView:blockSelf.view andtitle:@"登录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
              
            });
        }else{
            [AlertView showYMAlertView:self.view andtitle:@"登录失败"];
        }
    } failure:^(NSError *error) {
        [AlertView showYMAlertView:self.view andtitle:@"登录失败"];
    }];
}
-(void)timerFire{
    if (self.resendTime <= 0) {
        self.getCodeLabel.text = @"获取验证码";
        self.getCodeLabel.userInteractionEnabled  = YES;
        self.resendTime = 30;
        [self.myTimer setFireDate:[NSDate distantFuture]];
    }else{
        self.getCodeLabel.text = [NSString stringWithFormat:@"%ld秒后重新获取",(long)self.resendTime];
        self.getCodeLabel.userInteractionEnabled = NO;
    }
    self.resendTime --;
}
@end
