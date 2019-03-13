//
//  EditCompanyMessageController.m
//  TXProject
//
//  Created by Sam on 2019/2/19.
//  Copyright © 2019 sam. All rights reserved.
//

#import "EditCompanyMessageController.h"
#import "ZLPhotoActionSheet.h"
@interface EditCompanyMessageController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *companyLogoImage;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *companyBoss;
@property (weak, nonatomic) IBOutlet UITextField *companyCode;
@property (weak, nonatomic) IBOutlet UITextField *registerMoney;
@property (weak, nonatomic) IBOutlet UITextField *companyDate;
@property (weak, nonatomic) IBOutlet UITextField *companyArea;
@property (weak, nonatomic) IBOutlet UITextField *companyAddress;
@property (weak, nonatomic) IBOutlet UILabel *mainWork1;
@property (weak, nonatomic) IBOutlet UILabel *mainWork2;
@property (weak, nonatomic) IBOutlet UILabel *mainWork3;
@property (weak, nonatomic) IBOutlet UILabel *workArea;
@property (weak, nonatomic) IBOutlet UILabel *companyType;
@property (weak, nonatomic) IBOutlet UILabel *companyZZ;
@property (weak, nonatomic) IBOutlet UITextField *companySize;
@property (weak, nonatomic) IBOutlet UITextField *companyNumber;
@property (weak, nonatomic) IBOutlet UITextField *programerNumber;
@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhone;
@property (weak, nonatomic) IBOutlet UITextField *contactEmail;
@property (weak, nonatomic) IBOutlet UITextField *companyWeb;
@property (weak, nonatomic) IBOutlet UITextView *companyIntro;
@property (weak, nonatomic) IBOutlet UITextView *companyHonor;
@property (weak, nonatomic) IBOutlet UITextView *otherCompany;
@property (weak, nonatomic) IBOutlet UITextView *chanjiaorongpingtai;
@property (weak, nonatomic) IBOutlet UITextView *mainJishu;
@property (weak, nonatomic) IBOutlet UITextView *shengchangongyi;
@property (weak, nonatomic) IBOutlet UITextView *zuzhijigou;
@property (weak, nonatomic) IBOutlet UITextView *jingyinjieshao;
@property (weak, nonatomic) IBOutlet UIButton *updataBtn;
@property (nonatomic) NSDictionary *detailDic;
@property (nonatomic) NSArray *mainWorkArray;
@property (nonatomic) NSArray *typeArray;
@property (nonatomic) NSArray *workAreaArray;
@property (nonatomic) UIPickerView *areaPickerView;
@property (nonatomic) UIButton *pickSureBtn;
@property (nonatomic) NSInteger selectIndex;
@end

@implementation EditCompanyMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.typeArray = @[@"全部", @"高新技术企业", @"科技型中小企业", @"规模以上企业", @"创新型企业", @"民营科技企业", @"大中型企业", @"其他"];
    self.mainWorkArray = @[@"包装印刷-包装",@"包装印刷-印刷",@"地产建材-地产开发",@"地产建材-建筑材料",@"地产建材-建筑监理及设计", @"法律咨询-法律咨询及服务", @"法律咨询-知识产权咨询及服务", @"纺织服饰-布匹", @"纺织服饰-服装", @"纺织服饰-箱包",@"工程贸易-工程施工",@"工程贸易-零售贸易",@"广告传媒-广告设计制作", @"广告传媒-文化传媒",@"广告传媒-新媒体广告",@"环保化工-环保检测治理", @"环保化工-生物化工",@"家电灯饰-灯饰配件",@"家电灯饰-灯饰照明",@"家电灯饰-家电配件",@"家电灯饰-家用电器",@"家具装饰-办公家具",@"家具装饰-家居用品", @"家具装饰-装饰工程",@"教育艺术-教育培训", @"教育艺术-文化艺术", @"金融财会-财会服务",@"金融财会-金融投资",@"酒店餐饮-餐饮服务",@"酒店餐饮-综合酒店",@"能源矿产-矿产开发",@"能源矿产-新能源产业",@"网络电子-电脑及配件",@"网络电子-软件工程",@"网络电子-网络技术",@"五金机械-机械装备",@"五金机械-模具铸造",@"五金机械-五金加工",@"物流运输-货物流通",@"物流运输-客运",@"医药保健-保健品",@"医药保健-医药销售",@"其他行业-其他行业"];
    self.workAreaArray = @[@"全部",@"电子信息",@"装备制造",@"能源环保",@"生物技术与医药",@"新材料",@"现在农业",@"其他行业"];
    
    if (self.companyIdDic != nil) {
        self.title = @"企业更新";
        [self.updataBtn setTitle:@"更新" forState:UIControlStateNormal];
        [self editCompany];
        self.companyName.userInteractionEnabled = NO;
        self.companyBoss.userInteractionEnabled = NO;
        self.companyCode.userInteractionEnabled = NO;
        self.registerMoney.userInteractionEnabled = NO;
        self.companyDate.userInteractionEnabled = NO;
    }else{
        self.title = @"企业添加";
        [self.updataBtn setTitle:@"添加" forState:UIControlStateNormal];
    }
    [self setupClickAction];
    
}
- (IBAction)clickToUpdate:(id)sender {
    if (self.companyIdDic != nil) {
        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.companyIdDic[@"enterprise_id"],@"enterprise_id", nil];
        [HTTPREQUEST_SINGLE uploadImageArrayWithUrlStr:SH_UPLOAD_ENTREPRISE_LOGO parameters:param withHub:YES constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *imgName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
            NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", @"enterprise", imgName];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.companyLogoImage.image, 0.6) name:@"enterprise_logo" fileName:fileName mimeType:@"image/jpeg"];
        } progress:^(double progress) {
            
        } success:^(NSDictionary *responseDic) {
           
        } failure:^(NSError *error) {
            
        }];
    }
    NSMutableDictionary *param =[[NSMutableDictionary alloc] initWithObjectsAndKeys:self.companyName.text,@"enterprise_name",self.companyCode.text,@"credit_code",self.companyBoss.text,@"legal_representative",self.registerMoney.text,@"registered_capital",self.companyDate.text,@"establish_day",[NSString stringWithFormat:@"%lu",(unsigned long)[self.typeArray indexOfObject:self.companyType.text]+1],@"enterprise_type",[NSString stringWithFormat:@"%lu",(unsigned long)[self.workAreaArray indexOfObject:self.workArea.text]+1],@"domain",self.companyArea.text,@"area",[NSString stringWithFormat:@"%lu",(unsigned long)[self.typeArray indexOfObject:self.companyZZ.text]+1],@"enterprise_qualifications",self.companySize.text,@"enterprise_scale",[NSString stringWithFormat:@"%lu",(unsigned long)[self.mainWorkArray indexOfObject:self.mainWork1.text]+1],@"business_scope",[NSString stringWithFormat:@"%lu",(unsigned long)[self.mainWorkArray indexOfObject:self.mainWork2.text]+1],@"business_scope1",[NSString stringWithFormat:@"%lu",(unsigned long)[self.mainWorkArray indexOfObject:self.mainWork3.text]+1],@"business_scope2",self.companyNumber.text,@"enterprise_staff_num",self.programerNumber.text,@"research_development_staff_num",self.otherCompany.text,@"research_development_institutions",self.companyHonor.text,@"enterprise_honor",self.chanjiaorongpingtai.text,@"production_education_cooperation",self.contactName.text,@"contacts",self.companyAddress.text,@"address",self.contactPhone.text,@"phone",self.contactEmail.text,@"email",self.contactEmail.text,@"official_website",self.companyIntro.text,@"enterprise_profile",self.mainJishu.text,@"mainstream_technology",self.shengchangongyi.text,@"production_process",self.zuzhijigou.text,@"organization",self.jingyinjieshao.text,@"enterprise_essence_intro",@"",@"product_show",@"",@"enterprise_photo", nil];
    if (self.companyIdDic != nil) {
        [param setObject:self.companyIdDic[@"enterprise_id"] forKey:@"enterprise_id"];
    }else{
        [param setObject:@"" forKey:@"enterprise_logo"];
    }
    [HTTPREQUEST_SINGLE postWithURLString:SH_UPDATE_COMPANY parameters:param withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == -1002) {
            [AlertView showYMAlertView:self.view andtitle:@"操作成功"];
        }else{
            [AlertView showYMAlertView:self.view andtitle:@"操作失败"];
        }
    } failure:^(NSError *error) {
         [AlertView showYMAlertView:self.view andtitle:@"网络异常"];
    }];
  
}
-(void)setupClickAction{
    self.areaPickerView.delegate = self;
    self.areaPickerView.dataSource = self;
    [[UIApplication sharedApplication].keyWindow  addSubview:self.areaPickerView];
    self.pickSureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenH-340, ScreenW, 40)];
    [self.pickSureBtn setBackgroundColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.pickSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.pickSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pickSureBtn.hidden = YES;
    __block EditCompanyMessageController *blockSelf = self;
    [self.pickSureBtn bk_whenTapped:^{
        blockSelf.areaPickerView.hidden = YES;
        blockSelf.pickSureBtn.hidden = YES;
    }];
    [[UIApplication sharedApplication].keyWindow  addSubview:self.pickSureBtn];
    
    [self.companyLogoImage bk_whenTapped:^{
        ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
        
        //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
        ac.configuration.maxSelectCount = 1;
        ac.configuration.maxPreviewCount = 10;
        ac.configuration.allowMixSelect = NO;
        
        //如调用的方法无sender参数，则该参数必传
        ac.sender = blockSelf;
        __block EditCompanyMessageController *bblockSelf = blockSelf;
        //选择回调
        [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [bblockSelf.companyLogoImage setImage:images[0]];
        }];
        
        //调用相册
        [ac showPreviewAnimated:YES];
    }];
    
    [self.mainWork1 bk_whenTapped:^{
        self.selectIndex = 1;
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.pickSureBtn.hidden = NO;
        [blockSelf.areaPickerView reloadAllComponents];
         self.mainWork1.text = self.mainWorkArray[0];
    }];
    [self.mainWork2 bk_whenTapped:^{
        self.selectIndex = 2;
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.pickSureBtn.hidden = NO;
        [blockSelf.areaPickerView reloadAllComponents];
        self.mainWork2.text = self.mainWorkArray[0];
    }];
    [self.mainWork3 bk_whenTapped:^{
        self.selectIndex = 3;
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.pickSureBtn.hidden = NO;
        self.mainWork3.text = self.mainWorkArray[0];
        [blockSelf.areaPickerView reloadAllComponents];
    }];
    [self.workArea bk_whenTapped:^{
        self.selectIndex = 4;
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.pickSureBtn.hidden = NO;
        [blockSelf.areaPickerView reloadAllComponents];
        self.workArea.text = self.workAreaArray[0];
    }];
    [self.companyType bk_whenTapped:^{
        self.selectIndex = 5;
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.pickSureBtn.hidden = NO;
        [blockSelf.areaPickerView reloadAllComponents];
         self.companyType.text = self.typeArray[0];
    }];
    [self.companyZZ bk_whenTapped:^{
        self.selectIndex = 6;
        blockSelf.areaPickerView.hidden = NO;
        blockSelf.pickSureBtn.hidden = NO;
        [blockSelf.areaPickerView reloadAllComponents];
        self.companyZZ.text = self.typeArray[0];
    }];
}
-(void)editCompany{
    [HTTPREQUEST_SINGLE postWithURLString:SH_DETAIL_COMPANY parameters:@{@"enterprise_id":self.companyIdDic[@"enterprise_id"]} withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == 0) {
            NSArray *arr =  responseDic[@"data"];
            self.detailDic = arr.firstObject;
            [self setupDetailData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupDetailData{
    self.companyName.text = [self.detailDic[@"enterprise_name"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"enterprise_name"];
    self.companyBoss.text = [self.detailDic[@"legal_representative"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"legal_representative"];
    self.companyCode.text = [NSString stringWithFormat:@"%@",self.detailDic[@"credit_code"]];
    self.registerMoney.text = [NSString stringWithFormat:@"%@",self.detailDic[@"registered_capital"]];
    self.companyDate.text = [self.detailDic[@"establish_day"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"establish_day"];
   
    self.companyArea.text = [self.detailDic[@"area"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"area"];
    self.companyAddress.text = [self.detailDic[@"address"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"address"];
    self.mainWork1.text = self.mainWorkArray[[self.detailDic[@"business_scope"] isKindOfClass:[NSNull class]]?0:[self.detailDic[@"business_scope"]integerValue]];
    self.mainWork2.text = self.mainWorkArray[[self.detailDic[@"business_scope1"] isKindOfClass:[NSNull class]]?0:[self.detailDic[@"business_scope1"]integerValue]];
    self.mainWork3.text = self.mainWorkArray[[self.detailDic[@"business_scope2"] isKindOfClass:[NSNull class]]?0:[self.detailDic[@"business_scope2"]integerValue]];
    self.companyType.text = self.typeArray[[self.detailDic[@"entreprise_type"] isKindOfClass:[NSNull class]]?0:[self.detailDic[@"entreprise_type"] integerValue]];
    self.companyZZ.text = self.typeArray[[self.detailDic[@"entreprise_type"] isKindOfClass:[NSNull class]]?0:[self.detailDic[@"entreprise_type"] integerValue]];
    self.companySize.text =[self.detailDic[@"enterprise_scale"] isKindOfClass:[NSNull class]]?@"": [NSString stringWithFormat:@"%@",self.detailDic[@"enterprise_scale"]];
    self.companyNumber.text = [self.detailDic[@"enterprise_staff_num"] isKindOfClass:[NSNull class]]?@"":[NSString stringWithFormat:@"%@",self.detailDic[@"enterprise_staff_num"]];
    self.programerNumber.text =[self.detailDic[@"research_development_staff_num"] isKindOfClass:[NSNull class]]?@"": [NSString stringWithFormat:@"%@",self.detailDic[@"research_development_staff_num"]];
    self.contactName.text = [self.detailDic[@"contacts"] isKindOfClass:[NSNull class]]?@"": self.detailDic[@"contacts"];
    self.contactPhone.text = [self.detailDic[@"phone"] isKindOfClass:[NSNull class]]?@"":[NSString stringWithFormat:@"%@",self.detailDic[@"phone"]
                              ];
    self.contactEmail.text =[self.detailDic[@"email"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"email"];
    self.companyWeb.text =[self.detailDic[@"official_website"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"official_website"];
    self.companyIntro.text =[self.detailDic[@"enterprise_profile"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"enterprise_profile"];
    self.companyHonor.text = [self.detailDic[@"enterprise_honor"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"enterprise_honor"];
    self.otherCompany.text = [self.detailDic[@"research_development_institutions"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"research_development_institutions"];
    self.chanjiaorongpingtai.text = [self.detailDic[@"production_education_cooperation"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"production_education_cooperation"];
    self.mainJishu.text = [self.detailDic[@"mainstream_technology"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"mainstream_technology"];
    self.shengchangongyi.text =[self.detailDic[@"production_process"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"production_process"];
    self.zuzhijigou.text =[self.detailDic[@"organization"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"organization"];
    self.jingyinjieshao.text =[self.detailDic[@"enterprise_essence_intro"] isKindOfClass:[NSNull class]]?@"":self.detailDic[@"enterprise_essence_intro"];
    [self.companyLogoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,self.detailDic[@"enterprise_logo"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            [self.companyLogoImage setImage:[UIImage imageNamed:@"default_avatar"]];
        }
    }];
     self.workArea.text = self.workAreaArray[[self.detailDic[@"domain"] integerValue]-1];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.selectIndex <= 3) {
        return self.mainWorkArray.count;
    }else if (self.selectIndex == 4){
        return self.workAreaArray.count;
    }
    return  self.typeArray.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.selectIndex <= 3) {
        return self.mainWorkArray[row];
    }else if (self.selectIndex == 4){
        return self.workAreaArray[row];
    }
    return self.typeArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.selectIndex == 1) {
        self.mainWork1.text = self.mainWorkArray[row];
    }else if (self.selectIndex == 2) {
        self.mainWork2.text = self.mainWorkArray[row];
    }else if (self.selectIndex == 3) {
        self.mainWork3.text = self.mainWorkArray[row];
    }else if (self.selectIndex == 4) {
        self.workArea.text = self.workAreaArray[row];
    }else if (self.selectIndex == 5) {
        self.companyType.text = self.typeArray[row];
    }else if (self.selectIndex == 6) {
        self.companyZZ.text = self.typeArray[row];
    }
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
