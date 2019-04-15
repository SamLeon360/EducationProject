//
//  TSEnterpriseLibraryViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/15.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSEnterpriseLibraryViewModel.h"

@implementation TSEnterpriseLibraryViewModel


- (void)loadDataArrFromNetwork {
    
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/listFile"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"page"] = @"1";
            params[@"library_type"] = @"1";
            params[@"file_type"] = @"";
            params[@"file_extension"] = @"";
            params[@"file_name"] = @"";
            params[@"_search_type"] = @"";
            params[@"ios"] = @"";
            params[@"member_id"] = @-1;
            
            //            {"page":"1","library_type":"1","file_type":"","file_extension":"","file_name":"","_search_type":"","ios":"","member_id":-1}
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 1) {
                    
                    self.modelArr = [TSEnterpriseLibraryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                    [subscriber sendNext:self.modelArr];
                    
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
