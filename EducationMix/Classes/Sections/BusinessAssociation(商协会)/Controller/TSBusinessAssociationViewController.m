//
//  TSBusinessAssociationViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSBusinessAssociationViewController.h"
#import "TSBusinessAssociationModel.h"
#import "TSBusinessAssociationViewModel.h"
#import "TSBusinessAssociationTableViewCell.h"

@interface TSBusinessAssociationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;

@property (nonatomic, strong) TSBusinessAssociationViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TSBusinessAssociationViewController

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

#pragma mark - TableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    TSStudentDetailViewController *vc = [[TSStudentDetailViewController alloc] init];
//    TSStudentListModel *model = self.studentVM.modelArr[indexPath.row];
//    vc.student_id = model.student_id;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSBusinessAssociationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSBusinessAssociationTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSBusinessAssociationTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.viewModel.modelArr[indexPath.row];
    
    return cell;
}



#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        //        [_tableView registerNib:[UINib nibWithNibName:@"TSInstitutionStudentTableViewCell" bundle:nil] forCellReuseIdentifier:@"TSInstitutionStudentTableViewCell"];
        
        //        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 242)];
        //        tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //        _tableView.tableHeaderView = tableHeaderView;
        
        
        
    }
    return _tableView;
}

- (TSBusinessAssociationViewModel *)viewModel {
    
    if(!_viewModel) {
        
        _viewModel = [[TSBusinessAssociationViewModel alloc] init];
    }
    return _viewModel;
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
