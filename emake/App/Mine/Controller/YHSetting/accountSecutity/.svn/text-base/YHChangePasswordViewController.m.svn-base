//
//  YHChangePasswordViewController.m
//  emake
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHChangePasswordViewController.h"
#import "Tools.h"
@interface YHChangePasswordViewController ()<UITextFieldDelegate>{
    
    UIButton *commitBtn;
    UITextField *input1;
    UITextField *input2;
    UITextField *input3;
}

@end

@implementation YHChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    
    [self congigUI];
}
- (void)congigUI{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView  mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat distance = (TOP_BAR_HEIGHT) +  (HeightRate(13));
        make.top.mas_equalTo(distance);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(180));
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
        make.top.mas_equalTo(HeightRate(60));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *Linelabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
    Linelabel2.backgroundColor = SepratorLineColor;
    [backView addSubview:Linelabel2];
    
    [Linelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(120));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *Linelabel3 = [[UILabel alloc]initWithFrame:CGRectZero];
    Linelabel3.backgroundColor = SepratorLineColor;
    [backView addSubview:Linelabel3];
    
    [Linelabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *passwordImage1 = [[UIImageView alloc]initWithFrame:CGRectZero];
    passwordImage1.image = [UIImage imageNamed:@"login_password"];
    [backView addSubview:passwordImage1];
    [passwordImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(20));
        make.width.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(backView.mas_centerY).offset(-HeightRate(60));
        
    }];
    
    UIImageView *passwordImage2 = [[UIImageView alloc]initWithFrame:CGRectZero];
//    passwordImage2.image = [UIImage imageNamed:@"login_phone number"];
    passwordImage2.image = [UIImage imageNamed:@"login_password"];

    [backView addSubview:passwordImage2];
    [passwordImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(20));
        make.width.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(backView.mas_centerY).offset(0);
        
    }];
    
    UIImageView *passwordImage3 = [[UIImageView alloc]initWithFrame:CGRectZero];
    passwordImage3.image = [UIImage imageNamed:@"login_password"];
    [backView addSubview:passwordImage3];
    [passwordImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(20));
        make.width.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(backView.mas_centerY).offset(HeightRate(60));
        
    }];
    
    
    input1 =[[UITextField alloc]initWithFrame:CGRectZero];
    input1.placeholder = @"请输入原始密码";
    input1.font = [UIFont systemFontOfSize:14];
    input1.tag = 100;
    input1.delegate = self;
    input1.secureTextEntry = true;
    [backView addSubview:input1];
    
    [input1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImage1.mas_right).offset(WidthRate(12));
        make.height.mas_equalTo(HeightRate(29));
        make.width.mas_greaterThanOrEqualTo(WidthRate(250));
        make.centerY.mas_equalTo(passwordImage1.mas_centerY).offset(HeightRate(3));
    }];
    
    
    input2 =[[UITextField alloc]initWithFrame:CGRectZero];
    input2.placeholder = @"请输入新密码";
    input2.tag = 101;
    input2.delegate = self;
    input2.secureTextEntry = true;
    input2.font = [UIFont systemFontOfSize:14];
    [backView addSubview:input2];
    
    [input2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImage2.mas_right).offset(HeightRate(12));
        make.height.mas_equalTo(HeightRate(29));
        make.width.mas_greaterThanOrEqualTo(WidthRate(250));
        make.centerY.mas_equalTo(passwordImage2.mas_centerY).offset(HeightRate(3));
    }];
    
    
    
    input3 =[[UITextField alloc]initWithFrame:CGRectZero];
    input3.placeholder = @"请确认新密码";
    input3.tag = 102;
    input3.delegate = self;
    input3.font = [UIFont systemFontOfSize:14];
    input3.secureTextEntry = true;
    [backView addSubview:input3];
    
    [input3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordImage3.mas_right).offset(HeightRate(12));
        make.height.mas_equalTo(HeightRate(29));
        make.width.mas_greaterThanOrEqualTo(WidthRate(250));
        make.centerY.mas_equalTo(passwordImage3.mas_centerY).offset(HeightRate(3));
    }];
    
    
    UIButton *visualBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    visualBt1.tag = 100;
    [visualBt1 addTarget:self action:@selector(visiable:) forControlEvents:UIControlEventTouchUpInside];
    [visualBt1 setImage:[UIImage imageNamed:@"login_eyes_closed"] forState:UIControlStateNormal];
    [visualBt1 setImage:[UIImage imageNamed:@"login_eyes_opend"] forState:UIControlStateSelected];
    [backView addSubview:visualBt1];
    
    
    [visualBt1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo (WidthRate(-18));
        make.width.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(passwordImage1.mas_centerY);
        
    }];
    
    UIButton *visualBt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    visualBt2.tag = 101;
    [visualBt2 setImage:[UIImage imageNamed:@"login_eyes_closed"] forState:UIControlStateNormal];
    [visualBt2 addTarget:self action:@selector(visiable:) forControlEvents:UIControlEventTouchUpInside];
    [visualBt2 setImage:[UIImage imageNamed:@"login_eyes_opend"] forState:UIControlStateSelected];
    [backView addSubview:visualBt2];
    
    
    [visualBt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo (WidthRate(-18));
        make.width.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(passwordImage2.mas_centerY);
        
    }];
    
    
    UIButton *visualBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    visualBtn3.tag = 102;
    [visualBtn3 setImage:[UIImage imageNamed:@"login_eyes_closed"] forState:UIControlStateNormal];
    [visualBtn3 addTarget:self action:@selector(visiable:) forControlEvents:UIControlEventTouchUpInside];
    [visualBtn3 setImage:[UIImage imageNamed:@"login_eyes_opend"] forState:UIControlStateSelected];
    [backView addSubview:visualBtn3];
    
    
    [visualBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo (WidthRate(-18));
        make.width.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(passwordImage3.mas_centerY);
        
    }];
    
    commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn setTintColor:[UIColor whiteColor]];
    [commitBtn setBackgroundColor:[UIColor colorWithHexString:APP_THEME_MAIN_COLOR]];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.userInteractionEnabled = YES;
    [self.view addSubview:commitBtn];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(30);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(45));
    }];
}
- (void)visiable:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.tag ==100) {
        input1.secureTextEntry = !input1.secureTextEntry;
    }else if(sender.tag == 101){
        input2.secureTextEntry = !input2.secureTextEntry;
    }else{
        input3.secureTextEntry = !input3.secureTextEntry;
    }
}
- (void)commit{
    
    if (!input1.text||input1.text.length==0) {
        [self.view makeToast:@"原密码不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (!input2.text||input2.text.length==0) {
        [self.view makeToast:@"新密码不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (!input3.text||input3.text.length==0) {
        [self.view makeToast:@"确认新密码不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    if ([input2.text isEqualToString:input2.text] == false) {
        [self.view makeToast:@"两次输入的密码不一致" duration:1 position:CSToastPositionCenter];
        return;
    }
    NSString *old = [Tools md5:input1.text];
    NSString *new = [Tools md5:input2.text];
    NSString *new2 = [Tools md5:input3.text];

    NSDictionary *parameters = @{@"OldPassword":old,@"Password":new,@"VerificationPassword":new2};
   
    [[YHJsonRequest shared] updatePassword:parameters SuccessBlock:^(NSDictionary *successMessage) {
        
        self.block(@"success");
        [self.navigationController popViewControllerAnimated:YES];
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
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
