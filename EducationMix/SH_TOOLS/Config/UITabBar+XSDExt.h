//
//  UITabBar+XSDExt.h
//  estateanget_iOS
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 kenshinhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITabBar (XSDExt)
- (void)showBadgeOnItemIndex:(NSInteger)index;   ///<显示小红点

- (void)hideBadgeOnItemIndex:(NSInteger)index;  ///<隐藏小红点  
@end
