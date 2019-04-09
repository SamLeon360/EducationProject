//
//  NSString+TSExtension.h
//  EducationMix
//
//  Created by Taosky on 2019/3/29.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TSExtension)

//因接口缺陷，需要在本地映射基础资料（性别）-----大坑
+ (NSString *)getSexWithSexData:(NSString *)sex;

//因接口缺陷，需要在本地映射基础资料（专业领域）
+ (NSString *)getProfessionalField:(NSInteger)professionalFieldId;

//因接口缺陷，需要在本地映射基础资料（教师级别）
+ (NSString *)getAcademicTitle:(NSInteger)academicTitleId;

//因接口缺陷，需要在本地映射基础资料（成果级别）
+ (NSString *)getResearchLevel:(NSInteger)researchLevel;

//因接口缺陷，需要在本地映射基础资料（技术成熟度）
+ (NSString *)getOwnType:(NSInteger)OwnType;


@end

NS_ASSUME_NONNULL_END
