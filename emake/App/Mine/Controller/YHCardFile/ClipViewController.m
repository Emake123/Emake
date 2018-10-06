//
//  ClipViewController.m
//  ClipImage
//
//  Created by zhao on 16/11/1.
//  Copyright © 2016年 zhaoName. All rights reserved.
//

#import "ClipViewController.h"
#import "ClipImageView.h"
#import "YHUploadCardImgaeViewController.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface ClipViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) ClipImageView *clipImageView;

@end

@implementation ClipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.title = @"图片裁剪";
    [self getcameraAndphoto];
}

//////////////////////////////////
//#p---mark camera
-(void)getcameraAndphoto
{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"照相机", nil];
    [sheet showInView:self.view];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 从相机界面跳转会默认隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
}
- (void)sourceFromAlbum{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // 设置代理
    imagePickerController.delegate = self;
    
    // 设置是否需要做图片编辑，default NO
    imagePickerController.allowsEditing = YES;
    
    // 判断数据来源是否可用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 设置数据来源
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        // 打开相机/相册/图库
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
}
- (void)sourceFromCamral{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // 设置代理
    imagePickerController.delegate = self;
    
    // 设置是否需要做图片编辑，default NO
    imagePickerController.allowsEditing = YES;
    
    // 判断数据来源是否可用
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 设置数据来源
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 打开相机/相册/图库
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
    
}
#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        [self sourceFromAlbum];
        
    }else if (buttonIndex == 1) {
        
        [self sourceFromCamral];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma  mark === UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // 退出当前界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
   
    UIImage * uploadImage = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];

    self.clipImageView.clipImage = uploadImage;
    
    [self.view addSubview:self.clipImageView];
    
    self.navigationItem.title = @"图片裁剪";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClipImage:)];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(successClipImage:)];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

// 取消裁剪
- (void)cancelClipImage:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 裁剪成功
- (void)successClipImage:(UIBarButtonItem *)sender
{
    UIImage *clipedImage = [self.clipImageView getClipedImage];
    if([self.delegate respondsToSelector:@selector(didSuccessClipImage:)])
    {
        if (self.backVC==YES) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        [self.delegate didSuccessClipImage:clipedImage];
        
    }

}

- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning");
}


- (UIImage *)fixOrientation:(UIImage *)originalImage
{
    if (originalImage.imageOrientation == UIImageOrientationUp) return originalImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, originalImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, originalImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height,
                                             CGImageGetBitsPerComponent(originalImage.CGImage), 0,
                                             CGImageGetColorSpace(originalImage.CGImage),
                                             CGImageGetBitmapInfo(originalImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (originalImage.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.height,originalImage.size.width), originalImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.width,originalImage.size.height), originalImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
#pragma mark -- getter

- (ClipImageView *)clipImageView
{
    if(!_clipImageView)
    {
        _clipImageView = [ClipImageView initWithFrame:CGRectMake(0, 100, Screen_Width, Screen_Height-150)];
        
        _clipImageView.midLineColor = [UIColor redColor];

        _clipImageView.clipType = ClipAreaViewTypeRect;
    }
    return _clipImageView;
}
@end
