//
//  TSProjectDetailsViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSProjectDetailsViewModel.h"

@implementation TSProjectDetailsViewModel

- (instancetype)initWithProject_id:(NSInteger)project_id {
    
    if(!self) self = [super init];
    self.project_id = project_id;
    return self;
    
}


- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"project/detail_project"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"project_id"] = @(self.project_id);
            
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 0) {
                    
                    //                    if(responseObject[@"data"])
                    
                    self.model = [TSProjectDetailsModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
                    [subscriber sendNext:self.model];
                    
                } else {
                    
                    [TSProgressHUD showError:responseObject[@"message"]];
                    
                }
                [subscriber sendNext:self.model];
                
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
