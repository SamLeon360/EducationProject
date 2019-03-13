//
//  YKEditTreeCameraBottomView.m
//  YKMX
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 chenshuo. All rights reserved.
//

#import "YKEditTreeCameraBottomView.h"

@implementation YKEditTreeCameraBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:0.3];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    self.cancleBtn = [[UIButton alloc] init];
    [self.cancleBtn setImage:[[UIImage imageNamed:@"delPhoto_icon"] scaleToSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    [self addSubview:self.cancleBtn];
    
    self.takePhotoBtn = [[UIButton alloc] init];
    [self.takePhotoBtn setImage:[UIImage imageNamed:@"photograph"] forState:UIControlStateNormal];
    [self.takePhotoBtn setImage:[UIImage imageNamed:@"photograph_Select"] forState:UIControlStateHighlighted];
    [self addSubview:self.takePhotoBtn];
    
    self.saveBtn = [[UIButton alloc] init];
    [self.saveBtn makeCorner:15];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor colorWithRGB:0xe56a1f] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.saveBtn];
    
    [self.cancleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(@0);
        make.width.height.equalTo(@40);
    }];
    
    [self.takePhotoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(@0);
        make.width.height.equalTo(@70);
    }];
    
    [self.saveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(@0);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];
}

@end
