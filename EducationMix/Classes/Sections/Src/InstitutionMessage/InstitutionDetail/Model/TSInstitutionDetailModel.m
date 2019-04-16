//
//  TSInstitutionDetailModel.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailModel.h"

@implementation TSInstitutionDetailModel

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

- (NSMutableArray *)imageArr {
    
    if(!_imageArr) {
        
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}


@end
