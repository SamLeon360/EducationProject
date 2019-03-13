//
//  FriendNotifyCell.h
//  TXProject
//
//  Created by Sam on 2019/2/26.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendNotifyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarIamge;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *apccetBtn;

@end

NS_ASSUME_NONNULL_END
