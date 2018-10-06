//
//  YHChangePhoneNumberViewController.m
//  emake
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHChangePhoneNumberViewController.h"
#import "verificationCodeView.h"
@interface YHChangePhoneNumberViewController ()<UITextFieldDelegate>
@property (retain, nonatomic)UIButton *commitBtn;
@property (retain, nonatomic)UIButton *getCodeBtn;
@property (retain, nonatomic)UITextField *phoneNumberTextF;
@property (retain, nonatomic)UITextField *codeTextF;

@end

@implementation YHChangePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configSubViews];
    self.title =@"更换手机号";
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    self.getCodeBtn.layer.cornerRadius = 5;
    self.getCodeBtn.layer.borderWidth = 2;
    self.getCodeBtn.layer.borderColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR].CGColor;
    self.commitBtn.userInteractionEnabled = YES;
    self.commitBtn.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
}
- (void)configSubViews{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView  mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat distance = (TOP_BAR_HEIGHT) +  (HeightRate(13));
        make.top.mas_equalTo(distance);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(100));
    }];
    UILabel *Linelabel0 = [[UILabel alloc]initWithFrame:CGRectZero];
    Linelabel0.backgroundColor = SepratorLineColor;
    [backView addSubview:Linelabel0];
    
    [Linelabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *Linelabel1 = [[UILabel alloc]initWithFrame:CGRectZero];
    Linelabel1.backgroundColor = SepratorLineColor;
    [backView addSubview:Linelabel1];
    
    [Linelabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(50));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *Linelabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
    Linelabel2.backgroundColor = SepratorLineColor;
    [backView addSubview:Linelabel2];
    
    [Linelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *passwordImage1 = [[UIImageView alloc]initWithFrame:CGRectZero];
    passwordImage1.image = [UIImage imageNamed:@"login_code"];
    [backView addSubview:passwordImage1];
    [passwordImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(25));
        make.width.mas_equalTo(WidthRate(25));
        make.centerY.mas_equalTo(backView.mas_centerY).offset(-HeightRate(25));
        
    }];
    
    UIImageView *passwordImage2 = [[UIImageView alloc]initWithFrame:CGRectZero];
    passwordImage2.image = [UIImage imageNamed:@"login_phone number"];
    [backView addSubview:passwordImage2];
    [passwordImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(25));
        make.width.mas_equalTo(WidthRate(25));
        make.centerY.mas_equalTo(backView.mas_centerY).offset(HeightRate(25));
        
    }];
    
    
    self.phoneNumberTextF =[[UITextField alloc]initWithFrame:CGRectZero];
    self.phoneNumberTextF .placeholder = @"请输入未注册手机号";
    self.phoneNumberTextF .font = [UIFont systemFontOfSize:14];
    self.phoneNumberTextF .delegate = self;
    self.phoneNumberTextF .keyboardType = UIKeyboardTypePhonePad;
    [backView addSubview:self.phoneNumberTextF];
    
    [self.phoneNumberTextF  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImage1.mas_right).offset(WidthRate(12));
        make.height.mas_equalTo(HeightRate(29));
        make.width.mas_greaterThanOrEqualTo(WidthRate(250));
        make.centerY.mas_equalTo(passwordImage1.mas_centerY).offset(HeightRate(3));
    }];
    
    
    self.codeTextF =[[UITextField alloc]initWithFrame:CGRectZero];
    self.codeTextF.placeholder = @"请输入验证码";
    self.codeTextF.delegate = self;
    self.codeTextF.secureTextEntry = true;
    self.codeTextF .keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextF.font = [UIFont systemFontOfSize:14];
    [backView addSubview:self.codeTextF];
    
    [self.codeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImage2.mas_right).offset(HeightRate(12));
        make.height.mas_equalTo(HeightRate(29));
        make.width.mas_greaterThanOrEqualTo(WidthRate(150));
        make.centerY.mas_equalTo(passwordImage2.mas_centerY).offset(HeightRate(3));
    }];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
    self.getCodeBtn.layer.cornerRadius = WidthRate(2);
    self.getCodeBtn.layer.borderWidth = WidthRate(2);
    self.getCodeBtn.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
    [self.getCodeBtn setTitleColor:TextColor_999999 forState:UIControlStateNormal];
    [self.getCodeBtn addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.getCodeBtn];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-15));
        make.height.mas_equalTo(HeightRate(28));
        make.width.mas_equalTo(WidthRate(100));
        make.centerY.mas_equalTo(passwordImage2.mas_centerY);
    }];
    
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.commitBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    self.commitBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(45));
        make.top.mas_equalTo(backView.mas_bottom).offset(HeightRate(60));
        make.left.mas_equalTo(0);
    }];
}
- (void)getCode:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (!self.phoneNumberTextF.text||self.phoneNumberTextF.text.length == 0) {
        [self.view makeToast:@"手机号不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (![Tools isMobileNumber:self.phoneNumberTextF.text]) {
        [self.view makeToast:@"手机号格式不正确" duration:1 position:CSToastPositionCenter];
        return;
    }
    [self.view showWait:@"请求中" viewType:CurrentView];
    [[YHJsonRequest shared] exchangePhoneNumberVerificationCode:self.phoneNumberTextF.text succeededBlock:^(NSString *successMessage) {
        [verificationCodeView openCountdownWithButton:self.getCodeBtn];
        [self.view hideWait:CurrentView];
        [self.view makeToast:successMessage ];
    } failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage duration:1.0 position:CSToastPositionCenter];
    }];

}
- (void)commit:(UIButton *)sender {
    
    if (!self.phoneNumberTextF.text||self.phoneNumberTextF.text.length == 0) {
        [self.view makeToast:@"手机号不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (![Tools isMobileNumber:self.phoneNumberTextF.text]) {
        [self.view makeToast:@"手机号格式不正确" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (!self.codeTextF.text||self.codeTextF.text.length == 0) {
        [self.view makeToast:@"验证码不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    [[YHJsonRequest shared] exchangePhoneNumberMobileNumber:self.phoneNumberTextF.text andVerificationCode:self.codeTextF.text succeededBlock:^(NSString *successMessage) {
        [self.view hideWait:CurrentView];
        [self.view showToast:[self.view customShowAlert:@"保存成功" image:@"pop_success"] duration:1.5 position:CSToastPositionCenter completion:^(BOOL didTap) {
            
            [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextF.text forKey:LOGIN_MOBILEPHONE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popViewControllerAnimated:YES];

        }];
    
    } failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage duration:2 position:CSToastPositionCenter];
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
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
