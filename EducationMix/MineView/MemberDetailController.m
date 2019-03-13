//
//  MemberDetailController.m
//  TXProject
//
//  Created by Sam on 2019/2/25.
//  Copyright © 2019 sam. All rights reserved.
//

#import "MemberDetailController.h"
#import "MemberDetailAvatarCell.h"
#import "MemberOtherMessageCell.h"
#import "CompanyListCell.h"
#import "MemberIntroduceCell.h"
#import "MemberHeaderSection.h"

@interface MemberDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *chatView;
@property (nonatomic) NSMutableArray  *companyArray;
@property (nonatomic) NSArray *dataKeyArray;
@property (nonatomic) NSArray *dataTitleArray;
@property (nonatomic) NSString  *momentNumber;
@property (nonatomic) NSArray *companyTypeArray;
@property (nonatomic) NSMutableDictionary *memberDetailDic;
@property (nonatomic) NSString *introductionString;
@property (nonatomic) BOOL has_add;

@end

@implementation MemberDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = self.wayIn == nil ? @"会员风采" : self.memberDic[@"member_name"];
    self.dataTitleArray = SHOW_WEB ? @[@[@"",@"商会",@"手机",@"籍贯"],@[@"他的动态"],@[@""],@[@"政治面貌",@"毕业院校",@"从军经历",@"特长爱好",@"个人收件地址"]]: @[@[@"",@"商会",@"籍贯"],@[@"他的动态"],@[@""],@[@"毕业院校",@"特长爱好",@"个人收件地址"]];
    self.companyTypeArray = @[@"全部",@"电子信息",@"装备制造", @"能源环保",@"生物技术与医药",@"新材料",@"现代农药", @"其他"];
    [self GetCompanyData];
    [self getMemberData];
    __block MemberDetailController *blockSelf = self;
    [self.chatView bk_whenTapped:^{
        RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = [NSString stringWithFormat:@"%@",blockSelf.memberDic[@"member_id"]];
        conversationVC.title = blockSelf.memberDic[@"member_name"];
        [blockSelf.navigationController pushViewController:conversationVC animated:YES];
    }];
}
-(void)GetCompanyData{
    __block MemberDetailController *blockSelf = self;
    [HTTPREQUEST_SINGLE postWithURLString:SH_COMPANY_LIST parameters:@{@"member_id":self.memberDic[@"member_id"]} withHub:NO withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue]== 0) {
            blockSelf.companyArray = responseDic[@"data"];
            [blockSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    [HTTPREQUEST_SINGLE postWithURLString:SH_MOMENTS_DATA parameters:@{@"member_id":self.memberDic[@"member_id"]} withHub:NO withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 0) {
            blockSelf.momentNumber = [NSString stringWithFormat:@"%@",responseDic[@"data"]];
            [blockSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getMemberData{
    self.memberDetailDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSDictionary *param =@{@"commerce_id":USER_SINGLE.default_commerce_id,@"member_id":self.memberDic[@"member_id"]};
    __block MemberDetailController *blockSelf = self;
    [HTTPREQUEST_SINGLE postWithURLString:SH_MEMBER_DETAIL parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            [blockSelf.memberDetailDic setDictionary:responseDic[@"data"]];
            [blockSelf.memberDetailDic setObject:responseDic[@"add"][@"phone"] forKey:@"phone"];
            blockSelf.has_add = responseDic[@"add"][@"has_add"];
            blockSelf.introductionString = blockSelf.memberDetailDic[@"member_introduction"];
            blockSelf.dataKeyArray = SHOW_WEB?@[@[@"",@"default_commerce_name",@"phone",@"member_native_place"],@[@""],@[@"member_introduction"],@[@"member_political_status",@"member_graduation_school",@"military_experience",@"member_hobby",@"detail_address"]]:@[@[@"",@"default_commerce_name",@"member_native_place"],@[@""],@[@"member_introduction"],@[@"member_graduation_school",@"member_hobby",@"detail_address"]];;
            [blockSelf.tableView reloadData];
        }else{
            [AlertView showYMAlertView:blockSelf.view andtitle: [NSString stringWithFormat:@"%@",responseDic[@"message"]]];
        }
    } failure:^(NSError *error) {
        [AlertView showYMAlertView:blockSelf.view andtitle:@"网络异常，请检查网络"];
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 107;
        }else{
            return 45;
        }
    }else if (indexPath.section == 1||indexPath.section == 3){
        return 45;
    }else if (indexPath.section == 2){
        return [self getHeightLineWithString:[self.introductionString isKindOfClass:[NSNull class]]?@"":self.introductionString withWidth:ScreenW-25 withFont:[UIFont systemFontOfSize:14]]+20;
    }else{
        return 100;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.companyArray.count > 0) {
         return 5;
    }else{
        return 4;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return SHOW_WEB?4: 3;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return SHOW_WEB?5:3;
    }else{
        return self.companyArray.count;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        MemberHeaderSection *view = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderSection" owner:self options:nil][0];
        view.titleLabel.text = @"个人介绍";
        return view;
    }else if (section == 4){
        MemberHeaderSection *view = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderSection" owner:self options:nil][0];
        view.titleLabel.text = @"企业信息";
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 5)];
        [view setBackgroundColor:[UIColor colorWithRGB:0xededed]];
        return view;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2||section == 4) {
        return 46;
    }else{
        return 5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MemberDetailAvatarCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:@"MemberDetailAvatarCell"];
            [avatarCell.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,self.memberDetailDic[@"member_avatar"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [avatarCell.avatarImage setImage:[UIImage imageNamed:@"default_avatar"]];
                }
            }];
            avatarCell.addFriendBtn.hidden = self.wayIn == nil ? NO:YES;
            avatarCell.jobLabel.text = @"总经理";
            avatarCell.namelabe.text = self.memberDetailDic[@"member_name"];
            avatarCell.companyName.text = [self.memberDetailDic[@"enterprise_name"] isKindOfClass:[NSNull class]]?@"":self.memberDetailDic[@"enterprise_name"];
            if (self.has_add) {
                [avatarCell.addFriendBtn setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [avatarCell.addFriendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [avatarCell.addFriendBtn setTitle:@"删除好友" forState:UIControlStateNormal];
            }
            [avatarCell.addFriendBtn bk_whenTapped:^{
                if (self.has_add) {
                    NSDictionary *param = @{@"delete_id":self.memberDic[@"member_id"]};
                    [HTTPREQUEST_SINGLE postWithURLString:SH_DELETE_FRIENDS parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
                        if ([responseDic[@"code"] integerValue] == 0) {
                            [AlertView showYMAlertView:self.view andtitle:@"删除好友成功"];
                            
                        }
                    } failure:^(NSError *error) {
                        
                    }];
                }else{
                    NSDictionary *param = @{@"add_member_id":self.memberDic[@"member_id"],@"apply_desc":@""};
                    [HTTPREQUEST_SINGLE postWithURLString:SH_ADD_FRIENDS parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
                        if ([responseDic[@"code"] integerValue] == 0) {
                            [AlertView showYMAlertView:self.view andtitle:@"添加成功"];
                            
                        }
                    } failure:^(NSError *error) {
                        
                    }];
                }
            }];
            return avatarCell;
        }else {
            MemberOtherMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberOtherMessageCell"];
            NSArray *keyArray = self.dataKeyArray[indexPath.section];
            NSArray *titleArray = self.dataTitleArray[indexPath.section];
            cell.titleLabel.text = titleArray[indexPath.row];
            cell.contentLabel.text = self.memberDetailDic[keyArray[indexPath.row]];
            if (indexPath.row == 1) {
                cell.commerceJobLabel.hidden = YES;
            }else{
                cell.commerceJobLabel.hidden = YES;
            }
            [cell.leftImage setImage:[UIImage imageNamed:@"IOS_Phone_Blue"]];
            cell.leftImage.hidden = indexPath.row == 2?NO:YES;
            return cell;
        }
    } else if (indexPath.section == 1){
        MemberOtherMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberOtherMessageCell"];
         cell.commerceJobLabel.hidden = YES;
        NSArray *titleArray = self.dataTitleArray[indexPath.section];
        cell.titleLabel.text = titleArray[indexPath.row];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@条",self.momentNumber];
        return cell;
    }else if(indexPath.section == 2){
        MemberIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberIntroduceCell"];
        cell.introLabel.text = [self.memberDetailDic[@"member_introduction"] isKindOfClass:[NSNull class]]?@"":self.memberDetailDic[@"member_introduction"];
        return cell;
    }else if (indexPath.section == 3){
        MemberOtherMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberOtherMessageCell"];
         cell.commerceJobLabel.hidden = YES;
        NSArray *titleArray = self.dataTitleArray[indexPath.section];
        NSArray *keyArray = self.dataKeyArray[indexPath.section];
        cell.titleLabel.text  = titleArray[indexPath.row];
        cell.contentLabel.text = [self.memberDetailDic[keyArray[indexPath.row]] isKindOfClass:[NSNull class]]?@"":self.memberDetailDic[keyArray[indexPath.row]];
        return cell;
    }else{
        CompanyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyListCell"];
        cell.selectDefualtBtn.hidden = YES;
        NSDictionary *dic = self.companyArray[indexPath.row];
        [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,dic[@"enterprise_logo"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                [cell.companyImage setImage:[UIImage imageNamed:@"default_avatar"]];
            }
        }];
        cell.companyNameLabel.text = [dic[@"enterprise_name"] isKindOfClass:[NSNull class]]?@"":dic[@"enterprise_name"];
        cell.companyTypeCell.text = self.companyTypeArray[[dic[@"domain"] integerValue]];
        cell.companyAddressLabel.text = [dic[@"area"] isKindOfClass:[NSNull class]]?@"":dic[@"area"];
     
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.memberDetailDic[@"phone"]];
            UIWebView * callWebview = [[UIWebView alloc] init];[callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
    }
}

- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    
    return height;
    
}
@end
