//
//  EntreListCell.h
//  TXProject
//
//  Created by Sam on 2019/1/22.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EntreListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *titleCell;
@property (weak, nonatomic) IBOutlet UILabel *oneTag;
@property (weak, nonatomic) IBOutlet UILabel *twoTag;
@property (weak, nonatomic) IBOutlet UILabel *priceCell;
@property (weak, nonatomic) IBOutlet UILabel *addressCell;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end

NS_ASSUME_NONNULL_END
