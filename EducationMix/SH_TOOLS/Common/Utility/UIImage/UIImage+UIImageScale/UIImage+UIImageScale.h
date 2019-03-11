//
//  UIImage+UIImageScale.h
//  百城招聘宝
//
//  Created by admin on 15/11/24.
//  Copyright © 2015年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(UIImageScale)
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;
@end
