//
//  LoginViewController.m
//  EducationMix
//
//  Created by Sam on 2019/3/11.
//  Copyright © 2019 sam. All rights reserved.
//

#import "LoginViewController.h"
#import "EduMainViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLoginLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (nonatomic) NSInteger  typeStatus;///1：登录  2：注册
@end

@implementation LoginViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.typeStatus = 1;
    self.phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:self.phoneTF.font}];
    self.pwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:self.pwdTF.font}];
    [self setupClickAction];

}
-(void)viewDidLayoutSubviews{
    [self setupViews];
}
-(void)setupViews{
    [self.phoneView makeCorner:self.phoneView.frame.size.height/2];
    [self.pwdView makeCorner:self.pwdView.frame.size.height/2];
    [self.loginBtn makeCorner:self.loginBtn.frame.size.height/2];
}
-(void)setupClickAction{
    __block LoginViewController *blockSelf = self;
    [self.loginBtn bk_whenTapped:^{
        if (self.typeStatus == 1) {
            [blockSelf ClickToLogin];
        }else{
            
        }
            
    }];
  
    
}
-(void)ClickToRegister{
    if (self.phoneTF.text.length <= 0 ) {
        [AlertView showYMAlertView:self.view andtitle:@"请输入账号"];
        return;
    }
    
    if (self.pwdTF.text.length <= 0 ) {
        [AlertView showYMAlertView:self.view andtitle:@"请输入验证码"];
        return;
    }
//    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.phoneTF.text,@"phone_number",self.nameTF.text,@"member_name",self.passwordTF.text,@"password",self.codeTF.text,@"verify_code", nil];
//    [HTTPREQUEST_SINGLE postWithURLString:REGISTER_USER parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
//        NSDictionary *data = responseDic[@"data"];
//        if (data!=nil) {
//            [AlertView showYMAlertView:self.view andtitle:@"注册成功"];
//            [USER_SINGLE setUserDataWithDic:data];
//
//        }else{
//            [AlertView showYMAlertView:self.view andtitle:@"注册失败"];
//        }
//    } failure:^(NSError *error) {
//        [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
//    }];
}
-(void)ClickToLogin{
    if (self.phoneTF.text.length <= 0 ) {
        [AlertView showYMAlertView:self.view andtitle:@"请输入账号"];
        return;
    }
    
    if (self.pwdTF.text.length <= 0 ) {
        [AlertView showYMAlertView:self.view andtitle:@"请输入密码"];
        return;
    }
     __block LoginViewController *blockSelf = self;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.pwdTF.text,@"password",self.phoneTF.text,@"user_name",@"1",@"type",@"",@"captcha_key",@"",@"verify_code", nil];
    [HTTPREQUEST_SINGLE postWithURLString:LOGIN_URL parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        if ([responseDic[@"code"] integerValue] == 200) {
            NSDictionary *dic = responseDic[@"data"];
            [USER_SINGLE setUserDataWithDic:dic];
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"token"] forKey:@"token"];
            NSString *default_commerce_id = [NSString stringWithFormat:@"%@",USER_SINGLE.default_commerce_id];
                [AlertView showYMAlertView:blockSelf.view andtitle:@"登录成功"];
//                [JPUSHService setAlias:USER_SINGLE.token completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//                } seq:1];
            
            EduMainViewController *vc = [[UIStoryboard storyboardWithName:@"MainView" bundle:nil] instantiateViewControllerWithIdentifier:@"EduMainViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            }else{
                [AlertView showYMAlertView:blockSelf.view andtitle:responseDic[@"message"]];
            }
        
        
    } failure:^(NSError *error) {
        [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
    }];
    
}
@end
