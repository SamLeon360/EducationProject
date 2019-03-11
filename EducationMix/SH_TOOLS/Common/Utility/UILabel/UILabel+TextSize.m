//
//  UILabel+CGSize.m
//  SevenMBasket
//
//  Created by Jadian on 14-4-29.
//  Copyright (c) 2014年 IEXIN. All rights reserved.
//

#import "UILabel+TextSize.h"

@implementation UILabel (CGSize)

- (CGSize)textSizeByMaxWidth:(CGFloat)maxWidth {
    return [self textSizeByLimitSize:CGSizeMake(maxWidth, self.font.lineHeight)];
}


- (CGSize)textSizeByLimitSize:(CGSize)limitSize {
    NSStringDrawingOptions drawingOptions = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine;
    
    CGSize size;
    
	if (self.attributedText != nil) {
        size = [self.attributedText boundingRectWithSize:limitSize
		                                         options:drawingOptions
		                                         context:nil].size;
        
    } else {
       size = [self.text boundingRectWithSize:limitSize options:drawingOptions attributes:nil context:nil].size;
    }

    return CGSizeMake(ceil(size.width), ceil(size.height));
}

@end
