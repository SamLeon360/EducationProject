//
//  NSString+TSAcademyType.m
//  EducationMix
//
//  Created by Taosky on 2019/3/25.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "NSString+TSAcademyType.h"

@implementation NSString (TSAcademyType)

+ (NSString *)getacademyTypeWithTypeId:(NSInteger)typeId {
    
    NSString *typeName = @"";
    
    
    switch (typeId) {
        case 1:
            typeName = @"大专院校";
            break;
        case 2:
            typeName = @"高职院校";
            break;
        case 3:
            typeName = @"中职院校";
            break;
        case 4:
            typeName = @"科研院校";
            break;
        case 5:
            typeName = @"本科院校";
            break;

        default:
            typeName = @"未知学院类型";
            break;
    }
    
    return typeName;
    
}

@end
