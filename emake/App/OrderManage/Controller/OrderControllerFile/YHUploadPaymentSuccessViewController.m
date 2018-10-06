//
//  YHUploadPaymentSuccessViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHUploadPaymentSuccessViewController.h"

@interface YHUploadPaymentSuccessViewController ()

@end

@implementation YHUploadPaymentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.navTitleStr isEqualToString:@"上传成功"]) {
        
        self.title =self.navTitleStr;
        [self addRightNavBtn];

    }else if ([self.navTitleStr isEqualToString:@"开票申请"])
    {        self.title =self.navTitleStr;

    
    }
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubViews];
}
- (void)configSubViews{
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo((TOP_BAR_HEIGHT)+HeightRate(5));
        make.height.mas_equalTo(HeightRate(112));
    }];
    
    
    UIImageView * image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"wode_shangchuan"];
    [backView addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.width.mas_equalTo(WidthRate(30));
        make.height.mas_equalTo(WidthRate(30));
        make.top.mas_equalTo(HeightRate(20));
    }];
    
    UILabel *labelTips =[[UILabel alloc]init];
    labelTips.text =self.titlleStr;
    labelTips.textColor = TextColor_555555;
    labelTips.font = [UIFont systemFontOfSize:AdaptFont(16)];
    
    [backView addSubview:labelTips];
    
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(image.mas_right).offset(5);
        make.height.mas_equalTo(HeightRate(24));
        make.centerY.mas_equalTo(image.mas_centerY);
    }];
    

    UILabel *labelTipsAnother =[[UILabel alloc]init];
    labelTipsAnother.text = self.tipStr;
    labelTipsAnother.textColor = TextColor_B3B3B3;
    labelTipsAnother.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [backView addSubview:labelTipsAnother];
    
    [labelTipsAnother mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(HeightRate(24));
        make.top.mas_equalTo(image.mas_bottom).offset(10);
    }];
    

}
- (void)addRightNavBtn{
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    UILabel *rightBtnLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 30)];
    rightBtnLabel.textAlignment = NSTextAlignmentCenter;
    rightBtnLabel.text =@"完成";
    rightBtnLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:rightBtnLabel];
    
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 30);
    rightNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,0 );
    [rightNavBtn addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightNavBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}
- (void)complete{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
