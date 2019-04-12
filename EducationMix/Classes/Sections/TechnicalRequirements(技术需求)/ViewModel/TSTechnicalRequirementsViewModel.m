//
//  TSTechnicalRequirementsViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTechnicalRequirementsViewModel.h"

@implementation TSTechnicalRequirementsViewModel


//- (instancetype)initWithMapping_type:(NSInteger)mapping_type {
//    
//    if(!self) {
//        self = [super init];
//    }
//    _mapping_type = mapping_type;
//    
//    return self;
//    
//}

- (void)loadDataArrFromNetwork {
    
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/list_demand_technology"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"page"] = @1;
            params[@"commerce_id"] = @"";
            params[@"allow_publish"] = @1;
            params[@"demand_type"] = @"";
            params[@"enterprise_type"] = @"";
            params[@"domain"] = @"";
            params[@"area"] = @"";
            params[@"technology_name"] = @"";
            //{"page":1,"commerce_id":"","allow_publish":1,"demand_type":"","enterprise_type":"","domain":"","area":"","technology_name":""}
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 1) {
                    
                    self.modelArr = [TSTechnicalRequirementsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
