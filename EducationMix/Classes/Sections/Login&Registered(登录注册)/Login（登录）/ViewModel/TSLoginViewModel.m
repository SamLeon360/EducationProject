//
//  TSLoginViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSLoginViewModel.h"

@implementation TSLoginViewModel

//https://app.tianxun168.com/h5_v3/index.php?s=/api/user/loginIn


- (void)loadDataArrFromNetworkWithLoginModel:(TSLoginModel *)model {
    
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"https://app.tianxun168.com/h5_v3/index.php?s=/api/user/loginIn"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"user_name"] = model.user_name;
            params[@"password"] = model.password;
            
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 200) {
                    
                    self.userDataModel = [TSLoginUserDataModel mj_objectWithKeyValues:responseObject[@"data"]];
                    [subscriber sendNext:@(YES)];
                    
                    USER_SINGLE.token = self.userDataModel.token;
                    USER_SINGLE.member_id = self.userDataModel.token;
                    USER_SINGLE.user_type = self.userDataModel.user_type;

                } else {
                    
                    [TSProgressHUD showError:responseObject[@"message"]];
                    
                }
                
                
                
                [subscriber sendCompleted];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [subscriber sendError:error];
                [subscriber sendCompleted];
                
            }];
            
            
            return nil;
            
        }];
        
        return signal;
    }];
    
}

@end
