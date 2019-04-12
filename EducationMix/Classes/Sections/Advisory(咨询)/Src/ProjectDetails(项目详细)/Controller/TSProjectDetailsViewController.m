//
//  TSProjectDetailsViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSProjectDetailsViewController.h"
#import "TSProjectDetailsModel.h"
#import "TSProjectDetailsView.h"
#import "TSProjectDetailsViewModel.h"

@interface TSProjectDetailsViewController ()

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)TSProjectDetailsView *tableHeaderView;

@property (nonatomic, strong)TSProjectDetailsViewModel *viewModel;

@end

@implementation TSProjectDetailsViewController

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
        self.tableHeaderView.model = self.viewModel.model;
        [TSProgressHUD dismiss];

        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
    
}


#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44)];
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = self.tableHeaderView;
        
    }
    return _tableView;
    
}

- (TSProjectDetailsViewModel *)viewModel {
    
    if(!_viewModel){
        _viewModel = [[TSProjectDetailsViewModel alloc] initWithProject_id:self.project_id];
    }
    return _viewModel;
}

- (TSProjectDetailsView *)tableHeaderView {
    
    if(!_tableHeaderView) {
        _tableHeaderView =  [[[NSBundle mainBundle] loadNibNamed:@"TSProjectDetailsView" owner:self options:nil] lastObject];
        
    }
    return _tableHeaderView;
    
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
