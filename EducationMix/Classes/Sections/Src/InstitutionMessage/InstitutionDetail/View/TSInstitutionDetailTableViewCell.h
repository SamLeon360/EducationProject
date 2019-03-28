//
//  TSInstitutionDetailTableViewCell.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSInstitutionDetailModel.h"
#import "TSTSInstitutionDetailAdvanceSubjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSInstitutionDetailTableViewCell : UITableViewCell

@property (nonatomic, strong)TSInstitutionDetailModel *model;
@property (nonatomic, strong)TSTSInstitutionDetailAdvanceSubjectModel *asModel;




@end

NS_ASSUME_NONNULL_END
