//
//  TSMeViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/4/17.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSMeViewController.h"
#import "TSMeHeaderView.h"
#import "TSMeTableViewCell.h"
#import "TSMeViewModel.h"

@interface TSMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)TSMeViewModel *viewModel;

@end

@implementation TSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.title = @"我的";
    // Do any additional setup after loading the view from its nib.
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
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.meCellModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSMeTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSMeTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = self.viewModel.meCellModelArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 12;
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
//                tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        UIView *tableHeaderView = nil;
        
        //未登录状态下需要显示的页面
        if(USER_SINGLE.token.length<= 0) {
            
            
        } else {
            
            
        }
        
        tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"TSMeHeaderView" owner:self options:nil] objectAtIndex:0];
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableHeaderView = tableHeaderView;
        
        
        
    }
    return _tableView;
}

- (TSMeViewModel *)viewModel {
 
    if(!_viewModel) {
        _viewModel = [[TSMeViewModel alloc] init];
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
