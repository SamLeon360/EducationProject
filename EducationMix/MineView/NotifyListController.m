//
//  NotifyListController.m
//  TXProject
//
//  Created by Sam on 2019/2/26.
//  Copyright © 2019 sam. All rights reserved.
//

#import "NotifyListController.h"
#import "NotifyListCell.h"
#import "FriendNotifyListController.h"
@interface NotifyListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *notifyDicArray;
@end

@implementation NotifyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.notifyDicArray = @[@{@"image":@"notify_1",@"name":@"好友申请"}];
    self.title = @"消息列表";
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notifyDicArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotifyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotifyListCell"];
    NSDictionary *dic = self.notifyDicArray[indexPath.row];
    [cell.notifyImage setImage: [UIImage imageNamed:dic[@"image"]]];
    cell.cellName.text = dic[@"name"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FriendNotifyListController *vc = [[UIStoryboard storyboardWithName:@"Entrepreneurial" bundle:nil] instantiateViewControllerWithIdentifier:@"FriendNotifyListController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
