//
//  YKEditTreeCameraViewController.m
//  YKMX
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 chenshuo. All rights reserved.
//

#import "SHEditCommidityCameraController.h"

#import <AVFoundation/AVFoundation.h>

#import "SHEditCommidityPhotoView.h"
#import "YKEditTreeCameraBottomView.h"
#import "UIView+Genie.h"
#import "UIImage+Wechat.h"

#define kScreenBounds   [UIScreen mainScreen].bounds
#define kScreenWidth  kScreenBounds.size.width*1.0
#define kScreenHeight kScreenBounds.size.height*1.0

@interface SHEditCommidityCameraController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;

//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;

@property (nonatomic)AVCaptureStillImageOutput *ImageOutPut;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

/**
 *  记录开始的缩放比例
 */
@property(nonatomic,assign)CGFloat beginGestureScale;
/**
 *  最后的缩放比例
 */
@property(nonatomic,assign)CGFloat effectiveScale;

@property (nonatomic)UIButton *PhotoButton;
@property (nonatomic)UIButton *flashButton;
@property (nonatomic)UIImageView *imageView;
@property (nonatomic)UIView *focusView;
@property (nonatomic)BOOL isflashOn;
@property (nonatomic)UIImage *image;
@property (nonatomic) UIImageView *cameraIconView;

@property (nonatomic)BOOL canCa;

@property (nonatomic) NSInteger maxPhotoNum;
@property (nonatomic) NSMutableArray *unSaveImageArray;
@property (nonatomic) YKEditTreeCameraBottomView *bottomView;
@property (nonatomic) SHEditCommidityPhotoView *photoView;


@property (nonatomic) BOOL isHiddenPhoto;

@end

@implementation SHEditCommidityCameraController

- (instancetype)initWithArray:(NSArray *)array maxPhotoNum:(NSInteger)maxPhotoNum
{
    self = [super init];
    if (self) {
        self.isHiddenPhoto = NO;
        self.imageArray = array;
        self.maxPhotoNum = maxPhotoNum;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePhoto:) name:@"hidePhoto" object:nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.unSaveImageArray = [NSMutableArray array];
    
    [self.unSaveImageArray addObjectsFromArray:self.imageArray];
    self.cameraIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56*(ScreenW/320), 56*(ScreenW/320))];
    
    if (self.imageKeyArr == nil) {
        self.imageKeyArr = [NSMutableArray arrayWithCapacity:0];
    }
    _canCa = [self canUserCamear];
    if (_canCa) {
        [self customCamera];
        [self customUI];
        
    }else{
        return;
    }
    
    self.effectiveScale = self.beginGestureScale = 1.0f;
    [self setUpGesture];
    
}
-(void)hidePhoto:(NSNotification *)info{
    BOOL isHidden = info.object;
    self.isHiddenPhoto = isHidden;
}
- (void)customUI{
    
    self.bottomView = [[YKEditTreeCameraBottomView alloc] initWithFrame:CGRectMake(0, ScreenH-100, ScreenW, 100)];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView.cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.takePhotoBtn addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView.saveBtn addTarget:self action:@selector(saveImageArray) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoView = [[SHEditCommidityPhotoView alloc] initWithFrame:CGRectMake(0, self.bottomView.viewY - 100, ScreenW, 100)];
    self.photoView.imageArray = self.unSaveImageArray;
    self.photoView.delegate = self;
    [self.view addSubview:self.photoView];
    
    [self.view addSubview:self.imageView];
    self.imageView.hidden = YES;
    
    [self.view addSubview:self.cameraIconView];
    self.cameraIconView.center = CGPointMake(self.view.center.x, self.view.center.y-20);
    [self.cameraIconView setImage:[UIImage imageNamed:@"camera_icon_miaozhun"]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}
- (void)customCamera{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureExposureMode exposureMode = AVCaptureExposureModeContinuousAutoExposure;
    AVCaptureFocusMode focusMode = AVCaptureFocusModeContinuousAutoFocus;
    BOOL canResetFocus = [self.device isFocusPointOfInterestSupported] && [self.device isFocusModeSupported:focusMode];
    BOOL canResetExposure = [self.device isExposurePointOfInterestSupported] && [self.device isExposureModeSupported:exposureMode];
    CGPoint centerPoint = CGPointMake(0.5f, 0.5f);
    //    [self.device setFlashMode:AVCaptureFlashModeOff];
    
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    
    //生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.ImageOutPut = [[AVCaptureStillImageOutput alloc] init];
    
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
        
    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
    }
    
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.view.frame =  CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    self.previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth, kScreenWidth, kScreenHeight-kScreenWidth)];
    [view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:view];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    if ([_device lockForConfiguration:nil]) {
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeOff];
        }
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        if (canResetFocus) {
            _device.focusMode = focusMode;
            _device.focusPointOfInterest = centerPoint;
        }
        if([_device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]){
            //            [self configureCameraForHighestFrameRate:_device];
            CGPoint exposurePoint = CGPointMake(0.5f,0.5f);
            if ([_device isExposurePointOfInterestSupported]) {
                [_device setExposurePointOfInterest:exposurePoint];
            }
            
            //            [_device setExposureMode:AVCaptureExposureModeAutoExpose];
            
            [_device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        }
        
        [_device unlockForConfiguration];
        
    }
    
    //开始启动
    [self.session startRunning];
    
    
}

- (void)FlashOn{
    if ([_device lockForConfiguration:nil]) {
        if (_isflashOn) {
            if ([_device isFlashModeSupported:AVCaptureFlashModeOff]) {
                [_device setFlashMode:AVCaptureFlashModeOff];
                _isflashOn = NO;
                [_flashButton setTitle:@"闪光灯关" forState:UIControlStateNormal];
            }
        }else{
            if ([_device isFlashModeSupported:AVCaptureFlashModeOn]) {
                [_device setFlashMode:AVCaptureFlashModeOn];
                _isflashOn = YES;
                [_flashButton setTitle:@"闪光灯开" forState:UIControlStateNormal];
            }
        }
        
        [_device unlockForConfiguration];
    }
}

- (void)changeCamera{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        
        CATransition *animation = [CATransition animation];
        
        animation.duration = .5f;
        
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        animation.type = @"oglFlip";
        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;
        }
        else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;
        }
        
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:_input];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.input = newInput;
                
            } else {
                [self.session addInput:self.input];
            }
            
            [self.session commitConfiguration];
            
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
        
    }
}
- (void)configureCameraForHighestFrameRate:(AVCaptureDevice *)device
{
    AVCaptureDeviceFormat *bestFormat = nil;
    AVFrameRateRange *bestFrameRateRange = nil;
    for ( AVCaptureDeviceFormat *format in [device formats] ) {
        for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges ) {
            if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate ) {
                bestFormat = format;
                bestFrameRateRange = range;
            }
        }
    }
    if ( bestFormat ) {
        if ( [device lockForConfiguration:NULL] == YES ) {
            device.activeFormat = bestFormat;
            device.activeVideoMinFrameDuration = bestFrameRateRange.minFrameDuration;
            device.activeVideoMaxFrameDuration = bestFrameRateRange.minFrameDuration;
            [device unlockForConfiguration];
        }
    }
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    if (point.y > self.photoView.frame.origin.y) {
        self.cameraIconView.center = CGPointMake(point.x, self.photoView.frame.origin.y-self.cameraIconView.frame.size.height/2);
        [self focusAtPoint:CGPointMake(point.x, self.photoView.frame.origin.y-self.cameraIconView.frame.size.height/2)];
        return;
    }
    self.cameraIconView.center = point;
    [self focusAtPoint:point];
}
- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.device unlockForConfiguration];
        _focusView.center = point;
        _focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _focusView.hidden = YES;
            }];
        }];
    }
}

#pragma mark - 保存照片数组
-(void)saveImageArray{
    if (self.delegate && [self.delegate respondsToSelector:@selector(savePhotoWithArray:)]) {
     
        [self.delegate savePhotoWithArray:self.unSaveImageArray];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 截取照片
- (void) shutterCamera
{
    
    if (self.photoView.imageArray.count >= self.maxPhotoNum) {
        [CustomFountion showErrorHUD:[NSString stringWithFormat:@"最多只能保存%ld张照片",(long)self.maxPhotoNum]];
        return;
    }
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    [videoConnection setVideoScaleAndCropFactor:self.effectiveScale];
    
    [CustomFountion showWaitHUD:@"请稍后..."];
    @weakify(self);
    //验苗拍摄
    [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        @strongify(self);
        [CustomFountion dismissHUD];
        NSLog(@"%@",NSStringFromCGSize(self.image.size));
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.image = [UIImage imageWithData:imageData];
        self.image = [self fixOrientation:self.image];
        //        CGFloat height = 400 * self.image.size.height / self.image.size.width;
        self.image = [self thumbnailWithImage:self.image size:CGSizeMake(self.image.size.width, self.image.size.width)];
        self.imageView.image = _image;
        self.imageView.hidden = NO;
        UIImageView *imageView = self.photoView.imageViewArray.count>0 ? self.photoView.imageViewArray.lastObject : nil;
        CGRect rect=[imageView convertRect:imageView.frame toView:self.view];
        if (self.isHiddenPhoto) {
            rect.origin.x = 35.555555555;
        }else{
            rect.origin.x = imageView ? rect.origin.x + 80 * ScreenW / ScreenH + 10 : [self.photoView.myCollectionView convertRect:self.photoView.myCollectionView.frame toView:self.view].origin.x;
        }
        rect.origin.y = [self.photoView.myCollectionView convertRect:self.photoView.myCollectionView.frame toView:self.view].origin.y + 10;
        rect.size.height = 80;
        rect.size.width = 80 * ScreenW / ScreenH;
        @weakify(self);
        [self.imageView genieInTransitionWithDuration:0.5 destinationRect:rect destinationEdge:BCRectEdgeTop completion:^{
            @strongify(self);
            //            [self.session startRunning];
            self.imageView.hidden = YES;
        }];
        
        [self.unSaveImageArray addObject:[UIImage imageWithData:[CustomFountion OnlyCompressToDataWithImage:self.image FileSize:150]]];
        NSData *data = UIImageJPEGRepresentation([[UIImage alloc] initWithData:[CustomFountion OnlyCompressToDataWithImage:self.image FileSize:100]],1);
        NSLog(@"只压不缩-返回Data大小：%lu kb",data.length/1024);
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
        for (UIImage *image in self.unSaveImageArray) {
            [tempArray insertObject:image atIndex:0];
        }
        self.photoView.imageArray = tempArray;
        
        self.bottomView.takePhotoBtn.hidden = self.unSaveImageArray.count >= self.maxPhotoNum;
        
        NSLog(@"image size = %@",NSStringFromCGSize(self.image.size));
    }];
}

//------只压不缩--按NSData大小压缩，返回NSData
-(NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage
                              FileSize:(NSInteger)FileSize
{
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    //每次减少的比例
    float scale = 0.1;
    
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression)&&
           ((imageData.length/1024)>FileSize))
    {
        compression -= scale;
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
        
        //        NSLog(@"%f,%lu",compression,(unsigned long)imageData.length);
    }
    NSLog(@"只压不缩-返回Data大小：%lu kb",imageData.length/1024);
    return imageData;
}



#pragma mark - YKEditTreeCameraPhotoViewDelegate
-(void)deletePhoto{
    [self.unSaveImageArray setArray:self.photoView.imageArray];
    self.bottomView.takePhotoBtn.hidden = self.unSaveImageArray.count >= MaxPhotoNum;
}


#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage
{
    
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
-(void)cancle{
    [self.imageView removeFromSuperview];
    [self.session startRunning];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 100) {
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}

#pragma 创建手势
- (void)setUpGesture{
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
}
#pragma mark gestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        self.beginGestureScale = self.effectiveScale;
    }
    return YES;
}
//缩放手势 用于调整焦距
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer{
    
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSUInteger numTouches = [recognizer numberOfTouches], i;
    for ( i = 0; i < numTouches; ++i ) {
        CGPoint location = [recognizer locationOfTouch:i inView:self.view];
        CGPoint convertedLocation = [self.previewLayer convertPoint:location fromLayer:self.previewLayer.superlayer];
        if ( ! [self.previewLayer containsPoint:convertedLocation] ) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if ( allTouchesAreOnThePreviewLayer ) {
        
        
        self.effectiveScale = self.beginGestureScale * recognizer.scale;
        if (self.effectiveScale < 1.0){
            self.effectiveScale = 1.0;
        }
        
        NSLog(@"%f-------------->%f------------recognizerScale%f",self.effectiveScale,self.beginGestureScale,recognizer.scale);
        
        CGFloat maxScaleAndCropFactor = [[self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
        
        NSLog(@"%f",maxScaleAndCropFactor);
        if (self.effectiveScale > maxScaleAndCropFactor)
            self.effectiveScale = maxScaleAndCropFactor;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:.025];
        [self.previewLayer setAffineTransform:CGAffineTransformMakeScale(self.effectiveScale, self.effectiveScale)];
        [CATransaction commit];
        
    }
    
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW)];
    }
    return _imageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 修复自动旋转90度bug
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation ==UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform =CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height,0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx =CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                            CGImageGetBitsPerComponent(aImage.CGImage),0,
                                            CGImageGetColorSpace(aImage.CGImage),
                                            CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx,CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg =CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
- (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size

{
    
    CGSize originalsize = [originalImage size];
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    
    if (originalsize.width<size.width && originalsize.height<size.height)
        
    {
        
        return originalImage;
        
    }
    
    
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    
    else if(originalsize.width>size.width && originalsize.height>size.height)
        
    {
        
        CGFloat rate = 1.0;
        
        CGFloat widthRate = originalsize.width/size.width;
        
        CGFloat heightRate = originalsize.height/size.height;
        
        
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        
        
        CGImageRef imageRef = nil;
        
        
        
        if (heightRate>widthRate)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
            
        }
        
        else
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
            
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    
    else if(originalsize.height>size.height || originalsize.width>size.width)
        
    {
        
        CGImageRef imageRef = nil;
        
        
        
        if(originalsize.height>size.height)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
            
        }
        
        else if (originalsize.width>size.width)
            
        {
            
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
            
        }
        
        
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        
        
        
        　 　　CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        
        CGContextScaleCTM(con, 1.0, -1.0);
        
        
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        
        
        UIGraphicsEndImageContext();
        
        CGImageRelease(imageRef);
        
        
        
        return standardImage;
        
    }
    
    
    
    //原图为标准长宽的，不做处理
    
    else
        
    {
        
        return originalImage;
        
    }
    
    
    
}
@end
