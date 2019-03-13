//
//  MemberListController.m
//  TXProject
//
//  Created by Sam on 2019/1/14.
//  Copyright © 2019 sam. All rights reserved.
//

#import "MemberListController.h"
#import "MemberListCell.h"
#import "MJRefresh.h"
#import "TXWebViewController.h"
#import "MemberDetailController.h"
@interface MemberListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIView *topBtnView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *memberListArray;
@property (nonatomic) NSArray *typeArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topviewAutoHeight;
@property (nonatomic) BOOL newMember;
//@property (nonatomic) NSMutableArray *memberAvatarArray;
@property (nonatomic) NSInteger nPage;
@end

@implementation MemberListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.topviewAutoHeight setConstant: self.checkMember?0: 50];
    self.typeArray = @[@"全部",@"会长",@"执行会长",@"常务副会长",@"副会长",@"常务理事",@"理事",@"监事长",@"副监事长",@"监事",@"名誉会长",@"荣誉会长",@"创会会长",@"顾问",@"秘书长",@"执行秘书长",@"专职秘书长",@"副秘书长",@"干事",@"办公室主任",@"文员",@"部长",@"会员"];
    self.title = self.checkMember? @"查看所有成员":@"会员风采";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.newMember = NO;
    self.nPage = 1;
    __block MemberListController *blockSelf = self;
    [self.leftBtn bk_whenTapped:^{
        [blockSelf.leftBtn setTitleColor:[UIColor colorWithRGB:0xFACB46] forState:UIControlStateNormal];
        [blockSelf.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        blockSelf.newMember = NO;
        blockSelf.nPage = 1;
        [blockSelf getMemberListData];
        
    }];
    [self.rightBtn bk_whenTapped:^{
        [blockSelf.rightBtn setTitleColor:[UIColor colorWithRGB:0xFACB46] forState:UIControlStateNormal];
        [blockSelf.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        blockSelf.newMember = YES;
        blockSelf.nPage = 1;
        [blockSelf getMemberListData];
    }];
    [self.searchBtn bk_whenTapped:^{
        [blockSelf getMemberListData];
    }];
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor = [UIColor colorWithRGB:0xf2f2f2].CGColor;
    [self.searchView makeCorner:5];
    [self getMemberListData];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreMemberListData)];
    self.tableView.mj_footer = footer;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
}
-(void)getMoreMemberListData{
    self.nPage ++;
    __block MemberListController *blockSelf = self;

    NSDictionary *dic = self.newMember ? [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)self.nPage],@"page",self.commerceDic==nil?USER_SINGLE.default_commerce_id:self.commerceDic[@"commerce_id"],@"commerce_id",@"time",@"order",self.searchTF.text,@"name", nil]:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)self.nPage],@"page",self.commerceDic==nil?USER_SINGLE.default_commerce_id:self.commerceDic[@"commerce_id"],@"commerce_id",self.searchTF.text,@"name",  nil];
    [HTTPREQUEST_SINGLE allUserHeaderPostWithURLString:SH_GET_COMMERCE_MEMBER_LIST parameters:dic withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            NSArray *arr =responseDic[@"data"];
            if (arr.count <= 0&&blockSelf.nPage>1) {
                blockSelf.nPage --;
            }
            [blockSelf.memberListArray addObjectsFromArray:responseDic[@"data"]];
            [blockSelf.tableView reloadData];
            
        }else{
            blockSelf.nPage -- ;
        }
        [blockSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
         blockSelf.nPage -- ;
        [blockSelf.tableView.mj_footer endRefreshing];
    }];
}
-(void)getMemberListData{
    __block MemberListController *blockSelf = self;
    NSDictionary *dic = self.newMember ? [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)self.nPage],@"page",self.commerceDic==nil?USER_SINGLE.default_commerce_id:self.commerceDic[@"commerce_id"],@"commerce_id",@"time",@"order",self.searchTF.text,@"name", nil]:[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)self.nPage],@"page",self.commerceDic==nil?USER_SINGLE.default_commerce_id:self.commerceDic[@"commerce_id"],@"commerce_id",self.searchTF.text, @"name", nil];
    [HTTPREQUEST_SINGLE allUserHeaderPostWithURLString:SH_GET_COMMERCE_MEMBER_LIST parameters:dic withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            
            blockSelf.memberListArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *arr =responseDic[@"data"];
            if (arr.count <= 0&&blockSelf.nPage>1) {
                blockSelf.nPage --;
            }
            [blockSelf.memberListArray addObjectsFromArray:responseDic[@"data"]];
            [blockSelf.tableView reloadData];
        }
        [blockSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [blockSelf.tableView.mj_footer endRefreshing];
    }];
}
//-(void)getMemberAvatarData{
//    NSMutableArray *idsArray = [NSMutableArray arrayWithCapacity:0];
//    for (NSDictionary *dic in self.memberListArray) {
//        [idsArray addObject:dic[@"id"]];
//    }
//    __block MemberListController *blockSelf = self;
//    [HTTPREQUEST_SINGLE allUserHeaderPostWithURLString:SH_GET_MEMBERS_MESSAGE parameters:@{@"ids":idsArray} withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
//        blockSelf.memberAvatarArray = [NSMutableArray arrayWithCapacity:0];
//
//    } failure:^(NSError *error) {
//
//    }];
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memberListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.memberListArray[indexPath.row];
    MemberListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberListCell"];
    [cell.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://app.tianxun168.com/uploads/mem_info/%@/%@.jpg",dic[@"member_id"],dic[@"member_id"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [cell.avatarImage setImage:[UIImage imageNamed:@"default_avatar"]];
        }
    }];
    cell.memberName.text = [dic[@"member_name"] isKindOfClass:[NSNull class]]?@"":dic[@"member_name"];
    cell.memberCompany.text = [dic[@"enterprise_name"] isKindOfClass:[NSNull class]]?@"":dic[@"enterprise_name"];
    cell.memberType.text = [dic[@"enterprise_position"] isKindOfClass:[NSNull class]]?@"":dic[@"enterprise_position"];
    if ([dic[@"role_id"] isKindOfClass:[NSNull class]]) {
        cell.commerceType.text = @" 会员 ";
    }else{
        cell.commerceType.text = self.typeArray[[dic[@"member_post_in_commerce"] integerValue]];
    }
    [cell.commerceType makeCorner:5];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.memberListArray[indexPath.row];
    MemberDetailController *vc = [[UIStoryboard storyboardWithName:@"MineView" bundle:nil] instantiateViewControllerWithIdentifier:@"MemberDetailController"];
    vc.memberDic = dic;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


@end
