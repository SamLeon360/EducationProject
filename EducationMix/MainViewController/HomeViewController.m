//
//  HomeViewController.m
//  EducationMix
//
//  Created by Sam on 2019/3/12.
//  Copyright © 2019 sam. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeJobCell.h"
#import "HomeHeaderView.h"
#import "HomeSectionView.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *kefuImage;
@property (weak, nonatomic) IBOutlet UIImageView *msgIcon;
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;
@property (nonatomic) HomeHeaderView *headerView;
@property (nonatomic) HomeSectionView *sectionView;
@property (nonatomic) NSArray *dataArray;
@property (nonatomic) NSArray *posterArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    
    
}
-(void)GetTJJob{
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"affiliated_area",@"",@"allow_publish",@"",@"commerce_id",@"",@"education",@"",@"enterprise_id",@"",@"ios",@"",@"job_name",@"",@"job_type",@"",@"page",@"",@"receive_fresh_graduate",@"",@"work_type", nil];
    [HTTPREQUEST_SINGLE postWithURLString:SH_TUIJIAN_JOB parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            self.dataArray = responseDic[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count + 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 59;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeJobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeJobCell"];
    NSDictionary *dic  = self.dataArray[indexPath.row];
    cell.cellName.text = dic[@"job_name"];
    cell.cellMoney.text = [NSString stringWithFormat:@"%d-%d元/月",[dic[@"salary_min"] integerValue],[dic[@"salary_max"] integerValue]];
    cell.cellCompany.text = dic[@"enterprise_name"];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 156;
}

-(HomeHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"HomeXib" owner:self options:nil][0];
        _headerView.frame = CGRectMake(0, 0, ScreenW, 372*kScale);
        _headerView.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        //    NSMutableArray *urlArray = [NSMutableArray arrayWithCapacity:0];
        //    for (NSDictionary *dic in self.posterArray) {
        //        [urlArray addObject:dic[@"cover"]];
        //    }
        _headerView.cycleView.imageURLStringsGroup = self.posterArray;
        _headerView.cycleView.showPageControl = YES;
        [_headerView.cycleView setAutoScrollTimeInterval:5];
        _headerView.cycleView.autoScroll = self.posterArray.count >1?YES:NO;
        _headerView.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        
    }
    return _headerView;
}
-(HomeSectionView *)sectionView{
    if (_sectionView == nil) {
        _sectionView = [[NSBundle mainBundle] loadNibNamed:@"HomeXib" owner:self options:nil][1];
    }
    return _sectionView;
}


@end
