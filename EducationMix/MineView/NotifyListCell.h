//
//  NotifyListCell.h
//  TXProject
//
//  Created by Sam on 2019/2/26.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotifyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *notifyImage;
@property (weak, nonatomic) IBOutlet UILabel *cellName;

@end

NS_ASSUME_NONNULL_END
