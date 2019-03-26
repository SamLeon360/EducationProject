//
//  TSInstitutionDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailViewModel.h"

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
            
            NSString *url = @"academy/detail_academy";
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            params[@"academy_id"] = [NSNumber numberWithInteger:self.academy_id];
            
            [HTTPREQUEST_SINGLE postWithURLString:url parameters:params withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
                
                if ([responseDic[@"code"] integerValue] == 1) {
                    
                    TSInstitutionDetailModel *model = [TSInstitutionDetailModel mj_objectWithKeyValues:responseDic[@"data"]];
                    
                    [subscriber sendNext:model];
                } else {
                    
                    
                }

                [subscriber sendCompleted];
                
            } failure:^(NSError *error) {
                
                [subscriber sendError:error];
                [subscriber sendCompleted];

            }];
            
            
            return nil;
        }];
        
        return signal;
    }];
    
}

@end
