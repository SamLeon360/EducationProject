//
//  UIImage+Custom.h
//  PengKa
//
//  Created by GZK on 25/6/20.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)

+ (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect;
+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage*)imageCompressWithSimple:(UIImage*)image;


//用颜色创建一张图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *) addText:(UIImage *)img text:(NSString *)mark withRect:(CGRect)rect;
@end
