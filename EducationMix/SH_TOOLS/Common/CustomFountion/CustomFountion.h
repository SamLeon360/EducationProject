//
//  CustomFountion.h
//  PengKa
//
//  Created by chenshuo on 16/5/19.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CustomFountion : NSObject
+ (void)setHudType;
/**
 *  无图标提示框
 *
 *  @param tmpStr 提示文字
 */
+(void)showStrHUD:(NSString *)tmpStr;
+(void)showBadHudByDismiss:(NSString *)string  hideTime: (CGFloat )time;
+(void)hideHudByTime : (CGFloat )time;
/**
 *  错误提示框
 *
 *  @param tmpStr 提示文字
 */
+(void)showErrorHUD:(NSString *)tmpStr;

+(void)showErrorHUD:(NSString *)tmpStr delay:(CGFloat)delay;

/**
 *  成功提示框
 *
 *  @param tmpStr 提示文字
 */
+(void)showSuccessHUD:(NSString *)tmpStr;

+(void)showSuccessHUD:(NSString *)tmpStr delay:(CGFloat)delay;
/**
 *  等待提示框
 *
 *  @param tmpStr 提示文字
 */
+(void)showWaitHUD:(NSString *)tmpStr;

/**
 *  关闭提示框
 */
+(void)dismissHUD;

/**
 *  计算文本高度
 *
 *  @param text     文本
 *  @param fontSize 字体大小
 *  @param maxSize  视图大小
 *
 *  @return CGSize
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

/**
 *  UILabel行距
 *
 *  @param str    出入参数
 *  @param height 高度
 *
 *  @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)lineHeightWithAttributedString:(NSString *)str withHeight:(double)height;

/**
 浮点数处理并去掉多余的0

 @param floatValue 浮点数
 @return 字符串
 */
+(NSString *)stringDisposeWithFloat:(double)floatValue;


/**
 获取最顶层控制器

 @return 顶层控制器
 */
+ (UIViewController *)topViewController;

/**
 检查网络状态

 @return 是否联网
 */
+(BOOL)isNetWork;


/**
 压缩图片到指定大小

 @param image 图片
 @param kb 指定大小
 @return 压缩后的图片
 */
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
+(NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage FileSize:(NSInteger)FileSize;


/**
 判断是否为中国号码

 @param phoneNum 手机号码
 @return 对错
 */
+ (BOOL)isChinaMobile:(NSString *)phoneNum;

/**
 字典转json格式字符串

 @param dic 字典
 @return json格式字符串
 */
+ (NSString*)objectToJsonStr:(id)object;

+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
@end
