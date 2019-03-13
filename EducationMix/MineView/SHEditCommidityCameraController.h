//
//  SHEditCommidityCameraController.h
//  YKMX
//
//  Created by apple on 2018/7/30.
//  Copyright © 2018年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SHEditCommidityCameraDelegate <NSObject>

-(void)savePhotoWithArray:(NSArray *)array;

@end

@interface SHEditCommidityCameraController : UIViewController
@property (nonatomic) NSArray *imageArray;
@property (nonatomic, weak) id<SHEditCommidityCameraDelegate>delegate;
@property (nonatomic) NSMutableArray *imageKeyArr;
@property (nonatomic) NSString *wayIn;


- (instancetype)initWithArray:(NSArray *)array maxPhotoNum:(NSInteger)maxPhotoNum;
@end
