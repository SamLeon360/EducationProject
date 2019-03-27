//
//  TSProgressHUD.h
//  Mianbao
//
//  Created by Taosky on 2019/2/24.
//  Copyright © 2019 Taosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSProgressHUD : NSObject

+ (void)show;

+ (void)showWithMessage:(NSString *)message;

+ (void)dismiss;

+ (void)showError:(NSString *)errorInfo;

+ (void)showSuccess:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
