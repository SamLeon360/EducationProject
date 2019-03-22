//
//  TSInstitutionDetailViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/19.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSInstitutionDetailViewController.h"
#import "TSInstitutionDetailTableViewCell.h"

@interface TSInstitutionDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) UIViewController *controller;

@end

@implementation TSInstitutionDetailViewController

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
    // Do any additional setup after loading the view.
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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"";
    if (indexPath.row > 2) {
        identifier = @"TSInstitutionDetailTableViewCellSecond";
    } else {
        
        identifier = @"TSInstitutionDetailTableViewCellFirst";

    }
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"uitablviewcell"];
    
        TSInstitutionDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TSInstitutionDetailTableViewCell" owner:self options:nil] objectAtIndex:indexPath.row < 1 ? 0:1 ];
    }
    
    
    

    return cell;
}


- (void)loadData {
    
    [self.tableView reloadData];
}



- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.backgroundColor = TSColor_RGB(235, 235, 235);
        [self.tableView registerNib:[UINib nibWithNibName:@"JHCell" bundle:nil] forCellReuseIdentifier:@"JHCELL"];
        
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TSInstitutionDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"TSInstitutionDetailTableViewCell"];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
