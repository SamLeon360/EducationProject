//
//  CommerceDetailController.m
//  TXProject
//
//  Created by Sam on 2019/1/14.
//  Copyright © 2019 sam. All rights reserved.
//

#import "CommerceDetailController.h"
#import "commerceDetailSection.h"
#import "commerceDetailHeader.h"
#import "CommerceDetailCell.h"
#import "CommerceDetailFooter.h"
#import "TXWebViewController.h"
#import "MemberListController.h"
#import "AddCommerceController.h"
@interface CommerceDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) commerceDetailHeader *commerceHeader;
@property (nonatomic) CommerceDetailFooter *commerceFooter;
@property (nonatomic) NSArray *sectionTitleArray;
@property (nonatomic) NSArray *connectArray;
@property (nonatomic) NSDictionary *commerceDic;
@property (nonatomic) NSArray *connectMessageArray;
@property (nonatomic) NSDictionary *commerceFooterMsg;
@end

@implementation CommerceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社团详情";
    self.sectionTitleArray = @[@"社团简介",@"社团主要负责人",@"秘书处介绍",@"入会条件",@"联系信息"];
    self.connectArray = @[@{@"会长：":@"commerce_president"},@{@"执行会长：":@"executive_president"},@{@"监事长：":@"supervisor"},@{@"秘书处：":@"commerce_secretary_general"}];
    self.connectMessageArray = @[@{@"社团电话：":@"commerce_phone"},@{@"传真：":@"commerce_fax"},@{@"联系人：":@"contact"},@{@"联系人手机：":@"contact_phone"},@{@"电子邮箱：":@"email"},@{@"社团办公地址：":@"site"}];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSString *commerceId = @"";
    if (self.commerceId == nil) {
        commerceId = USER_SINGLE.default_commerce_id;
    }else{
        commerceId = self.commerceId;
    }
    __block CommerceDetailController *blockSelf = self;
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:commerceId,@"commerce_id",nil];
    [HTTPREQUEST_SINGLE allUserHeaderPostWithURLString:COMMERCE_DETAIL parameters:dic withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
            if ([responseDic[@"code"] integerValue] == 1) {
                blockSelf.commerceDic = responseDic[@"data"][0];
                blockSelf.commerceFooterMsg = responseDic[@"add"];
                blockSelf.tableView.tableHeaderView = blockSelf.commerceHeader;
                blockSelf.tableView.tableFooterView = blockSelf.commerceFooter;
                [blockSelf.tableView reloadData];
            }
        } failure:^(NSError *error) {
                                          
        }];
    
//    if (SHOW_WEB&&self.commerceId!=nil) {
//        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        editBtn.frame = CGRectMake(0, 0, 20, 20);
//        [editBtn setBackgroundImage:[UIImage imageNamed:@"edit_icon"] forState:UIControlStateNormal];
//        [editBtn addTarget:self action:@selector(clickToEdit) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editBtn];
//        self.navigationItem.rightBarButtonItem = rightItem;
//    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)clickToEdit{
    TXWebViewController *vc = [[UIStoryboard storyboardWithName:@"HomePage" bundle:nil] instantiateViewControllerWithIdentifier:@"TXWebViewController"];
    vc.webUrl = [NSString stringWithFormat:@"%@member/edit_platform/%@/1",WEB_HOST_URL,self.commerceDic[@"commerce_id"]];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitleArray.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    commerceDetailSection *sectionView = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][1];
    sectionView.titleLabel.text = self.sectionTitleArray[section];
    return sectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [CustomFountion getHeightLineWithString:self.commerceDic[@"commerce_introduction"] withWidth:ScreenW-10 withFont:[UIFont systemFontOfSize:13]] ;
    }else if (indexPath.section == 1){
        return 45;
    }else if (indexPath.section == 2){
        return [CustomFountion getHeightLineWithString:self.commerceDic[@"secretariat_introduction"] withWidth:ScreenW-10 withFont:[UIFont systemFontOfSize:13]] ;
    }else if (indexPath.section == 3){
        return [CustomFountion getHeightLineWithString:self.commerceDic[@"membership_conditions"] withWidth:ScreenW-10 withFont:[UIFont systemFontOfSize:13]] ;
    }else{
        return 45;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 6;
            break;
        default:
            return 0;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommerceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommerceDetailCell"];
    if (indexPath.section == 0&&indexPath.row == 0 ) {
        cell.cellContent.hidden = YES;
        cell.titleLabel.hidden = YES;
        cell.contentLabel.hidden = NO;
        cell.contentLabel.text = self.commerceDic[@"commerce_introduction"];
    }else if (indexPath.section == 1){
        cell.contentLabel.hidden = YES;
        cell.cellContent.hidden = NO;
        cell.titleLabel.hidden = NO;
        NSDictionary *dic =  self.connectArray[indexPath.row];
        cell.titleLabel.text = dic.allKeys[0];
        cell.cellContent.text = self.commerceDic[dic[dic.allKeys[0]]];
    }else if(indexPath.section == 2&&indexPath.row == 0){
        cell.cellContent.hidden = YES;
        cell.contentLabel.hidden = NO;
        cell.titleLabel.hidden = YES;
        cell.contentLabel.text = self.commerceDic[@"secretariat_introduction"];
        
    }else if (indexPath.section == 3){
        cell.cellContent.hidden = YES;
        cell.contentLabel.hidden = NO;
        cell.titleLabel.hidden = YES;
        cell.contentLabel.text = self.commerceDic[@"membership_conditions"];
    }else{
        cell.contentLabel.hidden = YES;
        cell.cellContent.hidden = NO;
        cell.titleLabel.hidden = NO;
        NSDictionary *dic =  self.connectMessageArray[indexPath.row];
        cell.titleLabel.text = dic.allKeys[0];
        cell.cellContent.text = self.commerceDic[dic[dic.allKeys[0]]];
    }
    return cell;
}


-(commerceDetailHeader *)commerceHeader{
    if (!_commerceHeader) {
        _commerceHeader = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][2];
        [_commerceHeader.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,self.commerceDic[@"commerce_logo"]]]];
        [_commerceHeader.avatarImage makeCorner:_commerceHeader.avatarImage.frame.size.height/2];
        _commerceHeader.commerceName.text = self.commerceDic[@"commerce_name"];
    }
    return _commerceHeader;
}
-(CommerceDetailFooter *)commerceFooter{
    if (!_commerceFooter) {
        _commerceFooter = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][3];
        [_commerceFooter.bigBtn makeCorner:5];
        [_commerceFooter.historyBtn makeCorner:5];
        if (![[NSString stringWithFormat:@"%@",USER_SINGLE.default_commerce_id] isEqualToString:self.commerceId]) {
            _commerceFooter.bigBtn.hidden = YES;
            _commerceFooter.historyBtn.hidden  = YES;
           [_commerceFooter.footerBtn setTitle:@"申请入会" forState:UIControlStateNormal];
           
        }else{
            [_commerceFooter.footerBtn setTitle:[NSString stringWithFormat:@"查看全部成员（%@）",self.commerceFooterMsg[@"ct"]] forState:UIControlStateNormal];
        }
        [_commerceFooter.bigBtn bk_whenTapped:^{
            if (!(SHOW_WEB)) {
                return ;
            }
            TXWebViewController *vc = [[UIStoryboard storyboardWithName:@"HomePage" bundle:nil] instantiateViewControllerWithIdentifier:@"TXWebViewController"];
            vc.webUrl = [NSString stringWithFormat:@"%@scommerce/event/%@/1/1",WEB_HOST_URL,self.commerceDic[@"commerce_id"]];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [_commerceFooter.historyBtn bk_whenTapped:^{
            if (!(SHOW_WEB)) {
                return ;
            }
            TXWebViewController *vc = [[UIStoryboard storyboardWithName:@"HomePage" bundle:nil] instantiateViewControllerWithIdentifier:@"TXWebViewController"];
            vc.webUrl = [NSString stringWithFormat:@"%@commerce/event/%@/2/1",WEB_HOST_URL,self.commerceDic[@"commerce_id"]];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [_commerceFooter.footerBtn bk_whenTapped:^{
            if ([self->_commerceFooter.footerBtn.titleLabel.text isEqualToString:@"申请入会"]) {
                AddCommerceController *vc = [[UIStoryboard storyboardWithName:@"CommerceView" bundle:nil] instantiateViewControllerWithIdentifier:@"AddCommerceController"];
                vc.commerceDic =  self.commerceDic;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
            MemberListController *vc = [[UIStoryboard storyboardWithName:@"MemberList" bundle:nil] instantiateViewControllerWithIdentifier:@"MemberListController"];
            vc.checkMember = YES;
            vc.commerceDic = self.commerceDic;
            [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
    }
    return _commerceFooter;
}

@end
