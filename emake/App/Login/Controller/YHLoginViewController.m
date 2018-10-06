


//
//  YHLoginViewController.m
//  emake
//
//  Created by 袁方 on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHLoginViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YHLoginView.h"
#import "YHRegisterViewController.h"
#import "YHPasswordViewController.h"
#import "YHMQTTClient.h"
#import "FMDBManager.h"
@interface YHLoginViewController ()<UITextFieldDelegate>{
    NSString *phone;
}
@property (nonatomic, weak) UIButton *getCaptchaButton;
@property (nonatomic, weak) UIButton *loginButton;
@property YHLoginView *loginView;
@end

@implementation YHLoginViewController

#pragma mark - LifeCycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configUI];
    phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    if (phone.length <= 0 && self.isLoginValid == false) {
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.imageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image2 = [UIImage imageNamed:@"direction_left"];//direction_left copy//loginDelete
        [back setImage:image2 forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backMainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
}
-(void)backMainBtnClick:(UIButton *)button{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_MOBILEPHONE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGIN_USERID];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_USERTYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - IBActions
- (void)login {
    [self.view endEditing:YES];
    [self.view showWait:@"登录中" viewType:CurrentView];
    [MobClick event:@"Login" label:@"登录"];
    [[YHJsonRequest shared] loginWithPassword:_loginView.textPassword.text MobileNumber:_loginView.textPhone.text succeededBlock:^(YHLoginUser *loginUser) {
            [self.view makeToast:@"登录成功" duration:2 position:CSToastPositionBottom];
            [self.view hideWait:CurrentView];
            //登陆成功后跳转到tabbar
            //保存手机号码
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_loginView.textPhone.text forKey:LOGIN_MOBILEPHONE];
        [userDefaults setObject:_loginView.textPassword.text forKey:LOGIN_PASSWORD];
        [userDefaults setObject:loginUser.UserId forKey:LOGIN_USERID];
        [userDefaults setObject:loginUser.UserName forKey:LOGIN_USERNAME];
        [userDefaults setObject:loginUser.UserType forKey:LOGIN_USERTYPE];
        [userDefaults setObject:loginUser.HeadImageUrl forKey:LOGIN_HeadImageURLString];
        [userDefaults setObject:loginUser.RealName forKey:LOGIN_USERREALNAME];
        
        [userDefaults setObject:loginUser.AuditRemark forKey:USERSTATEFailReason];
        [userDefaults setObject:loginUser.ApplyTime forKey:USERSTATECommitDate];
        [userDefaults setObject:loginUser.UserIdentity forKey:VipState];
        [userDefaults setObject:loginUser.AgentState forKey:LOGIN_USERCARDSTATE];

        
        [userDefaults setObject:loginUser.PSPDId forKey:USERSTATECommitDate];
        [userDefaults setObject:loginUser.BusinessCategory forKey:USERSELECCATEGORY];
        [userDefaults setObject:loginUser.refresh_token forKey:LOGIN_Refresh_Token];//
        [userDefaults setObject:loginUser.access_token forKey:LOGIN_Access_Token];
        [userDefaults setObject:loginUser.UserStyle forKey:LOGIN_UserStyle];
        [userDefaults setObject:loginUser.StoreId forKey:LOGIN_UserStoreID];
        [userDefaults setBool:[loginUser.BusinessCategoryName isEqualToString:@"工业品"] forKey:IsIndustryCatagory];
        if ([loginUser.BusinessCategoryName isEqualToString:@"工业品"]) {
            [userDefaults setObject:@"1" forKey:LOGIN_ISSTORE];
        }else{
            [userDefaults setObject:@"1" forKey:LOGIN_ISSTORE];
        }
        if ((!loginUser.NickName)||(loginUser.NickName.length<=0) ){
            [userDefaults setObject:nil forKey:LOGIN_USERNICKNAME];
        }else{
            [userDefaults setObject:loginUser.NickName forKey:LOGIN_USERNICKNAME];
        }
        
        [Tools SaveLocalVipstateWithCatagory:loginUser.IdentityCategorys];
        
        [userDefaults setObject:loginUser.PrizeState forKey:LOGIN_UserDrawState];
        [userDefaults setBool:YES forKey:Is_Login];
        [userDefaults synchronize];
        [[YHMQTTClient sharedClient] connectToHost:MQTT_IP Port:MQTT_PORT withUserID:loginUser.UserId];
        [[FMDBManager sharedManager] initMessageListDataBaseWithUserId:loginUser.UserId];
        [[FMDBManager sharedManager] initMessageDataBaseWithUserId:loginUser.UserId];
        [[FMDBManager sharedManager] initAdditionalMessageDataBaseWithUserId:loginUser.UserId];
        [[FMDBManager sharedManager] initServerListListDataBaseWithUserID:loginUser.UserId];

        [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonRefreshMainView object:nil];
        [self getcatagoryID];
        [self.navigationController popToRootViewControllerAnimated:YES];
        } failedBlock:^(NSString *errorMessage) {
            [self.view hideWait:CurrentView];
            [self.view makeToast:errorMessage];
        }];
}
-(void)registerPhone {
    YHRegisterViewController *registervc = [[YHRegisterViewController alloc] init];
    registervc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self.navigationController pushViewController:registervc animated:YES ];
}
-(void)forgetPassword {
    [MobClick event:@"ForgetPwd" label:@"忘记密码"];
    YHPasswordViewController *passwordvc = [[YHPasswordViewController alloc] init];
    [self.navigationController pushViewController:passwordvc animated:YES ];
}
-(void)showPassword {
    CGFloat imageOff =-12;
    if (_loginView.textPassword.isSecureTextEntry) {
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_opend" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
    [_loginView.showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
    
    _loginView.textPassword.secureTextEntry = NO;
    }else{
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_closed" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
        [_loginView.showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
        _loginView.textPassword.secureTextEntry = YES;
    }
}


-(void)getcatagoryID
{
    [[YHJsonRequest shared] getCatagoryIDsSuccessBlock:^(NSArray *success) {
        
        if (success.count>0) {
            [[NSUserDefaults standardUserDefaults] setObject:success forKey:CatagoryIDs];
            
            
        }else
        {
            [self.view makeToast:@"数据异常" duration:1.5 position:CSToastPositionCenter];
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        
    }];
    
}

#pragma mark - Private

- (void)configUI{
    
    _loginView  = [[YHLoginView alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
        _loginView.textPhone.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    }
    TPKeyboardAvoidingScrollView *containerScrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:containerScrollView];
    [_loginView loginVIewWith:containerScrollView];
    [_loginView.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.registerBtn addTarget:self action:@selector(registerPhone) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.fogetBtn addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [_loginView.showPasswordBtn addTarget:self action:@selector(showPassword) forControlEvents:UIControlEventTouchUpInside];
}
@end
