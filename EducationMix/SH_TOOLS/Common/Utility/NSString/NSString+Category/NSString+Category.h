//
//  NSString+Extension.h
//  PengKa
//
//  Created by LPN on 16/4/9.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  文字宽高
 *
 *  @param font    字体大小
 *  @param maxSize 最大的size
 *
 *  @return 字符串的size
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 *  对指定内定进行着色，keywords数组与colors数组相对应
 *
 *  @param keyWords 关键字数组
 *  @param colors    关键字对应颜色，如果传空，则默认对关键字着红色
 *  @param repeat   关键字出现多次的时候，是否全部进行多次着色,默认否
 *
 *  @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)attributeStringWithKeyWords:(NSArray *)keyWords colors:(NSArray *)colors repeat:(BOOL)repeat;

@end
