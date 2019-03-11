//
//  NSString+Utils.h
//  PengKa
//
//  Created by GZK on 16/6/20.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

/**
 *  计算字符串的字符数
 */
- (NSUInteger)getCharsCount;

/**
 *  判断字符串字符长度是否规定范围
 *
 *  @param min 最小长度
 *  @param max 最大长度
 *
 *  @return min < charsCount < max
 */
- (BOOL)charsCountGreater:(NSUInteger)min less:(NSUInteger)max;

/**
 *  nil, @"" Returns NO
 *  其他情况（需求如此 包括“  ”， “\n”）为YES
 */
- (BOOL)notEmptyString;

/**
 *
 *  @return 校验邮箱格式是否正确
 */
- (BOOL)validateEmailFormatter;

/**
 *
 *  @return 验证电话格式
 */
- (BOOL)validatePhoneFormatter;

/**
 *
 * @return 验证是否纯数字
 */
- (BOOL)validateNumberFormatter;

/**
 *
 * @return 验证密码格式是否正确
 */
- (BOOL)validatePasswordFormater;

/**
 *
 *  @return 是否含有中文字符
 */
- (BOOL)containsChineseCharacter;

/**
 *
 *  @return 除去字符串两侧的空白字符后字符串
 */
- (NSString *)stringByTrimminWhitespace;

/**
 *
 *  @return 格式化 保留小数点后两位
 */
- (NSString *)retainedTwoDecimal;


/**
 *
 *  @return 过滤替换字符串中的特殊字符
 */
- (NSString *)stringByFilteredSpecialCharacter;

/**
 *
 *  @return  url 中参数的键值对
 */
- (NSDictionary *)getUrlParmsDict;

- (NSString *)phoneDispaly;

/**
 *
 *  @return 加密为Base64
 */
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;

@end

@interface NSString (Encode)

-(NSString*)gb2312String;

-(NSString*)urlEncodeString;

@end
