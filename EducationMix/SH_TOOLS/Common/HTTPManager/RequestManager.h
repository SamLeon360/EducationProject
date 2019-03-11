//
//  RequestManager.h
//  BCZP
//
//  Created by zohar on 16/9/20.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "APIDefine.h"


#define NOTIFY_NAME_NetWorkChange @"NetWorkChange"

@interface UploadParam : NSObject


/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;

@end

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};


/**定义请求成功的block*/
typedef void(^requestSuccess)( NSDictionary * object);

/**定义请求失败的block*/
typedef void(^requestFailure)( NSError *error);

/**定义上传进度block*/
typedef void(^uploadProgress)(float progress);

/**定义下载进度block*/
typedef void(^downloadProgress)(float progress);


@interface RequestManager : NSObject

+ (instancetype)sharedInstance;
/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)getWithBaiduURLString:(NSString *)URLString
                   parameters:(id)parameters
                      withHub:(BOOL)isShowHub
                    withCache:(BOOL)isSave
                      success:(void (^)(NSDictionary *responseDic))success
                      failure:(void (^)(NSError *))failure;
- (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 withHub:(BOOL)isShowHub
               withCache:(BOOL)isSave
                 success:(void (^)(NSDictionary *responseDic))success
                 failure:(void (^)(NSError *error))failure;

- (void)getWithDIYURLString:(NSString *)URLString
                 parameters:(id)parameters
                    withHub:(BOOL)isShowHub
                  withCache:(BOOL)isSave
                    success:(void (^)(NSDictionary *responseDic))success
                    failure:(void (^)(NSError *))failure;
/**
 *  发送异步post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *error))failure;


- (void)postWithDIYURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(NSDictionary *responseDic))success
                  failure:(void (^)(NSError *error))failure;
    
- (void)postWithURLStringHeaderAndBody:(NSString *)URLString
                      headerParameters:(id)parameters
                        bodyParameters:(id)bodyparameters
                               withHub:(BOOL)isShowHub
                             withCache:(BOOL)isSave
                               success:(void (^)(NSDictionary *responseDic))success
                               failure:(void (^)(NSError *))failure;
/**
 *  发送异步put请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)putWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 withHub:(BOOL)isShowHub
               withCache:(BOOL)isSave
                 success:(void (^)(NSDictionary *responseDic))success
                 failure:(void (^)(NSError *))failure;

/**
 *  发送异步delete请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)deleteWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                    withHub:(BOOL)isShowHub
                  withCache:(BOOL)isSave
                    success:(void (^)(NSDictionary *responseDic))success
                    failure:(void (^)(NSError *))failure;

/**
 *  发送异步post请求,返回数据不封装
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (void)requestWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  withHub:(BOOL)isShowHub
                withCache:(BOOL)isSave
                  success:(void (^)(id responseData))success
                  failure:(void (^)(NSError *error))failure;


/**
 *上传图片
 *
 *@param urlStr     服务器网址
 *@param parameters 上传图片的参数
 *@param imageArr   上传的图片数组
 *@param progress   上传图片的进度
 *@param success    上传成功的回调
 *@param failure    上传失败的回调
 */
- (void)uploadImageArrayWithUrlStr:(NSString *)urlStr
                        parameters:(id)parameters
                        imageArray:(NSArray *)imageArr
                          progress:(void (^)(double progress)) progress
                           success:(void (^)(NSDictionary *responseDic))success
                           failure:(void (^)(NSError *error))failure;

/**
 带图片上传

 @param urlStr 服务器网址
 @param parameters 上传的参数
 @param isShowHub 是否显示hud
 @param constructingBodyWithBlock formData
 @param progress 上传图片的进度
 @param success 上传成功的回调
 @param failure 上传失败的回调
 */
- (void)uploadImageArrayWithUrlStr:(NSString *)urlStr
                        parameters:(id)parameters
                           withHub:(BOOL)isShowHub
         constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>formData)) constructingBodyWithBlock
                          progress:(void (^)(double progress)) progress
                           success:(void (^)(NSDictionary *responseDic))success
                           failure:(void (^)(NSError *error))failure;


- (void)postBugWithURLString:(NSString *)urlStr
                  parameters:(id)parameters
                     withHub:(BOOL)isShowHub
   constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>formData)) constructingBodyWithBlock
                    progress:(void (^)(double progress)) progress
                     success:(void (^)(NSDictionary *responseDic))success
                     failure:(void (^)(NSError *error))failure;


/**
 取消网络请求
 */
- (void)cancelAllRequest;
- (void)uploadImageArrayWithUrlStr:(NSString *)urlStr
                  headerparameters:(id)headerparameters
                    bodyParameters:(id)bodyparameters
                        imageArray:(NSArray *)imageArr
                          progress:(void (^)(double progress)) progress
                           success:(void (^)(NSDictionary *responseDic))success
                           failure:(void (^)(NSError *error))failure;
- (void)shitPostWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                      withHub:(BOOL)isShowHub
                    withCache:(BOOL)isSave
                      success:(void (^)(NSDictionary *responseDic))success
                      failure:(void (^)(NSError *))failure ;
- (void)allUserHeaderPostWithURLString:(NSString *)URLString
                            parameters:(id)parameters
                               withHub:(BOOL)isShowHub
                             withCache:(BOOL)isSave
                               success:(void (^)(NSDictionary *responseDic))success
                               failure:(void (^)(NSError *))failure ;
@end
