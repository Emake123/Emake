//
//  YHNoneTeamViewController.m
//  emake
//
//  Created by 张士超 on 2018/6/20.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHNoneTeamViewController.h"
#import "YHNewAuditViewController.h"
#import "YHCertificationStateViewController.h"
@interface YHNoneTeamViewController ()

@end

@implementation YHNoneTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInAuditView];
    self.title = @"我的团队";
}


-(void)addInAuditView{
    
    
    NSString * imageStr = @"tuzi02";
    
    UILabel *label = [[UILabel alloc]init];
    label.text  =@"想要创建团队拿提成吗？请先申请合伙人哦！";
    label.font = SYSTEM_FONT(AdaptFont(15));
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = ColorWithHexString(StandardBlueColor);
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-HeightRate(110));
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(WidthRate(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(WidthRate(45));
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr]];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(HeightRate(15));
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(WidthRate(0));
        make.width.mas_equalTo(WidthRate(148));
        make.height.mas_equalTo(WidthRate(116));
    }];
    
    
    
    UILabel *labelAnother = [[UILabel alloc]init];
    labelAnother.text  =@"客服热线：400-867-0211";
    labelAnother.font = SYSTEM_FONT(AdaptFont(14));
    labelAnother.textColor = ColorWithHexString(SymbolTopColor);
    labelAnother.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelAnother];
    
    [labelAnother mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(WidthRate(0));
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(imageView.mas_bottom).offset(HeightRate(15));
    }];
    
    UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lookBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [lookBtn setTitle:@"申请合伙人" forState:UIControlStateNormal];
    lookBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
    lookBtn.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
    lookBtn.layer.cornerRadius = 6;
    lookBtn.clipsToBounds = YES;
    [lookBtn addTarget:self action:@selector(lookButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lookBtn];
//    lookBtn.frame = CGRectMake(15, ScreenHeight*0.8, ScreenWidth-30, 40);
    
    [lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(WidthRate(0));
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(WidthRate(310));
        make.top.mas_equalTo(labelAnother.mas_bottom).offset(HeightRate(5));
    }];
    
}
-(void)lookButtonClick
{
    [self getcertification];
}

//　实名认证
-(void)getcertification
{
    NSString *state =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERCARDSTATE];
        NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    
    
    
    if ([state isEqualToString:@"1"]) {
        YHNewAuditViewController *vc =[[YHNewAuditViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isfail = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([state isEqualToString:@"2"]) {
        NSString *timeStr = [[NSUserDefaults standardUserDefaults] objectForKey:USERSTATECommitDate];

        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
//        vc.failReason = auditFailReason;
        vc.successDate = timeStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([state isEqualToString:@"3"]) {
        
        NSString *isCheck = [[NSUserDefaults standardUserDefaults] objectForKey:USERSISCHECK];

        if (![isCheck isEqualToString:@"1"] && [userType isEqualToString:@"1"]) {
            YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            YHNewAuditViewController *vc =[[YHNewAuditViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isfail = false;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if ([state isEqualToString:@"4"]) {
        NSString *resason =  [[NSUserDefaults standardUserDefaults] objectForKey:USERSTATEFailReason];

        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
        vc.failReason = resason;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
