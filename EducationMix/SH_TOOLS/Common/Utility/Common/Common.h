//
//  ColorFromHexCode.h
//  百城求职宝
//
//  Created by sunshine on 15/7/10.
//  Copyright (c) 2015年 chenshuo. All rights reserved.
//  作用：将RGB转换成对应颜色

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Common : NSObject

+ (UIColor *) colorFromHexCode:(NSString *)hexString;
+ (NSString *)EncodeGB2312Str:(NSString *)encodeStr;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;
+ (UIImage *)cutImage:(UIImage *)image;
+ (void)scalingWithView:(UIView *)view;
+ (void)scaleFontWithView:(UIView *)view;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString *)convertToJsonData:(NSDictionary *)dict;

+ (NSString *)arrayToJSONString:(NSArray *)array;

+ (UIViewController *)viewController :(UIView *)currentview;

+ (void)gotoMap : (CGFloat)lng andlat:(CGFloat)lat andAdd:(NSString *)add andVC:(UIViewController *)vc;
+(void)shareDataToWeChat:(NSDictionary * )dic;
@end
