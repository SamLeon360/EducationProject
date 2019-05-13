//
//  TSPoliciesAndRegulationsDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/12.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSPoliciesAndRegulationsDetailViewModel.h"

@implementation TSPoliciesAndRegulationsDetailViewModel

- (instancetype)initWithId:(NSInteger)Id {
    
    if(!self) self = [super init];
    self.Id = Id;
    return self;
}



- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"survey/detail_new_policy"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"id"] = @(self.Id);
            params[@"jump_flag"] = @"3";
            params[@"first"] = @1;
            
            //            {"technology_id":"26","commerce_id":""}
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 3) {
                    
                    self.model = [TSPoliciesAndRegulationsDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
                    [subscriber sendNext:self.model];
                    
                } else {
                    
                    [TSProgressHUD showError:responseObject[@"msg"]];
                    [subscriber sendError:nil];
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
