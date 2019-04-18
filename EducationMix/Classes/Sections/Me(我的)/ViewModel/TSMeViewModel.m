//
//  TSMeViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/17.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSMeViewModel.h"

@implementation TSMeViewModel

- (void)loadDataArrFromNetwork {
    
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"student/detail_student"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"page"] = @1;
            params[@"education"] = @"";
            params[@"sex"] = @"";
            params[@"affiliated_area"] = @"";
            params[@"major"] = @"";
            params[@"student_name"] = @"";
            params[@"graduation_time"] = @"";
            
            //            {"page":1,"education":"","sex":"","affiliated_area":"","major":"","student_name":"","graduation_time":""}
            
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 1) {
                    
                    self.model = [TSMeModel mj_objectWithKeyValues:responseObject[@"data"][0]];
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

- (NSArray *)meCellModelArr {
    
    if(!_meCellModelArr) {
        
        NSArray *data = @[@{@"title":@"账号信息",@"imageName":@"addressbook_fill"},
                            @{@"title":@"编辑信息",@"imageName":@"brush_fill"},
                            @{@"title":@"设置",@"imageName":@"setup_fill"},
                            @{@"title":@"我的消息",@"imageName":@"interactive"},];
        _meCellModelArr = [TSMeTableViewCellModel mj_objectArrayWithKeyValuesArray:data];
    }
    return _meCellModelArr;
    
}

@end
