//
//  UIButton+SetImage.h
//  SevenM
//
//  Created by Jadian on 12/19/14.
//  Copyright (c) 2014 IX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIButton (SetImage)

-(void)setBackgroupImage:(NSString*)imageName;

@end


@interface UIButton (SetBackgroundColorForState)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end


@interface UIButton (EdgeInsets)

- (void)topImageAndBottomTitle;

@end
