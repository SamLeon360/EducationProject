//
//  SHEditCommidityPhotoView.m
//  YKMX
//
//  Created by apple on 2018/8/1.
//  Copyright © 2018年 chenshuo. All rights reserved.
//

#import "SHEditCommidityPhotoView.h"



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@implementation SHEditCommidityPhotoView
-(instancetype)initWithFrame:(CGRect)frame{
    
    return [super initWithFrame:frame];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){80, 80};
}

@end
