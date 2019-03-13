//
//  HomeJobCell.h
//  EducationMix
//
//  Created by Sam on 2019/3/12.
//  Copyright © 2019 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeJobCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellMoney;
@property (weak, nonatomic) IBOutlet UILabel *cellCompany;
@property (weak, nonatomic) IBOutlet UILabel *cellJob;
@property (weak, nonatomic) IBOutlet UIView *cellTag;
@property (weak, nonatomic) IBOutlet UIView *cellTypeTag;
@property (weak, nonatomic) IBOutlet UILabel *cellAddress;
@end

NS_ASSUME_NONNULL_END
