//
//  TSAnnouncementDetailViewModel.m
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAnnouncementDetailViewModel.h"

@implementation TSAnnouncementDetailViewModel

- (instancetype)initWithModel:(TSAnnouncementModel *)model {
    
    if(!self) self = [super init];
    
    self.model = model;
    return self;
    
}

@end
