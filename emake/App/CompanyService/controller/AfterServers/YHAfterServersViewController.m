//
//  YHAfterServersViewController.m
//  emake
//
//  Created by 谷伟 on 2018/1/23.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHAfterServersViewController.h"

@interface YHAfterServersViewController ()

@end

@implementation YHAfterServersViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"Service" label:@"售后服务"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"售后服务";
    UILabel *ItemTips = [[UILabel alloc]init];
    ItemTips.textColor = TextColor_666666;
    ItemTips.numberOfLines = 0;
    ItemTips.font = SYSTEM_FONT(AdaptFont(14));
    [self.view addSubview:ItemTips];
    ItemTips.text = @"1. 平台产品由专业第3方机构提供全国范围售后服务；\n\n2. 10分钟响应、1小时对接、8小时到达现场（偏远地区除外）；\n\n3. 售后服务完成后，出具公允的产品责任认定书；\n\n4.  用户可在订单中提起售后服务。";

    [ItemTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.left.mas_equalTo(15);
        make.top.mas_equalTo((TOP_BAR_HEIGHT)+15);

    }];
    
    UIImageView *bgview = [[UIImageView alloc] init];
    bgview.image = [UIImage imageNamed:@"shouhoufuwujpg-1"];
    bgview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRate(260));
        make.bottom.mas_equalTo(HeightRate(-67));
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
