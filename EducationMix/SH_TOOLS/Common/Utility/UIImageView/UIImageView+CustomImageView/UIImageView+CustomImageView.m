//
//  UIImageView+CustomImageView.m
//  ZhenHuaOnline
//
//  Created by admin on 15/5/19.
//  Copyright (c) 2015年 梁继明. All rights reserved.
//

#import "UIImageView+CustomImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
//#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
//#import "SDBallProgressView.h"




@implementation UIImageView (CustomImageView)

-(void)setImageWithURLStrOrg:(NSString *)urlName withPlaceHolder:(NSString *)placeHolder{
    
    [self setImageWithURLStr:urlName withPlaceHolderUIImage:[UIImage imageNamed:placeHolder]];
    
    
}

-(void)setImageWithURLStr:(NSString *)urlName withPlaceHolderUIImage:(UIImage *)placeHolderImage{
    [self setImageWithURLStrOrg:urlName withPlaceHolderUIImage:placeHolderImage isShowHub:NO];
}

-(void)setImageWithURLStrOrg:(NSString *)urlName withPlaceHolderUIImage:(UIImage *)placeHolderImage isShowHub:(BOOL)isShow{
    self.image = nil;
//    [self sd_cancelCurrentImageLoad];
    NSURL *urlImage = [NSURL URLWithString:urlName] ;
    
    
    //    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    
    UIImage *image =  [[[SDWebImageManager sharedManager] imageCache] imageFromMemoryCacheForKey:urlName];
    
    if (!image) {
        image = [[[SDWebImageManager sharedManager] imageCache] imageFromDiskCacheForKey:urlName];
    }
    //    [[SDImageCache sharedImageCache] queryDiskCacheForKey:urlName done:^(UIImage *image, SDImageCacheType cacheType) {
    
    if (image) {
        
        self.image =  image;
        
    }else{
        
        if (isShow) {
            
            //            [CustomFountion showStrHUD:@"努力加载中"];
        }
        //        NSLog(@"***************************开始下载***************************");
        //        NSLog(@"self****%@\n",self);
        //        NSLog(@"image****%@\n",image);
        //        NSLog(@"urlName****%@\n",urlName);
        //        NSLog(@"imageURL****%@\n",[urlImage absoluteString]);
        
        [self sd_setImageWithURL:urlImage placeholderImage:placeHolderImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image) {
                //                NSLog(@"***************************下载完成***************************");
                //                NSLog(@"self****%@\n",self);
                //                NSLog(@"image****%@\n",image);
                //                NSLog(@"urlName****%@\n",urlName);
                //                NSLog(@"imageURL****%@\n",[imageURL absoluteString]);
                //
                //                image = [UIImageView compressImageWith:image];
                
                //                [[SDImageCache sharedImageCache] storeImage:image forKey:urlName toDisk:YES];
                
            }
            
        }];
        
    }
    
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    self.clipsToBounds = YES;
    
    //    }];
}


-(void)setImageWithURLStrOrg:(NSString *)urlName{

    [self setImageWithURLStrOrg:urlName withPlaceHolder:DEFAULT_IMAGE];


}

-(void)setImageConerWithURLStr:(NSString *)urlName withPlaceHolder:(NSString *)str{

    [self setImageConerWithURLStr:urlName withRadios:self.frame.size.width * 0.5f withPlaceHolder:str];

}

-(void)setImageConerWithURLStr:(NSString *)urlName withRadios:(CGFloat )r withPlaceHolder:(NSString *)str{
    
    [self setImageWithURLStr:urlName withPlaceHolder:str];
    
    [self makeCorner:r];
    
}


-(void)setImageWithURLStr:(NSString *)urlName withPlaceHolder:(NSString *)str{
        
    [self setImageWithURLStrOrg:urlName withPlaceHolder:str];
    
}

-(void)setImageWithURLStr:(NSString *)urlName{
    
    [self setImageWithURLStrOrg:urlName];
    
}

-(void)setImageConerWithURLStr:(NSString *)urlName{
    
    [self setImageWithURLStr:urlName withPlaceHolder:DEFAULT_IMAGE];
   
/*

    [self sd_setImageWithURL:placeholderImage:[UIImage imageNamed:@"icon_default_surface"]];

    
    NSLog(@"%f",self.frame.size.width);*/
    
   // self.layer.cornerRadius = 33.0f;
    
    
    
    self.layer.cornerRadius = self.frame.size.width*0.5f;
    
    self.layer.masksToBounds = YES;


}


+(UIImage *)compressImageWith:(UIImage *)image
{
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 640;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
