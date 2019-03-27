//
//  TSINSTMsgViewController.m
//  EducationMix
//
//  Created by Taosky on 2019/3/16.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import "TSINSTMsgViewController.h"
#import "JQHeaderView.h"
#import "SDCycleScrollView.h"
#import "JQRefreshHeaader.h"
#import "UIButton+Size.h"

#import "TSInstitutionDetailViewController.h"
#import "TSInstitutionStudentViewController.h"
#import "TSInstitutionTeacherViewController.h"
#import "TSInstitutionMsgBoardViewController.h"


#define CATEGORY  @[@"院校信息",@"专家教授",@"优秀学生"]

#define NAVBARHEIGHT 64.0f

#define FONTMAX 15.0
#define FONTMIN 14.0
#define PADDING 15.0


@interface TSINSTMsgViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *currentTableView;

@property (nonatomic, strong) JQHeaderView *jqHeaderView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

///
//滑动事件相关
///
@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) UIImageView *currentSelectedItemImageView;
@property (nonatomic, strong) UIScrollView *bottomScrollView;

//存放button
@property(nonatomic,strong)NSMutableArray *titleButtons;
//记录上一个button
@property (nonatomic, strong) UIButton *previousButton;
//存放控制器
@property(nonatomic,strong)NSMutableArray *controlleres;


//存放TableView
@property(nonatomic,strong)NSMutableArray *tableViews;

//记录上一个偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;
@end

@implementation TSINSTMsgViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

        //[self.view addSubview:self.jqHeaderView];
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.titleButtons = [[NSMutableArray alloc] initWithCapacity:CATEGORY.count];
    self.controlleres = [[NSMutableArray alloc] initWithCapacity:CATEGORY.count];
    self.tableViews = [[NSMutableArray alloc] initWithCapacity:CATEGORY.count];
    
    [self.view addSubview:self.bottomScrollView];
    self.jqHeaderView.tableViews = [NSMutableArray arrayWithArray:self.tableViews];
    
    [self.view addSubview:self.cycleScrollView];
    [self.view addSubview:self.segmentScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // Do any additional setup after loading the view.
}


#pragma observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([object isEqual:[NSNull null]]) {
        
        return;
    }
    
    UITableView *tableView = (UITableView *)object;
    
    if (!(self.currentTableView == tableView) ) {
        return;
    }
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    
    CGFloat tableViewoffsetY = tableView.contentOffset.y;
    
    self.lastTableViewOffsetY = tableViewoffsetY;
    
    if ( tableViewoffsetY>=0 && tableViewoffsetY<=136) {
        
        self.segmentScrollView.frame = CGRectMake(0, 200-tableViewoffsetY, SCREEN_WIDTH, 40);
        self.cycleScrollView.frame = CGRectMake(0, 0-tableViewoffsetY, SCREEN_WIDTH, 200);
        
    }else if( tableViewoffsetY < 0){
        
        self.segmentScrollView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 40);
        self.cycleScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        
    }else if (tableViewoffsetY > 136){
        
        self.segmentScrollView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        self.cycleScrollView.frame = CGRectMake(0, -136, SCREEN_WIDTH, 200);
    }
}



#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView !=self.bottomScrollView) {
        return ;
    }
    
    int index =  scrollView.contentOffset.x/scrollView.frame.size.width;
    
    UIButton *currentButton = self.titleButtons[index];
    //     for (UIButton *button in self.titleButtons) {
    //         button.selected = NO;
    //     }
    _previousButton.selected = NO;
    currentButton.selected = YES;
    _previousButton = currentButton;
    
    
    self.currentTableView  = self.tableViews[index];
    for (UITableView *tableView in self.tableViews) {
        
        if ( self.lastTableViewOffsetY>=0 &&  self.lastTableViewOffsetY<=136) {
            
            tableView.contentOffset = CGPointMake(0,  self.lastTableViewOffsetY);
            
        }else if(  self.lastTableViewOffsetY < 0){
            
            tableView.contentOffset = CGPointMake(0, 0);
            
        }else if ( self.lastTableViewOffsetY > 136){
            
            tableView.contentOffset = CGPointMake(0, 136);
        }
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            
            self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2,currentButton.frame.size.width, 2);
            
        }else{
            
            
            UIButton *preButton = self.titleButtons[index - 1];
            
            float offsetX = CGRectGetMinX(preButton.frame)-PADDING*2;
            
            [self.segmentScrollView scrollRectToVisible:CGRectMake(offsetX, 0, self.segmentScrollView.frame.size.width, self.segmentScrollView.frame.size.height) animated:YES];
            
            self.currentSelectedItemImageView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.segmentScrollView.frame.size.height-2, currentButton.frame.size.width, 2);
        }
        
    }];
    
    
}


#pragma  - mark 选项卡点击事件

-(void)changeSelectedItem:(UIButton *)currentButton {
    
    //     for (UIButton *button in self.titleButtons) {
    //         button.selected = NO;
    //     }
    
    _previousButton.selected = NO;
    currentButton.selected = YES;
    _previousButton = currentButton;
    
    NSInteger index = [self.titleButtons indexOfObject:currentButton];
    
    self.currentTableView  = self.tableViews[index];
    for (UITableView *tableView in self.tableViews) {
        
        if ( self.lastTableViewOffsetY>=0 &&  self.lastTableViewOffsetY<=136) {
            
            tableView.contentOffset = CGPointMake(0,  self.lastTableViewOffsetY);
            
        }else if(self.lastTableViewOffsetY < 0){
            
            tableView.contentOffset = CGPointMake(0, 0);
            
        }else if ( self.lastTableViewOffsetY > 136){
            
            tableView.contentOffset = CGPointMake(0, 136);
        }
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (index == 0) {
            
            self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2,currentButton.frame.size.width, 2);
            
        }else{
            
            
            UIButton *preButton = self.titleButtons[index - 1];
            
            float offsetX = CGRectGetMinX(preButton.frame)-PADDING*2;
            
            [self.segmentScrollView scrollRectToVisible:CGRectMake(offsetX, 0, self.segmentScrollView.frame.size.width, self.segmentScrollView.frame.size.height) animated:YES];
            
            self.currentSelectedItemImageView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.segmentScrollView.frame.size.height-2, currentButton.frame.size.width, 2);
        }
        self.bottomScrollView.contentOffset = CGPointMake(SCREEN_WIDTH *index, 0);
        
    }];
}


#pragma -mark Lazy Load

- (UIScrollView *)bottomScrollView {
    
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        
        
            TSInstitutionDetailViewController *detailViewController = [[TSInstitutionDetailViewController alloc] init];
        
            detailViewController.academy_id = self.academy_id;
            detailViewController.view.frame = CGRectMake(SCREEN_WIDTH * 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            
            //jsdTableViewController.view.backgroundColor = colors[i];
            [self.bottomScrollView addSubview:detailViewController.view];
        
            [self.controlleres addObject:detailViewController];
            [self.tableViews addObject:detailViewController.tableView];
            
            TSInstitutionTeacherViewController *teacherViewController = [[TSInstitutionTeacherViewController alloc] init];
            teacherViewController.view.frame = CGRectMake(SCREEN_WIDTH * 1, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            
            //jsdTableViewController.view.backgroundColor = colors[i];
            [self.bottomScrollView addSubview:teacherViewController.view];
            
            [self.controlleres addObject:teacherViewController];
            [self.tableViews addObject:teacherViewController.tableView];
        
            TSInstitutionStudentViewController *studentViewController = [[TSInstitutionStudentViewController alloc] init];
            studentViewController.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
            //jsdTableViewController.view.backgroundColor = colors[i];
            [self.bottomScrollView addSubview:studentViewController.view];
        
            [self.controlleres addObject:studentViewController];
            [self.tableViews addObject:studentViewController.tableView];
        
//            TSInstitutionMsgBoardViewController *msgBoardViewController = [[TSInstitutionMsgBoardViewController alloc] init];
//            msgBoardViewController.view.frame = CGRectMake(SCREEN_WIDTH * 1, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//
//            //jsdTableViewController.view.backgroundColor = colors[i];
//            [self.bottomScrollView addSubview:msgBoardViewController.view];
//
//            [self.controlleres addObject:msgBoardViewController];
//            [self.tableViews addObject:msgBoardViewController.tableView];
            //下拉刷新动画
//            JQRefreshHeaader *jqRefreshHeader  = [[JQRefreshHeaader alloc] initWithFrame:CGRectMake(0, 212, SCREEN_WIDTH, 30)];
//            jqRefreshHeader.backgroundColor = [UIColor whiteColor];
//            jqRefreshHeader.tableView = detailViewController.tableView;
//            [detailViewController.tableView.tableHeaderView addSubview:jqRefreshHeader];
            
            
            
//            NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
//            [detailViewController.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
//            [teacherViewController.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
//            [studentViewController.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
//
        
//        [detailViewController.tableView removeObserver:self forKeyPath:@"contentOffset"];
        
        self.currentTableView = self.tableViews[0];
        self.bottomScrollView.contentSize = CGSizeMake(self.controlleres.count * SCREEN_WIDTH, 0);
        
    }
    return _bottomScrollView;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}



- (NSMutableArray *)controlleres {
    
    if(!_controlleres){
        TSInstitutionDetailViewController *detailViewController = [[TSInstitutionDetailViewController alloc] init];
        TSInstitutionTeacherViewController *teacherViewController = [[TSInstitutionTeacherViewController alloc] init];
        TSInstitutionStudentViewController *studentViewController = [[TSInstitutionStudentViewController alloc] init];
        TSInstitutionMsgBoardViewController *msgBoardViewController = [[TSInstitutionMsgBoardViewController alloc] init];
        
        [self.controlleres addObject:detailViewController];
        [self.controlleres addObject:teacherViewController];
        [self.controlleres addObject:studentViewController];
        [self.controlleres addObject:msgBoardViewController];

    }
    return  _controlleres;
}




- (UIScrollView *)segmentScrollView {
    
    if (!_segmentScrollView) {
        
        _segmentScrollView =  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
        [_segmentScrollView addSubview:self.currentSelectedItemImageView];
        _segmentScrollView.showsHorizontalScrollIndicator = NO;
        _segmentScrollView.showsVerticalScrollIndicator = NO;
        _segmentScrollView.backgroundColor = [UIColor whiteColor];
        NSInteger btnoffset = 0;
        
        for (int i = 0; i<CATEGORY.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:CATEGORY[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:FONTMIN];
            CGSize size = [UIButton sizeOfLabelWithCustomMaxWidth:SCREEN_WIDTH systemFontSize:FONTMIN andFilledTextString:CATEGORY[i]];
            
            
            float originX =  i? PADDING*2+btnoffset:PADDING;
            
            btn.frame = CGRectMake(originX, 14, size.width, size.height);
            btnoffset = CGRectGetMaxX(btn.frame);
            
            
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [btn addTarget:self action:@selector(changeSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            [_segmentScrollView addSubview:btn];
            
            [self.titleButtons addObject:btn];
            
            //contentSize 等于按钮长度叠加
            //默认选中第一个按钮
            if (i == 0) {
                
                btn.selected = YES;
                _previousButton = btn;
                
                _currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2, btn.frame.size.width, 2);
            }
        }
        
        _segmentScrollView.contentSize = CGSizeMake(btnoffset+PADDING, 25);
    }
    
    return _segmentScrollView;
}

- (UIImageView *)currentSelectedItemImageView {
    if (!_currentSelectedItemImageView) {
        _currentSelectedItemImageView = [[UIImageView alloc] init];
        _currentSelectedItemImageView.image = [UIImage imageNamed:@"nar_bgbg"];
    }
    return _currentSelectedItemImageView;
}


- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        
        NSMutableArray *imageMutableArray = [NSMutableArray array];
        for (int i = 1; i<9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [imageMutableArray addObject:imageName];
        }
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageNamesGroup:imageMutableArray];
        
        
    }
    return _cycleScrollView;
}

- (JQHeaderView *)jqHeaderView {
    
    if (!_jqHeaderView) {
        
        _jqHeaderView = [[JQHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _jqHeaderView.backgroundColor = [UIColor clearColor];
        
    }
    return _jqHeaderView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
