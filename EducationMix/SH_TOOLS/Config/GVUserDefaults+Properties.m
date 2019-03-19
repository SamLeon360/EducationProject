//
//  GVUserDefaults+Properties.m
//  HireAssistant
//
//  Created by zohar on 16/9/24.
//  Copyright © 2016年 chenshuo. All rights reserved.
//

#import "GVUserDefaults+Properties.h"
#import "AFNetWorking.h"
#import "EduNavController.h"
#import "AppDelegate.h"
//#import "YKNavigationController.h"
//#import "YKWelcomeViewController.h"
//#import "YKWelcomeView.h"
//#import "YKBuyerHomeViewController.h"
//#import "AppDelegate.h"
//#import "YKLeftSellerInformationViewController.h"
//#import "NewSHBueryHomeController.h"
//#import <LCChatKit.h>
//#import <AVInstallation.h>
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wobjc-property-implementation"
@implementation GVUserDefaults (Properties)
#pragma clang diagnostic pop

- (BOOL)isLogin
{
//    NSLog(@"%@",self.objectId);
//    if([self.objectId isEqual:[NSNull null] ]) {
//        NSLog(@"这是空的");
//        
//    }
    
    BOOL islogin = (self.token.length > 0 && self.token != nil && ![self.token isEqual:[NSNull null] ])?YES:NO;
    
    return islogin;
}

//设置用户数据
-(void)setLoginUserDataWithDic:(NSDictionary *)dic{
    self.token = dic[@"sessiontoken"];
//    self.createAtTimestamp = [self setupCreateAtTimestamp:dic[@"createdAt"]];
    [self setUserDataWithDic:dic];
    [self replaceNull];
}

-(void)setUserDataWithDic:(NSDictionary *)dic{
    self.TokenFrom = [dic[@"TokenFrom"] isKindOfClass:[NSNull class]]?@"":dic[@"TokenFrom"];
    self.default_commerce_id = [dic[@"default_commerce_id"] isKindOfClass:[NSNull class]] ?@"":[NSString stringWithFormat:@"%@",dic[@"default_commerce_id"]];
    self.default_commerce_name = [dic[@"default_commerce_name"] isKindOfClass:[NSNull class]] ?@"":dic[@"default_commerce_name"];
    self.default_role_type = [dic[@"default_role_type"] isKindOfClass:[NSNull class]] ?@"":[NSString stringWithFormat:@"%@",dic[@"default_role_type"]];
    self.exp = [dic[@"exp"] isKindOfClass:[NSNull class]] ?@"":[NSString stringWithFormat:@"%@",dic[@"exp"]];
    self.member_id = [dic[@"member_id"] isKindOfClass:[NSNull class]] ?@"": [NSString stringWithFormat:@"%@",dic[@"member_id"]];
    self.role_type = [dic[@"role_type"] isKindOfClass:[NSNull class]]? @"":[NSString stringWithFormat:@"%@",dic[@"role_type"]];
    self.isSecretary = [dic[@"role_type"] isKindOfClass:[NSNull class]]||[dic[@"role_type"] integerValue]!=1?@"false":@"true";
    self.token = [dic[@"token"] isKindOfClass:[NSNull class]]?@"":[NSString stringWithFormat:@"%@",dic[@"token"]];
    if ([dic.allKeys containsObject:@"commerceDic"]) {
        self.commerceDic = dic[@"commerceDic"];
    }
    if ([dic.allKeys containsObject:@"academy_id"]) {
        self.academy_id = dic[@"academy_id"];
    }
    NSLog(@"%@",self.isSecretary);
    
//    self.address = dic[@"address"];
//    self.intro = dic[@"intro"];
//    self.isMaster =  [dic[@"master"] boolValue];
//    self.default_group_ground_count = [dic[@"default_group_ground_count"] integerValue];
//    self.nickname_allow_change = [dic[@"nickname_allow_change"] boolValue];
//    self.avatar_has_change = [dic[@"avatar_has_change"] boolValue];
//    self.status = [dic[@"status"] integerValue];
//    self.channl = dic[@"private_group"][@"channel_name"];
//    self.default_channel_name = dic[@"default_channel_name"];
//    [[NSUserDefaults standardUserDefaults] setObject:self.defaultGroup forKey:@"groupId"];
//    self.privateGroup = dic[@"private_group"];
//    if (self.moblie.length != 0) {
//         self.groupType = [[NSUserDefaults standardUserDefaults] objectForKey:self.moblie];
//    }
//    NSLog(@"登录后的开关状态-%@",self.groupType);
//    if (self.groupType == nil) {
//        self.groupType = PrivateType;
//        [[NSUserDefaults standardUserDefaults]setObject:PrivateType forKey:self.moblie];
//    }
////    self.groupType = dic[@"private_group"][@"type"];
////    for (NSDictionary *groupDic in self.allGroupArray) {
////        NSString *everyGroupId = groupDic[@"objectId"];
////        if ([everyGroupId isEqualToString: self.defaultGroup]) {
////            self.groupType = GroupType;
////            break;
////        }
////    }
//
//    if ([self.groupType isEqualToString:PrivateType]) {
//        self.isMaster = [self.privateGroup[@"ground_count"] integerValue]==0? NO:YES;
//        [[NSUserDefaults standardUserDefaults] setObject:self.privateGroup[@"objectId"] forKey:@"groupId"];
//    }else{
//        self.isMaster = self.default_group_ground_count ==0?NO:YES;
//        [[NSUserDefaults standardUserDefaults] setObject:self.defaultGroup forKey:@"groupId"];
//    }
//
//    self.defaultGroup = dic[@"default_group"];
//    [self replaceNull];
}
-(NSString *)GetDataByKey : (NSString *)string{
    NSDictionary *dic = [self getObjectData: self];
    return dic[string];
}
-(void)SetDataByWeb :(NSDictionary *)dic{
    NSMutableDictionary *tableDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [self.userData enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [tableDic setObject:obj forKey:key];
    }];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         [tableDic setObject:obj forKey:key];
    }];
    self.userData = tableDic;
    [self setUserDataWithDic:self.userData];
}
-(NSDictionary *)getUserData{
    return [self getObjectData:self];
}

- (NSDictionary*)getObjectData:(id)obj {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil) {
            
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dic setObject:value forKey:propName];
    }
    
    return dic;
}

- (id)getObjectInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
    
}
//替换nil值为@""
-(void)replaceNull{
    self.token = self.token.length>0?self.token:@"";
    self.TokenFrom = self.TokenFrom.length>0?self.TokenFrom:@"";
    self.default_commerce_id = self.default_commerce_id.length>0?self.default_commerce_id:@"";
    self.default_commerce_name = self.default_commerce_name.length>0?self.default_commerce_name:@"";
    self.default_role_type = self.default_role_type.length>0?self.default_role_type:@"";
    self.exp = self.exp.length>0?self.exp:@"";
    self.member_id = self.member_id.length>0?self.member_id:@"";
    self.role_type = self.role_type.length>0?self.role_type:@"";
//    self.address = self.address.length>0 ? self.address : @"";
//    self.intro = self.intro.length>0 ? self.intro : @"";
//    self.createAtTimestamp = self.createAtTimestamp.length>0?self.createAtTimestamp:@"";
}

//清除用户数据
-(void)delUserData{
    self.TokenFrom = nil;
    self.default_commerce_id = nil;
    self.default_commerce_name = nil;
    self.default_role_type = nil;
    self.exp = nil;
    self.member_id = nil;
    self.role_type = nil;//1-秘书处，2-普通
    self.token = nil;
    self.commerceDic = nil;
    self.isSecretary = @"";
    [self replaceNull];
}

-(void)logout{
    

    [AlertView showYMAlertView:[UIApplication sharedApplication].keyWindow andtitle:USER_SINGLE.token.length > 0 ?@"账号已过期，请重新登录":@"请先登录"];
   [self delUserData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        EduNavController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"EduNavController"];
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = vc;
    });
    
}

-(NSString *)setupCreateAtTimestamp:(NSString *)createAt{
    NSString *string = createAt;
//    NSRange range = [string rangeOfString:@"."];
//    string = [string stringByReplacingOccurrencesOfString:@"T" withString:@" "];
//    string = [string stringByReplacingOccurrencesOfString:@"Z" withString:@""];
//    string = [string substringWithRange:NSMakeRange(0, range.location)];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"YYYY-MM-dd HH:mm";
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    NSDate *date = [fmt dateFromString:string];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    return timeSp;
}


-(void)requestUserData{
//    __block GVUserDefaults *blockSelf = self;
//    [HTTPREQUEST_SINGLE getWithURLString:YK_URL_GET_USERINFO parameters:nil withHub:NO withCache:NO success:^(NSDictionary *responseDic) {
//        if ([responseDic[@"status"] integerValue] == 1) {
//            [blockSelf setUserDataWithDic:responseDic[@"results"]];
//        }
//    } failure:^(NSError *error) {}];
}




@end
