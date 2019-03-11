//
//  GVUserDefaults+Properties.h
//  HireAssistant
//
//  Created by zohar on 16/9/24.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>

typedef NS_ENUM(NSInteger,YKUserStatusType){
    YKUserStatusType_Audit_Error = -1,//失败
    YKUserStatusType_NewRegister = 0,//未认证
    YKUserStatusType_Auditing = 1,//认证中
    YKUserStatusType_Audit_Success = 2,//已通过
};

@interface GVUserDefaults (Properties)

@property (nonatomic, assign) NSString *TokenFrom;
@property (nonatomic, assign) NSString *default_commerce_id;
@property (nonatomic, assign) NSString *default_commerce_name;
@property (nonatomic, assign) NSString *default_role_type;
@property (nonatomic, assign) NSString *exp;
@property (nonatomic, assign) NSString *member_id;
@property (nonatomic,assign) NSString *member_name;
@property (nonatomic, assign) NSString *role_type;//1-秘书处，2-普通会员
@property (nonatomic, assign) NSString *token;
@property (nonatomic, assign) NSString *lastTimeShowHUD;
@property (nonatomic, assign) NSString *isSecretary;
@property (nonatomic,assign) NSDictionary *commerceDic;
@property (nonatomic,assign) NSDictionary *userData;
@property (nonatomic,assign) NSArray *commerceArray;
////
//@property (nonatomic, copy) NSString *username;

//是否登錄
- (BOOL)isLogin;
//保存用戶數據
-(void)setLoginUserDataWithDic:(NSDictionary *)dic;
-(void)setUserDataWithDic:(NSDictionary *)dic;
//清除登錄的用戶數據
-(void)delUserData;
//退出登录
-(void)logout;
//获取用户数据
-(void)requestUserData;

///返回用户全部数据
- (NSDictionary*)getUserData;

-(void)SetDataByWeb :(NSDictionary *)dic;
-(NSString *)GetDataByKey : (NSString *)string;
@end
