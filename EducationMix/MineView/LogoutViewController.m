//
//  LogoutViewController.m
//  TXProject
//
//  Created by Sam on 2019/1/10.
//  Copyright © 2019 sam. All rights reserved.
//

#import "LogoutViewController.h"

@interface LogoutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.logoutBtn makeCorner:5];
    [self.logoutBtn bk_whenTapped:^{
        [USER_SINGLE logout];
    }];
}

@end
