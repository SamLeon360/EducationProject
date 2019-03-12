//
//  TXConst.h
//  TXProject
//
//  Created by Sam on 2018/12/25.
//  Copyright © 2018年 sam. All rights reserved.
//

#ifndef TXConst_h
#define TXConst_h
#define DEFAULT_IMAGE @"default_icon"
//#define BUYER_DEFAULT_HEAD_IMAGE @"buyer_defaultHead_icon"
//#define SELLER_DEFAULT_HEAD_IMAGE @"seller_defaultHead_icon"


#define MaxPhotoNum 1

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define FULL_SCREEN CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
#define kScale    [UIScreen mainScreen].bounds.size.width/414.0f  //屏幕宽度相对iPhone6屏幕宽度的比例
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
#define kScaleByView    [UIScreen mainScreen].bounds.size.width/320.0f

#define TEXT_COLOR_GRAY [UIColor colorWithRGB:0x9c9c9c]
#define TEXT_COLOR_BLACK [UIColor colorWithRGB:0x2a2a2a]
#define TEXT_COLOR_ORANGE [UIColor colorWithRGB:0xff9900]

#define LOGIN_SUCCESS_REFRESH_DATA @"loginSuccessRefreshData"//登录成功刷新主页数据

// 注册通知
#define NOTIFY_ADD(_noParamsFunc, _notifyName)  [[NSNotificationCenter defaultCenter] \
addObserver:self \
selector:@selector(_noParamsFunc) \
name:_notifyName \
object:nil];

// 发送通知
#define NOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];

// 移除通知
#define NOTIFY_REMOVE(_notifyName) [[NSNotificationCenter defaultCenter] removeObserver:self name:_notifyName object:nil];


#define SHOW_WEB [[[NSUserDefaults standardUserDefaults] objectForKey:@"ShowWeb"] integerValue]==0

#define USER_SINGLE  [GVUserDefaults standardUserDefaults]
#define HTTPREQUEST_SINGLE [RequestManager sharedInstance]

typedef NS_ENUM(NSInteger,INTYPE) {
    shop_cycle,///商圈,1
    my_message,///我的,2
    chat_view, ///聊天,3
    check_community,///社团查询,4
    new_merchants,///招商引资,5
    entrepreneurship_index,///创业宝典,6
    integrated_service,///综合服务,7
    list_talent,///人才需求,8
    produce_education_financial,///产教融,8
    list_library,///文库,9
    deal_list,///新政新规,10
    samelevel_community,///同级社团,11
    samecity_community,///同城社团,12
    enterprise_search,///行业搜索,13
    list_product,///产品需求,14
    list_service,///服务需求,15
    commerce_library_list,///社团文库,16
    company_library_list,///企业文库,17
    list_bind_enterprise,///企业管理,18
    list_base,///基地信息,19
    list_job,///工作,20
    list_internship_apply,///实习审核,21
    pef_internship_list,///实习需求,22
    common_project_list,///项目合作,23
    privacy_policy,///隐私策略,24
    check_community_token,///社团查询,25
    new_merchants_token,///招商引资,26
    entrepreneurship_index_token,///创业宝典,27
    integrated_service_token,///综合服务,28
    list_talent_token,///人才需求,29
    produce_education_financial_token,///产教融,30
    list_library_token,///文库
    deal_list_token,///新政新规
    load_html////加载HTML
};
#endif /* TXConst_h */
