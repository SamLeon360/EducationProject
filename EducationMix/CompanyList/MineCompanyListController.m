
//
//  MineCompanyListController.m
//  TXProject
//
//  Created by Sam on 2019/2/19.
//  Copyright © 2019 sam. All rights reserved.
//

#import "MineCompanyListController.h"
#import "CompanyListCell.h"
#import "MJRefresh.h"
#import "EditCompanyMessageController.h"
@interface MineCompanyListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic) NSArray *companyListArray;
@property (nonatomic) NSArray *typeArray;
@property (nonatomic) NSInteger nPage;
@end

@implementation MineCompanyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.title = @"企业信息列表";
    self.typeArray = @[@"全部", @"高新技术企业", @"科技型中小企业", @"规模以上企业", @"创新型企业", @"民营科技企业", @"大中型企业", @"其他"];
    [self GetCompanyData];
    [self addRightBtn];
}
-(void)viewWillAppear:(BOOL)animated{
    [self GetCompanyData];
}
-(void)GetCompanyData{
    __block MineCompanyListController *blockSelf = self;
    [HTTPREQUEST_SINGLE postWithURLString:SH_COMPANY_LIST parameters:@{@"member_id":self.memberId} withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue]== 0) {
            blockSelf.companyListArray = responseDic[@"data"];
            [blockSelf.myTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    EditCompanyMessageController *vc = [[UIStoryboard storyboardWithName:@"CompanyView" bundle:nil] instantiateViewControllerWithIdentifier:@"EditCompanyMessageController"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.companyListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.companyListArray[indexPath.row];
    CompanyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyListCell"];
    [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,dic[@"enterprise_logo"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
             [cell.companyImage setImage:[UIImage imageNamed:@"default_avatar"]];
        }
    }];
    cell.companyNameLabel.text = [dic[@"enterprise_name"] isKindOfClass:[NSNull class]]?@"":dic[@"enterprise_name"];
    cell.companyTypeCell.text = self.typeArray[[dic[@"enterprise_type"] integerValue]];
    cell.companyAddressLabel.text = [dic[@"area"] isKindOfClass:[NSNull class]]?@"":dic[@"area"];
    [cell.selectDefualtBtn bk_whenTapped:^{
        [self ChangeCompanyDefault:@{@"enterprise_id":dic[@"enterprise_id"],@"handle_type":@"1"}];
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic =  self.companyListArray[indexPath.row];
    EditCompanyMessageController *vc = [[UIStoryboard storyboardWithName:@"CompanyView" bundle:nil] instantiateViewControllerWithIdentifier:@"EditCompanyMessageController"];
    vc.companyIdDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)ChangeCompanyDefault:(NSDictionary *)param{
    [HTTPREQUEST_SINGLE postWithURLString:SH_COMPANY_DEFAULT parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == -1002) {
            [AlertView showYMAlertView:self.view andtitle: responseDic[@"message"]];
        }else{
            [AlertView showYMAlertView:self.view andtitle: @"绑定失败"];
        }
    } failure:^(NSError *error) {
         [AlertView showYMAlertView:self.view andtitle: @"绑定失败"];
    }];
}
@end
