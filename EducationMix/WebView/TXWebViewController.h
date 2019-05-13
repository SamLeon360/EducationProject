//
//  TXWebViewController.h
//  TXProject
//
//  Created by Sam on 2018/12/26.
//  Copyright © 2018年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXWebViewController : UIViewController
@property (nonatomic) NSString *webUrl;
@property (nonatomic) NSString *localHTML;
@property (nonatomic) NSDictionary *dataDic;
@property (nonatomic) INTYPE intype;
@property (nonatomic) NSString *wayIn;

@end

NS_ASSUME_NONNULL_END
