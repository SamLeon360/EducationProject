//
//  LoginViewController.m
//  EducationMix
//
//  Created by Sam on 2019/3/11.
//  Copyright © 2019 sam. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    
}
-(void)viewDidLayoutSubviews{
    [self setupViews];
}
-(void)setupViews{
    [self.phoneView makeCorner:self.phoneView.frame.size.height/2];
    [self.pwdView makeCorner:self.pwdView.frame.size.height/2];
    [self.loginBtn makeCorner:self.loginBtn.frame.size.height/2];
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
