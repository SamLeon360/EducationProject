//
//  TSInternshipDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInternshipDetailViewModel.h"

@implementation TSInternshipDetailViewModel


- (instancetype)initWithTalent_id:(NSInteger)talent_id {
    
    if(!self) {
        self = [super init];
    }
    _talent_id  = talent_id;
    
    return self;
}

- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/detail_demand_talent"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"talent_id"] = @(self.talent_id);
            params[@"commerce_id"] = @"";
            params[@"_search_type"] = @0;

//            {"talent_id":"72","commerce_id":"","_search_type":0}

            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 0) {
                    
                    self.model = [TSInternshipDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
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
