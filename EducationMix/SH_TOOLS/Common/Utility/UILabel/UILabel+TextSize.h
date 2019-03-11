//
//  UILabel+CGSize.h
//  SevenMBasket
//
//  Created by Jadian on 14-4-29.
//  Copyright (c) 2014年 IEXIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CGSize)

/**
 *  计算文本尺寸(单行) 集成系统在IOS6、IOS7以上不同的计算方法; 兼容 NSString、NSAttributedString.
 *
 *  @param maxWidth 文本绘制的限制宽度
 *
 *  @return 返回文本的尺寸
 */
- (CGSize)textSizeByMaxWidth:(CGFloat)maxWidth;

/**
 *  计算文本尺寸(多行) 集成系统在IOS6、IOS7以上不同的计算方法; 兼容 NSString、NSAttributedString.
 *
 *  @param limitSize 文本绘制的限制范围
 *
 *  @return 返回文本的尺寸
 */
- (CGSize)textSizeByLimitSize:(CGSize)limitSize;

@end
