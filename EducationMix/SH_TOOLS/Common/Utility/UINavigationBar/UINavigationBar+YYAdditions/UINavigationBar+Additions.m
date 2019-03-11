//
//  UINavigationBar+Additions.m
//  PengKa
//
//  Created by zohar on 16/7/8.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "UINavigationBar+Additions.h"

@implementation UINavigationBar (Additions)

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if ([self pointInside:point withEvent:event]) {
        self.userInteractionEnabled = YES;
    } else {
        self.userInteractionEnabled = NO;
    }
    
    return [super hitTest:point withEvent:event];
}

@end
