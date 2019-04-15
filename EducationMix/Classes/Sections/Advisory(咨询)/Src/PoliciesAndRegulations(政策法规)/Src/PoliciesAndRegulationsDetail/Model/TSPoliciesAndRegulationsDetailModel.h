//
//  TSPoliciesAndRegulationsDetailModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/12.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSPoliciesAndRegulationsDetailModel : NSObject

@property(nonatomic, assign)NSInteger Id;
@property(nonatomic, strong)NSString *headlines;
@property(nonatomic, strong)NSString *headlines2;
@property(nonatomic, strong)NSString *headlines_img;
@property(nonatomic, assign)NSInteger types;
@property(nonatomic, strong)NSString *news_text;


//"id":135,
//"headlines":"中共中央办公厅 国务院办公厅印发《关于促进中小企业健康发展的指导意见》",
//"headlines2":"来源： 新华社",
//"headlines_img":"/uploads/IntegratedServices/20190408/1554717732805918250.jpg",
//"types":1,
//"news_text":"<p><s
@end

NS_ASSUME_NONNULL_END
