//
//  TSInstitutionDetailTableViewCellSecond.m
//  EducationMix
//
//  Created by Taosky on 2019/4/11.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailTableViewCellSecond.h"
#import "NSString+TSAcademyType.h"

@interface TSInstitutionDetailTableViewCellSecond ()

@property (strong, nonatomic) IBOutlet UILabel  *institutionType;
@property (strong, nonatomic) IBOutlet UILabel  *institutionAddress;

@property (strong, nonatomic) IBOutlet UILabel *college_introduction;

@property (strong, nonatomic) IBOutlet UILabel *subject_name;
@property (strong, nonatomic) IBOutlet UILabel *main_service_area;
@property (strong, nonatomic) IBOutlet UIImageView *subImageView;

@property (strong, nonatomic) IBOutlet UIView *line;


@end

@implementation TSInstitutionDetailTableViewCellSecond

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TSInstitutionDetailModel *)model {
    
    self.institutionType.text = [NSString getacademyTypeWithTypeId:model.academy_type];
    self.institutionAddress.text = model.address;
    
//    self.college_introduction.text = [model.content stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.college_introduction.text = model.content;
    
}

- (void)setFrame:(CGRect)frame{
    //frame.origin.x += 10;
    frame.origin.y += 8;
    frame.size.height -= 8;
    //frame.size.width -= 20;
    [super setFrame:frame];
}
@end
