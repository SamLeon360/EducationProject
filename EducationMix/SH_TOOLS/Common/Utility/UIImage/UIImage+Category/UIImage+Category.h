//
//  UIImage+Category.h
//  PengKa
//
//  Created by zohar on 16/3/24.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 *  控制image的缩放
 *
 *  @param size 缩放的尺寸
 *
 *  @return 缩放后的image
 */
- (UIImage *)scaleToSize:(CGSize)size;

/**
 *  控制图片颜色
 *
 *  @param color 想改变的颜色
 *
 *  @return 变色后的image
 */
- (UIImage *)imageWithColor:(UIColor *)color;

/**
 图片压缩

 @param maxFileSize maxFileSize 最大的imageData Length
 @return 返回压缩好图片
 */
- (UIImage *)compressImageToMaxFileSize:(NSInteger)maxFileSize;

/**
 *  截取部分图像
 *
 *  @param rect 阿萨德
 *
 *  @return 1
 */
- (UIImage*)getSubImage:(CGRect)rect;

///保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScaleSize:(CGSize)asize;

@end
