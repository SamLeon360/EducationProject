//
//  TSInstitutionTeacherViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionTeacherViewController.h"
#import "TSINstitutionTeacherTableViewCell.h"
#import "TSInstitutionTeacherViewModel.h"
#import "TSTeacherDetailViewController.h"
#import "TSInstitutionTeacherModel.h"

@interface TSInstitutionTeacherViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) TSInstitutionTeacherViewModel *teacherVM;

@end

@implementation TSInstitutionTeacherViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}



- (void)loadData {
    
    
    [self.teacherVM loadDataArrFromNetwork];
    [TSProgressHUD show];
    RACSignal *recommendContentSignal = [self.teacherVM.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        @strongify(self);
        [TSProgressHUD dismiss];

        [self.view addSubview:self.tableView];
        
        [self.tableView reloadData];

        
    } error:^(NSError *error) {
        
        [TSProgressHUD dismiss];
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSInstitutionTeacherModel *model = self.teacherVM.modelArr[indexPath.row];
    
    if(self.callBackBlock) {
        self.callBackBlock(model.expert_id);
    }
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

    TSInstitutionTeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSInstitutionTeacherTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInstitutionTeacherTableViewCell" owner:self options:nil] objectAtIndex:0];

    }
    cell.model = self.teacherVM.modelArr[indexPath.row];

    return cell;
}






- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);

//        [_tableView registerNib:[UINib nibWithNibName:@"TSInstitutionTeacherTableViewCell" bundle:nil] forCellReuseIdentifier:@"TSInstitutionTeacherTableViewCell"];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 242)];
        tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(182, 0, 0, 0);
        _tableView.tableHeaderView = tableHeaderView;
        
        
        
    }
    return _tableView;
}

- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
- (TSInstitutionTeacherViewModel *)teacherVM {
    
    if(!_teacherVM) {
        
        _teacherVM = [[TSInstitutionTeacherViewModel alloc] init];
    }
    return  _teacherVM;
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
