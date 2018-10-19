//
//  YHRegisterViewController.m
//  emake
//
//  Created by eMake on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHRegisterViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "FindPasswordView.h"
#import "YHLoginViewController.h"
#import "verificationCodeView.h"
#import "YHProtocolViewController.h"
#import "YHMainChooseCatagoryViewController.h"
#import "YHSelectClassifyViewController.h"
@interface YHRegisterViewController ()<UITextFieldDelegate>

@property(nonatomic ,strong)UITextField *mobilephoneTextField;
@property(nonatomic,copy)NSString *strMobilephone;
@property(nonatomic,copy)NSString *strCode;
@property(nonatomic,copy)NSString *strInvatedCode;
@property(nonatomic,copy)NSString *catagoryId;

@property FindPasswordView *passwordView;

@end

@implementation YHRegisterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [userDefaults objectForKey:LOGIN_MOBILEPHONE];
    if ([userDefaults objectForKey:LOGIN_MOBILEPHONE]) {
        NSString *oldtime = [userDefaults objectForKey:phone];
        long interval2 = [[NSDate date] timeIntervalSince1970];
        long duringTime = interval2-oldtime.longLongValue;
        if (duringTime>0 && oldtime.length>0 &&duringTime <60 &&phone.length>0) {
            _passwordView.getCodeBtn.tag = 60-duringTime;
            [verificationCodeView openCountdownWithButton:_passwordView.getCodeBtn];
            _passwordView.textMobilPhone.text = phone;
        }
    }
    if (self.isBinding) {
         [self.navigationController setNavigationBarHidden:NO animated:NO];
         UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]init];
         barBtn.title=@"";
         self.navigationItem.leftBarButtonItem = barBtn;
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSFontAttributeName:[UIFont systemFontOfSize:17],
         NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"]}];
         self.title = @"绑定手机号";
    }else{
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    TPKeyboardAvoidingScrollView *containerScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    containerScrollView.backgroundColor = APP_THEME_MAIN_GRAY;
    [self.view addSubview:containerScrollView];
    
    _passwordView = [[FindPasswordView alloc] init];
        [_passwordView loginVIewWith:containerScrollView isInvented:YES];

    [_passwordView.BtnSure addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.showPasswordBtn addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.userServers addTarget:self action:@selector(goProtolVC:) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.userPermission addTarget:self action:@selector(goProtolVC:) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.userPrivate addTarget:self action:@selector(goProtolVC:) forControlEvents:UIControlEventTouchUpInside];
    [_passwordView.BtnChooseCatagory addTarget:self action:@selector(chooseCatagore) forControlEvents:UIControlEventTouchUpInside];

//     [_passwordView.textChooseCatagory addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCatagore)] ];
    
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image2 = [UIImage imageNamed:@"direction_left"];//direction_left copy
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
    
    if (self.isBinding) {
        back.hidden = YES;
    }
    
    [self configProtocolView];

}
-(void)chooseCatagore
{
    YHSelectClassifyViewController *vc = [[YHSelectClassifyViewController alloc]init];
    __block YHRegisterViewController *weakSelf = self;
    vc.block = ^(NSDictionary *Category) {
        if (Category) {
//            weakSelf.classifyLabel.textColor = [UIColor blackColor];
            weakSelf.passwordView.textChooseCatagory.text = [Category objectForKey:@"CategoryName"];
            weakSelf.catagoryId = [Category objectForKey:@"CategoryId"];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)configProtocolView{

    
    
    
}
- (void)goProtolVC:(UIButton *)sender{
    YHProtocolViewController *vc = [[YHProtocolViewController alloc]init];
    vc.URL = [NSString stringWithFormat:@"%@%ld",RegisterProtcolURL,(long)sender.tag];
    NSString *title;
    switch (sender.tag) {
        case 3:
            title = @"隐私政策";
            break;
        case 1:
            title = @"使用许可";
            break;
        case 2:
            title = @"服务条款";
            break;
        default:
            break;
    }
    vc.titleName = title;
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
//获取验证码
-(void)getCodeBtnClick{
    
    [self.view endEditing:YES];
    if (![Tools isMobileNumber:_passwordView.textMobilPhone.text ]) {
        [self.view makeToast:@"手机号格式不正确或号码错误"];
        return;
    }
    [self.view showWait:@"loading..." viewType:CurrentView];
    [[YHJsonRequest shared] verificationCode:_passwordView.textMobilPhone.text isRegisterOrReset:1 succeededBlock:^(NSString *successMessage) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_passwordView.textMobilPhone.text forKey:LOGIN_MOBILEPHONE];
        _passwordView.getCodeBtn.tag = 0;
        NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        if ([Tools isNum:successMessage] && successMessage.length>0) {
            _passwordView.textCode.text = (NSString *)successMessage;
        }
        [[NSUserDefaults standardUserDefaults] setObject:date2 forKey:_passwordView.textMobilPhone.text];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [verificationCodeView openCountdownWithButton:_passwordView.getCodeBtn];
        [self.view hideWait:CurrentView];
        [self.view makeToast:successMessage];
    } failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage];
    }];
}
//注册设置密码页面
-(void)sureBtnClick
{
    [self.view endEditing:YES];
    
   
    
    if(_passwordView.textPassword.text.length<6) {
        [self.view makeToast:@"密码不少于6位"];return;
    };
    
    if(_passwordView.textCode.text.length<0.1) {
        [self.view makeToast:@"验证码不能为空"];return;
    };
    
    if(_passwordView.textMobilPhone.text.length<0.1 ) {
        [self.view makeToast:@"手机号不能为空"];return;
    };
    if( ![Tools isMobileNumber:_passwordView.textMobilPhone.text]) {
        [self.view makeToast:@"手机号格式不正确"];
        return;
    };
//    if(self.catagoryId.length<0.1 ) {
//        [self.view makeToast:@"当前品类为空"];return;
//    };
    _passwordView.inviteText.text = _passwordView.inviteText.text.length>0?_passwordView.inviteText.text:@"";
     NSString *passwordMd5 = [Tools md5:_passwordView.textPassword.text];
    NSDictionary *parameters = @{@"MobileNumber":_passwordView.textMobilPhone.text,@"VerificationCode":_passwordView.textCode.text,@"ReferenceMobileNumber":@"",@"BusinessCategory":@"",@"Password":passwordMd5,@"client_id":@"emake_app"};
                                 
        [[YHJsonRequest shared] userRegist:parameters succeededBlock:^(YHRegesterModel *loginUser) {
            
            [self.view makeToast:@"注册成功"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:_passwordView.textMobilPhone.text forKey:LOGIN_MOBILEPHONE];
            [userDefaults setObject:loginUser.UserId forKey:LOGIN_USERID];
            [userDefaults setObject:loginUser.UserType forKey:LOGIN_USERTYPE];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[YHLoginViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
            [userDefaults setObject:_passwordView.textMobilPhone.text forKey:LOGIN_MOBILEPHONE];
            [userDefaults synchronize];
          
        
    } failedBlock:^(NSString *errorMessage) {

        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage];
    }];
}

-(void)getNewPassword {
    [MobClick event:@"Register" label:@"注册"];
    [[YHJsonRequest shared] userReset:_passwordView.textMobilPhone.text VerificationPassword:_passwordView.textCode.text Password:_passwordView.textPassword.text succeededBlock:^(YHLoginUser *loginUser) {
        [self.view makeToast:@"注册成功"];
       
    }failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage];
    }];
}

-(void)showPassword:(UIButton*)btn {
  
    CGFloat imageOff =-12;
    if (_passwordView.textPassword.isSecureTextEntry) {
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_opend" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
        [_passwordView.showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
        _passwordView.textPassword.secureTextEntry = NO;
    }else{
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_closed" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
        [_passwordView.showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
        _passwordView.textPassword.secureTextEntry = YES;
    }
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
