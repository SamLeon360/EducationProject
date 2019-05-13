//
//  TSTechnicalRequirementsDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTechnicalRequirementsDetailViewModel.h"

@implementation TSTechnicalRequirementsDetailViewModel

- (instancetype)initWithTechnology_id:(NSInteger)technology_id Commerce_id:(NSInteger)commerce_id {
    
    if(!self) self = [super init];
    _technology_id = technology_id;
    _commerce_id = commerce_id;
    return self;
}


- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/detail_demand_technology"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"technology_id"] = @(self.technology_id);
            params[@"commerce_id"] = @(self.commerce_id);
            
            
//            {"technology_id":"26","commerce_id":""}

            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 0) {
                    
                    self.model = [TSTechnicalRequirementsDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
                    [subscriber sendNext:self.model];
                    
                } else {
                    
                    [TSProgressHUD showError:responseObject[@"msg"]];
                    
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
