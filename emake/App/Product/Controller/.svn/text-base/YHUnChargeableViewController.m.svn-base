//
//  YHUnChargeableViewController.m
//  emake
//
//  Created by 谷伟 on 2017/12/10.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHUnChargeableViewController.h"

@interface YHUnChargeableViewController ()

@end

@implementation YHUnChargeableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleName;
    [self configSubViews];
    [self addRigthDetailButtonIsShowCart:false];
}
- (void)configSubViews{
    
    UIImageView *imageShow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weishouquanicon"]];
    imageShow.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageShow];
    
    [imageShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(180));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(123));
        make.height.mas_equalTo(HeightRate(125));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text =@"此版块您未授权哦！";
    label.textColor =TextColor_737273;
    label.font = SYSTEM_FONT(AdaptFont(14));
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRate(23));
        make.top.mas_equalTo(imageShow.mas_bottom).offset(HeightRate(10));
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
