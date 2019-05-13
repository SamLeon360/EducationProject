//
//  TSPoliciesAndRegulationsModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/11.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSPoliciesAndRegulationsModel : NSObject

@property(nonatomic, assign)NSInteger Id;
@property(nonatomic, strong)NSString *headlines;
@property(nonatomic, strong)NSString *headlines2;
@property(nonatomic, strong)NSString *headlines_img;
@property(nonatomic, strong)NSString *publish_time;



//"headlines":"国务院办公厅关于同意建立自然灾害防治工作部际联席会议制度的函",
//"headlines2":"国办函〔2019〕30号",
//"headlines_img":null,
//"publish_time":"2019-04-10 00:00:00"

@end

NS_ASSUME_NONNULL_END
