//
//  TSEnterpriseLibraryModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/15.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSEnterpriseLibraryModel : NSObject


@property(nonatomic, assign)NSInteger file_id;
@property(nonatomic, strong)NSString *file_name;
@property(nonatomic, strong)NSString *member_name;
@property(nonatomic, strong)NSString *admin_name;
@property(nonatomic, strong)NSString *file_extension;

@property(nonatomic, strong)NSString *file;
@property(nonatomic, strong)NSString *release_time;

//"file_id":18,
//"file_name":"贵州省湖北商会成立庆典活动策划方案",
//"member_id":634,
//"member_name":"方佩佩",
//"admin_id":null,
//"admin_name":null,
//"library_type":1,
//"file_type":1,
//"public":1,
//"file_introduction":null,
//"file_extension":"doc",
//"file":"/uploads/ShFile/CommerLibrary/144/1532761174820642249.doc",
//"release_time":"2018-07-28 00:00:00",
//"browsing":48,
//"download":35

@end

NS_ASSUME_NONNULL_END
