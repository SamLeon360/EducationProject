//
//  CatchCrash.h
//  YKMX
//
//  Created by apple on 2018/1/27.
//  Copyright © 2018年 chenshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchCrash : NSObject
void uncaughtExceptionHandler(NSException *exception);
@end
