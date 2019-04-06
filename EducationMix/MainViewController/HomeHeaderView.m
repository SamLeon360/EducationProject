//
//  HomeHeaderView.m
//  EducationMix
//
//  Created by Sam on 2019/3/12.
//  Copyright © 2019 sam. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeNewPostCell.h"
@interface HomeHeaderView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic) int index;
@end

@implementation HomeHeaderView
-(void)setupTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewPostCell" bundle:nil] forCellReuseIdentifier:@"HomeNewPostCell"];
  self.index = 0;
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(3 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);

    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.index < self.postArray.count) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }else{
            self.index = 0;
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        self.index++;

    });

    // 启动定时器
    dispatch_resume(self.timer);
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.postArray[indexPath.row];
    NSString *content = dic[@"technology_name"];
    
    NSLog(content);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.postArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeNewPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewPostCell"];
    NSDictionary *dic = self.postArray[indexPath.row];
    cell.titleLabel.text = dic[@"technology_name"];
    cell.moneyLabel.text = [NSString stringWithFormat:@"%d万元",[dic[@"budget_money"] intValue]];
    return cell;
}
@end
