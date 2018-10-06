//
//  YHMineCityDelegateViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/12.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineCityDelegateViewController.h"
#import "YHMineCityDelegateApplyViewController.h"
@interface YHMineCityDelegateViewController ()

@end

@implementation YHMineCityDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请城市代理商";
    [self getConfigView];
    
    
}


-(void)getConfigView
{
    UIImageView *topImageView =[[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"dailishangtuiguang"];
    topImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:topImageView];
    [topImageView PSSetLeft:0];
    [topImageView PSSetTop:TOP_BAR_HEIGHT];
    [topImageView PSSetSize:ScreenWidth Height:HeightRate(250)];
    
    UILabel *tipLable = [[UILabel alloc] init];
    tipLable.text = @"易智造平台城市合作项目正式启动，面向全国招募城市代理商，负责易智造平台在各城市的市场拓展，会员招募等业务内容，邀请心怀梦想的城市代理商一起开疆扩土，共同打造中国领先的区块链共享工厂平台。\n";
    tipLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    tipLable.numberOfLines = 0;
    [self.view addSubview:tipLable];
    tipLable.translatesAutoresizingMaskIntoConstraints = false;
    [tipLable PSSetWidth:WidthRate(322)];
    [tipLable PSSetBottomAtItem:topImageView Length:HeightRate(15) ];
    [tipLable PSSetLeft:WidthRate(26)];
    
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.text = @"       申请步骤";
    titleLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    titleLable.backgroundColor = ColorWithHexString(@"F2F2F2");
    [self.view addSubview:titleLable];
    titleLable.translatesAutoresizingMaskIntoConstraints = false;
    [titleLable PSSetSize:ScreenWidth Height:HeightRate(40)];
    [titleLable PSSetBottomAtItem:tipLable Length:HeightRate(10) ];
    [titleLable PSSetLeft:WidthRate(0)];
    
    UIView *stepView = [self getStepView];
    stepView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:stepView];
    [stepView PSSetSize:ScreenWidth Height:HeightRate(60)];
    [stepView PSSetBottomAtItem:titleLable Length:HeightRate(5) ];
    [stepView PSSetLeft:WidthRate(0)];
    
    UIButton *applybutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [applybutton setTitle:@"申请" forState:UIControlStateNormal];
    [applybutton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    applybutton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(16)]; ;
    applybutton.translatesAutoresizingMaskIntoConstraints = false;
    applybutton.layer.cornerRadius = 6;
    applybutton.clipsToBounds = YES;
    [applybutton addTarget:self action:@selector(applyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    applybutton.backgroundColor  = ColorWithHexString(StandardBlueColor) ;
    [self.view addSubview:applybutton];
    [applybutton PSSetSize:WidthRate(310) Height:HeightRate(40)];
    [applybutton PSSetBottomAtItem:stepView Length:HeightRate(40) ];
    [applybutton PSSetCenterXPercent:0.5];
    
    UILabel *CallLable = [[UILabel alloc] init];
    CallLable.text = @"招商电话：025—86123899—8206（芮先生）";
    CallLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    CallLable.textColor = ColorWithHexString(@"999999");
    [self.view addSubview:CallLable];
    CallLable.translatesAutoresizingMaskIntoConstraints = false;
//    [CallLable PSSetSize:ScreenWidth Height:HeightRate(40)];
    [CallLable PSSetBottomAtItem:applybutton Length:HeightRate(10)];
    [CallLable PSSetLeft:WidthRate(37)];
}

-(UIView *)getStepView
{
    UIView *stepView = [[UIView alloc] init];
    

    
   UIView *view1 = [UIView customItemBottomTitle:@"申请" AndTobImage:@"daililiucheng02" WithSize:CGSizeMake(WidthRate(30), HeightRate(60)) color:@"999999"];
    view1.translatesAutoresizingMaskIntoConstraints = false;
    [stepView addSubview:view1];
    [view1 PSSetSize:WidthRate(40 ) Height:HeightRate(60)];
    [view1 PSSetCenterHorizontalAtItem:stepView];
    [view1 PSSetCenterXPercent:0.25];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = ColorWithHexString(StandardBlueColor);
    line.translatesAutoresizingMaskIntoConstraints = false;
    [stepView addSubview:line];
    [line PSSetSize:WidthRate(50 ) Height:HeightRate(1)];
    [line PSSetCenterHorizontalAtItem:stepView];
    [line PSSetCenterXPercent:(3/8.0)];
  

    UIView *view2 = [UIView customItemBottomTitle:@"审批" AndTobImage:@"daililicheng03" WithSize:CGSizeMake(WidthRate(30), HeightRate(60)) color:@"999999"];
    view2.translatesAutoresizingMaskIntoConstraints = false;
    [stepView addSubview:view2];
    [view2 PSSetSize:WidthRate(40 ) Height:HeightRate(60)];
    [view2 PSSetCenterHorizontalAtItem:stepView];
    [view2 PSSetCenterXPercent:0.5];
  
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = ColorWithHexString(StandardBlueColor);
    line1.translatesAutoresizingMaskIntoConstraints = false;
    [stepView addSubview:line1];
    [line1 PSSetSize:WidthRate(50 ) Height:HeightRate(1)];
    [line1 PSSetCenterHorizontalAtItem:stepView];
    [line1 PSSetCenterXPercent:(5/8.0)];
    
    
    UIView *view3 = [UIView customItemBottomTitle:@"合作" AndTobImage:@"daililicheng01s" WithSize:CGSizeMake(WidthRate(30), HeightRate(60)) color:@"999999"];
    view3.translatesAutoresizingMaskIntoConstraints = false;
    [stepView addSubview:view3];
    [view3 PSSetSize:WidthRate(40 ) Height:HeightRate(60)];
    [view3 PSSetCenterHorizontalAtItem:stepView];
    [view3 PSSetCenterXPercent:(6/8.0)];
    
    
   
    return stepView;
}


-(void)applyButtonClick:(UIButton *)buttton
{
    YHMineCityDelegateApplyViewController *apply = [[YHMineCityDelegateApplyViewController alloc] init];
    [self.navigationController pushViewController:apply animated:YES];
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
