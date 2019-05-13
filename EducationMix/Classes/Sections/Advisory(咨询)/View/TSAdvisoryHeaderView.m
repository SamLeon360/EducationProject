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

@interface TSAdvisoryHeaderView ()<UICollectionViewDataSource>

@property (nonatomic, strong)IBOutlet UICollectionView *collectionView;

//装collectionCell内容 （静态）
@property (nonatomic, strong)NSArray *dataSource;
//装collectionCell背景颜色 （静态）
@property(nonatomic, strong)NSMutableArray *colorArr;


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
        

        _dataSource = @[ @{@"image":@"法规.jpg",@"name":@"政策法规",@"englishName":@"Policy"},
                        @{@"image":@"文库.jpg",@"name":@"文库",@"englishName":@"Library"},
                        @{@"image":@"公告.jpg",@"name":@"通知公告",@"englishName":@"Notice"},
                        @{@"image":@"新闻.jpg",@"name":@"平台新闻",@"englishName":@"News"}];
    }
    return  _dataSource;
}

- (NSMutableArray *)colorArr {
    
    if(!_colorArr){
        
        _colorArr = [[NSMutableArray alloc] init];
        
        [_colorArr addObject: TSColor_RGB(154, 202, 64)];
        [_colorArr addObject: TSColor_RGB(253, 152, 39)];
        [_colorArr addObject: TSColor_RGB(253, 203, 46)];
        [_colorArr addObject: TSColor_RGB(106, 204, 203)];

    }
    return _colorArr;
}

// MARK: - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSAdvisoryHeaderViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TSAdvisoryHeaderViewCollectionViewCellID forIndexPath:indexPath];
    
    TSAdvisoryHeaderViewCollectionViewCellModel *model = [TSAdvisoryHeaderViewCollectionViewCellModel mj_objectWithKeyValues:self.dataSource[indexPath.row]];
    
    cell.backgroundColor = self.colorArr[indexPath.row];
//    cell.backgroundColor =self.cellBgColorArr[indexPath.row];
    cell.model = model;
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
