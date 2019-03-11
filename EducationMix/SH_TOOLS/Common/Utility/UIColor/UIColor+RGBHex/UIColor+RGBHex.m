//
//  UIColor+RGBHex.m
//  PengKa
//
//  Created by GZK on 16/6/4.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "UIColor+RGBHex.h"

@implementation UIColor (RGBHex)

+(UIColor*)colorWithRGB:(unsigned) rgbValue {
    return [UIColor colorWithRGB:rgbValue alpha:1.0];
}

+ (UIColor *)colorWithRGB:(unsigned int)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

@end
