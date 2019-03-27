//
//  InstitutionModel.h
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InstitutionModel : NSObject

@property (nonatomic, strong)NSString *academy_name;
@property (nonatomic, strong)NSString *college_introduction;
@property (nonatomic, strong)NSString *website;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *academy_logo;
@property (nonatomic, strong)NSString *phone;

@property (nonatomic, assign)NSInteger academy_type;
@property (nonatomic, assign)NSInteger academy_id;
@property (nonatomic, assign)NSInteger member_id;


@end

NS_ASSUME_NONNULL_END
