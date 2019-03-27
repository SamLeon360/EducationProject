//
//  TSNetManager.m
//  Mianbao
//
//  Created by Taosky on 2019/2/24.
//  Copyright © 2019 Taosky. All rights reserved.
//

#import "TSNetManager.h"

@implementation TSNetManager


- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];


    return self;
}

#pragma mark - Public
+ (instancetype)shareManager
{
    static TSNetManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


@end
