//
//  YHContractSighSuccessViewController.m
//  emake
//
//  Created by 张士超 on 2018/3/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHContractSighSuccessViewController.h"
#import "YHOrderManageNewViewController.h"
#import "YHOrderContractViewController.h"

@interface YHContractSighSuccessViewController ()

@end

@implementation YHContractSighSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"签订成功";//[self.IsIncludeTax isEqualToString:@"1"]? @"签订成功":@"确认成功";
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image  =  [UIImage imageNamed:@"xuanzeyinhangka02"];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(HeightRate(240));
        make.width.mas_equalTo(WidthRate(66));
        make.height.mas_equalTo(WidthRate(66));

    }];
    
    UILabel *lable = [[UILabel alloc] init];
    

  
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageview.mas_bottom).offset(8);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(200));

    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.cornerRadius = 6;
    leftBtn.layer.borderColor = SepratorLineColor.CGColor;
    [leftBtn setTitle:@"查看合同" forState:UIControlStateNormal];
    [leftBtn setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(lookMyContract) forControlEvents:UIControlEventTouchUpInside];

    leftBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lable.mas_bottom).offset(18);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(HeightRate(-55));
        make.width.mas_equalTo(WidthRate(100));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.cornerRadius = 6;
    rightBtn.layer.borderColor = SepratorLineColor.CGColor;
    [rightBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [rightBtn setTitleColor:ColorWithHexString(SymbolTopColor) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(lookMyOrder) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lable.mas_bottom).offset(18);
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(HeightRate(55));
        make.width.mas_equalTo(WidthRate(100));
        make.height.mas_equalTo(HeightRate(30));
    }];
//    if ([self.IsIncludeTax isEqualToString:@"1"]) {
        //        contract.title= @"订单合同";
        lable.text = @"合同签订成功";
//    }else
//    {
//        lable.text = @"订单已确认";
//        [leftBtn setTitle:@"查看销售订单" forState:UIControlStateNormal];
//        [rightBtn setTitle:@"查看订单" forState:UIControlStateNormal];
//
//    }
    
    

}
-(void)lookMyOrder
{
    YHOrderManageNewViewController *order = [[YHOrderManageNewViewController alloc] init];
    order.OrderState = 0;
    order.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:order animated:YES];
}
-(void)lookMyContract
{
    YHOrderContractViewController *contract = [[YHOrderContractViewController alloc] init];
    contract.contractID = self.contractId;
//    if ([self.IsIncludeTax isEqualToString:@"1"]) {
//        contract.title= @"订单合同";
//    }else
//    {
//        contract.title= @"销售订单";
//        
//    }
    contract.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contract animated:YES];
    
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
