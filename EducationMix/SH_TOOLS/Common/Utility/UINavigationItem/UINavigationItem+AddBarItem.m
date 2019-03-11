//
//  UINavigationItem+AddBarItem.m
//  SevenMBasket
//
//  Created by Jadian on 14-8-1.
//  Copyright (c) 2014年 IEXIN. All rights reserved.
//

#define APART_SPACE

#import "UINavigationItem+AddBarItem.h"

@implementation UINavigationItem (AddBarItem)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self setLeftBarButtonItems:@[negativeSpacer, leftBarButtonItem]];
    } else {
        [self setLeftBarButtonItem:leftBarButtonItem];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:@[negativeSpacer, rightBarButtonItem]];
    } else {
        [self setRightBarButtonItem:rightBarButtonItem];
    }
}

- (void)addRightBarButtonItems:(NSArray*)rightBarButtonItems {
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightBarButtonItems.count * 38.5, 44)];
    
    for (int i = 0; i < rightBarButtonItems.count; i++) {
        UIButton *btnItem = rightBarButtonItems[i];
        btnItem.frame = CGRectMake((i + 1) * 36 + i * 5 - btnItem.frame.size.width, (44 - btnItem.frame.size.height) / 2, btnItem.frame.size.width, btnItem.frame.size.height);
        [barView addSubview:btnItem];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:@[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:barView]]];
    } else {
        [self setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:barView]];
    }
}

- (UIBarButtonItem*)getLeftBarButtonItem {
    UIBarButtonItem *leftBarButtonItem;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        leftBarButtonItem = self.leftBarButtonItems[1];
    } else {
        leftBarButtonItem = self.leftBarButtonItem;
    }
    
    return leftBarButtonItem;
}

- (UIBarButtonItem*)getRightBarButtonItem {
    UIBarButtonItem *leftBarButtonItem;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        leftBarButtonItem = self.rightBarButtonItems[1];
    } else {
        leftBarButtonItem = self.rightBarButtonItem;
    }
    
    return leftBarButtonItem;
}

@end
