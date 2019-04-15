//
//  TSAnnouncementDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAnnouncementDetailViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "TSAnnouncementDetailViewModel.h"


@interface TSAnnouncementDetailViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong)IBOutlet UILabel *notify_title;
@property(nonatomic, strong)IBOutlet UILabel *publish_name;
@property(nonatomic, strong)IBOutlet UILabel *create_time;

@property(nonatomic, strong)TSAnnouncementDetailViewModel *viewModel;

@property(nonatomic, strong)WKWebView* webView;
@property(nonatomic, strong)WKWebViewJavascriptBridge *wkwebJsBrideg;
@end

@implementation TSAnnouncementDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 128+64, ScreenW, ScreenH-128-64)];
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
    
    self.notify_title.text = self.model.notify_title;
    self.publish_name.text = self.model.publish_name;
    self.create_time.text = self.model.create_time;
    [self.webView loadHTMLString:self.viewModel.model.notify_content baseURL:nil];
    //        [self.view addSubview:self.tableView];
    
}

- (TSAnnouncementDetailViewModel *)viewModel {
    
    if(!_viewModel){
     
        _viewModel = [[TSAnnouncementDetailViewModel alloc] initWithModel:self.model];
        
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
