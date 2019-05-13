//
//  TSNetManager.h
//  Mianbao
//
//  Created by Taosky on 2019/2/24.
//  Copyright © 2019 Taosky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSNetManager : AFHTTPSessionManager
/**
 *  单例
 */
+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
