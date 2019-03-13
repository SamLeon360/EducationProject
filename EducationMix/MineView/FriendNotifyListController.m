
//
//  FriendNotifyListController.m
//  TXProject
//
//  Created by Sam on 2019/2/26.
//  Copyright © 2019 sam. All rights reserved.
//

#import "FriendNotifyListController.h"
#import "FriendNotifyCell.h"
@interface FriendNotifyListController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *friendArray;

@end

@implementation FriendNotifyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate  = self;
    self.tableView.dataSource = self;
    self.title = @"好友申请列表";
    [self getFriendDataList];
}

-(void)getFriendDataList{
    [HTTPREQUEST_SINGLE postWithURLString:SH_APPLE_FRIENDS parameters:nil withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 0) {
            self.friendArray = responseDic[@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.friendArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendNotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendNotifyCell"];
    NSDictionary *dic = self.friendArray[indexPath.row];
    [cell.avatarIamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://app.tianxun168.com/uploads/mem_info/%@/%@.jpg",dic[@"id"],dic[@"id"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [cell.avatarIamge setImage:[UIImage imageNamed:@"default_avatar"]];
        }
    }];
    cell.descLabel.text = [NSString stringWithFormat:@"%@请求添加您为好友",dic[@"member_name"]];
    cell.timeLabel.text = dic[@"apply_time"];
    [cell.apccetBtn bk_whenTapped:^{
        [HTTPREQUEST_SINGLE postWithURLString:SH_HANDLE_FRIENDS parameters:@{@"handle_type":@"1",@"id":USER_SINGLE.member_id,@"request_id":dic[@"request_id"]} withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
            if ([responseDic[@"code"] integerValue]== -1002) {
                [self getFriendDataList];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    
    return cell;
}

@end
