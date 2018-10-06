//
//  YHUploadCardImgaeViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/5.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHUploadCardImgaeViewController.h"
#import "OSSClientLike.h"
#import "YHMineCardViewController.h"
#import "YHCertificationViewController.h"
@interface YHUploadCardImgaeViewController (){
    
    NSString *fileName;
    
    UIImageView *cardImage;
    
    UIButton *deleteBtn;
    
    UIButton *uploadBtn;
}

@end

@implementation YHUploadCardImgaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传名片";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"E6E6E6"];
    [self configUI];
    [self getfileName];
    [self addRightNavBtn];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [uploadBtn removeFromSuperview];
}
-(void)back:(UIButton *)button
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YHMineCardViewController class]]) {
            YHMineCardViewController *revise =(YHMineCardViewController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
        }else if ([controller isKindOfClass:[YHCertificationViewController class]]) {
            YHCertificationViewController *revise =(YHCertificationViewController *)controller;
            [self.navigationController popToViewController:revise animated:YES];
        }
    }
}
- (void)configUI{
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(145))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(307));
    }];
    
    
    cardImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    cardImage.image = self.uploadImge;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteBtnShow)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteBtnHidden)];
    [cardImage addGestureRecognizer:longPressGesture];
    [cardImage addGestureRecognizer:tapGesture];
    cardImage.userInteractionEnabled = YES;
    cardImage.clipsToBounds = YES;
    [backView addSubview:cardImage];
    
    
    
     [cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(WidthRate(36));
         make.right.mas_equalTo(WidthRate(-36));
         make.top.mas_equalTo(HeightRate(44));
         make.height.mas_equalTo(HeightRate(206));
     }];
    
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.hidden = true;
    [deleteBtn setImage:[UIImage imageNamed:@"mingpianshanchu"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(delegateImage) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cardImage.mas_right).offset(WidthRate(-15));
        make.bottom.mas_equalTo(cardImage.mas_top).offset(WidthRate(15));
        make.width.mas_equalTo(WidthRate(30));
        make.height.mas_equalTo(WidthRate(30));
    }];
    
}
- (void)delegateImage{
    
    deleteBtn.hidden = true;
    cardImage.image = [UIImage imageNamed:@"wo_mingpian"];
    self.uploadImge = nil;
    
}
- (void)addRightNavBtn{
    
    uploadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    uploadBtn.translatesAutoresizingMaskIntoConstraints = NO;
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [uploadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadObjectAsync) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:uploadBtn];
    [uploadBtn PSSetLeft:WidthRate(331)];
    [uploadBtn PSSetTop:37];
    [uploadBtn PSSetSize:WidthRate(37) Height:15];
    
}
- (void)deleteBtnShow{
    
    deleteBtn.hidden = false;
}
- (void)deleteBtnHidden{
    
    deleteBtn.hidden = true;
}
- (void)uploadObjectAsync{
    
    if (!self.uploadImge) {
        return;
    }
    //压缩到0.3M以内
    NSData *data = UIImageJPEGRepresentation(self.uploadImge, 1.0);
    if (data.bytes) {
        if ([Tools fileSize:data.length] <0.3) {
            NSLog(@"图片小");
            data = UIImageJPEGRepresentation(self.uploadImge, 1.0);
        }else{
            NSLog(@"图片大");
            float pressValue = 0.3 / [Tools fileSize:data.length];
            data = UIImageJPEGRepresentation(self.uploadImge, pressValue);
        }
    }
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageData = encodedImageStr;
    [self postServersURL:imageData];
}
- (void)postServersURL:(NSString *)imageData{
    
    
    [self.view showWait:@"上传中" viewType:CurrentView];
    [[YHJsonRequest shared] postURL:imageData toServers:^(UserInfoModel *successMessagesMode) {
        
            [self.view hideWait:CurrentView];
            [self.view makeToast:@"上传成功" duration:1.0 position:CSToastPositionCenter];
            [self performSelector:@selector(goBack) withObject:nil afterDelay:1.0];
        
    } failBLock:^(NSString *errorMessage) {
        
            [self.view hideWait:CurrentView];
            [self.view makeToast:errorMessage duration:1.0 position:CSToastPositionCenter];        
    }];
}
- (void)goBack{
    
    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        if ([temp isKindOfClass:[YHMineCardViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];
        }else if ([temp isKindOfClass:[YHCertificationViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}
#pragma mark ----Interface
- (void)getfileName{
    
    fileName = [Tools getUploadFileName];
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
