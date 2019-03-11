//
//  UIButton+Extension.m
//  PengKa
//
//  Created by LPN on 16/3/19.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)buttonWithFont:(CGFloat )font image:(NSString *)image imageH:(NSString *)imageH imageSlected:(NSString *)imageSlected title:(NSString *)title imageCenterRatio:(CGFloat )imageRatio titleCenterRatio:(CGFloat )titleRatio {
    
    UIImage *btnImage = [UIImage imageNamed:image];
    CGFloat imageWidth = CGImageGetWidth(btnImage.CGImage);
    CGFloat imageHeight = CGImageGetHeight(btnImage.CGImage);
    
    if ([UIScreen mainScreen].scale == 3.0f) {
        
        imageWidth *= 0.5f;
        imageHeight *= 0.5f;
    }
    
    NSString *btnText = title;
    UIFont *btnFont = [UIFont systemFontOfSize:font];
    NSDictionary *attrs = @{NSFontAttributeName : btnFont};
    CGSize labelSize = [btnText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine attributes:attrs context:nil].size;
    
    CGFloat labelHeight = labelSize.height;
    CGFloat labelWidth = labelSize.width;
    
    CGFloat btnH = imageHeight + labelHeight;
    CGFloat btnW = imageWidth + labelWidth;
    
    self.bounds = CGRectMake(0, 0, btnW, btnH);
    
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imageH] forState:UIControlStateHighlighted];
    [self setImage:[UIImage imageNamed:imageSlected] forState:UIControlStateSelected];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:font]];
    
    CGPoint imageEndCenter = CGPointMake(btnW / 2, btnH * imageRatio);
    CGPoint imageStartCenter = self.imageView.center;
    
    CGFloat top1 = imageEndCenter.y - imageStartCenter.y;
    CGFloat left1 = imageEndCenter.x - imageStartCenter.x;
    CGFloat bottom1 = -top1;
    CGFloat right1 = -left1;
    self.imageEdgeInsets = UIEdgeInsetsMake(top1, left1, bottom1, right1);
    
    CGPoint titleEndCenter = CGPointMake(btnW / 2, btnH * titleRatio);
    CGPoint titleStartCenter = self.titleLabel.center;
    
    CGFloat top2 = titleEndCenter.y - titleStartCenter.y;
    CGFloat left2 = titleEndCenter.x - titleStartCenter.x;
    CGFloat bottom2 = -top2;
    CGFloat right2 = -left2;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(top2, left2, bottom2, right2);
    self.contentEdgeInsets = UIEdgeInsetsMake(0, -labelWidth/2, 0, -labelWidth/2);
}

@end
