//
//  InstitutionTableViewCell.m
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import "InstitutionTableViewCell.h"

#import "NSString+TSAcademyType.h"
#import "UIImage+YPExtension.h"

@interface InstitutionTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *institutionTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *institutionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *institutionUrlLabel;
@property (strong, nonatomic) IBOutlet UILabel *tellLabel;


@property (strong, nonatomic) IBOutlet UIImageView *institutionImageView;

@property (nonatomic, strong) UIImage *placeholderImage;


@end

@implementation InstitutionTableViewCell

- (UIImage *)placeholderImage
{
    if (!_placeholderImage) {
        /**
         *   960    x   300
         *   width  x    ?
         */
        CGFloat width = ScreenW - 2 * 8;
        CGFloat height = width * 300 / 960;
        UIImage *placeholder = [UIImage yp_generateCenterImageWithBgColor:TSColor_RGB(235, 235, 235) bgImageSize:CGSizeMake(width, height) centerImage:[UIImage imageNamed:@"school.png"]];
        _placeholderImage = placeholder;
    }
    return _placeholderImage;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(InstitutionModel *)model {
    
    _institutionNameLabel.text = model.academy_name;
    _addressLabel.text = model.address;
    
    NSString *tmpPhone = @"";
    if(([model.phone rangeOfString:@"/"].location !=NSNotFound))
    {
        tmpPhone = [[model.phone componentsSeparatedByString:@"/"] objectAtIndex:0];
        _tellLabel.text = tmpPhone;

    } else {
        
        _tellLabel.text = model.phone;

    }
    
    _institutionUrlLabel.text = model.website;
    
    _institutionTypeLabel.text = [NSString getacademyTypeWithTypeId:model.academy_type];
    
//    [_institutionImageView setImageWithURL:[NSURL URLWithString:model.academy_logo] placeholder:self.placeholderImage options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,model.academy_logo];
    
    [_institutionImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:self.placeholderImage options:SDWebImageLowPriority];
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
