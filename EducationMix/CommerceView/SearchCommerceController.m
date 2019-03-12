//
//  SearchCommerceController.m
//  TXProject
//
//  Created by Sam on 2019/2/12.
//  Copyright © 2019 sam. All rights reserved.
//

#import "SearchCommerceController.h"
#import "SearchCommerceNameView.h"
#import "SearchCommerceTypeView.h"
#import "HomeCommerceCell.h"
#import "MJRefresh.h"
#import "UploadCommerceControllerController.h"
#import "BottomView.h"
#import "CommerceDetailController.h"
@interface SearchCommerceController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *commerceType;
@property (weak, nonatomic) IBOutlet UILabel *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) SearchCommerceNameView *searchNameView;
@property (nonatomic) SearchCommerceTypeView *searchTypeView;
@property (nonatomic) BottomView *bottomBtn;
@property (nonatomic) NSMutableArray *commerceArray;
@property (nonatomic) NSString *selCommerceType;
@property (nonatomic) NSInteger nPage;
@end

@implementation SearchCommerceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.title = @"社团查询";
    self.nPage = 1;
    self.selCommerceType = @"";
    [self.view addSubview:self.searchNameView];
    [self.view addSubview:self.searchTypeView];
    [self.view addSubview:self.bottomBtn];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 85)];
    self.tableView.tableFooterView = footerView;
    [self.bottomBtn makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.width.equalTo(@188);
        make.bottom.equalTo(@(-40));
        make.centerX.equalTo(@0);
    }];
    [self.searchNameView makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.top.equalTo(@50);
        make.left.right.equalTo(@0);
    }];
    __block SearchCommerceController *blockSelf= self;
    [self.commerceType bk_whenTapped:^{
        
        if (blockSelf.searchTypeView.hidden) {
            blockSelf.searchTypeView.hidden = NO;
            blockSelf.searchNameView.hidden = YES;
        }else{
            blockSelf.searchTypeView.hidden = YES;
        }
    }];
    [self.searchView bk_whenTapped:^{
        if (blockSelf.searchNameView.hidden) {
            blockSelf.searchNameView.hidden = NO;
            blockSelf.searchTypeView.hidden = YES;
        }else{
            blockSelf.searchNameView.hidden = YES;
        }
    }];
    [self getCommerceArray];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getDataArrayByMore)];
    self.tableView.mj_footer = footer;
}
-(void)getCommerceArray{
    __block SearchCommerceController *blockSelf = self;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"affiliated_area",self.searchNameView.searchTF.text,@"commerce_name",self.selCommerceType,@"commerce_type",@"1",@"page",@"",@"ios", nil];
    [HTTPREQUEST_SINGLE postWithURLString:SH_HOME_COMMERCES parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            blockSelf.commerceArray = [NSMutableArray arrayWithCapacity:0];
            blockSelf.commerceArray = responseDic[@"data"];
            [blockSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)getDataArrayByMore{
    self.nPage ++;
    NSString *name =self.searchNameView.searchTF.text.length==0?@"":self.searchNameView.searchTF.text;
    __block SearchCommerceController *blockSelf = self;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"affiliated_area",name,@"commerce_name",self.selCommerceType == nil?@"":self.selCommerceType,@"commerce_type",[NSString stringWithFormat:@"%ld",self.nPage],@"page",@"",@"ios", nil];
    [HTTPREQUEST_SINGLE postWithURLString:SH_HOME_COMMERCES parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 1) {
            [blockSelf.commerceArray addObjectsFromArray:responseDic[@"data"]] ;
            [blockSelf.tableView reloadData];
           
        }else{
            self.nPage --;
        }
         [blockSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        self.nPage -- ;
         [blockSelf.tableView.mj_footer endRefreshing];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.commerceArray[indexPath.row];
    CommerceDetailController *vc = [[UIStoryboard storyboardWithName:@"CommerceView" bundle:nil] instantiateViewControllerWithIdentifier:@"CommerceDetailController"];
    vc.commerceId = [NSString stringWithFormat:@"%ld",[dic[@"commerce_id"] integerValue]];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        HomeCommerceCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HomeCommerceCell"];
        NSDictionary *dic = self.commerceArray[indexPath.row];
        cell.titleLabel.text = dic[@"commerce_name"];
        NSString *commerceType = @"";
        switch ([dic[@"commerce_type"] integerValue]) {
            case 1:{
                commerceType = @"行业协会";
            }break;
            case 2:{
                commerceType = @"综合型商会";
            }break;
            case 3:{
                commerceType = @"地方商会";
            }break;
            case 4:{
                commerceType = @"异地商会";
            }break;
            default:
                break;
        }
        cell.contentLabel.text = commerceType;
        cell.cityLabel.text = [NSString stringWithFormat:@"  %@",dic[@"commerce_location"]];
        cell.numberLabel.text = [NSString stringWithFormat:@"%@名会员",dic[@"ct"]];
        [cell.cellView makeCorner:5];
        if ([dic[@"commerce_logo"] isKindOfClass:[NSNull class]]) {
            [cell.commerceImage setImage:[UIImage imageNamed:@"default_avatar"]];
        }else{
            [cell.commerceImage sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,dic[@"commerce_logo"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [cell.commerceImage setImage:[UIImage imageNamed:@"default_avatar"]];
                }
            }];
        }
        
        return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 95;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commerceArray.count;
}

-(SearchCommerceNameView *)searchNameView{
    if (_searchNameView == nil) {
        _searchNameView = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][5];
        _searchNameView.frame = CGRectMake(0, 50, ScreenW, 50);
        __block SearchCommerceController *blockSelf = self;
        [_searchNameView.searchBtn bk_whenTapped:^{
            [blockSelf getCommerceArray];
            blockSelf.searchNameView.hidden = YES;
        }];
        _searchNameView.hidden = YES;
    }
    
    return _searchNameView;
}
-(SearchCommerceTypeView *)searchTypeView{
    if (_searchTypeView == nil) {
        _searchTypeView = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][4];
        _searchTypeView.frame = CGRectMake(0, 50, ScreenW, 200);
        __block SearchCommerceController *blockSelf = self;
        [_searchTypeView.allView bk_whenTapped:^{
            blockSelf.selCommerceType = @"";
            [blockSelf resetLabelColor];
            blockSelf.searchTypeView.allLabel.textColor = [UIColor colorWithRGB:0x00bfff];
            [blockSelf getCommerceArray];
            blockSelf.searchTypeView.hidden = YES;
        }];
        [_searchTypeView.oneView bk_whenTapped:^{
            blockSelf.selCommerceType = @"1";
            [blockSelf resetLabelColor];
            blockSelf.searchTypeView.oneLabel.textColor = [UIColor colorWithRGB:0x00bfff];
            [blockSelf getCommerceArray];
            blockSelf.searchTypeView.hidden = YES;
        }];
        [_searchTypeView.twoView bk_whenTapped:^{
            blockSelf.selCommerceType = @"2";
            [blockSelf resetLabelColor];
            blockSelf.searchTypeView.twoLabel.textColor = [UIColor colorWithRGB:0x00bfff];
            [blockSelf getCommerceArray];
            blockSelf.searchTypeView.hidden = YES;
        }];
        [_searchTypeView.threeView bk_whenTapped:^{
            blockSelf.selCommerceType = @"3";
            [blockSelf resetLabelColor];
            blockSelf.searchTypeView.threeLabel.textColor = [UIColor colorWithRGB:0x00bfff];
            [blockSelf getCommerceArray];
            blockSelf.searchTypeView.hidden = YES;
        }];
        [_searchTypeView.fourView bk_whenTapped:^{
            blockSelf.selCommerceType = @"4";
            [blockSelf resetLabelColor];
            blockSelf.searchTypeView.fourLabel.textColor = [UIColor colorWithRGB:0x00bfff];
            [blockSelf getCommerceArray];
            blockSelf.searchTypeView.hidden = YES;
        }];
        _searchTypeView.hidden = YES;
    }
    
    return _searchTypeView;
}
-(void)resetLabelColor{
    self.searchTypeView.oneLabel.textColor = [UIColor blackColor];
    self.searchTypeView.twoLabel.textColor = [UIColor blackColor];
    self.searchTypeView.threeLabel.textColor = [UIColor blackColor];
    self.searchTypeView.fourLabel.textColor = [UIColor blackColor];
    self.searchTypeView.allLabel.textColor = [UIColor blackColor];
}
-(BottomView *)bottomBtn{
    if (_bottomBtn == nil) {
        _bottomBtn = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][6];
        __block SearchCommerceController *blockSelf = self;
        [_bottomBtn makeCorner:45/2];
        [_bottomBtn bk_whenTapped:^{
            UploadCommerceControllerController *vc = [[UIStoryboard storyboardWithName:@"CommerceView" bundle:nil] instantiateViewControllerWithIdentifier:@"UploadCommerceControllerController"];
            [blockSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _bottomBtn;
}

@end
