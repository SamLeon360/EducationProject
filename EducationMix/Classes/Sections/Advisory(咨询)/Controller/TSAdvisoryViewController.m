//
//  TSAdvisoryViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/7.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSAdvisoryViewController.h"
#import "TSAdvisoryHeaderView.h"

#import "TSTSAdvisoryTableViewCell.h"
#import "TSAdvisoryViewModel.h"
#import "TSAdvisoryModel.h"

#import "TSAchievementDetailViewController.h"
#import "TSTeamDetailsViewController.h"
#import "TSTechnicalRequirementsDetailViewController.h"
#import "TSProjectDetailsViewController.h"

#import "TSPoliciesAndRegulationsViewController.h"

@interface TSAdvisoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate>

@property(nonatomic, strong)TSAdvisoryViewModel *advisoryVM;

@property(nonatomic, assign)NSInteger mapping_type;

@property(nonatomic, strong)IBOutlet UITableView *tableView;

@property(nonatomic, strong)IBOutlet UIButton *button1;
@property(nonatomic, strong)IBOutlet UIButton *button2;
@property(nonatomic, strong)IBOutlet UIButton *button3;
@property(nonatomic, strong)IBOutlet UIButton *button4;

@property (nonatomic, strong)IBOutlet UICollectionView *collectionView;

//装collectionCell内容 （静态）
@property (nonatomic, strong)NSArray *collectionDataSource;

//记录上一个button
@property (nonatomic, strong) UIButton *previousButton;
//装按钮
@property(nonatomic, strong)NSArray *buttonArr;
//记录当前页面按钮
@property(nonatomic, assign)NSInteger btnInx;

@end

@implementation TSAdvisoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUI];
    self.mapping_type = 1;
    
    [self loadData];
    self.buttonArr;
    
    _collectionView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)setUI {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
    
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    TSAdvisoryHeaderView *headerView = [[TSAdvisoryHeaderView alloc] init];
//    TSAdvisoryHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"TSAdvisoryHeaderView" owner:self options:nil] lastObject];
//    [headerView setFrame:CGRectMake(0, 64, 100, 100)];
//
//    [self.view addSubview:headerView];
    
    
}

- (void)loadData {
    
    [self.advisoryVM loadDataArrFromNetwork];
    
    RACSignal *recommendContentSignal = [self.advisoryVM.requestCommand execute:nil];
    
    @weakify(self);
    [[RACSignal combineLatest:@[recommendContentSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        [self.tableView reloadData];
        
        
    } error:^(NSError *error) {
        [TSProgressHUD showError:error.description];
        
    }];
    
    [TSProgressHUD dismiss];
}

-(void)changeSelectedItem:(UIButton *)currentButton {

    _previousButton.selected = NO;
    currentButton.selected = YES;
    _previousButton = currentButton;
    
    NSInteger index = [self.buttonArr indexOfObject:currentButton];
    
    self.mapping_type = index + 1 ;
    self.advisoryVM.mapping_type = index + 1;
    [self loadData];
    self.btnInx = index;
//    NSLog(@"%ld",index);
    
    
}


#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(self.btnInx == 0){
        TSAchievementDetailViewController *vc = [[TSAchievementDetailViewController alloc] init];
        vc.title = @"成果详细";
        TSAdvisoryModel *model = self.advisoryVM.modelArr[indexPath.row];
        vc.results_id = model.Id;
        [self.navigationController pushViewController:vc animated:YES];
    } else if(self.btnInx == 1){
        
        TSTeamDetailsViewController *vc = [[TSTeamDetailsViewController alloc] init];
        vc.title = @"成果详细";
        TSAdvisoryModel *model = self.advisoryVM.modelArr[indexPath.row];
        vc.team_id = model.Id;
        [self.navigationController pushViewController:vc animated:YES];
    } else if(self.btnInx == 2){
        TSTechnicalRequirementsDetailViewController *vc = [[TSTechnicalRequirementsDetailViewController alloc] init];
        TSAdvisoryModel *model = self.advisoryVM.modelArr[indexPath.row];
        vc.technology_id = model.Id;
        vc.commerce_id = 0;
        vc.title = @"技术需求详细";
        [self.navigationController pushViewController:vc animated:YES];
    } else if(self.btnInx == 3){
        TSProjectDetailsViewController *vc = [[TSProjectDetailsViewController alloc] init];
        TSAdvisoryModel *model = self.advisoryVM.modelArr[indexPath.row];
        vc.project_id = model.Id;
        vc.title = @"项目信息";
        [self.navigationController pushViewController:vc animated:YES];
    }
    

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.advisoryVM.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSTSAdvisoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSTSAdvisoryTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSTSAdvisoryTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.advisoryVM.modelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TSPoliciesAndRegulationsViewController *vc = [[TSPoliciesAndRegulationsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc hidesBottomBarWhenPushed];
//    NSLog(@"点击");
}

#pragma mark - lazy
- (NSArray *)buttonArr {
    
    if(!_buttonArr) {
        
        _buttonArr = [[NSArray alloc] initWithObjects:_button1,_button2,_button3,_button4, nil];
        
        
        for (int i = 0; i<_buttonArr.count; i++) {
            
            UIButton *btn = _buttonArr[i];
            [btn addTarget:self action:@selector(changeSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                btn.selected = YES;
                _previousButton = btn;
                self.btnInx = 0;

                
            }
        }

        
    }
    return _buttonArr;
}

- (TSAdvisoryViewModel *)advisoryVM {
    
    if(!_advisoryVM) {
        _advisoryVM = [[TSAdvisoryViewModel alloc] initWithMapping_type:1];
    }
    return _advisoryVM;
    
}

- (NSArray *)collectionDataSource {
    
    if(!_collectionDataSource) {
        
        _collectionDataSource = @[ @{@"image":@"法规.jpg",@"name":@"政策法规",@"englishName":@"Policy"},
                         @{@"image":@"文库.jpg",@"name":@"文库",@"englishName":@"Library"},
                         @{@"image":@"公告.jpg",@"name":@"通知公告",@"englishName":@"Notice"},
                         @{@"image":@"新闻.jpg",@"name":@"平台新闻",@"englishName":@"News"}];
    }
    return _collectionDataSource;
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
