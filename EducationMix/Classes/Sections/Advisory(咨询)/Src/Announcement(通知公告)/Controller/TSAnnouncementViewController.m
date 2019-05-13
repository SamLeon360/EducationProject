//
//  TSAnnouncementViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/14.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAnnouncementViewController.h"
#import "TSAnnouncementTableViewCell.h"
#import "TSAnnouncementModel.h"
#import "TSAnnouncementViewModel.h"

#import "TSAnnouncementDetailViewController.h"

@interface TSAnnouncementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSAnnouncementViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TSAnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        [self.view addSubview:self.tableView];
        
        [self.tableView reloadData];
        [TSProgressHUD dismiss];
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
}


#pragma  mark - UITablViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSAnnouncementDetailViewController *vc = [[TSAnnouncementDetailViewController alloc] init];
    vc.model = self.viewModel.modelArr[indexPath.row];
    vc.title = @"通知公告";
    [self.navigationController pushViewController:vc animated:YES];
    [vc hidesBottomBarWhenPushed];

    //
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSAnnouncementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSAnnouncementTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSAnnouncementTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.viewModel.modelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma  mark - lazy
- (TSAnnouncementViewModel *)viewModel {
    
    if(!_viewModel){
        
        _viewModel = [[TSAnnouncementViewModel alloc] init];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    return _tableView;
    
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
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
