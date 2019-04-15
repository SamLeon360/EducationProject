//
//  TSEnterpriseLibraryModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/15.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSEnterpriseLibraryModel.h"

@implementation TSEnterpriseLibraryModel

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
