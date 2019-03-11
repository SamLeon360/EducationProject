//
//  CustomFountion.m
//  PengKa
//
//  Created by chenshuo on 16/5/19.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "CustomFountion.h"
#import "Reachability.h"


@implementation CustomFountion

+(void)showStrHUD:(NSString *)tmpStr{
    
    [self setHudType];
    
//    [SVProgressHUD setInfoImage:nil];
    
    [SVProgressHUD showInfoWithStatus:tmpStr];
    
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:1.5f];
    
}

+(void)showErrorHUD:(NSString *)tmpStr{
    [CustomFountion showErrorHUD:tmpStr delay:1.5f];
}

+(void)showErrorHUD:(NSString *)tmpStr delay:(CGFloat)delay{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self setHudType];
        [SVProgressHUD showErrorWithStatus:tmpStr];
    });
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:delay];
    
}
+(void)showBadHudByDismiss:(NSString *)string  hideTime: (CGFloat )time{
    [CustomFountion showErrorHUD:string];
    [CustomFountion hideHudByTime:time];
}
+(void)hideHudByTime : (CGFloat )time{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
+(void)showSuccessHUD:(NSString *)tmpStr{
    
    [CustomFountion showSuccessHUD:tmpStr delay:1.5f];
}


+(void)showSuccessHUD:(NSString *)tmpStr delay:(CGFloat)delay{
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self setHudType];
        [SVProgressHUD showSuccessWithStatus:tmpStr];
    });
    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:delay];
    
}

+(void)dismissHUD{
    
    double nowTimestamp = [[NSDate date] timeIntervalSince1970];
    double timeDifference = nowTimestamp - [USER_SINGLE.lastTimeShowHUD doubleValue];
    
    if (timeDifference >= 1.2) {
        [SVProgressHUD dismiss];
    }else{
        [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:1.2 - timeDifference];
    }
    
}

+(void)showWaitHUD:(NSString *)tmpStr{
    
    [self setHudDefaultType];
    
    [SVProgressHUD showWithStatus:tmpStr];
    
//    [self performSelector:@selector(dismissHUD) withObject:nil afterDelay:1];
    
    
}

+ (void)setHudType{
    
    USER_SINGLE.lastTimeShowHUD = [NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]];
    [CustomFountion setHudDefaultType];
}

+ (void)setHudDefaultType{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.6]];
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD dismiss];
    
}
//要计算的字符串，第二个参数
//lalbel的字体大小
//第三个参数label允许的最大尺寸。
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    //    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading | NSString DrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    CGSize labelSize = [text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

+ (NSMutableAttributedString *)lineHeightWithAttributedString:(NSString *)str withHeight:(double)height{
    if (!str) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = height;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
//    [paragraphStyle setLineSpacing:height];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [str length])];
    [attributedString addAttribute:NSKernAttributeName value:@0.0 range:NSMakeRange(0, [str length])];
    return attributedString;
}

//计算UILabel的高度(带有行间距的情况)
+(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withHeight:(CGFloat)height MaxSize:(CGSize)maxSize {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = height;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


//浮点数处理并去掉多余的0
+(NSString *)stringDisposeWithFloat:(double)floatValue
{
    NSString *str = [NSString stringWithFormat:@"%f",floatValue];
    long len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        //s.substring(0, len - i - 1);
        return [str substringToIndex:[str length]-1];
    }
    else
    {
        return str;
    }
};

+ (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark - 获取网络状态

+(BOOL)isNetWork{
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    BOOL net = NO;
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = YES;
            break;
            
        case ReachableViaWWAN:
            net = YES;
            break;
            
        case NotReachable:
            net = NO;
            
        default:
            break;
    }
    
    return net;
}

#pragma mark - 压缩图片到指定大小
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    if (!image) {
        return image;
    }
    if (kb<1) {
        return image;
    }
    
    kb*=1024;
    
    
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
    
}
//------只压不缩--按NSData大小压缩，返回NSData
+(NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage
                              FileSize:(NSInteger)FileSize
{
//    UIImage *image = [UIImage imageWithData:UIImagePNGRepresentation(OldImage)];
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    //每次减少的比例
    float scale = 0.1;
    
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression)&&
           ((imageData.length/1024)>FileSize))
    {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
        
        //        NSLog(@"%f,%lu",compression,(unsigned long)imageData.length);
    }
    NSLog(@"只压不缩-返回Data大小：%lu kb",imageData.length/1024);
    return imageData;
}

+ (BOOL)isChinaMobile:(NSString *)phoneNum
{
    NSString *MOBILE = @"^1(3|4|5|7|8)[0-9]\\d{8}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestcm evaluateWithObject:phoneNum];
}

//字典转json格式字符串：
+ (NSString*)objectToJsonStr:(id)object
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
    
}
@end
