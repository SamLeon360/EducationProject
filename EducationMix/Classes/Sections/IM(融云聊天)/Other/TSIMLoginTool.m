//
//  TSIMLoginTool.m
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSIMLoginTool.h"
#import <RongIMKit/RongIMKit.h>


@implementation TSIMLoginTool


#pragma mark - Public
+ (instancetype)shareManager
{
    static TSIMLoginTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        [[RCIM sharedRCIM] initWithAppKey:@"e5t4ouvpe6zoa"];
    });
    return _instance;
}

-(void)login {
    
    if(!USER_SINGLE.token) return;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"chat/refreshToken"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"member_id"] = USER_SINGLE.member_id;
    params[@"token"] = USER_SINGLE.token;
    params[@"RoleType"] = USER_SINGLE.role_type;
    
    [TSRequestTool POST:url parameters:nil headers:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject[@"code"] integerValue]== 200){
            
            NSString *token = responseObject[@"token"];
            

            [self imLoginWithToken:token];

        }
        
        [TSProgressHUD showSuccess:responseObject[@"message"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [TSProgressHUD showError:error.debugDescription];
        
    }];
}


//IM登录
- (void)imLoginWithToken:(NSString *)token {
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
}


@end
