//
//  YHProductEmptyViewController.m
//  emake
//
//  Created by 谷伟 on 2017/12/12.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHProductEmptyViewController.h"

@interface YHProductEmptyViewController ()

@end

@implementation YHProductEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleName;
    [self configSubViews];
}
- (void)configSubViews{
    
    UIImageView *imageShow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shangjiazhong"]];
    [self.view addSubview:imageShow];
    
    [imageShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(195));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(125));
        make.height.mas_equalTo(HeightRate(125));
    }];
    UILabel *label = [[UILabel alloc]init];
    label.text =@"正在上架中\n敬请期待...";
    label.textColor =TextColor_737273;
    label.numberOfLines = 2;
    label.font = SYSTEM_FONT(AdaptFont(14));
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRate(44));
        make.width.mas_equalTo(WidthRate(80));
        make.top.mas_equalTo(imageShow.mas_bottom).offset(HeightRate(16));
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
