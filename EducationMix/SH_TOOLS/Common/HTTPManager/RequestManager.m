//
//  RequestManager.m
//  BCZP
//
//  Created by zohar on 16/9/20.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "RequestManager.h"

#import <AFNetworking.h>
#import <YYCache.h>
#import "AppDelegate.h"
//#import "ThirdPartyManager.h"

#import "NSDictionary+Json.h"
@interface RequestManager()

@end


@implementation RequestManager

static id _instance = nil;

static bool isShowingLoginVC = false;

static AFHTTPSessionManager *sessionManager;

+ (instancetype)sharedInstance {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}



- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NAME_NetWorkChange object:@(status)];
            //如果网络变化，地图为初始化。再初始化一次。
//            if (![ThirdPartyManager sharedManager].isMapServiceStart) {
//                [[ThirdPartyManager sharedManager] initMap];
//            }
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 位置网络
                    NSLog(@"位置网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    NSLog(@"无法联网");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // WIFI
                    NSLog(@"当前在WIFI网络下");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    // 手机自带网络
                    NSLog(@"当前使用的是2G/3G/4G网络");
                }
            }
        }];
        sessionManager = [AFHTTPSessionManager manager];
        //证书效验
//        sessionManager.securityPolicy = [self customSecurityPolicy];
    });
    return _instance;
}

- (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"app.bczp.cn" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates = certSet;
    
    return securityPolicy;
}


#pragma 监测网络的可链接性
- (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}



#pragma mark -- GET请求 --
- (void)getWithBaiduURLString:(NSString *)URLString
              parameters:(id)parameters
                 withHub:(BOOL)isShowHub
               withCache:(BOOL)isSave
                 success:(void (^)(NSDictionary *responseDic))success
                 failure:(void (^)(NSError *))failure {
    
        [self getWithDIYURLString:URLString parameters:parameters withHub:isShowHub withCache:isSave success:success failure:failure];
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 withHub:(BOOL)isShowHub
               withCache:(BOOL)isSave
                 success:(void (^)(NSDictionary *responseDic))success
                 failure:(void (^)(NSError *))failure {
    if ([URLString isEqualToString:SH_URL_GET_APPSTORE]) {
        [self getWithDIYURLString:URLString parameters:parameters withHub:isShowHub withCache:isSave success:success failure:failure];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@",TX_HOST_URL, URLString];
        [self getWithDIYURLString:url parameters:parameters withHub:isShowHub withCache:isSave success:success failure:failure];
    }
}

- (void)getWithDIYURLString:(NSString *)URLString
              parameters:(id)parameters
                 withHub:(BOOL)isShowHub
               withCache:(BOOL)isSave
                 success:(void (^)(NSDictionary *responseDic))success
                 failure:(void (^)(NSError *))failure{
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //        manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    sessionManager.requestSerializer.timeoutInterval = 15.f;
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
//   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
    NSString *url = URLString;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//     [dic setObject:USER_SINGLE.token forKey:@"token"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",cacheKey);
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ([result isKindOfClass:[NSArray class]]) {
                
            }else{
                if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                    if ([result[@"results"][@"code"] integerValue] == 5000) {
                        NOTIFY_POST(@"addReLoginView");
                    }
                }
                [result logDic];
            }
//            NSDictionary *results = result[@"results"];
           
            success(result);
#ifdef DEBUG
            
#else
            
#endif
        }
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        if (isShowHub) {
            [CustomFountion dismissHUD];
//            [CustomFountion showErrorHUD:[error description]];
        }
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
    }];
}
#pragma mark -- POST请求 指定URL
- (void)postWithDIYURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    //    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.0"};
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
    NSString *url = [NSString stringWithFormat:@"%@", URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:USER_SINGLE.token forKey:@"token"];
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
              if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                  if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
              }
            //            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
            //
            //            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
//
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *))failure {
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
//    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.0"};
 
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    if (USER_SINGLE.token.length > 0 ) {
         [dic setObject:USER_SINGLE.token forKey:@"token"];
    }
    if ([URLString isEqualToString:SH_GET_AREA]||[URLString isEqualToString:SH_GET_NEWS_DETAIL]||[URLString isEqualToString:SH_WEB_DETAIL]||[URLString isEqualToString:SH_COMPANY_LIST]||[URLString isEqualToString:SH_DETAIL_COMPANY]||[URLString isEqualToString:SH_COMPANY_DEFAULT]||[URLString isEqualToString:SH_PRICE_PAY]||[URLString isEqualToString:SH_CREAT_ORDER]||[URLString isEqualToString:SH_MOMENTS_DATA]||[URLString isEqualToString:SH_MEMBER_DETAIL]||[URLString isEqualToString:SH_HANDLE_FRIENDS]||[URLString isEqualToString:SH_UPDATE_COMPANY]||[URLString isEqualToString:SH_INVESTMENT_LIST]||[URLString isEqualToString:SH_MOTION_LIST]||[URLString isEqualToString:SH_INVESTMEMT_DETAIL]||[URLString isEqualToString:SH_SHOW_MESSAGE]||[URLString isEqualToString:SH_ADD_MESSAGE]||[URLString isEqualToString:SH_GET_MEMBERS_MESSAGE]||[URLString  isEqualToString:SH_DELETE_COLLECTION]||[URLString isEqualToString:SH_ADD_COLLECTION]||[URLString isEqualToString:LOGIN_URL]) {
        [dic removeObjectForKey:@"token"];
    }
    
//    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }

    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
//            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
//            
//            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postWithURLStringHeaderAndBody:(NSString *)URLString
               headerParameters:(id)parameters
               bodyParameters:(id)bodyparameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    //    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.0"};
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    if (USER_SINGLE.token.length > 0) {
        [dic setObject:USER_SINGLE.token forKey:@"token"];
    }
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    //    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:bodyparameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
            //            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
            //
            //            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark -- POST请求 --
- (void)putWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:USER_SINGLE.token forKey:@"token"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager PUT:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
            //            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
            //
            //            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- DELETE请求 --
- (void)deleteWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
//    if ([USER_SINGLE isLogin]) {
        [dic setObject:USER_SINGLE.token forKey:@"token"];
//    }
//    if ([URLString isEqualToString:[NSString stringWithFormat:@"%@/%@",YK_URL_POST_TREE,parameters[@"objectId"]]]) {
//        [dic removeObjectForKey:@"groupId"];
//    }
//    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
//        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    [sessionManager DELETE:url parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
            //            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
            //
            //            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}


- (void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                     withHub:(BOOL)isShowHub
                   withCache:(BOOL)isSave
                     success:(void (^)(id responseData))success
                     failure:(void (^)(NSError *error))failure
{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (USER_SINGLE.token.length>0) {
        [dic setObject:USER_SINGLE.token forKey:@"token"];
    }
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    //    [dic setValue:kCityCode forKey:@"globalcc"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
//        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            if (isSave) {
                //缓存
                [cache setObject:result forKey:cacheKey];
            }
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
            success(result);
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            
        }else{
            
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            id result = [cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
    
}


- (void)postBugWithURLString:(NSString *)urlStr
                  parameters:(id)parameters
                     withHub:(BOOL)isShowHub
   constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  _Nonnull formData)) constructingBodyWithBlock
                    progress:(void (^)(double progress)) progress
                     success:(void (^)(NSDictionary *responseDic))success
                     failure:(void (^)(NSError *error))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    //    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.0"};
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, urlStr];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    if ([USER_SINGLE isLogin]) {
    [dic setObject:USER_SINGLE.token forKey:@"token"];
//    }
//    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:dic constructingBodyWithBlock:constructingBodyWithBlock progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---%f",uploadProgress.fractionCompleted);
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
        if (isShowHub) {
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"请稍后..."];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
        if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
            if ([result[@"results"][@"code"] integerValue] == 5000) {
                NOTIFY_POST(@"addReLoginView");
            }
        }
#ifdef DEBUG
        [result logDic];
#else
        
#endif
        
        if (success) {
            success(result);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- 上传图片 --
- (void)uploadImageArrayWithUrlStr:(NSString *)urlStr
                        headerparameters:(id)headerparameters
                        bodyParameters:(id)bodyparameters
                        imageArray:(NSArray *)imageArr
                          progress:(void (^)(double progress)) progress
                           success:(void (^)(NSDictionary *responseDic))success
                           failure:(void (^)(NSError *error))failure{
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval= 60.f;//请求超时5.0s
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, urlStr];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:headerparameters];
    //    if ([USER_SINGLE isLogin]) {
    [dic setObject:USER_SINGLE.token forKey:@"token"];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
//        }
    //    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];

    
    //////////////////////////////
//    NSString *strUrl = [url stringByAppendingString:@"?"];
//    for (NSString *strKey in dic.allKeys) {
//        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
//    }
//    NSLog(@"%@",strUrl);
    //////////////////////////////
    
    [sessionManager POST:url parameters:bodyparameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(NSInteger i = 0; i < imageArr.count; i++)
        {
            NSData * imageData = UIImageJPEGRepresentation([imageArr objectAtIndex: i], 0.6);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *imgName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
            NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", USER_SINGLE.member_id, imgName];
//              [formData appendPartWithFormData:bodyparameters[@"member_id"]  name:@"member_id"];
            [formData appendPartWithFileData:imageData name:@"avatar[]" fileName:fileName mimeType:@"image/png"];
          
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---%f",uploadProgress.fractionCompleted);
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
        
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
        if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
            if ([result[@"results"][@"code"] integerValue] == 5000) {
                NOTIFY_POST(@"addReLoginView");
            }
        }
#ifdef DEBUG
        [result logDic];
#else
        
#endif
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- 上传图片 --
- (void)uploadImageArrayWithUrlStr:(NSString *)urlStr
                        parameters:(id)parameters
                        imageArray:(NSArray *)imageArr
                          progress:(void (^)(double progress)) progress
                           success:(void (^)(NSDictionary *responseDic))success
                           failure:(void (^)(NSError *error))failure{
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval= 60.f;//请求超时5.0s
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, urlStr];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    if ([USER_SINGLE isLogin]) {
    [dic setObject:USER_SINGLE.token forKey:@"token"];
//    }
//    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
  
    
    //////////////////////////////
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    //////////////////////////////
    
    [sessionManager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for(NSInteger i = 0; i < imageArr.count; i++)
        {
            NSData * imageData = UIImageJPEGRepresentation([imageArr objectAtIndex: i], 0.6);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *imgName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
//            NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", USER_SINGLE.nickname, imgName];
            
//            [formData appendPartWithFileData:imageData name:imgName fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---%f",uploadProgress.fractionCompleted);
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
        
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
        if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
            if ([result[@"results"][@"code"] integerValue] == 5000) {
                NOTIFY_POST(@"addReLoginView");
            }
        }
#ifdef DEBUG
        [result logDic];
#else
        
#endif
        
        if (success) {
            success(result);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

- (void)uploadImageArrayWithUrlStr:(NSString *)urlStr
                        parameters:(id)parameters
                           withHub:(BOOL)isShowHub
         constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>  _Nonnull formData)) constructingBodyWithBlock
                          progress:(void (^)(double progress)) progress
                           success:(void (^)(NSDictionary *responseDic))success
                           failure:(void (^)(NSError *error))failure{
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.requestSerializer.timeoutInterval= 60.f;//请求超时5.0s
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] forHTTPHeaderField:@"iOS-Version"];
    [sessionManager.requestSerializer setValue: [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forHTTPHeaderField:@"iOS-Build"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, urlStr];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    if ([USER_SINGLE isLogin]) {
    [dic setObject:USER_SINGLE.token forKey:@"token"];
    if ([urlStr isEqualToString:SH_UPLOAD_ENTREPRISE_LOGO]) {
        [dic removeObjectForKey:@"token"];
    }
//    }
//    if ([urlStr isEqualToString:[NSString stringWithFormat:@"/api/v1/tree?%@",@"clear_mu_photo=1"]] || [urlStr isEqualToString:@"/api/v1/tree"]) {
//        [dic removeObjectForKey:@"groupId"];
//    }
//    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    //////////////////////////////
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    
    
    if (isShowHub) {
//        [CustomFountion setHudType];
         [SVProgressHUD showProgress:0 status:@"请稍后..."];
    }
    [sessionManager POST:url parameters:dic constructingBodyWithBlock:constructingBodyWithBlock progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---%f",uploadProgress.fractionCompleted);
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
        if (isShowHub) {
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"请稍后..."];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
        if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
            if ([result[@"results"][@"code"] integerValue] == 5000) {
                NOTIFY_POST(@"addReLoginView");
            }
        }
#ifdef DEBUG
        [result logDic];
#else
        
#endif
        
        if (success) {
            success(result);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        if (failure) {
            failure(error);
        }
    }];
    
}
#pragma mark -- POST请求 --奇葩请求方法
- (void)shitPostWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    //    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.0"};
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
    
    if (USER_SINGLE.token.length > 0) {
        [sessionManager.requestSerializer setValue:USER_SINGLE.token forHTTPHeaderField:@"token"];
    }
    
    //    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
            //            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
            //
            //            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --奇葩请求方法
- (void)allUserHeaderPostWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                      withHub:(BOOL)isShowHub
                    withCache:(BOOL)isSave
                      success:(void (^)(NSDictionary *responseDic))success
                      failure:(void (^)(NSError *))failure {
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",nil];
    sessionManager.requestSerializer.timeoutInterval= 15.f;
    //    NSDictionary *headerFieldValueDictionary = @{@"version":@"1.0"};
    
    NSString *url = [NSString stringWithFormat:@"%@%@", TX_HOST_URL, URLString];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        [sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
//    }];
//
    if (USER_SINGLE.token.length > 0) {
        [sessionManager.requestSerializer setValue:USER_SINGLE.token forHTTPHeaderField:@"token"];
        NSLog(@"%@",USER_SINGLE.TokenFrom);
        [sessionManager.requestSerializer setValue:USER_SINGLE.TokenFrom forHTTPHeaderField:@"TokenFrom"];
        [sessionManager.requestSerializer setValue:USER_SINGLE.role_type forHTTPHeaderField:@"RoleType"];
        [sessionManager.requestSerializer setValue:USER_SINGLE.member_id forHTTPHeaderField:@"member_id"];
    }
    
    //    [sessionManager.requestSerializer setValue:USER_SINGLE.isOpenSeller?@"seller":@"buyer" forHTTPHeaderField:@"role"];
    
    YYCache *cache = [YYCache cacheWithName:@"myCache"];
    
    NSString *cacheKey = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        cacheKey = [NSString stringWithFormat:@"%@%@=%@&", cacheKey, strKey, [dic objectForKey:strKey]];
    }
    
    NSString *strUrl = [url stringByAppendingString:@"?"];
    for (NSString *strKey in dic.allKeys) {
        strUrl = [NSString stringWithFormat:@"%@%@=%@&", strUrl, strKey, [dic objectForKey:strKey]];
    }
    NSLog(@"%@",strUrl);
    
    if (isShowHub) {
        [CustomFountion showWaitHUD:@"请稍候..."];
    }
    
    [sessionManager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (isShowHub) {
                [CustomFountion dismissHUD];
            }
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSDictionary dictionaryWithJsonString:response];
            if ( [result[@"results"] isKindOfClass:[NSDictionary class]]) {
                if ([result[@"results"][@"code"] integerValue] == 5000) {
                    NOTIFY_POST(@"addReLoginView");
                }
            }
            //            NSDictionary *resultJson = [NSDictionary dictionaryWithJsonString:response];
            //
            //            NSDictionary *result =  [NSDictionary changeType:resultJson];
#ifdef DEBUG
            [result logDic];
#else
            
#endif
            success(result);
        }else{
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (isShowHub) {
            [CustomFountion dismissHUD];
        }
        
        if(isSave){
            
            YYCache *cache = [YYCache cacheWithName:@"myCache"];
            NSDictionary *result = (NSDictionary *)[cache objectForKey:cacheKey];
            if(result){
                success(result);
                [CustomFountion showErrorHUD:@"网络错误!"];
                return;
            }
            
        }
        
        if (failure) {
            failure(error);
        }
    }];
}
#pragma mark - 取消所有网络请求
- (void)cancelAllRequest {
    
    for (NSURLSessionDataTask *task in sessionManager.tasks) {
        [task cancel];
    }
    [sessionManager.operationQueue cancelAllOperations];
}

@end
