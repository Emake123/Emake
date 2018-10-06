//
//  YHCertificationStateOriginalViewController.m
//  emake
//
//  Created by 谷伟 on 2017/11/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCertificationStateOriginalViewController.h"
#import "YHNewAuditViewController.h"
@interface YHCertificationStateOriginalViewController ()

@end

@implementation YHCertificationStateOriginalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    self.title =@"合伙人申请";
    [self configSubViews];
    
    UIBarButtonItem *bar =[[UIBarButtonItem alloc]initWithCustomView:[UIButton buttonWithType:UIButtonTypeCustom]];
    self.navigationItem.leftBarButtonItem = bar;
}
- (void)configSubViews{
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"renzheng"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(150));
        make.height.mas_equalTo(HeightRate(172));
        make.top.mas_equalTo((TOP_BAR_HEIGHT)+HeightRate(32));
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text =@"尚未认证";
    label.font = SYSTEM_FONT(AdaptFont(20));
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(image.mas_bottom).offset(HeightRate(16));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRate(29));
    }];
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.text = @"亲，为实现价格保护，请上传合伙人申请资料！";

    tipsLabel.font = SYSTEM_FONT(AdaptFont(14));
    tipsLabel.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [self.view addSubview:tipsLabel];
    
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(HeightRate(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRate(23));
    }];
    
    UIButton *cerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cerBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [cerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cerBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    [cerBtn setTitle:@"立即认证" forState:UIControlStateNormal];
    [cerBtn addTarget:self action:@selector(goCer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cerBtn];
    
    [cerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(45));
        make.top.mas_equalTo(tipsLabel.mas_bottom).offset(HeightRate(46));
    }];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = TextColor_BBBBBB;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    [nextBtn setTitle:@"下次再说" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(45));
        make.top.mas_equalTo(cerBtn.mas_bottom).offset(HeightRate(24));
    }];
    
}
- (void)goCer{
    
    YHNewAuditViewController *vc = [[YHNewAuditViewController alloc]init];
    vc.isfail = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)nextTime{
    
    [self.navigationController popViewControllerAnimated:YES];
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
