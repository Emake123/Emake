//
//  YHTeamInviteViewController.m
//  emake
//
//  Created by 谷伟 on 2018/1/8.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHTeamInviteViewController.h"
#import "YHMissonCreatSuccessView.h"
#import "YHCommonWebViewController.h"
@interface YHTeamInviteViewController ()
@property (nonatomic,retain)UITextField *inviteName;
@property (nonatomic,retain)NSMutableArray *selectBtnArr;
@property (nonatomic,retain)UILabel *selectLable;

@end

@implementation YHTeamInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    self.title = @"邀请好友";
    [self configSubViews];
}
- (void)configSubViews{
    
    UIImageView *bgImageView =[[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"invented.jpg"];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);


    }];
    
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 6;
    topView.clipsToBounds = YES;
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY).offset(60);
        make.centerX.mas_equalTo(bgImageView.mas_centerX);
        make.width.mas_equalTo(WidthRate(250));
        make.height.mas_equalTo(HeightRateCommon(60));
    }];
    
    UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"haomashuru"]];
    [topView addSubview:leftImage];
    
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((WidthRate(15)));
        make.width.mas_equalTo(WidthRate(24));
        make.height.mas_equalTo(WidthRate(24));
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
    self.inviteName = [[UITextField alloc]init];
    self.inviteName.backgroundColor = [UIColor whiteColor];
    self.inviteName.placeholder = @"请输入您要邀请的成员手机号";
    self.inviteName.font = SYSTEM_FONT(AdaptFont(14));
    self.inviteName.keyboardType = UIKeyboardTypePhonePad;
    self.inviteName.borderStyle = UITextBorderStyleNone;
    [topView addSubview:self.inviteName];
    
    [self.inviteName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(8));
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    self.selectBtnArr = [NSMutableArray arrayWithCapacity:2];
    
   NSString * userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];

    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"分销商" forState:UIControlStateNormal];
    [titleBtn setTitleColor:ColorWithHexString(@"FFFF00") forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(buttonSelectTitle:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    titleBtn.tag = 2;
    [self.view addSubview:titleBtn];
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((WidthRate(100)));
        make.width.mas_equalTo(WidthRate(60));
        make.height.mas_equalTo(WidthRate(40));
        make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(10));
    }];
    titleBtn.selected = YES;
//    self.selectBtn =titleBtn;
    [self.selectBtnArr addObject:titleBtn];
    
    UILabel *title1  = [[UILabel alloc] init];
    title1.backgroundColor = ColorWithHexString(@"FFFF00");
    [self.view addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleBtn.mas_left);
        make.width.mas_equalTo(WidthRate(60));
        make.height.mas_equalTo(HeightRate(2));
        make.top.mas_equalTo(titleBtn.mas_bottom);
    }];
    self.selectLable = title1;
    
    UIButton *rightTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightTitleBtn setTitle:@"B端用户" forState:UIControlStateNormal];
    [rightTitleBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [rightTitleBtn addTarget:self action:@selector(buttonSelectTitle:) forControlEvents:UIControlEventTouchUpInside];
    rightTitleBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    rightTitleBtn.tag = 4;
    [self.view addSubview:rightTitleBtn];
    [rightTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo((WidthRate(-100)));
        make.width.mas_equalTo(WidthRate(60));
        make.height.mas_equalTo(WidthRate(40));
        make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(10));
    }];
    [self.selectBtnArr addObject:rightTitleBtn];
    if (![userType isEqualToString:@"1"]) {
        rightTitleBtn.hidden = YES;
        titleBtn.hidden = YES;
        title1.hidden = YES;
    }

    UIButton *rulerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rulerBtn setTitle:@"提成规则" forState:UIControlStateNormal];
    [rulerBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
    rulerBtn.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
    rulerBtn.layer.borderWidth = 1;
    rulerBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(18));
    rulerBtn.layer.cornerRadius = 6;
    rulerBtn.clipsToBounds = YES;
    [rulerBtn addTarget:self action:@selector(goMyTeamActityRulerVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rulerBtn];
    
    [rulerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(90));
        make.height.mas_equalTo(HeightRate(30));
        make.bottom.mas_equalTo(HeightRate(-90));
    }];
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    commitBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(18));
    commitBtn.layer.cornerRadius = 6;
    commitBtn.clipsToBounds = YES;
    [commitBtn addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.right.mas_equalTo(WidthRate(-20));
        make.height.mas_equalTo(HeightRate(40));
        make.bottom.mas_equalTo(HeightRate(-40));
    }];
    
}

-(void)buttonSelectTitle:(UIButton *)button
{
    for (UIButton *btn in self.selectBtnArr) {
        if ([btn isEqual:button]) {
            [btn setTitleColor:ColorWithHexString(@"FFFF00") forState:UIControlStateNormal];
            btn.selected = YES;
            [self.selectLable mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(button.mas_left);
                make.width.mas_equalTo(WidthRate(60));
                make.height.mas_equalTo(HeightRate(2));
                make.top.mas_equalTo(button.mas_bottom);
            }];
        }else
        {
            btn.selected = NO;

            [btn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
            
        }
    }
    
    
}
- (void)goMyTeamActityRulerVC{
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.titleName = @"团队提成规则";
    NSString * userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    NSString * catagory = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    NSString *kind = [catagory isEqualToString:@"001-001"]?@"1":@"2";
    
    vc.URLString = [NSString stringWithFormat:@"%@/%@/%@",TeamActivtyInstructionURL,userType,kind];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)invite{
    [MobClick event:@"AddMembers" label:@"添加团员"];
    [self.view endEditing:YES];
    if (!self.inviteName.text||self.inviteName.text.length<=0) {
        [self.view makeToast:@"请输入您要邀请的成员手机号" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (![Tools isMobileNumber:self.inviteName.text]) {
        [self.view makeToast:@"手机号格式不正确" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    NSString *text = [NSString stringWithFormat:@"%@元",self.moneyText];
  NSString *  userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    NSString *str;
    if ([userType isEqualToString:@"1"]) {
        for (UIButton *btn in self.selectBtnArr) {
            if (btn.isSelected == YES) {
                str =[NSString stringWithFormat:@"%ld",btn.tag];;

            }
        }
    }else
    {
        str = @"4";
    }
    NSDictionary *parameter = @{@"MobileNumber":self.inviteName.text,@"ToUserType":str};

    [[YHJsonRequest shared] inviteTeamMember:parameter SuccessBlock:^(NSString *successMessage) {
        YHMissonCreatSuccessView *view = [[YHMissonCreatSuccessView alloc]initInviteTitle:self.inviteName.text missionName:self.title content:text];
        [view showAnimated];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonRefreshTeamMember object:nil];

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
