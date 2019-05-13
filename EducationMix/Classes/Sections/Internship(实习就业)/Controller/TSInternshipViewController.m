//
//  TSInternshipViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/27.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInternshipViewController.h"
#import "TSInternshipTableViewCell.h"
#import "TSInternshipModel.h"
#import "TSInternshipViewModel.h"

#import "TSInternshipDetailViewController.h"

@interface TSInternshipViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSInternshipViewModel *internshipVM;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TSInternshipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实习就业";
    [self.view addSubview:self.tableView];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    
    
    [self.internshipVM loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.internshipVM.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        [self.tableView reloadData];
        
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
    [TSProgressHUD dismiss];
}

#pragma  mark - UITablViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TSInternshipDetailViewController *vc = [[TSInternshipDetailViewController alloc] init];
    TSInternshipModel *model = self.internshipVM.modelArr[indexPath.row];
    vc.talent_id = model.talent_id;
    vc.title = @"人才需求信息";
    [self.navigationController pushViewController:vc animated:YES];
    
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
    return self.internshipVM.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSInternshipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSInternshipTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInternshipTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.internshipVM.modelArr[indexPath.row];
    
    return cell;
}

#pragma  mark - lazy
- (TSInternshipViewModel *)internshipVM {
    if(!_internshipVM) {
        _internshipVM = [[TSInternshipViewModel alloc] init];
    }
    return _internshipVM;
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
