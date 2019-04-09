//
//  TSAdvisoryHeaderView.m
//  EducationMix
//
//  Created by Taosky on 2019/4/7.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAdvisoryHeaderView.h"
#import "TSAdvisoryHeaderViewCollectionViewCell.h"

static NSString *const TSAdvisoryHeaderViewCollectionViewCellID = @"TSAdvisoryHeaderViewCollectionViewCell";

@interface TSAdvisoryHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)IBOutlet UICollectionView *collectionView;



@end

@implementation TSAdvisoryHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    if(_collectionView){
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemW = (ScreenW - 50) / 2;
        CGFloat itemH = ((ScreenW / 2) - 3 * 16) / 2;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 16;
        layout.minimumInteritemSpacing = 16;//cell左右最小间隔
        
        //self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.collectionViewLayout = layout;
//        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.backgroundColor = TSColor_RGB(26, 26, 26);
        //    [_collectionView registerClass:[TSMainViewCollectionViewCell class] forCellWithReuseIdentifier:@"TSMainViewCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TSAdvisoryHeaderViewCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:TSAdvisoryHeaderViewCollectionViewCellID];
    }
}


// MARK: - Lazy


- (NSArray *)dataSource {
    
    if(!_dataSource){
        _dataSource = @[@"",@"",@"",@""];
    }
    return  _dataSource;
}


// MARK: - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSAdvisoryHeaderViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TSAdvisoryHeaderViewCollectionViewCellID forIndexPath:indexPath];
//    cell.backgroundColor =self.cellBgColorArr[indexPath.row];
//    cell.model = self.dataSource[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    // FIXME: ZYT 处理跳转
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
