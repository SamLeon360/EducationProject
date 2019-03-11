//
//  NSString+Utils.m
//  PengKa
//
//  Created by GZK on 16/6/20.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

#pragma mark - Return NSUInteger, NSInteger, etc.

- (NSUInteger)getCharsCount {
	int charsCount = 0;
	char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
	for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
		if (*p) {
			p++;
			charsCount++;
		}
		else {
			p++;
		}
	}
	return charsCount;
}


#pragma mark - Return BOOL

- (BOOL)charsCountGreater:(NSUInteger)min less:(NSUInteger)max {
	NSUInteger charsCount = [self getCharsCount];

	return (charsCount >= min && charsCount <= max);
}

- (BOOL)notEmptyString {
	return (![self isEqualToString:@""]);
}

- (BOOL)validateEmailFormatter
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+(\\.[a-z0-9-]+)*\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


- (BOOL)validatePhoneFormatter {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                              @"^[0-9\\-\\+\\*\\#]+$"];
    return [predicate evaluateWithObject:self];
}

- (BOOL)validateNumberFormatter {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",
                              @"^[0-9]+$"];
    return [predicate evaluateWithObject:self];
}

- (BOOL)validatePasswordFormater {
    NSString *regex = @"^[\\@A-Za-z0-9\\~\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\_\\+\\|\\{\\}\\:\\\"\\<\\>\\?\\`\\-\\=\\[\\]\\;\\'\\,\\.\\/\\\\]{6,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containsChineseCharacter{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[\u4e00-\u9fa5]"];
    return [predicate evaluateWithObject:self];
}

#pragma mark - Return NSString

- (NSString *)stringByTrimminWhitespace {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)retainedTwoDecimal{
    return [NSString stringWithFormat:@"%.2f", self.floatValue];
}

- (NSString *)stringByFilteredSpecialCharacter{
    if ([self isEqualToString:@""])
        return self;
    
	NSString *string;
    NSRegularExpression *regular =
    [[NSRegularExpression alloc] initWithPattern:@"<([^>]*)>"
                                         options:NSRegularExpressionCaseInsensitive
                                           error:NULL];
    
    string = [regular stringByReplacingMatchesInString:self
                                             options:0
                                               range:NSMakeRange(0, self.length)
                                        withTemplate:@" "];
    
	string = [string stringByReplacingOccurrencesOfString:@"$0#" withString:@"`"];
	string = [string stringByReplacingOccurrencesOfString:@"$1#" withString:@"'"];
	string = [string stringByReplacingOccurrencesOfString:@"$2#" withString:@"\""];
	string = [string stringByReplacingOccurrencesOfString:@"$3#" withString:@";"];

	string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];

	string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];

    return string;
}

- (NSString *)phoneDispaly {
    if (self.length > 10){
       return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }
    else
       return self;
}

- (NSString *)base64EncodedString {
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}

- (NSString *)base64DecodedString {
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *str = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return str;
}

#pragma mark - Return NSDictionary

- (NSDictionary *)getUrlParmsDict {
    NSArray *parmsArray  = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    for (NSString *parm in parmsArray) {
        
        NSInteger locationOfFirstEqualSignal = [parm rangeOfString:@"="].location;
        NSString *originalString = [parm substringFromIndex:locationOfFirstEqualSignal + 1].stringByFilteredSpecialCharacter;
        
        NSString *tranferString = (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef)originalString, CFSTR(""), kCFStringEncodingUTF8);

        [temp setObject:tranferString ?: originalString
                 forKey:[parm substringToIndex:locationOfFirstEqualSignal]];
    }
    
    return temp;
}

@end


@implementation NSString (Encode)

- (NSString *)gb2312String {
    CFStringEncodings encodeType = kCFStringEncodingGB_18030_2000;
    CFStringRef strRef = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 CFSTR(""),
                                                                                 encodeType);
    
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                     kCFAllocatorDefault,
                                                                     (CFStringRef)strRef,
                                                                     NULL,
                                                                     nonAlphaNumValidChars,
                                                                     encodeType));
}

-(NSString *)urlEncodeString {
    NSMutableString *urlEncodeStr = [NSMutableString string];
    
    const char *source = [self UTF8String];
    for (int i = 0; i < strlen(source); ++i) {
        const unsigned char tmpChar = source[i];
        
        if (tmpChar == ' ') {
            [urlEncodeStr appendString:@"+"];
        }
        else if (tmpChar == '.' || tmpChar == '-' || tmpChar == '_' || tmpChar == '~' ||
                 (tmpChar >= 'a' && tmpChar <= 'z') ||
                 (tmpChar >= 'A' && tmpChar <= 'Z') ||
                 (tmpChar >= '0' && tmpChar <= '9')) {
            [urlEncodeStr appendFormat:@"%c", tmpChar];
        }
        else {
            [urlEncodeStr appendFormat:@"%%%02X", tmpChar];
        }
    }
    
    return urlEncodeStr;
}

@end
