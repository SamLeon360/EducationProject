//
//  MemberOtherMessageCell.h
//  TXProject
//
//  Created by Sam on 2019/2/25.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberOtherMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commerceJobLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;

@end

NS_ASSUME_NONNULL_END
