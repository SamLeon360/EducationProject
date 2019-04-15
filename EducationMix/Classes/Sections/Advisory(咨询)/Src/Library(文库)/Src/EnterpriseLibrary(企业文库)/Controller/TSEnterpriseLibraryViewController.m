//
//  TSEnterpriseLibraryViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/15.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSEnterpriseLibraryViewController.h"
#import "TSEnterpriseLibraryViewModel.h"
#import "TSEnterpriseLibraryTableViewCell.h"

@interface TSEnterpriseLibraryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)TSEnterpriseLibraryViewModel *viewModel;
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation TSEnterpriseLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}


- (void)loadData {
    
    [self.viewModel loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.viewModel.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        [self.tableView reloadData];
        
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
    [TSProgressHUD dismiss];
    
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
    return 98;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSEnterpriseLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSEnterpriseLibraryTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSEnterpriseLibraryTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.viewModel.modelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        

        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //        _tableView.tableHeaderView = tableHeaderView;
        
        
        
    }
    return _tableView;
}

- (TSEnterpriseLibraryViewModel *)viewModel {
    
    if(!_viewModel) {
        _viewModel = [[TSEnterpriseLibraryViewModel alloc] init];
        
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
