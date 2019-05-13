//
//  TSInternshipViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/4.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInternshipViewModel.h"

@implementation TSInternshipViewModel

- (instancetype)initWithModel:(TSInternshipModel *)model {
    
    if(!self) self = [super init];
    return self;
}

- (void)loadDataArrFromNetwork {
    
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/list_demand_talent"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"page"] = @1;
            params[@"commerce_id"] = @"";
            params[@"allow_publish"] = @"";
            params[@"job_type"] = @"";
            params[@"education"] = @"";

            params[@"work_type"] = @"";
            params[@"job_name"] = @"";
            params[@"receive_fresh_graduate"] = @"1";
            params[@"affiliated_area"] = @"";
            params[@"ios"] = @"";
            
            params[@"enterprise_id"] = @"";
            
//            {"page":1,"commerce_id":"","allow_publish":"","job_type":"","education":"","work_type":"","job_name":"","receive_fresh_graduate":"1","affiliated_area":"","ios":"","enterprise_id":""}
            
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 1) {
                    
                    self.modelArr = [TSInternshipModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    [subscriber sendNext:self.modelArr];
                    
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
