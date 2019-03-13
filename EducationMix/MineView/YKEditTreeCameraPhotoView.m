//
//  YKEditTreeCameraPhotoView.m
//  YKMX
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 chenshuo. All rights reserved.
//

#import "YKEditTreeCameraPhotoView.h"

#import "YKEditTreePhotoCollectionViewCell.h"
#import <PYPhotoBrowseView.h>

@interface YKEditTreeCameraPhotoView() <YKEditTreePhotoCollectionViewCellDelegate>


@property (nonatomic) UIButton *leftBtn;

@end

@implementation YKEditTreeCameraPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    self.leftBtn = [[UIButton alloc] init];
    [self.leftBtn setImage:[UIImage imageNamed:@"editTree_camera_packup_icon"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"editTree_camera_unfold_icon"] forState:UIControlStateSelected];
    [self addSubview:self.leftBtn];
    
    [self.leftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(@0);
        make.width.equalTo(self.leftBtn.height).multipliedBy(43.0/170);
    }];
    
    [self addSubview:self.myCollectionView];
    
    [self.myCollectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.right);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(ScreenW - 100*43.0/170);
    }];
    
    @weakify(self);
    [self.leftBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        self.leftBtn.selected = !self.leftBtn.selected;
        [UIView animateWithDuration:0.5 animations:^{
            [self.myCollectionView updateConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                if (!self.leftBtn.selected) {
                    make.width.equalTo(ScreenW - 100*43.0/170);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"hidePhoto" object:@(NO)];
                }else{
                    make.width.equalTo(@0);
                       [[NSNotificationCenter defaultCenter] postNotificationName:@"hidePhoto" object:@(YES)];
                }
            }];
            [self.myCollectionView.superview layoutIfNeeded];
        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YKEditTreePhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YKEditTreePhotoCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.bottomView.hidden = YES;
    [cell.bottomViewAutoHeight setConstant:0];
    cell.imageView.userInteractionEnabled = YES;
    id  imageObject = self.imageArray[indexPath.row];
    if ([imageObject isKindOfClass:[UIImage class]]) {
        cell.imageView.image = self.imageArray[indexPath.row];
    }else{
        if ([imageObject isKindOfClass:[NSString class]]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageObject]];
        }else{
            NSDictionary *dic = self.imageArray[indexPath.row];
            if ([[dic allKeys] containsObject:@"network"]) {
                cell.imageView.image = dic[@"network"];
            }else if ([[dic allKeys] containsObject:@"photo"]) {
                cell.imageView.image = dic[@"photo"];
            }else {
                cell.imageView.image = dic[@"camera"];
            }
        }
    }
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.tag = indexPath.row;
    
    [cell.imageView bk_removeAllBlockObservers];
    @weakify(cell);
    @weakify(self);
    [cell.imageView bk_whenTapped:^{
        @strongify(self);
        @strongify(cell);
        PYPhotoBrowseView *browser = [[PYPhotoBrowseView alloc] init];
        browser.images = self.imageArray;
        browser.currentIndex = [self.imageViewArray indexOfObject:cell.imageView];
        browser.sourceImgageViews = self.imageViewArray;
        [browser show];
    }];
    
    if (indexPath.row >= self.imageViewArray.count) {
        [self.imageViewArray addObject:cell.imageView];
    }else{
        [self.imageViewArray replaceObjectAtIndex:indexPath.row withObject:cell.imageView];
    }

    return cell;
}




#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){80 * ScreenW / ScreenH , 80};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){0,0};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){0,0};
}




#pragma mark ---- UICollectionViewDelegate
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    YKEditTreePhotoCollectionViewCell *cell = (YKEditTreePhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    if (self.imageArray.count < MaxPhotoNum) {
//        if (indexPath.row == 0) {
////            if (self.delegate && [self.delegate respondsToSelector:@selector(addPhotoWithPhotoView:)]) {
////                [self.delegate addPhotoWithPhotoView:self];
////            }
//        }else{
//            PYPhotoBrowseView *browser = [[PYPhotoBrowseView alloc] init];
//            browser.images = self.imageArray;
//            browser.currentIndex = indexPath.row - 1;
//            browser.sourceImgageViews = self.imageViewArray;
//            [browser show];
//        }
//    }else{
//        PYPhotoBrowseView *browser = [[PYPhotoBrowseView alloc] init];
//        browser.images = self.imageArray;
//        browser.currentIndex = indexPath.row;
//        browser.sourceImgageViews = self.imageViewArray;
//        [browser show];
//    }
}


#pragma mark ---- YKEditTreePhotoCollectionViewCellDelegate

-(void)cell:(YKEditTreePhotoCollectionViewCell *)cell didSelectDelBtn:(UIButton *)btn{
    
    
    
    NSIndexPath *indexPath = [self.myCollectionView indexPathForCell:cell];
    
    if (self.imageArray.count == MaxPhotoNum) {
        [self.imageArray removeObjectAtIndex:indexPath.row];
        [self.imageViewArray removeObjectAtIndex:indexPath.row];
        [self.myCollectionView reloadData];
    }else{
        [self.imageArray removeObjectAtIndex:indexPath.row];
        [self.imageViewArray removeObjectAtIndex:indexPath.row];
        [self.myCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deletePhoto)]) {
        [self.delegate deletePhoto];
    }
}

-(void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
    [self.myCollectionView reloadData];
//    [self.myCollectionView ]
    if (imageArray.count>0) {
        [self.myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:imageArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

#pragma mark ---- lazy load
-(UICollectionView *)myCollectionView{
    
    if (!_myCollectionView) {
        //        CGFloat collectionViewHeight = ScreenH - self.tabBarController.tabBar.viewHeight;
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 15, ScreenW, 100) collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView.showsVerticalScrollIndicator = FALSE;
        _myCollectionView.showsHorizontalScrollIndicator = FALSE;
        //        _myCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        [_myCollectionView registerClass:[YKEditTreePhotoCollectionViewCell class] forCellWithReuseIdentifier:@"YKEditTreePhotoCollectionViewCell"];
    }
    
    return _myCollectionView;
}

-(NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}


@end
