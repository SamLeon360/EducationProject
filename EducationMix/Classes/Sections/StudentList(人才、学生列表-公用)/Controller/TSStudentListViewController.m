//
//  TSStudentListViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/1.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSStudentListViewController.h"
#import "TSStudentListTableViewCell.h"
#import "TSStudentListViewModel.h"

#import "TSStudentDetailViewController.h"

@interface TSStudentListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSStudentListViewModel *studentVM;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation TSStudentListViewController

// 非storyBoard(xib或非xib)都走这个方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

// 如果连接了串联图storyBoard 走这个方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
    [self loadData];
    
    // Do any additional setup after loading the view.
}

- (void)loadData {
    
    [self.studentVM loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.studentVM.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        [self.tableView reloadData];
        
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
    [TSProgressHUD dismiss];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSStudentDetailViewController *vc = [[TSStudentDetailViewController alloc] init];
    TSStudentListModel *model = self.studentVM.modelArr[indexPath.row];
    vc.student_id = model.student_id;
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
    return self.studentVM.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSStudentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSStudentListTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSStudentListTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.studentVM.modelArr[indexPath.row];
    
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

- (TSStudentListViewModel *)studentVM {
    if(!_studentVM) {
        _studentVM = [[TSStudentListViewModel alloc] init];
    }
    return _studentVM;
    
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
