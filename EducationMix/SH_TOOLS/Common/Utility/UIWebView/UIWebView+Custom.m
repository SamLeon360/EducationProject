//
//  UIWebView+Custom.m
//  SevenM
//
//  Created by Jadian on 8/27/15.
//  Copyright (c) 2015 IX. All rights reserved.
//

#import "UIWebView+Custom.h"

@implementation UIWebView (HTMLContent)

- (NSString *)htmlContent {
    return [self stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
}

- (NSArray *)ImageSources {
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"<img[^>]*src=\"([^\"]*)\"[^>]*>"
                                                                                       options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *checkingResults = [regularExpression matchesInString:self.htmlContent
                                                          options:NSMatchingReportProgress range:NSMakeRange(0, self.htmlContent.length)];
    
    NSMutableArray *imageSources = [NSMutableArray array];
    for (NSTextCheckingResult *result in checkingResults)
        if (result.numberOfRanges > 1)
            [imageSources addObject:[self.htmlContent substringWithRange:[result rangeAtIndex:1]]];
    
    return imageSources;
}

@end
