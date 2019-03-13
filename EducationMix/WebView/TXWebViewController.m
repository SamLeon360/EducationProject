//
//  TXWebViewController.m
//  TXProject
//
//  Created by Sam on 2018/12/26.
//  Copyright © 2018年 sam. All rights reserved.
//

#import "TXWebViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "LoginViewController.h"
#import "EduNavController.h"
#import "Appdelegate.h"
//#import "MemberDetailController.h"
@interface TXWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic) UIButton *reloadBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleHead;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) UIButton *popBtn;
@end

@implementation TXWebViewController
{
    WKWebView* webView;
    WKWebViewJavascriptBridge *wkwebJsBrideg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __block TXWebViewController *blockSelf = self;
    if (self.dataDic!=nil) {
         webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 130, ScreenW, ScreenH+20)];
    }else{
        self.titleHead.hidden = YES;
        self.timeLabel.hidden = YES;
         webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 60, ScreenW, ScreenH-20)];
    }
    [webView setNavigationDelegate:self];
    webView.clipsToBounds = YES;
    [self.navigationController setNavigationBarHidden:YES];
    webView.UIDelegate = self;
    [self.view addSubview:webView];
    wkwebJsBrideg = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    [wkwebJsBrideg setWebViewDelegate:self];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.dataDic != nil) {
            make.right.left.bottom.equalTo(0);
            make.top.equalTo(130);
        }else{
            make.right.left.bottom.equalTo(0);
            make.top.equalTo(20);
        }
    }];
    if (self.webUrl != nil) {
           [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl ]]];
    }else{
        if (self.dataDic) {
            NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"first",self.dataDic[@"id"],@"id",@"3",@"jump_flag", nil];
            [HTTPREQUEST_SINGLE postWithURLString:SH_WEB_DETAIL parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
                NSArray *arr = responseDic[@"data"];
                self.dataDic = arr.firstObject;
                self.titleHead.text = self.dataDic[@"headlines"];
                self.timeLabel.text = [ self.dataDic[@"headlines2"] isKindOfClass:[NSNull class]]?@"":self.dataDic[@"headlines2"];
                [self->webView loadHTMLString:self.dataDic[@"news_text"] baseURL:nil];
            } failure:^(NSError *error) {
                
            }];
        }else{
            [self linkToView];
        }
        
    }
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, ScreenW, 20)];
//    [view setBackgroundColor:[UIColor colorWithRGB:0x3e85fb]];
//    [self.view addSubview:view];
//      self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGB:0x3e85fb];
    ///https://app.tianxun168.com/h5/demmo.html
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://app.tianxun168.com/h5/demmo.html"]]];
    [self setupNavStyle];
    [self setupFouction];
    [self setupPopBtn];
}
-(void)viewWillAppear:(BOOL)animated{
    if (self.localHTML == nil&&self.dataDic==nil) {
         [self.navigationController setNavigationBarHidden:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
//        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGB:0x202c3d];
//    [self.navigationController setNavigationBarHidden:NO];
}

-(void)linkToView{
    
        switch (self.intype) {
            case 0:{
                self.title = @"商圈";
                [self setupNavStyle];
                [self.navigationController setNavigationBarHidden:YES];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"member/moment_index/1"]]]];
            }break;
            case 1:{
                self.title = @"我的";
                [self setupNavStyle];
                [self.navigationController setNavigationBarHidden:YES];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"member/profile"]]]];
            }break;
            case 2:{
                self.title = @"聊天";
                [self setupNavStyle];
                [self.navigationController setNavigationBarHidden:YES];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"member/chat_list//"]]]];
            }break;
            case 3:{
                self.title = @"社团查询";
                NSLog(@"%@",[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"home/common_square"]);
                NSLog(@"%@",[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"home/common_square"]);
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"commerce_list///1//1"]]]];
            }break;
            case 4:{
                self.title = @"招商引资";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"merchants/new_merchants/0/1"]]]];
            }break;
            case 5:{
                self.title = @"创业宝典";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"entrepreneurship_index/0///1"]]]];
            }break;
            case 6:{
                self.title = @"综合服务";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"integrated_service/integrated_service_index/1/2//1"]]]];
            }break;
            case 7:{
                self.title = @"人才需求";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"list_talent/1//1/////2//1"]]]];
            }break;
            case 8:{
                self.title = @"产教融";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"produce_education_financial/1"]]]];
            }break;
            case 9:{
                self.title = @"文库";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"library/list_library/0/1"]]]];
            }break;
            case 10:{
                self.title = @"新政新规";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"produce_education_financial/new_deal_list/1////1"]]]];
            }break;
            case 11:{
                self.title = @"同籍社团";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"platform/third_part/2/1"]]]];
            }break;
            case 12:{
                self.title = @"同城社团";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"platform/third_part/1/1"]]]];
            }break;
            case 13:{
                self.title = @"行业查找";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"platform/enterprise_search///1"]]]];
            }break;
            case 14:{
                self.title = @"产品需求信息";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"list_product/1//////1"]]]];
            }break;
            case 15:{
                self.title = @"服务需求信息";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"list_service/1//////1"]]]];
            }break;
            case 16:{
                self.title = @"社团文库";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"library/commerce_library_list/1/1////1/1"]]]];
            }break;
            case 17:{
                self.title = @"企业文库";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"library/commerce_library_list/1/2////1/1"]]]];
            }break;
            case 18:{
                self.title = @"企业管理";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"member/manager/list_bind_enterprise//1"]]]];
            }break;
            case 19:{
                self.title = @"基地";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"enterprise/base/list_base/1"]]]];
            }break;
            case 20:{
                self.title = @"工作";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"enterprise/jobs/list_job/1/1"]]]];
            }break;
            case 21:{
                self.title = @"实习审核";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"enterprise/internship_handle/list_internship_apply/1//1"]]]];
            }break;
            case 22:{
                self.title = @"实习需求";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"common/pef_internship_list/1//////1"]]]];
            }break;
            case 23:{
                self.title = @"项目合作";
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"common/common_project_list/1////1"]]]];
            }break;
            case 24:{
                self.title = @"隐私策略";
                [self.navigationController setNavigationBarHidden:YES];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"about_privacy"]]]];
            }
                break;
//            case 25:{
//                self.title = @"社团查询";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"commerce_list///1//"]]]];
//            }
//                break;
//            case 26:{
//                self.title = @"招商引资";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"merchants/new_merchants/0/"]]]];
//            }
//                break;
//            case 27:{
//                self.title = @"创业宝典";
//                [self.navigationController setNavigationBarHidden:YES];
//                NSLog(@"%@",[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"entrepreneurship_index/1////"]);
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"entrepreneurship_index/1////"]]]];
//            }
//                break;
//            case 28:{
//                self.title = @"综合服务";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"integrated_service/integrated_service_index/1/2///"]]]];
//            }
//                break;
//            case 29:{
//                self.title = @"人才需求";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,[NSString stringWithFormat:@"list_talent/1/%@/1/////2//",USER_SINGLE.default_commerce_id]]]]];
//            }
//                break;
//            case 30:{
//                self.title = @"产教融";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"produce_education_financial/"]]]];
//            }
//                break;
//            case 31:{
//                self.title = @"文库";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"library/list_library/0/"]]]];
//            }
//                break;
//            case 32:{
//                self.title = @"新政新规";
//                [self.navigationController setNavigationBarHidden:YES];
//                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WEB_HOST_URL,@"produce_education_financial/new_deal_list/1////"]]]];
//            }
//                break;
            case 33:{
                self.title = @"通知详情";
                [self.navigationController setNavigationBarHidden:NO];
                [webView loadHTMLString:self.localHTML baseURL:[NSURL URLWithString:@"https://app.tianxun168.com/h5/#/member/commerce_notify//"]];
            }
            default:
                break;
        }
    
}

-(void)setupPopBtn{
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[[UIImage imageNamed:@"navi_back"] scaleToSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(clickToPop:) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}

- (IBAction)clickToPop:(id)sender {
    if (!webView.canGoBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSString *js = @"onBackKeyDown()";
        [webView evaluateJavaScript:js completionHandler:^(id _Nullable object, NSError * _Nullable error)
         { }];
    }
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
    self.reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    [self.reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    self.reloadBtn.center = CGPointMake(self.view.center.x - 90, self.view.center.y);
    [self.reloadBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.reloadBtn bk_whenTapped:^{
        [webView reload];
    }];
    self.popBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    [self.popBtn setTitle:@"返回上个界面" forState:UIControlStateNormal];
    self.popBtn.center = CGPointMake(self.view.center.x + 90, self.view.center.y);
    __block TXWebViewController *blockSelf = self;
    [self.popBtn bk_whenTapped:^{
        [blockSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.popBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.view addSubview:self.reloadBtn];
    [self.view addSubview:self.popBtn];
    [SVProgressHUD dismiss];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
    self.reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    [self.reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    self.reloadBtn.center = CGPointMake(self.view.center.x - 90, self.view.center.y);
    [self.reloadBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.reloadBtn bk_whenTapped:^{
        [webView reload];
    }];
    self.popBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 50)];
    [self.popBtn setTitle:@"返回上个界面" forState:UIControlStateNormal];
    self.popBtn.center = CGPointMake(self.view.center.x + 90, self.view.center.y);
    __block TXWebViewController *blockSelf = self;
    [self.popBtn bk_whenTapped:^{
        [blockSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.popBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.view addSubview:self.reloadBtn];
    [self.view addSubview:self.popBtn];
    [SVProgressHUD dismiss];
}

-(void)setupFouction{
    [wkwebJsBrideg registerHandler:@"navhidden" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *navShow = data;
        if ([navShow isEqualToString:@"YES"]) {
            [self.navigationController setNavigationBarHidden:NO];
        }else{
            [self.navigationController setNavigationBarHidden:YES];
        }
    }];
    
    [wkwebJsBrideg registerHandler:@"clickToChat" handler:^(id data, WVJBResponseCallback responseCallback) {
//        RCConversationModel *model = data;
        [self.navigationController setNavigationBarHidden:NO];
        RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = [NSString stringWithFormat:@"%@",data[@"member_id"]];
        conversationVC.title = data[@"member_name"];
        [self.navigationController pushViewController:conversationVC animated:YES];
    }];
    [wkwebJsBrideg registerHandler:@"setData" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dataDic = data;
        [USER_SINGLE SetDataByWeb:dataDic];
        
    }];
    
    [wkwebJsBrideg registerHandler:@"logOut" handler:^(id data, WVJBResponseCallback responseCallback) {
        [USER_SINGLE logout];
    }];
    ////跳转到登录界面
    [wkwebJsBrideg registerHandler:@"jumpToApp" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *type = data;
        if ([type isEqualToString:@"login"]) {
//            TXLoginNavControllerViewController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"TXLoginNavControllerViewController"];
//
//            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//
//            appDelegate.window.rootViewController = vc;
//            [appDelegate.window makeKeyAndVisible];
        }
    }];
    [wkwebJsBrideg registerHandler:@"clickToUserMessage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dic = data;
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRGB:0x3e85fb];
        self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset =UIEdgeInsetsMake(0,0, 0, 0);
        layout.headerReferenceSize =CGSizeMake(ScreenW,208*kScale);
//        MemberDetailController *vc = [[UIStoryboard storyboardWithName:@"MineView" bundle:nil] instantiateViewControllerWithIdentifier:@"MemberDetailController"];
//        vc.wayIn = @"web";
//        vc.memberDic = dic;
//        [self.navigationController pushViewController:vc animated:YES];
    }];
    [wkwebJsBrideg registerHandler:@"getStorageData" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *userdic = [[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.TokenFrom,@"TokenFrom",USER_SINGLE.default_commerce_id,@"default_commerce_id",USER_SINGLE.default_commerce_name,@"default_commerce_name",USER_SINGLE.default_role_type,@"default_role_type",USER_SINGLE.exp,@"exp",USER_SINGLE.token,@"token",USER_SINGLE.member_id,@"member_id",USER_SINGLE.role_type,@"role_type",USER_SINGLE.isSecretary,@"i", USER_SINGLE.commerceDic==nil?@"":USER_SINGLE.commerceDic,@"s",nil];
            responseCallback([Common convertToJsonData:userdic]);
    }];
    [wkwebJsBrideg registerHandler:@"gobackView" handler:^(id data, WVJBResponseCallback responseCallback) {
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = webView.estimatedProgress;
        [SVProgressHUD show];
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
                
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                [SVProgressHUD dismiss];
            }];
        }
    }else{
        
    }
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSLog(@"%@",URL);
    
    decisionHandler(WKNavigationActionPolicyAllow);

}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (self.reloadBtn) {
        [self.reloadBtn removeFromSuperview];
    }
    if (self.popBtn) {
        [self.popBtn removeFromSuperview];
    }
}
-(void)setupNavStyle{
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRGB:0x3e85fb];
//    self.navigationController.navigationBar.titleTextAttributes= @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

@end
