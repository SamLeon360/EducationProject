//
//  TSInstitutionDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailViewModel.h"


#import "TSRequestTool.h"
#import "TSProgressHUD.h"

@implementation TSInstitutionDetailViewModel

- (instancetype)initWithModel:(TSInstitutionDetailModel *)model {
    
    self = [super init];
    if(!self) return nil;
    self.model = model;
    return self;
}

- (void)loadDataArrFromNetwork {
    
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            params[@"academy_id"] = [NSNumber numberWithInteger:self.academy_id];
        
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"academy/detail_academy"];
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 0) {
                    
                    TSInstitutionDetailModel *model = [TSInstitutionDetailModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
                    [subscriber sendNext:model];
                    
                    NSArray *mArr = @[@{@"academy_id":[NSNumber numberWithInteger:model.academy_id],@"address":model.address},
                                      @{@"college_introduction":model.college_introduction},
                                      @{@"cooperation":model.cooperation}];
                    
//                    NSArray *advance_subjectArr = [model.advance_subject componentsSeparatedByString: ];
                    
                    NSDictionary *advance_subjectDic = [self dictionaryWithJsonString:model.advance_subject];
//                    TSTSInstitutionDetailAdvanceSubjectModel *dasModel = []
                    
                    
                    self.modelArr = [TSInstitutionDetailModel mj_objectArrayWithKeyValuesArray:mArr];
                    
                    
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


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
