//
//  GetAreaView.m
//  TXProject
//
//  Created by Sam on 2019/4/9.
//  Copyright © 2019 sam. All rights reserved.
//

#import "GetAreaView.h"
#import "AreaStringCell.h"
@interface GetAreaView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) NSDictionary *areaDic;


@end
@implementation GetAreaView
-(void)setupTableView{
    self.cityTable.delegate = self;
    self.cityTable.dataSource = self;
    self.provinceTable.delegate = self;
    self.provinceTable.dataSource = self;
    self.selectProvince = @"福建";
    [self.cityTable registerNib:[UINib nibWithNibName:@"AreaStringCell" bundle:nil] forCellReuseIdentifier:@"AreaStringCell"];
    [self.provinceTable registerNib:[UINib nibWithNibName:@"AreaStringCell" bundle:nil] forCellReuseIdentifier:@"AreaStringCell"];
    [self GetAreaData];
}
-(void)GetAreaData{
    [HTTPREQUEST_SINGLE postWithURLString:SH_NEW_GET_AREA parameters:nil withHub:NO withCache:NO success:^(NSDictionary *responseDic) {
        self.areaDic = responseDic;
        [self.provinceTable reloadData];
        [self.cityTable reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.provinceTable) {
        return self.areaDic.allKeys.count;
    }else{
        NSArray *arr = self.areaDic[self.selectProvince];
        return arr.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AreaStringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaStringCell"];
    
    if (tableView == self.provinceTable) {
         cell.cellString.text = self.areaDic.allKeys[indexPath.row];
        if ([self.selectProvince isEqualToString:cell.cellString.text]) {
            cell.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
        [cell.cellString bk_whenTapped:^{
            NSIndexPath *indexP = [self.provinceTable indexPathForCell:cell];
              self.selectProvince = self.areaDic.allKeys[indexP.row];
            [self.cityTable reloadData];
            [self.provinceTable reloadData];
        }];
       
        return cell;
    }else{
        NSArray *arr = self.areaDic[self.selectProvince];
        cell.cellString.text = arr[indexPath.row];
        [cell.cellString bk_whenTapped:^{
            NSIndexPath *indexP = [self.cityTable indexPathForCell:cell];
            NSArray *arr = self.areaDic[self.selectProvince];
            self.selecCity = arr[indexP.row];
            [self.cityTable reloadData];
            [self.provinceTable reloadData];
        }];
        if ([self.selecCity isEqualToString:cell.cellString.text]) {
            cell.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    }
}
@end
