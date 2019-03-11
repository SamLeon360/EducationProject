//
//  UIView+Extension.m
//  PengKa
//
//  Created by zohar on 16/3/16.
//  Copyright © 2016年 zohar. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setViewX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)viewX{
    return self.frame.origin.x;
}

- (void)setViewY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)viewY{
    return self.frame.origin.y;
}

- (void)setViewCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)viewCenterX{
    return self.center.x;
}

- (void)setViewCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)viewCenterY{
    return self.center.y;
}

- (void)setViewWidth:(CGFloat)viewWidth{
    CGRect frame = self.frame;
    frame.size.width = viewWidth;
    self.frame = frame;
}

- (CGFloat)viewWidth{
    return self.frame.size.width;
}

- (void)setViewHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)viewHeight{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)viewLeft
{
    return CGRectGetMinX(self.frame);
}

- (void)setViewLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)viewRight
{
    return CGRectGetMaxX(self.frame);
}

- (void)setViewRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right;
    self.frame = frame;
}

- (CGFloat)viewBottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setViewBottom:(CGFloat)bottom
{
    self.viewY = self.viewBottom - self.viewHeight;
}

-(void)makeCorner:(CGFloat)radius{
    CALayer * lay = self.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:radius];
}
@end
