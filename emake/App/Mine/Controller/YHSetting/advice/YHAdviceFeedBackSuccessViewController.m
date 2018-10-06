//
//  YHAdviceFeedBackSuccessViewController.m
//  emake
//
//  Created by 谷伟 on 2018/6/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHAdviceFeedBackSuccessViewController.h"
#import "YHSettingViewController.h"
@interface YHAdviceFeedBackSuccessViewController ()

@end

@implementation YHAdviceFeedBackSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self addRigthDetailButtonIsShowCart:false];
    [self configSubViews];
}
- (void)configSubViews{
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(380));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"反馈成功";
    label.font = SYSTEM_FONT(AdaptFont(14));
    label.textColor = TextColor_666666;
    [backView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.top.mas_equalTo(HeightRate(70));
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tuzi03"]];
    [backView addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.top.mas_equalTo(label.mas_bottom).offset(HeightRate(20));
        make.width.mas_equalTo(WidthRate(148));
        make.height.mas_equalTo(HeightRate(116));
    }];
    
    UIView *shadowView = [[UIView alloc]init];
    shadowView.backgroundColor = RGBColor(242, 242, 242);
    [backView addSubview:shadowView];

    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.top.mas_equalTo(image.mas_bottom).offset(HeightRate(39));
        make.height.mas_equalTo(HeightRate(61));
        make.width.mas_equalTo(WidthRate(282));
    }];
    
    UILabel *labelText = [[UILabel alloc]init];
    labelText.numberOfLines = 0;
    labelText.text = @"感谢您对易智造的关注与支持，我们会认真处理您的反馈，尽快修复和完善相关功能。";
    labelText.font = SYSTEM_FONT(AdaptFont(13));
    labelText.textColor = TextColor_666666;
    [backView addSubview:labelText];
    
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(shadowView.mas_centerX);
        make.centerY.mas_equalTo(shadowView.mas_centerY);
        make.width.mas_equalTo(WidthRate(254));
        make.height.mas_equalTo(HeightRate(36));
    }];
    
    UIButton *shutDown = [UIButton buttonWithType:UIButtonTypeCustom];
    [shutDown setTitle:@"关闭" forState:UIControlStateNormal];
    [shutDown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shutDown.layer.cornerRadius = WidthRate(3);
    shutDown.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [shutDown addTarget:self action:@selector(shutDown) forControlEvents:UIControlEventTouchUpInside];
    shutDown.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    [self.view addSubview:shutDown];
    
    [shutDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WidthRate(322));
        make.height.mas_equalTo(HeightRate(40));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(backView.mas_bottom).offset(HeightRate(15));
    }];
}
- (void)shutDown{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[YHSettingViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
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
