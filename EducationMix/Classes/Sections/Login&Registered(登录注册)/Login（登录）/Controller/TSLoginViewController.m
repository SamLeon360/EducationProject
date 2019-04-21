//
//  TSLoginViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/20.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSLoginViewController.h"
#import "TSLoginHeaderView.h"
#import "TSLoginViewModel.h"
#import "TSLoginModel.h"

@interface TSLoginViewController ()

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)TSLoginViewModel *viewModel;

@property(nonatomic, strong)IBOutlet UITextField *phoneTextField;
@property(nonatomic, strong)IBOutlet UITextField *passwordTextField;

@property(nonatomic, strong)IBOutlet UIButton *loginBtn;
@property(nonatomic, strong)IBOutlet UIButton *backBtn;

@property(nonatomic, strong)TSLoginModel *loginModel;

@end

@implementation TSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //验证手机号码信号
    RACSignal *validPhonenumSignal =
    [self.phoneTextField.rac_textSignal
     map:^id(NSString * text) {
         return @([NSString validateMobile:text]);
     }];
    
    //验证密码信号
    RACSignal *validPasswordSignal =
    [self.passwordTextField.rac_textSignal
     map:^id(NSString * text) {
         return @([self validPassword:text]);
     }];
    
    RACSignal *registerSignal =
    [RACSignal combineLatest:@[validPhonenumSignal,validPasswordSignal] reduce:^id(NSNumber *validPhonenumSignal, NSNumber * validPasswordSignal){
        return @([validPhonenumSignal boolValue] && [validPasswordSignal boolValue]);
    }];
    
    RAC(self.loginBtn, backgroundColor) = [registerSignal map:^id(NSNumber * registerValid) {
        
        return [registerValid boolValue] ? TSColor_RGB(66, 152, 222) :[UIColor lightGrayColor];
    }];
    
//    RAC(self.loginBtn, backgroundColor) = [validPasswordSignal map:^id(NSNumber * passwordNumValid) {
//
//        return [passwordNumValid boolValue] ? TSColor_RGB(66, 152, 222) :[UIColor lightGrayColor];
//    }];
    
    RACSignal *loginBtnStepSignal =
    [RACSignal combineLatest:@[validPhonenumSignal,validPasswordSignal] reduce:^id(NSNumber *validPhonenumSignal,NSNumber *validPasswordSignal){
        return @([validPhonenumSignal boolValue]  &&[validPasswordSignal boolValue]);
    }];
    [loginBtnStepSignal subscribeNext:^(NSNumber * nextStep) {
        self.loginBtn.enabled = [nextStep boolValue];
        
        if ([nextStep boolValue]) {
            
            self.loginModel.user_name = self.phoneTextField.text;
            self.loginModel.password = self.passwordTextField.text;

        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData {
    
    [TSProgressHUD show];

    [self.viewModel loadDataArrFromNetworkWithLoginModel:self.loginModel];
    
    
    RACSignal *recommendContentSignal = [self.viewModel.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        
        if(x) {
            [TSProgressHUD showSuccess:@"登录成功"];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            
            
        }


        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
}

- (IBAction)loginBtnAction:(id)sender {
    
    [self loadData];
    
}

- (IBAction)backBtnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//忘记密码
- (IBAction)forgetPasswordBtnAction:(id)sender {
    
    
}


- (IBAction)registeredBtnAction:(id)sender {
    
    
}


#pragma mark - validmethod

- (BOOL)validPassword:(NSString *)password {
    
    return password.length > 0;
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        
        TSLoginHeaderView *tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"TSLoginHeaderView" owner:self options:nil] objectAtIndex:0];
       
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = tableHeaderView;
        
        
    }
    return _tableView;
}

- (TSLoginViewModel *)viewModel {
 
    if(!_viewModel) {
        _viewModel = [[TSLoginViewModel alloc] init];
    }
    return _viewModel;
    
}

- (TSLoginModel *)loginModel {
    if(!_loginModel) {
        
        _loginModel = [[TSLoginModel alloc] init];
        
    }
    return _loginModel;
    
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
