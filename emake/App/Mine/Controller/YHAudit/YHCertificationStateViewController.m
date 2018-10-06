//
//  YHCertificationStateViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/10.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCertificationStateViewController.h"
#import "YHNewAuditViewController.h"
#import "YHSixTeamViewController.h"
#import "YHMineCityDelegateSuccessViewController.h"
#import "YHMineCityDelegateApplyViewController.h"
@interface YHCertificationStateViewController ()
{
    NSInteger recorderState;// 0:待审核。1:审核失败 2审核成功
}
@end

@implementation YHCertificationStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"代理商申请";
    NSString *state =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERCARDSTATE];
    recorderState = [state isEqualToString:@"2"]?1:([state isEqualToString:@"1"]?2:0);

    [self addInAuditView];
    
}
-(void)back:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)addInAuditView{
    
    NSString *title;
    NSString *title1;
    NSString *title2;
    NSArray *imageArr;
    NSString *titleColorStr1;
    NSString *titleColorStr2;

    NSString *imageStr;

    if (recorderState == 0) {
        title = @"代理商申请信息已提交，客服审核1-3个工作日";
        title1 = [NSString stringWithFormat:@"你提交的时间：%@",self.successDate];
        title2 =@"客服热线：400-867-0211";

        imageArr=@[@"0201",@"0202",@"0103"];
        titleColorStr1 = StandardBlueColor;
        titleColorStr2 = SymbolTopColor;

        imageStr = @"tuzi02";
    }else if (recorderState == 1)
    {
        title = @"很抱歉，您的代理商申请审核失败！";
        title1 = [NSString stringWithFormat:@"失败原因：%@",self.failReason] ;
        title2 = @"";
        imageArr = @[@"0201",@"0202",@"0303"];
        
        titleColorStr1 = @"FF9900";
        imageStr = @"tuzi04";

        UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [lookBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
        [lookBtn setTitle:@"重新申请" forState:UIControlStateNormal];
        lookBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
        lookBtn.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
        lookBtn.layer.borderWidth = 1;
        lookBtn.layer.cornerRadius = 6;;
        [lookBtn addTarget:self action:@selector(auditAgainButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:lookBtn];
        lookBtn.frame = CGRectMake(15, ScreenHeight*0.8, ScreenWidth-30, 40);
        

    }else if(recorderState == 2)
    {
        title =  @"恭喜您，您的代理商申请审核成功！";
        title1 = @"您可以发展自己的VIP用户啦～";
        title2 = @"";
        imageArr=@[@"0201",@"0202",@"0203"];
        imageStr = @"tuzi03";

        titleColorStr1 = StandardBlueColor;

        
        UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [lookBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
        [lookBtn setTitle:@"立即发展" forState:UIControlStateNormal];
        lookBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
//        lookBtn.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
//        lookBtn.layer.borderWidth = 1;
        lookBtn.layer.cornerRadius = 6;
        lookBtn.clipsToBounds = YES;
        [lookBtn addTarget:self action:@selector(lookButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:lookBtn];
        lookBtn.frame = CGRectMake(15, ScreenHeight*0.8, ScreenWidth-30, 40);
        
                             
                             
    }
    [self progress:self.view imageArr:imageArr];

    
    UILabel *label = [[UILabel alloc]init];
    label.text  =title;
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
    labelAnother.text  =title1;
    labelAnother.font = SYSTEM_FONT(AdaptFont(14));
    labelAnother.textColor = ColorWithHexString(titleColorStr1);
    labelAnother.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelAnother];
    
    [labelAnother mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(WidthRate(0));
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(imageView.mas_bottom).offset(HeightRate(15));
    }];
    
    UILabel *labelTime = [[UILabel alloc]init];
    labelTime.text  = title2;
    labelTime.font = SYSTEM_FONT(AdaptFont(14));
    labelTime.textColor = ColorWithHexString(titleColorStr2);
    labelTime.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelTime];
    
    [labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(WidthRate(0));
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(labelAnother.mas_bottom).offset(HeightRate(5));
    }];
    
}


-(void)lookButtonClick
{
    [[YHJsonRequest shared] usercheckCertification:@"1" SuccessBlock:^(NSString *Success) {
        
        YHMineCityDelegateSuccessViewController *vc = [[YHMineCityDelegateSuccessViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];

        
    }];
    
   
}
-(void)auditAgainButtonClick
{
    YHMineCityDelegateApplyViewController *vc = [[YHMineCityDelegateApplyViewController alloc] init];
    vc.isfail = YES;

    [self.navigationController pushViewController:vc animated:YES];
}
-(void)progress:(UIView *)bgview imageArr:(NSArray *)imageArr
{
    NSArray *titleArr = @[@"填写基本信息",@"等待客服审核",@"审核完成"];
    
    CGFloat width = (ScreenWidth-20)/3;
    for (int i = 0; i < titleArr.count; i ++) {
        
        
        UIImageView *progressImageView = [[UIImageView alloc] init];
        progressImageView.image = [UIImage imageNamed:imageArr[i]];
        progressImageView.frame = CGRectMake(10+width*i,HeightRate(15+85), width, HeightRate(16));
        [bgview addSubview:progressImageView];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = titleArr[i];
        title.font = [UIFont systemFontOfSize:AdaptFont(10)];
        title.frame = CGRectMake(10+width*i,  HeightRate(31+85), width, HeightRate(20));
        title.textColor = ColorWithHexString(@"797979");
        title.textAlignment = NSTextAlignmentCenter;
        [bgview addSubview:title];
        
    }
    
}


@end
