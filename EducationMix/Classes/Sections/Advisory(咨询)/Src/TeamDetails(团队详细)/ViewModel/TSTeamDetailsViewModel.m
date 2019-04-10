//
//  TSTeamDetailsViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeamDetailsViewModel.h"

@implementation TSTeamDetailsViewModel

- (instancetype)initWithTeam_id:(NSInteger)team_id {
    
    if(!self) self = [super init];
    
    _team_id = team_id;
    return self;
    
}


- (void)loadDataArrFromNetwork {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL,@"common/detail_common_expert_team"];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
            params[@"team_id"] = @(self.team_id);
            
            
            //            {"talent_id":"72","commerce_id":"","_search_type":0}
            
            [TSRequestTool POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([responseObject[@"code"] integerValue] == 0) {
                    
                    //                    if(responseObject[@"data"])
                    
                    self.model = [TSTeamDetailsModel mj_objectWithKeyValues:responseObject[@"data"][0]];
                    
                    [subscriber sendNext:self.model];
                    
                } else {
                    
                    [TSProgressHUD showError:responseObject[@"message"]];
                    
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
