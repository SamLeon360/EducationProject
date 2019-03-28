//
//  TSInstitutionDetailTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailTableViewCell.h"
#import "NSString+TSAcademyType.h"


@interface TSInstitutionDetailTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel  *institutionType;
@property (strong, nonatomic) IBOutlet UILabel  *institutionAddress;

@property (strong, nonatomic) IBOutlet UILabel *college_introduction;

@property (strong, nonatomic) IBOutlet UILabel *subject_name;
@property (strong, nonatomic) IBOutlet UILabel *main_service_area;
@property (strong, nonatomic) IBOutlet UIImageView *subImageView;

@property (strong, nonatomic) IBOutlet UIView *line;

@end


@implementation TSInstitutionDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _line.backgroundColor = TSColor_RGB(244, 244, 244);
    // Initialization code
}

- (void)setModel:(TSInstitutionDetailModel *)model {
    
    self.institutionType.text = [NSString getacademyTypeWithTypeId:model.academy_type];
    self.institutionAddress.text = model.address;
    
    self.college_introduction.text = [model.content stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
}

- (void)setAsModel:(TSTSInstitutionDetailAdvanceSubjectModel *)asModel {
    
    self.subject_name.text = asModel.subject_name;
    self.main_service_area.text = asModel.main_service_area;
    
}

- (void)setFrame:(CGRect)frame{
    //frame.origin.x += 10;
    //frame.origin.y += 8;
    frame.size.height -= 8;
    //frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
