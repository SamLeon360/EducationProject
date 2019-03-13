//
//  UploadCommerceControllerController.m
//  TXProject
//
//  Created by Sam on 2019/2/13.
//  Copyright © 2019 sam. All rights reserved.
//

#import "UploadCommerceControllerController.h"

#import "UploadSelectTypeView.h"
#import "ZLPhotoActionSheet.h"
#import <IQKeyboardManager.h>
@interface UploadCommerceControllerController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *commerceNameLabel;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeTF;
@property (weak, nonatomic) IBOutlet UILabel *provinceTF;
@property (weak, nonatomic) IBOutlet UILabel *cityTF;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commerceAutoHeight;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeCommerceLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeCommerceCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeCommerceAreaLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *contactEmailTF;
@property (weak, nonatomic) IBOutlet UITextView *remarkTF;

@property (nonatomic) UploadSelectTypeView *selectTypeView;
@property (nonatomic) UIPickerView *areaPickerView;
@property (nonatomic) UIButton *pickSureBtn;
@property (nonatomic) NSArray *areaArray;
@property (nonatomic) NSArray *mainJobArray;
@property (nonatomic) NSString *parentId;
@property (nonatomic) NSString *regionId;
@property (nonatomic) BOOL isprovince;
@property (nonatomic) NSInteger selectType;
@property (nonatomic) BOOL selectMainJob;
@end

@implementation UploadCommerceControllerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社团入驻平台申请";
    self.parentId = @"1";
    self.regionId = @"1";
    self.isprovince = YES;
    self.selectMainJob = NO;
    [self.oneView makeCorner:10];
    [self.twoView makeCorner:10];
    [self.sureBtn makeCorner:18];
    [IQKeyboardManager sharedManager].enable = YES;
    self.areaPickerView.delegate = self;
    self.areaPickerView.dataSource = self;
    [[UIApplication sharedApplication].keyWindow  addSubview:self.areaPickerView];
    [[UIApplication sharedApplication].keyWindow  addSubview:self.selectTypeView];
    self.commerceAutoHeight.constant = 50;
//    [[UIApplication sharedApplication].keyWindow  addSubview:self.areaPickerView];
    [self setupClickAction];
    [self getAreaData];
    self.mainJobArray = @[@"包装印刷-包装",@"包装印刷-印刷",@"地产建材-地产开发",@"地产建材-建筑材料",@"地产建材-建筑监理及设计",@"法律咨询-法律咨询及服务",@"法律咨询-知识产权咨询及服务",@"纺织服饰-布匹",@"纺织服饰-服装",@"纺织服饰-箱包",@"工程贸易-工程施工",@"工程贸易-零售贸易",@"广告传媒-广告设计制作",@"广告传媒-文化传媒",@"广告传媒-新媒体广告",@"环保化工-环保检测治理",@"环保化工-生物化工",@"家电灯饰-灯饰配件",@"家电灯饰-灯饰照明",@"家电灯饰-家电配件",@"家电灯饰-家用电器",@"家具装饰-办公家具",@"家具装饰-家居用品",@"家具装饰-装饰工程",@"教育艺术-教育培训",@"教育艺术-文化艺术",@"金融财会-财会服务",@"金融财会-金融投资",@"酒店餐饮-餐饮服务",@"酒店餐饮-综合酒店",@"能源矿产-矿产开发",@"能源矿产-新能源产业",@"网络电子-电脑及配件",@"网络电子-软件工程",@"网络电子-网络技术",@"五金机械-机械装备",@"五金机械-模具铸造",@"五金机械-五金加工",@"物流运输-货物流通",@"物流运输-客运",@"医药保健-保健品",@"医药保健-医药销售",@"其他行业-其他行业",];
}
-(void)setupClickAction{
    self.pickSureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenH-340, ScreenW, 40)];
    [self.pickSureBtn setBackgroundColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pickSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.pickSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pickSureBtn.hidden = YES;
    __block UploadCommerceControllerController *blockSelf = self;
    [self.pickSureBtn bk_whenTapped:^{
        blockSelf.areaPickerView.hidden = YES;
        blockSelf.pickSureBtn.hidden = YES;
    }];
    [[UIApplication sharedApplication].keyWindow  addSubview:self.pickSureBtn];

    [self.typeTF bk_whenTapped:^{
        blockSelf.selectTypeView.hidden = NO;
    }];
    [self.selectTypeView.oneLabel bk_whenTapped:^{
        __block UploadCommerceControllerController *bblockSelf = self;
        blockSelf.selectType = 0;
        blockSelf.typeTF.text = blockSelf.selectTypeView.oneLabel.text;
        blockSelf.selectTypeView.hidden = YES;
        blockSelf.changeLabel.text = @"主营业务 * :";
        blockSelf.changeCommerceLabel.text = @"请选择主营业务";
        blockSelf.selectMainJob = YES;
        blockSelf.changeCommerceCityLabel.text = @"";
        blockSelf.commerceAutoHeight.constant = 100;
        [blockSelf.changeCommerceLabel bk_whenTapped:^{
            [bblockSelf.areaPickerView reloadAllComponents];
            bblockSelf.areaPickerView.hidden = NO;
            bblockSelf.pickSureBtn.hidden = NO;
        }];
    }];
    [self.selectTypeView.twoLabel bk_whenTapped:^{
        blockSelf.selectType = 1;
        blockSelf.selectMainJob = NO;
        blockSelf.typeTF.text = blockSelf.selectTypeView.twoLabel.text;
        blockSelf.selectTypeView.hidden = YES;
        blockSelf.commerceAutoHeight.constant = 50;
    }];
    [self.selectTypeView.threeLabel bk_whenTapped:^{
        blockSelf.selectType = 2;
         blockSelf.selectMainJob = NO;
        blockSelf.typeTF.text = blockSelf.selectTypeView.threeLabel.text;
        blockSelf.selectTypeView.hidden = YES;
        blockSelf.commerceAutoHeight.constant = 50;
    }];
    [self.selectTypeView.fourLabel bk_whenTapped:^{
        blockSelf.selectType = 3;
         blockSelf.selectMainJob = NO;
        blockSelf.typeTF.text = blockSelf.selectTypeView.fourLabel.text;
        blockSelf.selectTypeView.hidden = YES;
        blockSelf.changeLabel.text = @"社团会籍 * :";
       
        blockSelf.commerceAutoHeight.constant = 100;
        __block UploadCommerceControllerController *bblockSelf = self;
        [blockSelf.changeCommerceLabel bk_whenTapped:^{
            bblockSelf.parentId = @"1";
            bblockSelf.regionId = @"1";
            [bblockSelf.areaPickerView reloadAllComponents];
            bblockSelf.areaPickerView.hidden = NO;
            bblockSelf.isprovince = YES;
            bblockSelf.pickSureBtn.hidden = NO;
        }];
        [blockSelf.changeCommerceCityLabel bk_whenTapped:^{
            if (bblockSelf.provinceTF.text.length > 0) {
                bblockSelf.areaPickerView.hidden = NO;
                [bblockSelf getAreaData];
                bblockSelf.isprovince = NO;
                bblockSelf.pickSureBtn.hidden = NO;
            }else{
                return ;
            }
        }];
    }];
    
    [self.provinceTF bk_whenTapped:^{
        blockSelf.parentId = @"1";
        blockSelf.regionId = @"1";
         blockSelf.selectMainJob = NO;
        [blockSelf.areaPickerView reloadAllComponents];
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.isprovince = YES;
        blockSelf.pickSureBtn.hidden = NO;
    }];
    [self.cityTF bk_whenTapped:^{
        if (blockSelf.provinceTF.text.length > 0) {
            blockSelf.areaPickerView.hidden = NO;
            [blockSelf getAreaData];
            blockSelf.isprovince = NO;
            blockSelf.pickSureBtn.hidden = NO;
        }else{
            return ;
        }
    }];
    [self.uploadImageView bk_whenTapped:^{
        ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
        
        //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
        ac.configuration.maxSelectCount = 1;
        ac.configuration.maxPreviewCount = 10;
        ac.configuration.allowMixSelect = NO;
        
        //如调用的方法无sender参数，则该参数必传
        ac.sender = blockSelf;
        __block UploadCommerceControllerController *bblockSelf = blockSelf;
        //选择回调
        [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [bblockSelf.uploadImageView setImage:images[0]];
        }];
        
        //调用相册
        [ac showPreviewAnimated:YES];
    }];
    
}
-(void)getAreaData{
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.parentId,@"parent_id",self.regionId,@"region_type", nil];
    __block UploadCommerceControllerController *blockSelf = self;
    [HTTPREQUEST_SINGLE postWithURLString:SH_GET_AREA parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        blockSelf.areaArray = responseDic[@"data"];
        [blockSelf.areaPickerView reloadAllComponents];
    } failure:^(NSError *error) {
        
    }];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.selectMainJob) {
        return self.mainJobArray.count;
    }
    return self.areaArray.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.selectMainJob) {
        return self.mainJobArray[row];
    }
    NSDictionary *dic = self.areaArray[row];
    return dic[@"region_name"];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.selectMainJob) {
        self.changeCommerceLabel.text = self.mainJobArray[row];
    }else{
        NSDictionary *dic = self.areaArray[row];
        self.parentId = [NSString stringWithFormat:@"%@",dic[@"region_id"]];
        self.regionId = [NSString stringWithFormat:@"%@",@"2"];
        if (self.selectType == 3) {
            if (self.isprovince) {
                self.changeCommerceLabel.text = dic[@"region_name"];
            }else{
                self.changeCommerceCityLabel.text = dic[@"region_name"];
            }
        }else{
            if (self.isprovince) {
                self.provinceTF.text = dic[@"region_name"];
            }else{
                self.cityTF.text = dic[@"region_name"];
            }
        }
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (IBAction)clickToUpload:(id)sender {
    NSDictionary *param;
    if (self.selectType != 0&&self.selectType != 3) {
        param = [[NSDictionary alloc] initWithObjectsAndKeys:self.commerceNameLabel.text,@"commerce_name",[NSString stringWithFormat:@"%d",self.selectType+1],@"commerce_type",[NSString stringWithFormat:@"%@|%@",self.provinceTF.text,self.cityTF.text],@"commerce_location_real",self.contactNameLabel.text,@"contact",self.contactPhoneTF.text,@"contact_phone",self.contactEmailTF.text,@"email",self.remarkTF.text,@"remark", nil];
    }else{
        if (self.selectType == 3) {
            param = [[NSDictionary alloc] initWithObjectsAndKeys:self.commerceNameLabel.text,@"commerce_name",[NSString stringWithFormat:@"%d",self.selectType+1],@"commerce_type",[NSString stringWithFormat:@"%@|%@",self.provinceTF.text,self.cityTF.text],@"commerce_location_real",self.cityTF.text,@"commerce_lcation",self.contactNameLabel.text,@"contact",self.contactPhoneTF.text,@"contact_phone",self.contactEmailTF.text,@"email",self.remarkTF.text,@"remark",self.changeCommerceLabel.text,@"commerce_belong_membership",[NSString stringWithFormat:@"%@|%@",self.changeCommerceLabel.text,self.changeCommerceCityLabel.text],@"commerce_belong_membership_real", nil];
        }else if (self.selectType == 1){
            param = [[NSDictionary alloc] initWithObjectsAndKeys:self.commerceNameLabel.text,@"commerce_name",[NSString stringWithFormat:@"%d",self.selectType+1],@"commerce_type",[NSString stringWithFormat:@"%@|%@",self.provinceTF.text,self.cityTF.text],@"commerce_location_real",self.cityTF.text,@"commerce_lcation",self.contactNameLabel.text,@"contact",self.contactPhoneTF.text,@"contact_phone",self.contactEmailTF.text,@"email",self.remarkTF.text,@"remark",@"",@"commerce_belong_membership",@"||",@"commerce_belong_membership_real",[NSString stringWithFormat:@"%lu",(unsigned long)[self.mainJobArray indexOfObject:self.changeCommerceLabel.text]],@"main_business", nil];
        }else{
            param = [[NSDictionary alloc] initWithObjectsAndKeys:self.commerceNameLabel.text,@"commerce_name",[NSString stringWithFormat:@"%ld",self.selectType+1],@"commerce_type",[NSString stringWithFormat:@"%@|%@",self.provinceTF.text,self.cityTF.text],@"commerce_location_real",self.cityTF.text,@"commerce_lcation",self.contactNameLabel.text,@"contact",self.contactPhoneTF.text,@"contact_phone",self.contactEmailTF.text,@"email",self.remarkTF.text,@"remark",@"",@"commerce_belong_membership",@"||",@"commerce_belong_membership_real", nil];
        }
      
    }
    [HTTPREQUEST_SINGLE uploadImageArrayWithUrlStr:SH_CREATE_COMMERCE parameters:param withHub:YES constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imgName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
        NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", @"commerce", imgName];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.uploadImageView.image, 0.6) name:@"u_business_license[]" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(double progress) {
        [SVProgressHUD showProgress:progress];
    } success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        if ([responseDic[@"code"] integerValue] == -1002) {
            [AlertView showYMAlertView:self.view andtitle:@"入驻成功"];
        }else{
            [AlertView showYMAlertView:self.view andtitle:@"资料填写错误"];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
           [AlertView showYMAlertView:self.view andtitle:@"入驻失败"];
    }];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UploadSelectTypeView *)selectTypeView{
    if (_selectTypeView == nil) {
        _selectTypeView = [[NSBundle mainBundle] loadNibNamed:@"CommerceList" owner:self options:nil][7];
        _selectTypeView.frame = CGRectMake(0, ScreenH-200, ScreenW, 200);
        _selectTypeView.hidden = YES;
    }
    return _selectTypeView;
}
-(UIPickerView *)areaPickerView{
    if (_areaPickerView == nil) {
        _areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenH-300, ScreenW, 300)];
        _areaPickerView.backgroundColor = [UIColor colorWithRGB:0xf2f2f2];
        _areaPickerView.hidden = YES;
    }
    return  _areaPickerView;
}
@end
