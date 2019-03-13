//
//  FriendListController.m
//  TXProject
//
//  Created by Sam on 2019/2/26.
//  Copyright © 2019 sam. All rights reserved.
//

#import "FriendListController.h"
#import "FriendListCell.h"
#import "MemberDetailController.h"
@interface FriendListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *friendsList;
@end

@implementation FriendListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"好友列表";
    [self GetFriendsListData];
}
-(void)GetFriendsListData{
    self.friendsList = [NSMutableArray arrayWithCapacity:0];
    [HTTPREQUEST_SINGLE postWithURLString:SH_FRIEND_LIST parameters:nil withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 0) {
            self.friendsList = [NSMutableArray arrayWithArray:responseDic[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendsList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendListCell"];
    NSDictionary *dic = self.friendsList[indexPath.row];
    [cell.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://app.tianxun168.com/uploads/mem_info/%@/%@.jpg",dic[@"friend_id"],dic[@"friend_id"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [cell.avatarImage setImage:[UIImage imageNamed:@"default_avatar"]];
        }
    }];
    cell.name.text = dic[@"member_name"];
    cell.companyName.text = dic[@"default_enterprise_name"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        NSDictionary *dic = self.friendsList[indexPath.row];
            MemberDetailController *vc = [[UIStoryboard storyboardWithName:@"MineView" bundle:nil] instantiateViewControllerWithIdentifier:@"MemberDetailController"];
            vc.memberDic = @{@"member_id":dic[@"friend_id"],@"commerce_id":USER_SINGLE.default_commerce_id};
            [self.navigationController pushViewController:vc animated:YES];
}
@end
