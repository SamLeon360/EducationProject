//
//  EduMeViewController.m
//  EducationMix
//
//  Created by Sam on 2019/3/13.
//  Copyright © 2019 sam. All rights reserved.
//

#import "EduMeViewController.h"
#import "EduStuTeaHeader.h"
#import "EduSchoolHeader.h"
#import "EduMineCell.h"
@interface EduMeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSInteger typeIndex; ///1--学生,2--老师,3--院校
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) EduStuTeaHeader *eduStuTeaHeader;
@property (nonatomic) EduSchoolHeader *eduSchoolHeader;

@property (nonatomic) NSArray *cellTitleArray;
@property (nonatomic) NSString *urlString ;
@property (nonatomic) NSDictionary *param;
@property (nonatomic) NSDictionary *detailDic;
@end

@implementation EduMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSLog(@"%@",USER_SINGLE.token);
    if ([USER_SINGLE.role_type isEqualToString:@"8"]) {
        self.urlString  = SH_SCHOOL_DETAIL;
        self.typeIndex = 3;
        self.param = [[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.academy_id,@"academy_id", nil];
    }else if ([USER_SINGLE.role_type isEqualToString:@"12"]){
        self.urlString = SH_STUDENT_DETAIL;
        self.typeIndex = 1;
        self.param = [[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.member_id,@"member_id", nil];
    }else{
        self.urlString = SH_TEACHER_DETAIL;
        self.typeIndex = 2;
        self.param = [[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.member_id,@"id", nil];
    }
    NSArray *typeString = @[@"编辑学生资料",@"编辑教授资料",@"编辑院校资料"];
    self.cellTitleArray = @[self.typeIndex == 1?@[@"我的消息"]:@[@"我的发布",@"我的消息"],@[@"账号信息",typeString[self.typeIndex-1],@"软件设置"]];
    [self GetDetail];
    self.tableView.tableFooterView = [[UIView alloc] init];
}
-(void)GetDetail{
    [HTTPREQUEST_SINGLE postWithURLString:self.urlString parameters:self.param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 0) {
            self.detailDic = responseDic[@"data"];
            if ([USER_SINGLE.role_type isEqualToString:@"8"]) {
                self.tableView.tableHeaderView = self.eduSchoolHeader;
            }else{
                self.tableView.tableHeaderView = self.eduStuTeaHeader;
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.typeIndex==3||self.typeIndex==2?2:1;
    }else{
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.typeIndex == 3?60:50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    [view setBackgroundColor:[UIColor colorWithRGB:0xE5E5E5]];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EduMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EduMineCell"];
    NSArray *arr = self.cellTitleArray[indexPath.section];
    cell.cellTitleLabel.text = arr[indexPath.row];
    return cell;
}

-(EduSchoolHeader *)eduSchoolHeader{
    if (_eduSchoolHeader == nil) {
        _eduSchoolHeader = [[NSBundle mainBundle] loadNibNamed:@"HomeXib" owner:self options:nil][2];
        _eduSchoolHeader.schoolName.text = self.detailDic[@"academy_name"];
        [_eduSchoolHeader.schoolImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,self.detailDic[@"academy_logo"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                [self->_eduSchoolHeader.schoolImage setImage:[UIImage imageNamed:@"school_default_icon"]];
            }
        }];
    }
    return _eduSchoolHeader;
}
-(EduStuTeaHeader *)eduStuTeaHeader{
    if (_eduStuTeaHeader) {
        _eduStuTeaHeader = [[NSBundle mainBundle] loadNibNamed:@"HomeXib" owner:self options:nil][3];
        [_eduStuTeaHeader.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,self.detailDic[@"photo"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (error) {
                [self->_eduStuTeaHeader.avatarImage setImage:[UIImage imageNamed:self.typeIndex==2?@"teacher_default_icon":@"studen_default_icon"]];
            }
        }];
        _eduStuTeaHeader.nameLabel.text = self.typeIndex==2?self.detailDic[@"expert_name"]:self.detailDic[@"student_name"];
        _eduStuTeaHeader.typeLabel.text = self.typeIndex == 2?@" 教授 ":@" 学生 ";
        _eduStuTeaHeader.subjectLabel.text = self.typeIndex==2?self.detailDic[@"major"]:self.detailDic[@"major_field"];
        _eduStuTeaHeader.sexLabel.text = [self.detailDic[@"sex"] integerValue] == 1?@"性别：男":@"性别：女";
    }
    return _eduStuTeaHeader;
}
@end
