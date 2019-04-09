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

@interface TSAdvisoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)TSAdvisoryViewModel *advisoryVM;

@property(nonatomic, assign)NSInteger mapping_type;

@property(nonatomic, strong)IBOutlet UITableView *tableView;

@property(nonatomic, strong)IBOutlet UIButton *button1;
@property(nonatomic, strong)IBOutlet UIButton *button2;
@property(nonatomic, strong)IBOutlet UIButton *button3;
@property(nonatomic, strong)IBOutlet UIButton *button4;

//记录上一个button
@property (nonatomic, strong) UIButton *previousButton;
//装按钮
@property(nonatomic, strong)NSArray *buttonArr;

@end

@implementation TSAdvisoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUI];
    self.mapping_type = 1;
    
    [self loadData];
    self.buttonArr;
    
    
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
    
//    NSLog(@"%ld",index);
    
    
}


#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSAchievementDetailViewController *vc = [[TSAchievementDetailViewController alloc] init];
    vc.title = @"成果详细";
    TSAdvisoryModel *model = self.advisoryVM.modelArr[indexPath.row];
    vc.results_id = model.Id;
    [self.navigationController pushViewController:vc animated:YES];
    
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
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
