//
//  TSTeacherDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/3.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeacherDetailViewController.h"
#import "TSTeacherDetailView.h"
#import "TSTeacherDetailViewModel.h"

@interface TSTeacherDetailViewController ()

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)TSTeacherDetailView *tableHeaderView;
@property (nonatomic, strong)TSTeacherDetailViewModel *viewModel;

@end

@implementation TSTeacherDetailViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"专家详细"];
    [self loadData];

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
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
        [TSProgressHUD dismiss];

        
    }];
    
    
}


#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64)];
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = self.tableHeaderView;
        
    }
    return _tableView;
}

- (TSTeacherDetailViewModel *)viewModel {
    
    if(!_viewModel){
        _viewModel = [[TSTeacherDetailViewModel alloc] initWithexpert_id:self.expert_id];
    }
    return _viewModel;
}

- (TSTeacherDetailView *)tableHeaderView {
    
    if(!_tableHeaderView) {
        _tableHeaderView =  [[[NSBundle mainBundle] loadNibNamed:@"TSTeacherDetailView" owner:self options:nil] lastObject];
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
