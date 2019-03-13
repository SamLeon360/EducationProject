//
//  MemberListCell.h
//  TXProject
//
//  Created by Sam on 2019/1/14.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *memberCompany;
@property (weak, nonatomic) IBOutlet UILabel *memberType;
@property (weak, nonatomic) IBOutlet UILabel *commerceType;

@end

NS_ASSUME_NONNULL_END
