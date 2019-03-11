//
//  UINavigationItem+AddBarItem.h
//  SevenMBasket
//
//  Created by Jadian on 14-8-1.
//  Copyright (c) 2014年 IEXIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (AddBarItem)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)addRightBarButtonItems:(NSArray*)rightBarButtonItems;

- (UIBarButtonItem*)getLeftBarButtonItem;

- (UIBarButtonItem*)getRightBarButtonItem;

@end
