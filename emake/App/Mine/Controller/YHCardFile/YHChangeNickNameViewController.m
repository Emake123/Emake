//
//  YHChangeNickNameViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHChangeNickNameViewController.h"
@interface YHChangeNickNameViewController ()<UITextFieldDelegate>{
    
    UITextField *input;
    
    UIButton * confirmBtn;
    
}

@end

@implementation YHChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"昵称";
    [self addRightNavBtn:@"确定"];
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    [self configUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [confirmBtn removeFromSuperview];
}
- (void)rightBtnClick:(UIButton *)sender{
    BOOL isRight =[self validateNickname:input.text];
    if (isRight== false) {
        [self.view makeToast:@"昵称命名不正确" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    self.block(input.text);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configUI{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(55))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(55));
        
        
    }];

    input = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(55))];
    if (self.nickName) {
        input.text = self.nickName;
    }
    input.placeholder =@"还是空的，快来取个有逼格的名字吧";
    input.borderStyle = UITextBorderStyleNone;
    input.font = [UIFont systemFontOfSize:14];
    input.delegate = self;
    input.clearButtonMode = UITextFieldViewModeAlways;
    [backView addSubview:input];
    
    
    [input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(12));
        make.right.mas_equalTo(WidthRate(-5));
        make.centerY.mas_equalTo(backView.mas_centerY);
        make.height.mas_equalTo(HeightRate(55));
    }];
    
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectZero;
    [backView addSubview:deleteBtn];
    
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-12));
        make.height.mas_equalTo(WidthRate(14));
        make.width.mas_equalTo(WidthRate(14));
        make.centerY.mas_equalTo(backView.mas_centerY);
    }];
    
    
    UILabel *lableTips = [[UILabel alloc]initWithFrame:CGRectZero];
    lableTips.text = @"4-20个字符，可由中英文、数字、\"_\"、\"-\"组成";
    lableTips.font = [UIFont systemFontOfSize:10];
    lableTips.textColor = TextColor_BEC2C9;
    [self.view addSubview:lableTips];
    
    [lableTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(7);
        make.left.mas_equalTo(WidthRate(12));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(23));
    }];
    
}

- (BOOL) validateNickname:(NSString *)nickname

{
    
//    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSString *nicknameRegex = @"[a-zA-Z0-9\u4e00-\u9fa5_-]{4,20}";

    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL IsRight = [passWordPredicate evaluateWithObject:nickname];
    return IsRight;
    
}
#pragma mark---UITextfieldDelegate
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
