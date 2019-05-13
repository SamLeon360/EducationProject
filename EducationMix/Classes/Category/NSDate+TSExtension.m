//
//  NSDate+TSExtension.m
//  EducationMix
//
//  Created by Taosky on 2019/3/29.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "NSDate+TSExtension.h"

@implementation NSDate (TSExtension)


+ (NSInteger)getDateTimeIntervalWithStartDate:(id)startDate {
    
//    NSDate *tmpStartDate = [[NSDate alloc]init];
    
    if([startDate isKindOfClass:[NSString class]] && startDate) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        startDate = [dateFormatter dateFromString:startDate];
    }
    
    NSDate *  nowDate    = [ [ NSDate alloc] init ];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
    
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:startDate  toDate:nowDate  options:0];
    
    NSInteger diffYear = [cps year];
    
    //    NSInteger diffMon = [cps month];
    //
    //    NSInteger diffDay = [cps day];
    //
    //    NSInteger diffHour = [cps hour];
    //
    //    NSInteger diffMin = [cps minute];
    //
    //    NSInteger diffSec = [cps second];
    
    return diffYear;
}


@end
