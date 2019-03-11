//
//  UIButton+SetImage.m
//  SevenM
//
//  Created by Jadian on 12/19/14.
//  Copyright (c) 2014 IX. All rights reserved.
//

#import "UIButton+Custom.h"
#import "UIImage+Custom.h"

#import <objc/runtime.h>

@implementation UIButton (SetImage)

-(void)setBackgroupImage:(NSString *)imageName {
    UIImage *normalImage = [UIImage imageNamed:imageName];
    if (normalImage)
       	[self setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    UIImage *hightedImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_p"]];
    if (hightedImage) {
       	[self setBackgroundImage:hightedImage forState:UIControlStateSelected];
       	[self setBackgroundImage:hightedImage forState:UIControlStateHighlighted];
    }
}

@end


@implementation UIButton (SetBackgroundColorForState)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor rect:CGRectMake(0.f, 0.f, 1.f, 1.f)] forState:state];
}

@end


@implementation UIButton (EdgeInsets)

- (void)topImageAndBottomTitle {
    
    self.imageEdgeInsets = UIEdgeInsetsZero;
    self.titleEdgeInsets = UIEdgeInsetsZero;
    
    CGFloat btn_width = CGRectGetWidth(self.bounds);
    CGFloat btn_height = CGRectGetHeight(self.bounds);
    
    CGRect imageViewFrame = self.imageView.frame;
    CGRect titleLabelFrame = self.titleLabel.frame;
    
    CGFloat imageHorizontalPadding = (btn_width - CGRectGetWidth(imageViewFrame))/2;
    
    CGFloat verticalRemainingSpace = btn_height - CGRectGetHeight(titleLabelFrame) - CGRectGetHeight(imageViewFrame);
    
    CGFloat image_vertical_shiftValue = CGRectGetMinY(imageViewFrame) - verticalRemainingSpace / 2;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-image_vertical_shiftValue, imageHorizontalPadding, verticalRemainingSpace, image_vertical_shiftValue);
    
    // must reset imageViewFrame after adjust imageView position
    imageViewFrame = self.imageView.frame;
    
    CGSize labelSize = CGSizeMake(btn_width, CGRectGetHeight(titleLabelFrame));
    
    CGFloat textWidth = [self.titleLabel.text boundingRectWithSize:labelSize
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName : self.titleLabel.font}
                                                       context:NULL].size.width;
    
    CGFloat labelHorizontalPadding = (btn_width - textWidth)/2;
    
    CGFloat label_left_shiftValue = CGRectGetMinX(titleLabelFrame) - labelHorizontalPadding;
    
    CGFloat label_right_shiftValue = (textWidth > CGRectGetWidth(titleLabelFrame)) ? CGRectGetMaxX(titleLabelFrame) - (labelHorizontalPadding + textWidth) : label_left_shiftValue;
    
    CGFloat label_vertical_shiftValue = CGRectGetMaxY(imageViewFrame) - CGRectGetMinY(titleLabelFrame);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(label_vertical_shiftValue, -label_left_shiftValue, -label_vertical_shiftValue, label_right_shiftValue);
}

- (void)rightImageAndLeftTitle {
    
}

@end
