//
//  YHOrderPaymentVoucherDisplayViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderPaymentVoucherDisplayViewController.h"

@interface YHOrderPaymentVoucherDisplayViewController ()

@end

@implementation YHOrderPaymentVoucherDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =  TextColor_F5F5F5;
    self.title = @"付款凭证展示";
    [self configSubViews];
    
}
- (void)configSubViews{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(258));
    }];
    
    UIImageView *PaymentImageView = [[UIImageView alloc]init];
    [backView addSubview:PaymentImageView];
    
    [PaymentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.right.mas_equalTo(WidthRate(-20));
        make.top.mas_equalTo(HeightRate(20));
        make.bottom.mas_equalTo(HeightRate(-HeightRate(15)));
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
