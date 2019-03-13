//
//  CompanyListCell.h
//  TXProject
//
//  Created by Sam on 2019/2/19.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyTypeCell;
@property (weak, nonatomic) IBOutlet UILabel *companyAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectDefualtBtn;

@end

NS_ASSUME_NONNULL_END
