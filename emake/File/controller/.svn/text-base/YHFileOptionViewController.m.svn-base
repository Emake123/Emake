//
//  YHFileOptionViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/29.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHFileOptionViewController.h"
@interface YHFileOptionViewController ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong)UIDocumentInteractionController *documentInteractionController;
@end

@implementation YHFileOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"文件管理";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubviews];
}
- (void)configSubviews{
    
    UIImageView *fileImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    fileImage.image = [UIImage imageNamed:@"wenjian"];
    [self.view addSubview:fileImage];
    
    [fileImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(100));
        make.height.mas_equalTo(WidthRate(100));
        make.top.mas_equalTo(HeightRate(180));
    }];
    
    UILabel *fileName = [[UILabel alloc]init];
    fileName.textColor = [UIColor blackColor];
    fileName.font = SYSTEM_FONT(AdaptFont(14));
    fileName.text = self.fileModel.FileName;
    [self.view addSubview:fileName];
    
    [fileName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(fileImage.mas_bottom).offset(HeightRate(10));
    }];
    
    UILabel *fileSize = [[UILabel alloc]init];
    fileSize.textColor = TextColor_666666;
    fileSize.font = SYSTEM_FONT(AdaptFont(14));
    fileSize.text = self.fileModel.FileSize;
    [self.view addSubview:fileSize];
    
    [fileSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(fileName.mas_bottom).offset(HeightRate(10));
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn addTarget:self action:@selector(sendFile) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    [sendBtn setTitle:@"其他应用打开" forState:UIControlStateNormal];
    sendBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sendBtn];
    
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(130));
        make.height.mas_equalTo(HeightRate(45));
        make.top.mas_equalTo(fileSize.mas_bottom).offset(HeightRate(20));
    }];
}
- (void)sendFile{
    
    NSString *fileName = self.fileModel.FilePath.lastPathComponent;
    if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:fileName]]) {
        [self.view showWait:@"文件寻找中，请稍等" viewType:CurrentView];
        [[OSSClientLike sharedClient] downloadFileObjectAsyncWithFileName:fileName andDownloadTargetFile:[Tools getPath:fileName] succcessBlock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view hideWait:CurrentView];
                self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:[Tools getPath:fileName]]];
                [_documentInteractionController setDelegate:self];
                [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
            });
            
            
        } failBLock:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view hideWait:CurrentView];
                [self.view makeToast:@"文件寻找失败，操作错误" duration:1.0 position:CSToastPositionCenter];
            });
            
        }];
    }else{
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:[Tools getPath:fileName]]];
        [_documentInteractionController setDelegate:self];
        [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }
}

@end
