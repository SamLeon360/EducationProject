//
//  TSRequestTool.m
//  Mianbao
//
//  Created by Taosky on 2019/2/24.
//  Copyright © 2019 Taosky. All rights reserved.
//

#import "TSRequestTool.h"

@implementation TSRequestTool

+ (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               headers:(nullable id)headers
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    TSNetManager *mgr = [TSNetManager shareManager];
    
    if (headers) {
        [mgr.requestSerializer setValue:[[headers allValues] firstObject] forHTTPHeaderField:[[headers allKeys] firstObject]];
    }
    
    NSURLSessionDataTask *task = [mgr GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        YPLog(@"%@",responseObject);
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        YPLog(@"%@",error);
        failure(task,error);
    }];;
    return task;
}


+ (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable id)headers
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    
    TSNetManager *mgr = [TSNetManager shareManager];

    if (headers) {
        [mgr.requestSerializer setValue:[[headers allValues] firstObject] forHTTPHeaderField:[[headers allKeys] firstObject]];
    }
    
    NSURLSessionDataTask *task = [mgr POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //                TSLog(@"%@",responseObject);
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //                TSLog(@"%@",error);
        failure(task,error);
    }];
    return task;
}

+ (void)cancel
{
    // 取消网络请求
    [[TSNetManager shareManager].operationQueue cancelAllOperations];
    
    // 取消任务中的所有网络请求
    //    [[YPNetManager shareManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 杀死Session
    //    [[YPNetManager shareManager] invalidateSessionCancelingTasks:YES];
}

@end
