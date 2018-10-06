//
//  YHPayViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHPayViewController.h"
#import "YHMemberPayTableViewCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YHSuperGroupDetailViewController.h"

@interface YHPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)BOOL isSelect;
@end

@implementation YHPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认支付";
    CGFloat topHeight = self.isHidenTopTitle==YES?0:47;
    UILabel *moneyTip = [[UILabel alloc] init];
    moneyTip.backgroundColor = ColorWithHexString(@"FFFFCC");
    moneyTip.textColor = ColorWithHexString(@"FF9900");
    moneyTip.text = [NSString stringWithFormat:@"   付%@元定金，即可参与拼团，拼团不成功，立即全额退款 ",[Tools getHaveNum:self.payOrderMoney.doubleValue]];
    moneyTip.font = [UIFont systemFontOfSize:AdaptFont(13)];
    moneyTip.numberOfLines = 0;
    [self.view addSubview:moneyTip];
    [moneyTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(topHeight) );
        
    }];
    moneyTip.hidden = self.isHidenTopTitle;
    
//    CGRectMake(0, HeightRate(47)+(TOP_BAR_HEIGHT), ScreenWidth, HeightRate(200))
    UITableView *mytable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    mytable.dataSource = self;
    mytable.delegate = self;
    mytable.scrollEnabled = false;
    mytable.backgroundColor = [UIColor whiteColor];
    mytable.sectionHeaderHeight =0;
    mytable.sectionFooterHeight = 0;
    mytable.rowHeight = HeightRate(60);
    mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mytable];
    [mytable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyTip.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(200));
    }];
    
    
    
    UIButton *payMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payMoneyButton setTitle:[NSString stringWithFormat:@"¥%@元 确认支付",[Tools getHaveNum:self.payOrderMoney.doubleValue]] forState:UIControlStateNormal];
    [payMoneyButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [payMoneyButton addTarget:self action:@selector(payMoney) forControlEvents:UIControlEventTouchUpInside];
    
    payMoneyButton.backgroundColor = ColorWithHexString(StandardBlueColor);
    payMoneyButton.layer.cornerRadius = 6;
    payMoneyButton.clipsToBounds = YES;
    [self.view addSubview:payMoneyButton];
    [payMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mytable.mas_bottom).offset(HeightRate(50));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(40));
        //        make.bottom.mas_equalTo(HeightRate(-40));
        
    }];
 
}

-(void)getSuperGroupPayData
{
    [[YHJsonRequest shared] getSuperGroupPay:self.payParams SuccessBlock:^(NSString *success) {
        
        [self doAPPayWithOrderString:success];
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeightRate(47);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(47))];
    UILabel *moneyTip = [[UILabel alloc] init];
    moneyTip.backgroundColor = ColorWithHexString(@"f2f2f2");
    moneyTip.textColor = ColorWithHexString(@"666666");
    moneyTip.text = @"     选择支付方式";
    moneyTip.font = [UIFont systemFontOfSize:AdaptFont(13)];
    moneyTip.numberOfLines = 0;
    [headView addSubview:moneyTip];
    [moneyTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(47) );
        
    }];
    return headView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        YHMemberPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMemberPayTableViewCell"];
        
        if (cell == nil) {
            cell = [[YHMemberPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHMemberPayTableViewCell"];
        }
    
//    weixinzhifu. zhifubaozhifu
    cell.payImageView.image = [UIImage imageNamed:indexPath.row  ?@"weixinzhifu":@"zhifubaozhifu"];
    cell.payName.text = indexPath.row ?@"微信支付":@"支付宝支付";
    [cell.paySelectButton addTarget:self action:@selector(paySelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
}

-(void)paySelectButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    self.isSelect = button.selected;

}
-(void)payMoney
{
    if (self.isSelect==false) {
        [self.view makeToast:@"请选择支付方式" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    [self getSuperGroupPayData];

}
- (void)doAPPayWithOrderString:(NSString *)orderString
{
    if (orderString.length==0) {
        [self.view makeToast:@"加密失败" duration:1.5 position:CSToastPositionCenter];
        
        return;
    }
    
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdk";
    
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
    NSString *resultStatus = resultDic[@"resultStatus"];
        NSInteger successState = 0;
        //8000 正在处理中 4000  订单支付失败 6001 用户中途取消/重复操作取消 6002  网络连接出错
       
            if([resultStatus isEqualToString:@"6001"])
        {
            successState =1;

        }else//取消
        {
           
            
            successState = [resultStatus isEqualToString:@"9000"]==YES?2:0;
            
            NSDictionary *dic;

            if (self.isHidenTopTitle==false) {
                
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[YHSuperGroupDetailViewController class]]) {
                        YHSuperGroupDetailViewController *vc11 = (YHSuperGroupDetailViewController *)vc;
                        [self.navigationController popToViewController:vc11 animated:YES];
                    }
                }
                dic = @{@"NsuserDefaultsPaySuccessState":@(successState),@"OrderNo":self.OrderNo};
                
            } else {
                
                [self.navigationController popViewControllerAnimated:YES];
                 dic = @{@"NsuserDefaultsPaySuccessState":@(successState)};
            }
            
           
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NsuserDefaultsPaySuccessState object:nil userInfo:dic];

        }
     
//    self.block(nil);
        NSLog(@"reslut = %@",resultDic);
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
