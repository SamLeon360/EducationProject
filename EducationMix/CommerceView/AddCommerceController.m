//
//  AddCommerceController.m
//  TXProject
//
//  Created by Sam on 2019/2/15.
//  Copyright © 2019 sam. All rights reserved.
//

#import "AddCommerceController.h"
#import "ZLPhotoActionSheet.h"
@interface AddCommerceController ()
@property (weak, nonatomic) IBOutlet UITextField *commerceNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *companyNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactEmailLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkTF;
@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property (weak, nonatomic) IBOutlet UIImageView *idcardOnImage;
@property (weak, nonatomic) IBOutlet UIImageView *idcardBackIamge;
@property (nonatomic) BOOL hadCompanyImage;
@property (nonatomic) BOOL hadIdcardOnImage;
@property (nonatomic) BOOL hadIdcardBackImage;
@end

@implementation AddCommerceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hadCompanyImage = NO;
    self.hadIdcardOnImage = NO;
    self.hadIdcardBackImage = NO;
    self.title = @"加入社团";
    self.commerceNameLabel.text = self.commerceDic[@"commerce_name"];
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    
    //相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    ac.configuration.maxSelectCount = 1;
    ac.configuration.maxPreviewCount = 10;
    ac.configuration.allowMixSelect = NO;
    
    //如调用的方法无sender参数，则该参数必传
    ac.sender = self;
    //选择回调
    __block AddCommerceController *blockSelf = self;
    [self.companyImage bk_whenTapped:^{
        __block AddCommerceController *bblockSelf = blockSelf;
        [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            if (images.count >=1) {
                [bblockSelf.companyImage setImage:images[0]];
                bblockSelf.hadCompanyImage = YES;
            }
            
        }];
        //调用相册
        [ac showPreviewAnimated:YES];
    }];
    [self.idcardOnImage bk_whenTapped:^{
         __block AddCommerceController *bblockSelf = blockSelf;
        [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            if (images.count>=1) {
                 [bblockSelf.idcardOnImage setImage:images[0]];
                bblockSelf.hadIdcardOnImage = YES;
            }
        }];
        //调用相册
        [ac showPreviewAnimated:YES];
    }];
    [self.idcardBackIamge bk_whenTapped:^{
         __block AddCommerceController *bblockSelf = blockSelf;
        [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            if (images.count >= 1) {
                [bblockSelf.idcardBackIamge setImage:images[0]];
                bblockSelf.hadIdcardBackImage = YES;
            }
        }];
        //调用相册
        [ac showPreviewAnimated:YES];
    }];
  
}
- (IBAction)clickToHandUp:(id)sender {
    if (self.companyNameLabel.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请填写企业名称"];
        return;
    }
    if (self.addressLabel.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请填写企业地址"];
        return;
    }
    if (self.contactNameLabel.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请填写联系人"];
        return;
    }
    if (self.contactNumberLabel.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请填写联系电话"];
        return;
    }
    if (self.contactEmailLabel.text.length <= 0) {
        [AlertView showYMAlertView:self.view andtitle:@"请填写联系邮箱"];
        return;
    }
    if (self.companyImage.tag == 1) {
        [AlertView showYMAlertView:self.view andtitle:@"请选择营业执照"];
        return;
    }
    if (self.idcardOnImage.tag == 1) {
        [AlertView showYMAlertView:self.view andtitle:@"请选择身份证正面"];
        return;
    }
    if (self.companyImage.tag == 1) {
        [AlertView showYMAlertView:self.view andtitle:@"请选择身份证反面"];
        return;
    }
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:self.commerceDic[@"commerce_id"],@"commerce_id",self.companyNameLabel.text,@"enterprise_name",self.addressLabel.text,@"enterprise_address",self.contactNameLabel.text, @"application_name",self.contactNumberLabel.text,@"contact_phone",self.contactEmailLabel.text,@"email",self.remarkTF.text,@"introduction", nil];
    [HTTPREQUEST_SINGLE uploadImageArrayWithUrlStr:SH_ADD_COMMERCE parameters:param withHub:YES constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *imgName = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
        NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", @"commerce", imgName];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.companyImage.image, 0.3) name:@"u_business_license[]" fileName:fileName mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.idcardOnImage.image, 0.3) name:@"u_id_card[]" fileName:@"0" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.idcardBackIamge.image, 0.3) name:@"u_id_card[]" fileName:@"1" mimeType:@"image/jpeg"];
    } progress:^(double progress) {
         [SVProgressHUD showProgress:progress];
    } success:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        if ([responseDic[@"code"] integerValue] == -1002) {
            [AlertView showYMAlertView:self.view andtitle:@"申请入会成功"];
        }else{
            [AlertView showYMAlertView:self.view andtitle:@"资料填写错误"];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}


@end
