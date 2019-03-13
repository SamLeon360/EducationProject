//
//  YKEditTreeCameraPhotoView.h
//  YKMX
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 chenshuo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKEditTreeCameraPhotoViewDelegate <NSObject>

-(void)deletePhoto;

@end

@interface YKEditTreeCameraPhotoView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *myCollectionView;
@property (nonatomic) NSMutableArray *imageArray;
@property (nonatomic) NSMutableArray *imageViewArray;

@property (nonatomic,weak) id<YKEditTreeCameraPhotoViewDelegate> delegate;

@end
