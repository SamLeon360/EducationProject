//
//  EduMainViewController.m
//  EducationMix
//
//  Created by Sam on 2019/3/13.
//  Copyright © 2019 sam. All rights reserved.
//

#import "EduMainViewController.h"
#import "EduStuTeaHeader.h"
#import "EduSchoolHeader.h"
#import "EduMineCell.h"
@interface EduMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) NSInteger typeIndex; ///1--学生,2--老师,3--院校
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) EduStuTeaHeader *eduStuTeaHeader;
@property (nonatomic) EduSchoolHeader *eduSchoolHeader;

@property (nonatomic) NSArray *cellTitleArray;
@end

@implementation EduMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSArray *typeString = @[@"编辑学生资料",@"编辑教授资料",@"编辑院校资料"];
    self.cellTitleArray = @[self.typeIndex == 1?@[@"我的消息"]:@[@"我的发布",@"我的消息"],@[@"账号信息",typeString[self.typeIndex-1],@"软件设置"]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.typeIndex == 3?2:1;
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
    }
    return _eduSchoolHeader;
}
-(EduStuTeaHeader *)eduStuTeaHeader{
    if (_eduStuTeaHeader) {
        _eduStuTeaHeader = [[NSBundle mainBundle] loadNibNamed:@"HomeXib" owner:self options:nil][3];
    }
    return _eduStuTeaHeader;
}
@end
