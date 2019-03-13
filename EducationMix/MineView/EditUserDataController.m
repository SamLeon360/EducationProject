//
//  EditUserDataController.m
//  TXProject
//
//  Created by Sam on 2019/1/8.
//  Copyright © 2019 sam. All rights reserved.
//

#import "EditUserDataController.h"
#import "NewEditAlertView.h"
#import "TXWebViewController.h"
#import "ZLPhotoActionSheet.h"
#import "SHEditCommidityCameraController.h"
@interface EditUserDataController ()<SHEditCommidityCameraDelegate>
    @property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
    @property (weak, nonatomic) IBOutlet UITextField *nameTF;
    @property (weak, nonatomic) IBOutlet UIButton *manBtn;
    @property (weak, nonatomic) IBOutlet UIButton *girlBtn;
    @property (weak, nonatomic) IBOutlet UITextField *brithdayTF;
    @property (weak, nonatomic) IBOutlet UITextField *jiguanTF;
    @property (weak, nonatomic) IBOutlet UITextField *zhengfuTF;
    @property (weak, nonatomic) IBOutlet UITextField *schoolTF;
    @property (weak, nonatomic) IBOutlet UITextField *congjunTF;
    @property (weak, nonatomic) IBOutlet UITextField *aihaoTF;
    @property (weak, nonatomic) IBOutlet UITextView *gerenTF;
    @property (weak, nonatomic) IBOutlet UITextField *phoneTF;
    @property (weak, nonatomic) IBOutlet UITextField *outPhoneTF;
    @property (weak, nonatomic) IBOutlet UIButton *yesBtn;
    @property (weak, nonatomic) IBOutlet UIButton *noBtn;
    @property (weak, nonatomic) IBOutlet UITextField *emailTF;
    @property (weak, nonatomic) IBOutlet UITextField *addressTF;
    @property (weak, nonatomic) IBOutlet UITextField *commerceTF;
    @property (weak, nonatomic) IBOutlet UITableViewCell *commerceCell;
    @property (nonatomic) NSMutableDictionary *editUserData;
    
@end

@implementation EditUserDataController
    {
         NewEditAlertView *alertView;
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.editUserData = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self setupNewAlertView];
    __block EditUserDataController *blockSelf = self;
    [self.avatarImage bk_whenTapped:^{
        [blockSelf showEditAlertView];
    }];
    [self.userDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![key isEqualToString:@"member_id"]) {
            if ([obj isKindOfClass:[NSNull class]]) {
                if ([key isEqualToString:@"member_sex"]&&[obj isKindOfClass:[NSNull class]]) {
                    [self.editUserData setObject:@"1" forKey:key];
                }else{
                    [self.editUserData setObject:@"" forKey:key];
                }
            }else{
                [self.editUserData setObject:obj forKey:key];
            }
        }
        
    }];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AVATAR_HOST_URL,self.editUserData[@"member_avatar"]]]];
    if ([self.editUserData[@"member_sex"] integerValue] == 1) {
        [self.manBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
        [self.manBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [self.girlBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
        [self.girlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

    self.nameTF.text = [self.editUserData[@"member_name"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_name"];
    self.brithdayTF.text = [self.editUserData[@"member_age"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_age"];
    self.jiguanTF.text = [self.editUserData[@"member_native_place"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_native_place"];
    self.schoolTF.text =[self.editUserData[@"member_graduation_school"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_graduation_school"] ;
    self.congjunTF.text =[self.editUserData[@"military_experience"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"military_experience"] ;
    self.aihaoTF.text = [self.editUserData[@"member_hobby"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_hobby"] ;
    self.gerenTF.text = [self.editUserData[@"member_introduction"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_introduction"] ;
    self.phoneTF.text = [self.editUserData[@"member_phone"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_phone"] ;
    self.outPhoneTF.text = [self.editUserData[@"ext_phone"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"ext_phone"];
    self.emailTF.text = [self.editUserData[@"member_email"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_email"] ;
    self.addressTF.text = [self.editUserData[@"detail_address"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"detail_address"] ;
    self.zhengfuTF.text = [self.editUserData[@"member_political_status"] isKindOfClass:[NSNull class]]?@"":self.editUserData[@"member_political_status"];
    self.commerceTF.text = USER_SINGLE.default_commerce_name;
//    [self.commerceCell bk_whenTapped:^{
//        NSLog(@"%@",[NSString stringWithFormat:@"https://app.tianxun168.com/h5/#/member/business_card/%@/%@/",self.userDic[@"member_name"],USER_SINGLE.default_commerce_id]);
//        if (self.commerceTF.text.length > 0) {
//            TXWebViewController *vc = [[UIStoryboard storyboardWithName:@"HomePage" bundle:nil] instantiateViewControllerWithIdentifier:@"TXWebViewController"];
//            vc.webUrl = [NSString stringWithFormat:@"https://app.tianxun168.com/h5/#/member/business_card/%@/%@/",[self.userDic[@"member_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],USER_SINGLE.default_commerce_id];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }];
}

    /**
     门店图
     */
-(void)clickToTakePhoto{
    [self hideEditAlertView];
    SHEditCommidityCameraController *cameraVC = [[SHEditCommidityCameraController alloc] initWithArray:nil maxPhotoNum:1];
    cameraVC.delegate = self;
    
    [self.navigationController pushViewController:cameraVC animated:YES];
}

    
    /**
     门店图相册
     */
-(void)clickToTakeLib{
    [self hideEditAlertView];
    
    //相册问题
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    
    //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    ac.configuration.maxSelectCount = 1;
    ac.configuration.allowSelectVideo = NO;
    ac.configuration.allowTakePhotoInLibrary = NO;
    ac.configuration.maxPreviewCount = 1;
    ac.configuration.editAfterSelectThumbnailImage = YES;
    ac.configuration.hideClipRatiosToolBar = YES;
    ac.configuration.clipRatios = @[GetClipRatio(1, 1)];
    ac.configuration.saveNewImageAfterEdit = NO;
//    ac.configuration.clipRatios = @[1,1];
    //如调用的方法无sender参数，则该参数必传
    ac.sender = self;
    __block EditUserDataController *blockself = self;
    //选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        [blockself.avatarImage setImage:images[0]];
        [blockself upavatar];
    }];
    
    
    [ac showPhotoLibrary];
}
-(void)upavatar{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.member_id,@"member_id",USER_SINGLE.role_type,@"RoleType", nil];
    [HTTPREQUEST_SINGLE uploadImageArrayWithUrlStr:SH_UPLOAD_AVATAR headerparameters:dic bodyParameters:[[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.member_id,@"member_id", nil] imageArray:@[[self.avatarImage.image scaleToSize:CGSizeMake(200, 200)]] progress:^(double progress) {
        [SVProgressHUD showProgress:progress];
    } success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue]== -1002) {
             NOTIFY_POST(@"getNewMeMessage");
            
        }
        NSLog(@"%@",responseDic);
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];

}
-(void)setupNewAlertView{
    __block EditUserDataController *blockSelf = self;
    alertView = [[NSBundle mainBundle] loadNibNamed:@"NewEditAlertView" owner:self options:nil][0];
    [alertView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    alertView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    alertView.alpha = 0;
    [alertView.cancelBtn addTarget:self action:@selector(hideEditAlertView) forControlEvents:UIControlEventTouchUpInside];
    [alertView.takePhotoBtn addTarget:self action:@selector(clickToTakePhoto) forControlEvents:UIControlEventTouchUpInside];
    [alertView.photoLib addTarget:self action:@selector(clickToTakeLib) forControlEvents:UIControlEventTouchUpInside];
    [alertView bk_whenTapped:^{
        [blockSelf hideEditAlertView];
    }];
    [[[UIApplication sharedApplication] keyWindow] addSubview:alertView];
}
 
    
-(void)savePhotoWithArray:(NSArray *)array{
    if (array.count == 0) {
        return;
    }
    [self.avatarImage setImage:array[0]];
    [self upavatar];
}
- (IBAction)clickManBtn:(id)sender {
    [self.manBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.manBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.girlBtn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editUserData setObject:@"1" forKey:@"member_sex"];
}
- (IBAction)clickGirlBtn:(id)sender {
    [self.girlBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.girlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.manBtn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editUserData setObject:@"2" forKey:@"member_sex"];
}
- (IBAction)clickYesBtn:(id)sender {
    [self.yesBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.yesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.noBtn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.noBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editUserData setObject:@"1" forKey:@"show_phone"];
}
- (IBAction)clickNoBtn:(id)sender {
    [self.noBtn setBackgroundColor:[UIColor colorWithRGB:0x3e85fb] forState:UIControlStateNormal];
    [self.noBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.yesBtn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.yesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.editUserData setObject:@"2" forKey:@"show_phone"];
}
- (IBAction)clickToSaveEditData:(id)sender {
  
    [self.editUserData removeObjectForKey:@"commerce_contribution"];
    [self.editUserData removeObjectForKey:@"commerce_identity"];
    [self.editUserData removeObjectForKey:@"commonweal_identity"];
    [self.editUserData removeObjectForKey:@"enterprise_position"];
    [self.editUserData removeObjectForKey:@"goverment_identity"];
    [self.editUserData removeObjectForKey:@"member_join_commerce_time"];
    [self.editUserData removeObjectForKey:@"member_main_achievement"];
    [self.editUserData removeObjectForKey:@"member_style_honor"];
    [self.editUserData removeObjectForKey:@"member_style_picture"];
    [self.editUserData removeObjectForKey:@"member_style_video"];
    [self.editUserData removeObjectForKey:@"member_avatar"];
    if (![self.editUserData.allKeys containsObject:@"show_phone"]) {
        [self.editUserData setObject:@"1" forKey:@"show_phone"];
    }
    [self.editUserData setObject:self.commerceTF.text forKey:@"enterprise_name"];
    [self.editUserData setObject:@"" forKey:@"enterprise_scale"];
    [self.editUserData setObject:@"" forKey:@"enterprise_site"];
    [self.editUserData setObject:self.nameTF.text.length==0?@"":self.nameTF.text forKey:@"member_name"];
    
    [self.editUserData setObject:self.brithdayTF.text.length==0?@"":self.brithdayTF.text forKey:@"member_age"];
    [self.editUserData setObject:self.jiguanTF.text.length==0?@"":self.jiguanTF.text forKey:@"member_native_place"];
    [self.editUserData setObject:self.zhengfuTF.text.length==0?@"":self.zhengfuTF.text forKey:@"member_political_status"];
    [self.editUserData setObject:self.schoolTF.text.length==0?@"":self.schoolTF.text forKey:@"member_graduation_school"];
    [self.editUserData setObject:self.congjunTF.text.length==0?@"":self.congjunTF.text forKey:@"military_experience"];
    [self.editUserData setObject:self.aihaoTF.text.length==0?@"":self.aihaoTF.text forKey:@"member_hobby"];
    [self.editUserData setObject:self.gerenTF.text.length==0?@"":self.gerenTF.text forKey:@"member_introduction"];
    [self.editUserData setObject:self.phoneTF.text.length==0?@"":self.phoneTF.text forKey:@"member_phone"];
    [self.editUserData setObject:self.emailTF.text.length==0?@"":self.emailTF.text forKey:@"member_email"];
    [self.editUserData setObject:self.addressTF.text.length==0?@"":self.addressTF.text forKey:@"detail_address"];
//    [self.editUserData setObject:USER_SINGLE.member_id forKey:@"member_id"];
    [self.editUserData setObject:self.outPhoneTF.text.length==0?@"":self.outPhoneTF.text forKey:@"ext_phone"];
    NSDictionary *headerDic = [[NSDictionary alloc] initWithObjectsAndKeys:USER_SINGLE.member_id,@"member_id", nil];
    [HTTPREQUEST_SINGLE postWithURLStringHeaderAndBody:SH_SAVE_USER_DATA headerParameters:headerDic bodyParameters:self.editUserData withHub:YES withCache:NO success:^(NSDictionary *responseDic) {
        if ([responseDic[@"code"] integerValue] == -1002) {
            [AlertView showYMAlertView:self.view andtitle:@"更新成功"];
            NOTIFY_POST(@"getNewMeMessage");
        }
    } failure:^(NSError *error) {
        
    }];
    
}
    
-(void)showEditAlertView{
    [UIView animateWithDuration:0.5 animations:^{
        self->alertView.alpha = 1;
    }];
}
-(void)hideEditAlertView{
    [UIView animateWithDuration:0.5 animations:^{
        self->alertView.alpha = 0;
    }];
}

@end
