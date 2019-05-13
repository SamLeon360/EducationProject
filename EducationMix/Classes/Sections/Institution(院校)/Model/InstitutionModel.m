//
//  InstitutionModel.m
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import "InstitutionModel.h"

@implementation InstitutionModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if (oldValue == [NSNull null]) {
        if ([oldValue isKindOfClass:[NSArray class]]) {
            return  @[];
        }else if([oldValue isKindOfClass:[NSDictionary class]]){
            return @{};
        }else{
            return @"";
        }
    }
    return oldValue;
}
@end
