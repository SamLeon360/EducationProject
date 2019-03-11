//
//  CatchCrash.m
//  YKMX
//
//  Created by apple on 2018/1/27.
//  Copyright © 2018年 chenshuo. All rights reserved.
//

#import "CatchCrash.h"

@implementation CatchCrash

void uncaughtExceptionHandler(NSException *exception)

{
    
    // 异常的堆栈信息
    
//    NSArray *stackArray = [exception callStackSymbols];
//    
//    // 出现异常的原因
//    
//    NSString *reason = [exception reason];
//    
//    // 异常名称
//    
//    NSString *name = [exception name];
//    
//    NSString *exceptionInfo = [NSString stringWithFormat:@"异常名称：%@\n  闪退原因：%@\n 闪退用户：%@\n 闪退用户ST：%@",name, reason, USER_SINGLE.objectId,USER_SINGLE.sessiontoken];
//    
//    NSLog(@"%@", exceptionInfo);
//    
//    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
//    
//    [tmpArr insertObject:reason atIndex:0];
//    
//    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
//    
//    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()] forKey:@"logPath"];
 
    
}

@end  
