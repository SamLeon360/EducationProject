//
//  TSPoliciesAndRegulationsDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/12.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSPoliciesAndRegulationsDetailViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "TSPoliciesAndRegulationsDetailViewModel.h"
#import "TSPoliciesAndRegulationsDetailModel.h"

@interface TSPoliciesAndRegulationsDetailViewController ()<WKUIDelegate,WKNavigationDelegate>


@property (weak, nonatomic) IBOutlet UILabel *headlines;
@property (weak, nonatomic) IBOutlet UILabel *headlines2;
@property (weak, nonatomic) IBOutlet UIImageView *headlines_img;
@property (weak, nonatomic) IBOutlet UILabel *news_text;

@property(nonatomic, strong)TSPoliciesAndRegulationsDetailViewModel *viewModel;

@property(nonatomic, strong)WKWebView* webView;
@property(nonatomic, strong)WKWebViewJavascriptBridge *wkwebJsBrideg;

@end

@implementation TSPoliciesAndRegulationsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 90+64, ScreenW, ScreenH-90-64)];
    [self.webView setNavigationDelegate:self];
    self.webView.clipsToBounds = YES;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    self.wkwebJsBrideg = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.wkwebJsBrideg setWebViewDelegate:self];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData {
    
    
    [TSProgressHUD show];
    
    [self.viewModel loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.viewModel.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        
        TSPoliciesAndRegulationsDetailModel *model = [[TSPoliciesAndRegulationsDetailModel alloc] init];
        model = self.viewModel.model;
        self.headlines.text = model.headlines;
        self.headlines2.text = model.headlines2;
        [self.webView loadHTMLString:self.viewModel.model.news_text baseURL:nil];
//        [self.view addSubview:self.tableView];
        
//        self.tableHeaderView.model = self.viewModel.model;
        
        
        
        [TSProgressHUD dismiss];
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
    }];
    
}

#pragma mark - lazy
- (TSPoliciesAndRegulationsDetailViewModel *)viewModel {
 
    if(!_viewModel){
        _viewModel = [[TSPoliciesAndRegulationsDetailViewModel alloc] initWithId:_Id];
    }
    return _viewModel;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
