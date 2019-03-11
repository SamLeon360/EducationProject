//
//  UIButton+Extension.h
//  PengKa
//
//  Created by LPN on 16/3/19.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

- (void)buttonWithFont:(CGFloat )font image:(NSString *)image imageH:(NSString *)imageH imageSlected:(NSString *)imageSlected title:(NSString *)title imageCenterRatio:(CGFloat )imageRatio titleCenterRatio:(CGFloat )titleRatio;

@end
