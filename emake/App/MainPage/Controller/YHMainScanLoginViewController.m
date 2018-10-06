//
//  YHMainScanLoginViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/8.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainScanLoginViewController.h"
#import "YHMainViewController.h"
@interface YHMainScanLoginViewController ()

@end

@implementation YHMainScanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描登录";
    
    UIImageView *image = [[UIImageView alloc] init];
    image.center = CGPointMake(self.view.centerX, self.view.centerY-50);
    image.bounds = CGRectMake(0, 0, WidthRate(320), HeightRate(172));
    [self.view addSubview:image];
    image.image = [UIImage imageNamed:@"saomiaodengluzhishi"];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.center = CGPointMake(self.view.centerX, ScreenHeight*0.7);
    loginBtn.bounds = CGRectMake(0, 0, WidthRate(320), HeightRate(30));
    loginBtn.layer.cornerRadius = 6;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"确认登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = ColorWithHexString(StandardBlueColor);

    [self.view addSubview:loginBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.center = CGPointMake(self.view.centerX,  ScreenHeight*0.8);
    cancelBtn.bounds = CGRectMake(0, 0, WidthRate(320), HeightRate(30));
    cancelBtn.layer.cornerRadius = 6;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderWidth = 1;
    cancelBtn.layer.borderColor = SepratorLineColor.CGColor;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:cancelBtn];
    
}

//确认完登录返回首页
-(void)loginBtnClick
{
    [[YHJsonRequest shared] userScanQRCodeLogin:self.logId SuccessBlock:^(NSString *Success) {
        
        [self.view makeToast:Success];
        
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[YHMainViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
                
            }
        }
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages];
        
    }];
    
}

-(void)cancelBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
