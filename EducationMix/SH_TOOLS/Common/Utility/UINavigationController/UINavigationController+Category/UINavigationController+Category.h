//
//  UINavigationController+Category.h
//  PengKa
//
//  Created by zohar on 16/3/29.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Category)

- (void)pushAnimationDidStop;

- (void)pushViewController: (UIViewController*)controller animatedWithTransition: (UIViewAnimationTransition)transition;

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition;

@end
