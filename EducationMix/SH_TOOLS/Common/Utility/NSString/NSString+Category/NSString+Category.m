
//
//  NSString+Extension.m
//  PengKa
//
//  Created by LPN on 16/4/9.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Extension)

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (NSMutableAttributedString *)attributeStringWithKeyWords:(NSArray *)keyWords colors:(NSArray *)colors repeat:(BOOL)repeat
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSDictionary* attributes = @{NSForegroundColorAttributeName:[Common colorFromHexCode:@"666666"],
                                 NSFontAttributeName:[UIFont systemFontOfSize:12 * kScaleByView]};
    
    [attString addAttributes:attributes range:NSMakeRange(0, self.length)];
    
    
    if (keyWords) {
        
        [keyWords enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSMutableString *tmpString = [NSMutableString stringWithString:self];
            NSRange range = [self rangeOfString:obj];
            NSInteger location = 0;
            while (range.length > 0) {
                UIColor *color = nil;
                if (!colors[idx]) {
                    color = TEXT_COLOR_ORANGE;
                }else{
                    color = colors[idx];
                }
                [attString addAttribute:(NSString*)NSForegroundColorAttributeName value:color range:NSMakeRange(location + range.location, range.length)];
                location += (range.location + range.length);
                NSString *tmp = [tmpString substringWithRange:NSMakeRange(range.location+ range.length, self.length - location)];
                tmpString = [NSMutableString stringWithString:tmp];
                range = [tmp rangeOfString:obj];
                if (!repeat) {
                    break;
                }
            }
            
        }];
    }
    
    return attString;
    
}

@end
