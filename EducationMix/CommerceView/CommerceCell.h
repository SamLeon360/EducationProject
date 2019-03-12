//
//  CommerceCell.h
//  TXProject
//
//  Created by Sam on 2018/12/26.
//  Copyright © 2018年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommerceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commerceName;
@property (weak, nonatomic) IBOutlet UILabel *userType;

@end

NS_ASSUME_NONNULL_END
