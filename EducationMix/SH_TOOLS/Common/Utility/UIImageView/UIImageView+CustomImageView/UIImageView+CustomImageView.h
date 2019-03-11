//
//  UIImageView+CustomImageView.h
//  ZhenHuaOnline
//
//  Created by admin on 15/5/19.
//  Copyright (c) 2015年 梁继明. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (CustomImageView)

-(void)setImageWithURLStr:(NSString *)urlName ;

-(void)setImageConerWithURLStr:(NSString *)urlName;

-(void)setImageWithURLStrOrg:(NSString *)urlName;

-(void)setImageConerWithURLStr:(NSString *)urlName withRadios:(CGFloat )r withPlaceHolder:(NSString *)str;
//进度条
-(void)setImageWithURLStrOrg:(NSString *)urlName withPlaceHolderUIImage:(UIImage *)placeHolderImage isShowHub:(BOOL)isShow;

-(void)setImageWithURLStrOrg:(NSString *)urlName withPlaceHolder:(NSString *)placeHolder;

-(void)setImageConerWithURLStr:(NSString *)urlName withPlaceHolder:(NSString *)str;

-(void)setImageWithURLStr:(NSString *)urlName withPlaceHolder:(NSString *)str;

-(void)setImageWithURLStr:(NSString *)urlName withPlaceHolderUIImage:(UIImage *)placeHolderImage;

@end
