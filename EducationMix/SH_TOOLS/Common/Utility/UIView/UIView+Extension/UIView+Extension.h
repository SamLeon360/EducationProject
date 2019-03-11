//
//  UIView+Extension.h
//  PengKa
//
//  Created by zohar on 16/3/16.
//  Copyright © 2016年 zohar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic,assign) CGFloat viewX;
@property (nonatomic,assign) CGFloat viewY;
@property (nonatomic,assign) CGFloat viewCenterX;
@property (nonatomic,assign) CGFloat viewCenterY;
@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,assign) CGFloat viewHeight;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;

@property (nonatomic, assign) CGFloat viewLeft;
@property (nonatomic, assign) CGFloat viewRight;
@property (nonatomic, assign) CGFloat viewBottom;

-(void)makeCorner:(CGFloat)radius;

@end
