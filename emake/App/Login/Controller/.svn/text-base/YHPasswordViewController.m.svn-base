//
//  YHPasswordViewController.m
//  emake
//
//  Created by eMake on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHPasswordViewController.h"
#import "FindPasswordView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "verificationCodeView.h"
#import "YHLoginViewController.h"
@interface YHPasswordViewController ()<UITextFieldDelegate>

@property(nonatomic,copy)NSString *StrMobilephone;
@property(nonatomic,copy)NSString *StrCode;
@property(nonatomic,copy)NSString *StrPassword;
@property FindPasswordView *passwordView;

@end

@implementation YHPasswordViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TPKeyboardAvoidingScrollView *containerScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    containerScrollView.backgroundColor = APP_THEME_MAIN_GRAY;
    [self.view addSubview:containerScrollView];
    
   _passwordView = [[FindPasswordView alloc] init];
    [_passwordView loginVIewWith:containerScrollView isInvented:NO];
    
    [_passwordView.BtnSure addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.showPasswordBtn addTarget:self action:@selector(showPassword) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image2 = [UIImage imageNamed:@"direction_left"];
    
    [back setImage:image2 forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    back.translatesAutoresizingMaskIntoConstraints =NO;
    [self.view addSubview:back];
    if (ScreenHeight == 812) {
        [back PSSetTop:HeightRate(50)];
    }else{
        [back PSSetTop:HeightRate(26)];
    }
    [back PSSetLeft:WidthRate(10)];
    [back PSSetSize:WidthRate(34) Height:HeightRate(18)];
}

-(void)showPassword
{
    
    CGFloat imageOff =-12;
    if (_passwordView.textPassword.isSecureTextEntry) {
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_opend" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
        [_passwordView.showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
        _passwordView.textPassword.secureTextEntry = NO;
    }else
    {
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_closed" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
        [_passwordView.showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
        _passwordView.textPassword.secureTextEntry = YES;
    }
    
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getCodeBtnClick
{
    [self.view endEditing:YES];
    if (![Tools isMobileNumber:_passwordView.textMobilPhone.text ]) {
        [self.view makeToast:@"手机号码格式不正确或号码错误"];
        return;
    }
    [self.view showWait:@"loading..." viewType:CurrentView];
  
    [[YHJsonRequest shared] verificationCode:_passwordView.textMobilPhone.text isRegisterOrReset:2 succeededBlock:^(NSString *successMessage) {
        
        [verificationCodeView openCountdownWithButton:_passwordView.getCodeBtn];
        if ([Tools isNum:successMessage] && successMessage.length > 0) {
            _passwordView.textCode.text = (NSString *)successMessage;
        }
        [_passwordView.getCodeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.view hideWait:CurrentView];
        [self.view makeToast:successMessage];
        
    } failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage];
    }];

}
-(void)sureBtnClick {
    [self.view endEditing:YES];
    if (_passwordView.textMobilPhone.text.length == 0) {
        [self.view makeToast:@"当前手机号为空"];
        return;
    };
     if (_passwordView.textPassword.text.length ==0 ) {
        [self.view makeToast:@"密码不能为空"];
        return;
    };
    if (_passwordView.textPassword.text.length  <6 ) {
        [self.view makeToast:@"密码不能少于6位"];
        return;
    };
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
 
    [userDefaults setObject:_passwordView.textMobilPhone.text forKey:LOGIN_MOBILEPHONE];// 用于鉴权的

    [[YHJsonRequest shared] userforget:_passwordView.textMobilPhone.text VerificationCode:_passwordView.textCode.text Password:_passwordView.textPassword.text succeededBlock:^(YHLoginUser *loginUser) {
        
        for (UIViewController *temp in self.navigationController.viewControllers) {
            
            if ([temp isKindOfClass:[YHLoginViewController class]]) {
                
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
        
        
    } failedBlock:^(NSString *errorMessage) {
        
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage];
        
    }];
    
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
