//
//  TSTeacherDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/3.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeacherDetailViewModel.h"

@implementation TSTeacherDetailViewModel


- (instancetype)initWithexpert_id:(NSInteger)expert_id {
    
    if(!self) self = [super init];
    _expert_id = expert_id;
    return self;
}

- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            

            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"id"] = @(self.expert_id);
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"expert/detail_expert_info"];
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                if ([responseObject[@"code"] integerValue] == 0) {
                    
                    self.model = [TSTeacherDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
                    [subscriber sendNext:self.model];
                    
                } else {
                    
                    [TSProgressHUD showError:responseObject[@"msg"]];
                    
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
