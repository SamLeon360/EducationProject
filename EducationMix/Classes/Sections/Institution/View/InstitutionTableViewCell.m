//
//  InstitutionTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import "InstitutionTableViewCell.h"

@interface InstitutionTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *institutionTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *institutionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *institutionUrlLabel;
@property (strong, nonatomic) IBOutlet UILabel *tellLabel;


@property (strong, nonatomic) IBOutlet UIImageView *institutionImageView;



@end

@implementation InstitutionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
