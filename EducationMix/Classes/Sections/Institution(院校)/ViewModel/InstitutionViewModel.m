//
//  InstitutionViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import "InstitutionViewModel.h"

@implementation InstitutionViewModel

- (instancetype)initWithModel:(InstitutionModel *)model {
    
    self = [super init];
    if (!self) return nil;
    self.model = model;
    return self;
}


- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
//            @weakify(self);
            NSString *url = @"academy/list_academy";
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            params[@"page"] = @1;
            params[@"academy_type"] = @"";
            params[@"affiliated_area"] = @"";
            params[@"academy_name"] = @"";

            [HTTPREQUEST_SINGLE postWithURLString:url parameters:params withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
                
                if ([responseDic[@"code"] integerValue] == 1) {
                    
                    self.modelArr = [InstitutionModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
                    [subscriber sendNext:self.modelArr];
                    [subscriber sendCompleted];
                    
                }
            } failure:^(NSError *error) {
                
                [subscriber sendError:error];
                
                //[AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
            }];
            
            
            return nil;
            
        }];
        
        return signal;
        
    }];
    
    
    
}


@end
