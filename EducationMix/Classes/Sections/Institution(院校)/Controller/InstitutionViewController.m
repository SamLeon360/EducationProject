//
//  InstitutionViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import "InstitutionViewController.h"
#import "InstitutionTableViewCell.h"
#import "InstitutionViewModel.h"
#import "InstitutionModel.h"

#import "TSINSTMsgViewController.h"

#import "TSInternshipViewController.h"

@interface InstitutionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@property (nonatomic, strong) InstitutionViewModel *contentVM;

@end

@implementation InstitutionViewController

- (InstitutionViewModel *)contentVM {
    
    if(!_contentVM){
        _contentVM = [[InstitutionViewModel alloc]init];
    }
    return _contentVM;
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view addSubview:self.tableView];
        [self loadData];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"院校";

    // Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InstitutionModel *model = self.contentVM.modelArr[indexPath.row];
    
    if(![self.contentVM.model isEqual:[NSNull null]]) {
        TSINSTMsgViewController *viewControlle = [[TSINSTMsgViewController alloc]init];
        viewControlle.academy_id = model.academy_id;
        viewControlle.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:viewControlle animated:YES];

    }
    

//    _contentVM.modelArr
//    NSString *academy_id =  _contentVM.modelArr[indexPath.row].academy_id;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentVM.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstitutionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstitutionTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InstitutionTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.contentVM.modelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


- (void)loadData {
    
    [self.contentVM loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.contentVM.requestCommand execute:nil];
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        
        // 刷新tableView数据源
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
//        [_contentTableView.mj_header endRefreshing];
    }];
}



- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        
        [_tableView registerNib:[UINib nibWithNibName:@"InstitutionTableViewCell" bundle:nil] forCellReuseIdentifier:@"InstitutionTableViewCell"];
        
//        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        _tableView.tableHeaderView = tableHeaderView;
        
        
        
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
