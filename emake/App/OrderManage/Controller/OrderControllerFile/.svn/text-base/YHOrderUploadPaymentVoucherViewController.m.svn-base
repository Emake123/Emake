//
//  YHOrderUploadPaymentVoucherViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderUploadPaymentVoucherViewController.h"
#import "OSSClientLike.h"
#import "YHUploadPaymentSuccessViewController.h"
@interface YHOrderUploadPaymentVoucherViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    UIButton *uploadBtn;
    UIView *backView;
    UIImageView *takePhoto;
    UILabel *labelAdd;
    UIImage *uploadImage;
    NSInteger count;
    NSMutableArray *uploadImageArray;
}

@end

@implementation YHOrderUploadPaymentVoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"上传付款凭证";
    count = 0;
    uploadImageArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.view.backgroundColor = TextColor_F5F5F5;
    [self addRightNavBtn];

    [self configSubViews];
}
- (void)addRightNavBtn{
    uploadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    uploadBtn.frame =CGRectMake(0, 0, 44, 44);
    uploadBtn.translatesAutoresizingMaskIntoConstraints = NO;
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [uploadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:uploadBtn];
    [self.navigationController.view addSubview:uploadBtn];
}
- (void)configSubViews{
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(149));
    }];

    UILabel *labelTips =[[UILabel alloc]init];
    labelTips.text =@"上传凭证（最多三张）";
    labelTips.font = [UIFont systemFontOfSize:15];
    [backView addSubview:labelTips];
    
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(29));
        make.height.mas_equalTo(HeightRate(24));
        make.width.mas_equalTo(HeightRate(200));
        make.top.mas_equalTo(HeightRate(14));
    }];
    
    takePhoto = [[UIImageView alloc]init];
    takePhoto.image = [UIImage imageNamed:@"wode_shangchuan"];
    takePhoto.layer.cornerRadius = WidthRate(26);
    takePhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSelect)];
    [takePhoto addGestureRecognizer:gesture];
    [backView addSubview:takePhoto];
    
    [takePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(37));
        make.width.mas_equalTo(WidthRate(52));
        make.height.mas_equalTo(WidthRate(52));
        make.top.mas_equalTo(labelTips.mas_bottom).offset(HeightRate(12));
    }];
    
    labelAdd =[[UILabel alloc]init];
    labelAdd.text =@"添加图片";
    labelAdd.font = [UIFont systemFontOfSize:12];
    labelAdd.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:labelAdd];
    
    [labelAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(takePhoto.mas_centerX);
        make.height.mas_equalTo(HeightRate(24));
        make.top.mas_equalTo(takePhoto.mas_bottom).offset(HeightRate(2));
        make.width.mas_equalTo(HeightRate(70));
    }];
}
- (void)showSelect{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"照相机", nil];
    [sheet showInView:self.view];
}
- (void)sourceFrom:(NSInteger)flag{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    // 设置代理
    imagePickerController.delegate = self;
    
    // 设置是否需要做图片编辑，default NO
    imagePickerController.allowsEditing = YES;
    
    UIImagePickerControllerSourceType sourceType = 0;
    
    if (flag == 0) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    // 判断数据来源是否可用
    if([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        // 设置数据来源
        imagePickerController.sourceType = sourceType;
        
        // 打开相机/相册/图库
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
}
#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        [self sourceFrom:0];
        
    }else if (buttonIndex == 1) {
        
        [self sourceFrom:1];
    }
}
#pragma  mark === UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // 退出当前界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
// 选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    uploadImage = [[UIImage alloc] init];
    // 获取点击的图片
    uploadImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    [uploadImageArray addObject:uploadImage];
    [self displayImageAndLayout:uploadImageArray];
}
- (void)displayImageAndLayout:(NSMutableArray *)imageArray{
    if (imageArray.count  == 0 ) {
        [backView removeFromSuperview];
        [self configSubViews];
        return;
    }else{
        [backView removeFromSuperview];
        [self configSubViews];
        for (int i =0; i<imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = imageArray[i];
            [backView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.left.mas_equalTo(WidthRate(22));
                }else if (i == 1) {
                    make.left.mas_equalTo(WidthRate(120));
                }else if (i == 2) {
                    make.left.mas_equalTo(WidthRate(222));
                }
                make.top.mas_equalTo(HeightRate(54));
                make.width.mas_equalTo(WidthRate(80));
                make.height.mas_equalTo(HeightRate(55));
            }];
            
            
            UIButton *deleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
            deleBtn.tag = 200+ i;
            [deleBtn setImage:[UIImage imageNamed:@"mingpian_shanchu"] forState:UIControlStateNormal];
            [deleBtn addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:deleBtn];
            
            [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(imageView.mas_right).offset(-15);
                make.width.mas_equalTo(WidthRate(20));
                make.height.mas_equalTo(HeightRate(20));
                make.bottom.mas_equalTo(imageView.mas_top).offset(7);
            }];
            
            [UIView animateWithDuration:1.0 animations:^{
                [takePhoto mas_updateConstraints:^(MASConstraintMaker *make) {
                    if (i == 0) {
                        make.left.mas_equalTo(WidthRate(120));
                        takePhoto.hidden = false;
                        labelAdd.hidden = false;
                    }else if (i == 1) {
                        make.left.mas_equalTo(WidthRate(227));
                        takePhoto.hidden = false;
                        labelAdd.hidden = false;
                    }else if (i == 2) {
                        takePhoto.hidden = YES;
                        labelAdd.hidden = YES;
                    }
                    
                }];
            } completion:^(BOOL finished) {
                
            }];
    }
    }
}
- (void)deletePicture:(UIButton *)btn{
    
    [uploadImageArray removeObjectAtIndex:btn.tag-200];
    
    [self displayImageAndLayout:uploadImageArray];
    
}
- (void)uploadImage{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("gcd-group", DISPATCH_QUEUE_CONCURRENT);
    [self.view showWait:@"上传中" viewType:CurrentView];
    for (int i =0; i<uploadImageArray.count; i++) {
        
        dispatch_group_async(group, queue, ^{
            NSString *fileName = [Tools getUploadFileName];
            [[OSSClientLike sharedClient] uploadObjectAsync:uploadImageArray[i] withFileName:fileName succcessBlock:^{
            } failBLock:^{
                [self.view hideWait:CurrentView];
                [self.view makeToast:@"上传失败"];
            }];
        });
    }
    dispatch_group_notify(group, queue, ^{
        
        [self performSelectorOnMainThread:@selector(goSuccessVC) withObject:nil waitUntilDone:YES];
        
    });
}
- (void)goSuccessVC{
    
    [self.view hideWait:CurrentView];
    [self.view makeToast:@"上传成功"];
    YHUploadPaymentSuccessViewController *vc = [[YHUploadPaymentSuccessViewController alloc]init];
    vc.titlleStr = @"付款交易凭证已上传成功，客服审核中";
    vc.tipStr = @"您的付款交易凭证已提交客服审核中，请耐心等待";
    vc.navTitleStr = @"上传成功";
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
