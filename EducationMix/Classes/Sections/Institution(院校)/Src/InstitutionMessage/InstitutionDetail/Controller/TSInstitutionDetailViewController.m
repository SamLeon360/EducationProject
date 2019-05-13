//
//  TSInstitutionDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailViewController.h"
#import "TSInstitutionDetailTableViewCell.h"
#import "TSInstitutionDetailTableViewCellSecond.h"
#import "TSInstitutionDetailViewModel.h"

#import "UITableView+FDTemplateLayoutCell.h"

@interface TSInstitutionDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)TSInstitutionDetailViewModel *detailVM;

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@end

@implementation TSInstitutionDetailViewController

- (TSInstitutionDetailViewModel *)detailVM {
    
    if(!_detailVM) {
        _detailVM = [[TSInstitutionDetailViewModel alloc] init];
        _detailVM.academy_id = _academy_id;
    }
    return _detailVM;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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


-(void)configCell:(TSInstitutionDetailTableViewCellSecond *)cell indexPath:(NSIndexPath *)indexPath {
    
    cell.model = self.detailVM.modelArr[indexPath.row];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 100;
        
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        
        return [tableView fd_heightForCellWithIdentifier:@"TSInstitutionDetailTableViewCellSecond" configuration:^(id cell) {
            [self configCell:cell indexPath:indexPath];
//            (TSInstitutionDetailTableViewCellSecond *)cell.model = self.detailVM.modelArr[indexPath.row];
            

        }];
//        return 120;
    } else if (indexPath.row > 2) {
        return 50;
    }
    return 44;
    
}

- (NSInteger)tableView:(UITableView *)tableVie numberOfRowsInSection:(NSInteger)section {
    
    return self.detailVM.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSInstitutionDetailTableViewCell *cell = nil;

    NSString *identifier = @"";
    if (indexPath.row == 0) {
        identifier = @"TSInstitutionDetailTableViewCellFirst";
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInstitutionDetailTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.model = self.detailVM.modelArr[indexPath.row];
        
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        
        TSInstitutionDetailTableViewCellSecond *cell1 = [tableView dequeueReusableCellWithIdentifier:@"TSInstitutionDetailTableViewCellSecond"];
//        identifier = @"TSInstitutionDetailTableViewCellSecond";
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInstitutionDetailTableViewCell" owner:self options:nil] objectAtIndex:1];
        cell1.model = self.detailVM.modelArr[indexPath.row];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
        
    } else if (indexPath.row > 2) {
        identifier = @"TSInstitutionDetailTableViewCellFirstThree";
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInstitutionDetailTableViewCell" owner:self options:nil] objectAtIndex:2];
        cell.asModel = self.detailVM.modelArr[indexPath.row];

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)loadData {
    
    [self.detailVM loadDataArrFromNetwork];
    RACSignal *recommendContentSignal = [self.detailVM.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        // 刷新tableView数据源
        
        [self.tableView reloadData];
        
        if(self.callBackBlock){
            
            self.callBackBlock(self.detailVM.model.imageArr);
        }
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:@"网络出错"];        //        [_contentTableView.mj_header endRefreshing];
    }];
    
    [TSProgressHUD dismiss];

}



- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        [self.tableView registerNib:[UINib nibWithNibName:@"TSInstitutionDetailTableViewCellSecond" bundle:nil] forCellReuseIdentifier:@"TSInstitutionDetailTableViewCellSecond"];
        
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TSInstitutionDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"TSInstitutionDetailTableViewCellSecond"];
        
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

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
//    [self removeObserver:self.tableView forKeyPath:@"contentOffset"];

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
