//
//  UIColor+RGBHex.h
//  PengKa
//
//  Created by GZK on 16/6/4.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBHex)

+(UIColor*)colorWithRGB:(unsigned)rgbValue;
+(UIColor*)colorWithRGB:(unsigned)rgbValue  alpha:(CGFloat)alpha;

@end
