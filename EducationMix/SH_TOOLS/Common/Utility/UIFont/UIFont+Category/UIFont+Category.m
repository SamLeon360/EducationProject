//
//  UIFont+Category.m
//  PengKa
//
//  Created by zohar on 16/5/17.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)

+ (UIFont *)fontOfSize:(CGFloat)size
{
//    return [UIFont fontWithName:@"MicrosoftYaHei" size:size];
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldFontOfSize:(CGFloat)size
{
    
//    return [UIFont fontWithName:@"MicrosoftYaHei-Bold" size:size];
    return [UIFont boldSystemFontOfSize:size];
}


@end
