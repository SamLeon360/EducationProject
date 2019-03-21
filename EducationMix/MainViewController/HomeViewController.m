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
#import "YYLabel.h"
#import "LPTagModel.h"
#import "HomeSectionView.h"
#import "EduNavController.h"
#import "LoginBottomView.h"
#import "EduMeViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,LPSwitchTagDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *kefuImage;
@property (weak, nonatomic) IBOutlet UIImageView *msgIcon;
@property (weak, nonatomic) IBOutlet UIImageView *shareImage;
@property (nonatomic) HomeHeaderView *headerView;
@property (nonatomic) HomeSectionView *sectionView;
@property (nonatomic) NSArray *workTypeArray ;
@property (nonatomic) NSArray *dataArray;
@property (nonatomic) NSArray *posterArray;
@property (nonatomic) LoginBottomView *loginBtnView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    self.workTypeArray =  @[@"全部",@"电子信息",@"装备制造", @"能源环保",@"生物技术与医药",@"新材料",@"现代农药", @"其他"];
    [self GetTJJob];
    [self GetNewPost];
    
   
}
-(void)GetTJJob{
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"affiliated_area",@"",@"allow_publish",@"",@"commerce_id",@"",@"education",@"",@"enterprise_id",@"",@"ios",@"",@"job_name",@"",@"job_type",@"1",@"page",@"",@"receive_fresh_graduate",@"",@"work_type", nil];
    [HTTPREQUEST_SINGLE postWithURLString:SH_TUIJIAN_JOB parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            self.dataArray = responseDic[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [AlertView showYMAlertView:self.view andtitle:@"网络异常，请检查网络"];
    }];
}
-(void)viewWillLayoutSubviews{
    if (USER_SINGLE.token.length<= 0) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.loginBtnView];
    }
    
}
-(void)GetNewPost{
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"1",@"allow_publish",@"",@"commerce_id",@"",@"area",@"",@"demand_type",@"",@"domain",@"",@"enterprise_type",@"",@"technology_name",@"1",@"page", nil];
    [HTTPREQUEST_SINGLE postWithURLString:SH_NEWS_POST_HOME parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            self.posterArray = responseDic[@"data"];
             self.tableView.tableHeaderView = self.headerView;
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
    return self.dataArray.count ;
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
    cell.cellMoney.text = [NSString stringWithFormat:@"%ld-%ld元/月",[dic[@"salary_min"] integerValue],[dic[@"salary_max"] integerValue]];
    cell.cellCompany.text = dic[@"enterprise_name"];

    cell.cellAddress.text = [dic[@"area"] stringByReplacingOccurrencesOfString:@"|" withString:@""];
    LPTagCollectionView *tagCollectionView ;
    
    if (cell.cellTypeTag.subviews.count <= 0) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 13);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        tagCollectionView = [[LPTagCollectionView alloc] initWithFrame:cell.cellTypeTag.frame collectionViewLayout:layout];
        [cell.cellTypeTag addSubview:tagCollectionView];
    }else{
        tagCollectionView = cell.cellTypeTag.subviews.firstObject;
    }
    NSArray *tagArray = [dic[@"welfare"] componentsSeparatedByString:@"|"];
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:0];
    tagCollectionView.fontColor = [UIColor colorWithRGB:0x3f78bc];
    tagCollectionView.borderColor = [UIColor colorWithRGB:0x3f78bc];
    for (int i = 0; i < tagArray.count ; i++) {
        LPTagModel *model = [[LPTagModel alloc] init];
        model.name = tagArray[i];
        model.isChoose = NO;
        [modelArray addObject:model];
    }
    tagCollectionView.tagArray = modelArray;
    tagCollectionView.fontSize = 12;
    tagCollectionView.cellHeight = 19;
    tagCollectionView.scrollEnabled = NO;
    tagCollectionView.tagDelegate = self;
    [tagCollectionView reloadData];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

-(HomeHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"HomeXib" owner:self options:nil][0];
        _headerView.frame = CGRectMake(0, 0, ScreenW, 435*kScale);
        _headerView.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _headerView.postArray = self.posterArray;
        [_headerView setupTableView];
//        _headerView.cycleView.imageURLStringsGroup = self.posterArray;
        _headerView.cycleView.showPageControl = YES;
        [_headerView.cycleView setAutoScrollTimeInterval:5];
//        _headerView.cycleView.autoScroll = self.posterArray.count >1?YES:NO;
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

-(LoginBottomView *)loginBtnView{
    if (_loginBtnView == nil) {
        _loginBtnView = [[NSBundle mainBundle] loadNibNamed:@"LoginBottomView" owner:self options:nil][0];
        [_loginBtnView.loginBtn bk_whenTapped:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                EduNavController *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"EduNavController"];
                AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appDelegate.window.rootViewController = vc;
                [appDelegate.window makeKeyAndVisible];
            });
        }];
        [_loginBtnView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
        _loginBtnView.frame = CGRectMake(0, ScreenH-112, ScreenW, 64);
        [_loginBtnView.loginBtn makeCorner:_loginBtnView.loginBtn.frame.size.height/2];
    }
    return _loginBtnView;
}
@end
