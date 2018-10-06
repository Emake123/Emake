//
//  YHAboutViewController.m
//  emake
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHAboutViewController.h"
@interface YHAboutViewController ()

@end

@implementation YHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    self.title = @"关于";
    [self configUI];
}
- (void)configUI{
    
    UIView * backView  = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(166);
    }];
    
    UIImageView * logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    logoView.image = [UIImage imageNamed:@"login_logo"];
    [backView addSubview:logoView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 74, 23)];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    label.text =[NSString stringWithFormat:@"易智造%@",app_Version];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:label];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(36);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(logoView);
        make.top.mas_equalTo(106);
        make.width.mas_equalTo(73);
        make.height.mas_equalTo(24);
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
