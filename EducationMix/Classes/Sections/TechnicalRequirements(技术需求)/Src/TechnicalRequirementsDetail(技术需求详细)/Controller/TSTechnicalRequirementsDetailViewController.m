//
//  TSTechnicalRequirementsDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTechnicalRequirementsDetailViewController.h"
#import "TSTechnicalRequirementsDetailModel.h"
#import "TSTechnicalRequirementsDetailViewModel.h"
#import "TSTechnicalRequirementsDetailView.h"

@interface TSTechnicalRequirementsDetailViewController ()

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)TSTechnicalRequirementsDetailView *tableHeaderView;

@property (nonatomic, strong)TSTechnicalRequirementsDetailViewModel *viewModel;

@end

@implementation TSTechnicalRequirementsDetailViewController

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

- (TSTechnicalRequirementsDetailViewModel *)viewModel {
    
    if(!_viewModel){
        _viewModel = [[TSTechnicalRequirementsDetailViewModel alloc] initWithTechnology_id:_technology_id Commerce_id:_commerce_id];
    }
    return _viewModel;
}

- (TSTechnicalRequirementsDetailView *)tableHeaderView {
    
    if(!_tableHeaderView) {
        _tableHeaderView =  [[[NSBundle mainBundle] loadNibNamed:@"TSTechnicalRequirementsDetailView" owner:self options:nil] lastObject];
        
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
