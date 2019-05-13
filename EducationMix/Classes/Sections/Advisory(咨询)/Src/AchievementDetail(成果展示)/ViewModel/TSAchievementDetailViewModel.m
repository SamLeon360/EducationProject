//
//  TSAchievementDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/8.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAchievementDetailViewModel.h"

@implementation TSAchievementDetailViewModel

- (instancetype)initWithTalent_id:(NSInteger)results_id {
    
    if(!self) self = [super init];
    
    _results_id = results_id;
    
    return self;
}



- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"results/detail_results"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"results_id"] = @(self.results_id);
       
            
            //            {"talent_id":"72","commerce_id":"","_search_type":0}
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 0) {
                    
//                    if(responseObject[@"data"])
                    
                    self.model = [TSAchievementDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
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
