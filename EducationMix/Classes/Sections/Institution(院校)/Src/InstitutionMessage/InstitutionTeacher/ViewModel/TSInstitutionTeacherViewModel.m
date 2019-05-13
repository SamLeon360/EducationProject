//
//  TSInstitutionTeacherViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionTeacherViewModel.h"

@implementation TSInstitutionTeacherViewModel

- (instancetype)initWithModel:(TSInstitutionTeacherModel *)model {
    
    if(!self){
        self = [super init];
        _model = model;
    }
    return self;
}

-(void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/list_common_expert"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"page"] = @1;
            params[@"expert_type"] = @"";
            params[@"academic_title"] = @"";
            params[@"industrial_field"] = @"";
            params[@"academy_type"] = @"";
            params[@"affiliated_area"] = @"";
            params[@"expert_name"] = @"";
            
        
//{"page":1,"expert_type":"","academic_title":"","industrial_field":"","academy_type":"","affiliated_area":"","expert_name":""}
            
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 1) {
                    
                    self.modelArr = [TSInstitutionTeacherModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
