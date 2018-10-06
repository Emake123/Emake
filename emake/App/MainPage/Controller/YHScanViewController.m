//
//  YHScanViewController.m
//  emake
//
//  Created by 张士超 on 2018/4/27.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YHMainScanLoginViewController.h"
#import "Tools.h"
@interface YHScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,CALayerDelegate>
{
    BOOL isContinuAnimal;//判断扫描线的动画是（yes）继续还是（no）停止
}
@property(nonatomic,strong)AVCaptureDevice *device;
@property(nonatomic,strong)AVCaptureDeviceInput *input;
@property(nonatomic,strong)AVCaptureMetadataOutput *output;
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@property(nonatomic,strong)CALayer *maskLayer;
@property(nonatomic,strong)UIView *scanView;
@property(nonatomic,strong)UIImageView *readLineView;

@end

@implementation YHScanViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([Tools isTakePhoto:self] == YES) {
        isContinuAnimal = YES;

        [self scanViewQRCode];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描";
}
-(void)scanViewQRCode {
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
   
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    UIImageView * scanbgView = [[UIImageView alloc] init];
    scanbgView.image = [UIImage imageNamed:@"saomiaokuang"];
    [self.view addSubview:scanbgView];
    scanbgView.frame = CGRectMake(0.206*ScreenWidth, 0.33*ScreenHeight,  WidthRate(220),  HeightRate(220));
    
    self.scanView = scanbgView;
  
    UILabel * tipLable = [[UILabel alloc] init];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    [self.scanView addSubview:tipLable];
    tipLable.frame = CGRectMake(0, self.scanView.frame.size.height*0.5+25,  WidthRate(220),  HeightRate(220));
    tipLable.text =  @" 将二维码放入框内，即可自动扫描";

    
    self.maskLayer = [[CALayer alloc] init];
    self.maskLayer.frame = self.view.layer.bounds;
    self.maskLayer.delegate = self;
    [self.view.layer insertSublayer:self.maskLayer above:self.preview];//(self.maskLayer, above: self.preview)
    [self.maskLayer setNeedsDisplay];
    
    [_session startRunning];
    [self scanAnimalLine:isContinuAnimal];
}

//扫描线
-(void)scanAnimalLine:(BOOL)isContinu
{
    CGRect rect = CGRectMake(0, 5, WidthRate(220), 2);
    
    if (self.readLineView != nil) {
        [self.readLineView removeFromSuperview];
    }
    __weak YHScanViewController *weakSelf = self;
    self.readLineView = [[UIImageView alloc] initWithFrame:rect];
    self.readLineView.image = [UIImage imageNamed:@"saomiaoxian"];
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakSelf.readLineView.frame = CGRectMake(0, self.scanView.frame.size.height-3, WidthRate(220), 2);
        weakSelf.readLineView.animationRepeatCount = 0;
        
    } completion:^(BOOL finished) {
        
        if (isContinu == YES) {
            [self scanAnimalLine:isContinuAnimal];

        }
    }];
    [self.scanView addSubview:self.readLineView];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        if (![stringValue containsString:@"EMAKE-"]) {
            [self.view makeToast:@"二维码错误" duration:1. position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [_session startRunning];

            }];
            return;
        }
        YHMainScanLoginViewController *scan = [[YHMainScanLoginViewController alloc] init];
        scan.logId =stringValue;
        [self.navigationController pushViewController:scan animated:YES];
        
        // 2. 删除预览图层
        
        isContinuAnimal = NO;
        if (self.session != nil)
        {
            [self.session stopRunning];
        }
        
        if (self.preview != nil)
        {
            [self.preview removeFromSuperlayer];
        }
        if(self.maskLayer.delegate != nil)
        {
            self.maskLayer.delegate = nil;
        }
        
        if(self.maskLayer.delegate != nil)
        {
            self.maskLayer.delegate = nil;
        }
        if(self.scanView != nil)
        {
            [self.scanView removeFromSuperview];
        }
    }
}

//Note: 蒙板生成。需设置代理，并在退出页面时取消代理。
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    if (layer == self.maskLayer) {
        UIGraphicsBeginImageContextWithOptions(self.maskLayer.frame.size, NO, 1.0);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
        CGContextFillRect(ctx, self.maskLayer.frame);
        CGRect scanFrame = [self.view convertRect:self.scanView.frame fromView:self.scanView.superview];
        CGContextClearRect(ctx, scanFrame);
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    [_session stopRunning];
    isContinuAnimal = NO;
    if (self.maskLayer) {
        [self.maskLayer removeFromSuperlayer];
    }
    if (self.session != nil)
    {
        [self.session stopRunning];
    }
    
    if (self.preview != nil)
    {
        [self.preview removeFromSuperlayer];
    }
    if(self.maskLayer.delegate != nil)
    {
        self.maskLayer.delegate = nil;
    }
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
