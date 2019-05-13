//
//  TSTechnicalRequirementsViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/10.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTechnicalRequirementsViewController.h"
#import "TSTechnicalRequirementsModel.h"
#import "TSTechnicalRequirementsViewModel.h"
#import "TSTechnicalRequirementsTableViewCell.h"

#import "TSTechnicalRequirementsDetailViewController.h"

@interface TSTechnicalRequirementsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSTechnicalRequirementsViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TSTechnicalRequirementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"技术需求";
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
    TSTechnicalRequirementsDetailViewController *vc = [[TSTechnicalRequirementsDetailViewController alloc] init];
    TSTechnicalRequirementsModel *model = self.viewModel.modelArr[indexPath.row];
    vc.technology_id = model.technology_id;
    vc.commerce_id = model.commerce_id;
    vc.title = @"技术需求详细";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 147+9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSTechnicalRequirementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSTechnicalRequirementsTableViewCell"];
    
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSTechnicalRequirementsTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.model = self.viewModel.modelArr[indexPath.row];
    
    return cell;
}

#pragma  mark - lazy


- (TSTechnicalRequirementsViewModel *)viewModel {
    if(!_viewModel) {
        _viewModel = [[TSTechnicalRequirementsViewModel alloc] init];
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
