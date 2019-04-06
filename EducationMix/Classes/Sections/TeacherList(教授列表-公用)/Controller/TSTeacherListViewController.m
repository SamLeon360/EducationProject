//
//  TSTeacherListViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSTeacherListViewController.h"

#import "TSTeacherListViewModel.h"
#import "TSTeacherListModel.h"
#import "TSTeacherListTableViewCell.h"

#import "TSTeacherDetailViewController.h"

@interface TSTeacherListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSTeacherListViewModel *teacherVM;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation TSTeacherListViewController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        [self.view addSubview:self.tableView];
        [self loadData];
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSTeacherDetailViewController *vc = [[TSTeacherDetailViewController alloc] init];
    TSTeacherListModel *model = self.teacherVM.modelArr[indexPath.row];
    
    vc.expert_id = model.expert_id;
    
    [self.navigationController pushViewController:vc animated:YES];
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
    return [self.teacherVM.modelArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSTeacherListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSTeacherListTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSTeacherListTableViewCell" owner:self options:nil] objectAtIndex:0];
        
    }
    cell.model = self.teacherVM.modelArr[indexPath.row];
    
    return cell;
}


- (void)loadData {
    
    [self.teacherVM loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.teacherVM.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        
    }];
    
    [TSProgressHUD dismiss];
    
}



- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        //        [_tableView registerNib:[UINib nibWithNibName:@"TSInstitutionTeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"TSInstitutionTeacherTableViewCell"];
        
//        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 242)];
//        tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.tableHeaderView = tableHeaderView;
        
        
        
    }
    return _tableView;
}




#pragma mark - lazy
- (TSTeacherListViewModel *)teacherVM {
    
    if(!_teacherVM) {
        _teacherVM = [[TSTeacherListViewModel alloc] init];
    }
    return  _teacherVM;
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
