
//  YKEditTreePhotoCollectionViewCell.h
//  YKMX
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TKDragView.h"
@class YKEditTreePhotoCollectionViewCell;
@protocol YKEditTreePhotoCollectionViewCellDelegate <NSObject>

-(void)cell:(YKEditTreePhotoCollectionViewCell *)cell didSelectDelBtn:(UIButton *)btn;

@end

@interface YKEditTreePhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewAutoHeight;
@property (nonatomic, weak) id<YKEditTreePhotoCollectionViewCellDelegate> delegate;

@end
