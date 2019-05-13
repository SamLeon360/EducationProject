//
//  TSBusinessAssociationModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSBusinessAssociationModel : NSObject


@property(nonatomic, strong)NSString *commerce_name;
@property(nonatomic, strong)NSString *commerce_type;
@property(nonatomic, strong)NSString *commerce_logo;
@property(nonatomic, strong)NSString *commerce_location;

@property(nonatomic, assign)NSInteger commerce_id;
@property(nonatomic, assign)NSInteger ct;
@property(nonatomic, assign)NSInteger examination_grade;



//"commerce_id":144,
//"ct":104,
//"commerce_name":"中山市贵州商会",
//"commerce_type":"4",
//"examination_grade":4,
//"commerce_logo":"/uploads/commerce/144/144.jpg",
//"commerce_location":"中山市"

@end

NS_ASSUME_NONNULL_END
