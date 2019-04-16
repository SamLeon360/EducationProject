//
//  HomePageModelCell.h
//  TXProject
//
//  Created by Sam on 2018/12/26.
//  Copyright © 2018年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageModelCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;

@end

NS_ASSUME_NONNULL_END
