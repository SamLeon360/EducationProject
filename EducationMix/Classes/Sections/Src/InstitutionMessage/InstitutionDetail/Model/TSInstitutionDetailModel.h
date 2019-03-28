//
//  TSInstitutionDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInstitutionDetailModel : NSObject

@property (nonatomic, strong)NSString *academy_logo;
@property (nonatomic, strong)NSString *academy_name;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *establishment_date;
@property (nonatomic, strong)NSString *college_introduction;

@property (nonatomic, strong)NSString *content;

@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *website;
@property (nonatomic, strong)NSString *cooperation;
@property (nonatomic, strong)NSString *affiliated_area;
@property (nonatomic, strong)NSString *award;

@property (nonatomic, strong)NSString *introduction_teachers;
@property (nonatomic, strong)NSString *teaching_facilities;
@property (nonatomic, strong)NSString *leading_professional_introduction;
@property (nonatomic, strong)NSString *excellent_graduates;
@property (nonatomic, strong)NSString *graphic_attachments;

@property (nonatomic, strong)NSString *advance_subject;


@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, assign)NSInteger member_id;
@property (nonatomic, assign)NSInteger academy_type;

@end

NS_ASSUME_NONNULL_END
