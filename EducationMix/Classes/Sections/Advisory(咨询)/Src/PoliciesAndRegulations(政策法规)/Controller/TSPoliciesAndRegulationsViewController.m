//
//  TSPoliciesAndRegulationsViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/11.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSPoliciesAndRegulationsViewController.h"
#import "TSPoliciesAndRegulationsModel.h"
#import "TSPoliciesAndRegulationsTableViewCell.h"
#import "TSPoliciesAndRegulationsViewModel.h"
@interface TSPoliciesAndRegulationsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSPoliciesAndRegulationsViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TSPoliciesAndRegulationsViewController

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
//    TSInternshipDetailViewController *vc = [[TSInternshipDetailViewController alloc] init];
//    TSInternshipModel *model = self.internshipVM.modelArr[indexPath.row];
//    vc.talent_id = model.talent_id;
//    [self.navigationController pushViewController:vc animated:YES];
//
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSPoliciesAndRegulationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSPoliciesAndRegulationsTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSPoliciesAndRegulationsTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.viewModel.modelArr[indexPath.row];
    
    return cell;
}

#pragma  mark - lazy
- (TSPoliciesAndRegulationsViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[TSPoliciesAndRegulationsViewModel alloc] init];
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
