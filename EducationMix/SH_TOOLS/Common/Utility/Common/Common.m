//
//  ColorFromHexCode.m
//  百城求职宝
//
//  Created by sunshine on 15/7/10.
//  Copyright (c) 2015年 chenshuo. All rights reserved.
//

#import "Common.h"
#import <ShareSDK/ShareSDK.h>
#import "UIImage+UIImageScale.h"
@implementation Common

+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (NSString *)EncodeGB2312Str:(NSString *)encodeStr{
    
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""), kCFStringEncodingGB_18030_2000));
    NSString *newStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingGB_18030_2000));
    return newStr;
}
//颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(void)shareDataToWeChat : (NSDictionary *)dic{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:dic[@"text"]
                                     images:@[dic[@"imageData"]]
                                        url:[NSURL URLWithString:dic[@"url"]]
                                      title:dic[@"title"]
                                       type:SSDKContentTypeAuto];
    [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        NSLog(@"%lu---%@---%@--%@",(unsigned long)state,userData,contentEntity,error);
    }];
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

+(UIImage *)cutImage:(UIImage *)image{
    if (ScreenW > 320)
    {
        if (image.size.width < image.size.height)
            return  [image getSubImage:CGRectMake(0, fabs(image.size.height - image.size.width), image.size.width * 3,  image.size.width * 3)];
        else
            return [image getSubImage:CGRectMake(0, fabs(image.size.width - image.size.height), image.size.height * 3,  image.size.height * 3)];
    }
    else
    {
        if (image.size.width < image.size.height)
            return  [image getSubImage:CGRectMake(0, fabs(image.size.height - image.size.width), image.size.width * 2,  image.size.width * 2)];
        else
            return [image getSubImage:CGRectMake(0, fabs(image.size.width - image.size.height), image.size.height * 2,  image.size.height * 2)];
    }
    
}


// 比例放大
+ (void)scalingWithView:(UIView *)view{
    for(UIView *subView in view.subviews){
        CGRect rect = subView.frame;
        rect.size.width *= kScaleByView;
        rect.size.height *=kScaleByView;
        rect.origin.x *= kScaleByView;
        rect.origin.y *= kScaleByView;
        subView.frame = rect;
        if(subView.subviews.count > 0){
            [self scalingWithView:subView];
        }
    }
}

// 字体放大
+ (void)scaleFontWithView:(UIView *)view{
    for(UIView *subView in view.subviews){
        if([subView isKindOfClass:[UILabel class]]){
            UILabel *lable = (UILabel *)subView;
            lable.font = [UIFont systemFontOfSize:lable.font.pointSize * kScaleByView];
        }
        if(subView.subviews.count > 0){
            [self scaleFontWithView:subView];
        }
    }
}


+ (NSString *)arrayToJSONString:(NSArray *)array

{
    
    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return jsonString;
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
+ (UIViewController *)viewController :(UIView *)currentview

{
    
    for (UIView* next = [currentview superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
#pragma mark - 去地图展示路线
/** 去地图展示路线 */
+ (void)gotoMap : (CGFloat)lng andlat:(CGFloat)lat andAdd:(NSString *)add andVC:(UIViewController *)vc{
    // 后台返回的目的地坐标是百度地图的
    // 百度地图与高德地图、苹果地图采用的坐标系不一样，故高德和苹果只能用地名不能用后台返回的坐标
    CGFloat latitude  = lat;  // 纬度
    CGFloat longitude = lng; // 经度
    NSString *address = add; // 送达地址
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"" message:@"导航到此定位" preferredStyle:UIAlertControllerStyleActionSheet];
    //确定按钮的风格是默认的
    UIAlertAction *baiduMap = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
            // 百度地图
            // 起点为“我的位置”，终点为后台返回的坐标
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=riding", latitude, longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
        }else{
            // 快递员没有安装上面三种地图APP，弹窗提示安装地图APP
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请安装地图APP" message:@"建议安装百度地图APP" preferredStyle:UIAlertControllerStyleAlert];
             [vc presentViewController:alertVC animated:NO completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            });
           
        }
    }];
    UIAlertAction *gaodeMap = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
            // 高德地图
            // 起点为“我的位置”，终点为后台返回的address
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=%@&did=BGVIS2&dname=%@&dev=0&t=0",@"我的位置",address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else{
            // 快递员没有安装上面三种地图APP，弹窗提示安装地图APP
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请安装地图APP" message:@"建议安装高德地图APP" preferredStyle:UIAlertControllerStyleAlert];
            [vc presentViewController:alertVC animated:NO completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
    UIAlertAction *appleMap = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com"]]){
            // 苹果地图
            // 起点为“我的位置”，终点为后台返回的address
            NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@",address] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }else{
            // 快递员没有安装上面三种地图APP，弹窗提示安装地图APP
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请安装地图APP" message:@"建议安装苹果地图APP" preferredStyle:UIAlertControllerStyleAlert];
            [vc presentViewController:alertVC animated:NO completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alertVC dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }];
    //取消按钮的风格是取消， 并且一直在最下边，且只能有一个
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alter dismissViewControllerAnimated:YES completion:nil];
    }];

    [alter addAction:baiduMap];
    [alter addAction:gaodeMap];
    [alter addAction:appleMap];
    [alter addAction:cancle];
    
    
    [vc presentViewController:alter animated:YES completion:^{
        
    }];
    
 
 
    
  
    
    
}

@end
