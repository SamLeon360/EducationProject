//
//  TSStudentDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/2.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSStudentDetailViewController.h"
#import "TSStudentDetailView.h"

#import "TSStudentDetailViewModel.h"

@interface TSStudentDetailViewController ()

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)TSStudentDetailView *tableHeaderView;

@property (nonatomic, strong)TSStudentDetailViewModel *viewModel;

@end

@implementation TSStudentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view from its nib.
}


- (void)loadData {
    
    [self.viewModel loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.viewModel.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        self.tableHeaderView.model = self.viewModel.model;
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
    [TSProgressHUD dismiss];
    
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

- (TSStudentDetailViewModel *)viewModel {
 
    if(!_viewModel){
        _viewModel = [[TSStudentDetailViewModel alloc] initWithStudent_id:_student_id];
    }
    return _viewModel;
}

- (TSStudentDetailView *)tableHeaderView {
    
    if(!_tableHeaderView) {
        _tableHeaderView =  [[[NSBundle mainBundle] loadNibNamed:@"TSStudentDetailView" owner:self options:nil] lastObject];
        
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
