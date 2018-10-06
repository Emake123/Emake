//
//  YHShoppingInsranceViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/24.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHShoppingInsranceViewController.h"
#import "YHInsuranceSeviceViewController.h"
@interface YHShoppingInsranceViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *insurancfeeLable;
@property(nonatomic,strong)UITextField *insurancfeeTextfeild;

@end

@implementation YHShoppingInsranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"增加投保额";
    self.view.backgroundColor = ColorWithHexString(@"EBEBEB");
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(240));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
    }];
    
    
    UILabel *tipsLable = [[UILabel alloc] init];
    tipsLable.textColor = ColorWithHexString(@"666666") ;
    tipsLable.backgroundColor = ColorWithHexString(@"FFFFCC");
    tipsLable.text = @"       易智造平台人保费用0.5%，可增加保额。 ";
    tipsLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    tipsLable.textAlignment = NSTextAlignmentLeft;
    [bgview addSubview:tipsLable];
    [tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(77));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *insuranceLable = [[UILabel alloc] init];
    insuranceLable.text = [NSString stringWithFormat:@"投保额："];
    insuranceLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [bgview addSubview:insuranceLable];
    [insuranceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(HeightRate(30));
        make.top.mas_equalTo(tipsLable.mas_bottom).offset(HeightRate(16));
//        make.width.mas_equalTo(ScreenWidth- WidthRate(12));
    }];
    
    UILabel *priceSymbol = [[UILabel alloc] init];
    priceSymbol.text = [NSString stringWithFormat:@"¥"];
    
    priceSymbol.font = [UIFont systemFontOfSize:AdaptFont(28)];
    priceSymbol.textColor = ColorWithHexString(@"000000");
    [bgview addSubview:priceSymbol];
    [priceSymbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(HeightRate(30));
        make.top.mas_equalTo(insuranceLable.mas_bottom).offset(HeightRate(5));
        //        make.width.mas_equalTo(ScreenWidth- WidthRate(12));
    }];
    
    UITextField *price = [[UITextField alloc] init];
    price.text = [NSString stringWithFormat:@"%@",[Tools getHaveNum:self.totalPrice.doubleValue]];
    price.placeholder = [NSString stringWithFormat:@"%@",[Tools getHaveNum:self.originalTotalPrice.doubleValue]];
    price.delegate = self;
    price.keyboardType = UIKeyboardTypeDecimalPad;
    price.font = [UIFont systemFontOfSize:AdaptFont(28)];
    price.textColor = ColorWithHexString(StandardBlueColor);
    [bgview addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceSymbol.mas_right).offset(10);
        make.height.mas_equalTo(HeightRate(40));
        make.top.mas_equalTo(insuranceLable.mas_bottom).offset(HeightRate(5));
        make.width.mas_equalTo(WidthRate(240));
    }];
    self.insurancfeeTextfeild = price;
    
    
    UILabel *line33 = [[UILabel alloc] init];
    line33.backgroundColor = SepratorLineColor;
    [bgview addSubview:line33];
    
    [line33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(0.5));
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(price.mas_bottom).offset(HeightRate(10));
    }];
    
    UILabel *insureFee = [[UILabel alloc] init];
    
    insureFee.text = [NSString stringWithFormat:@"保费0.5%%：¥%@",[Tools getHaveNum:floorNumber(self.totalPrice.doubleValue*0.005)]];
    insureFee.font = [UIFont systemFontOfSize:AdaptFont(14)];
    insureFee.textColor = ColorWithHexString(@"999999");
    [bgview addSubview:insureFee];
    [insureFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(HeightRate(30));
        make.top.mas_equalTo(line33.mas_bottom).offset(HeightRate(5));
        //        make.width.mas_equalTo(ScreenWidth- WidthRate(12));
    }];
    self.insurancfeeLable = insureFee;
    
    UIButton *leftTipImage = [[UIButton alloc] init];
    [leftTipImage setImage:[UIImage imageNamed:@"bangzhu1"] forState:UIControlStateNormal];
    [leftTipImage addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:leftTipImage];
    [leftTipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(40));
        make.width.mas_equalTo(WidthRate(40));
        make.centerY.mas_equalTo(insureFee.mas_centerY).offset(HeightRate(0));
    }];
    
   
    UIButton *addInsuranceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addInsuranceBtn.layer.borderWidth = 1;
//    addInsuranceBtn.layer.borderColor =ColorWithHexString(StandardBlueColor).CGColor;
    [addInsuranceBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    addInsuranceBtn.layer.masksToBounds = YES;
    addInsuranceBtn.layer.cornerRadius = HeightRate(6);
    addInsuranceBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
    addInsuranceBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [addInsuranceBtn setTitle:@"确认" forState:UIControlStateNormal];
    [addInsuranceBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addInsuranceBtn];
    [addInsuranceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(12));
        make.right.mas_equalTo(WidthRate(-12));

        make.height.mas_equalTo(HeightRate(40));
        make.top.mas_equalTo(bgview.mas_bottom).offset(HeightRate(40));
//        make.width.mas_equalTo(ScreenWidth- WidthRate(12));
    }];
}
#pragma mark--button click
-(void)sureBtnClick
{
    if (self.insurancfeeTextfeild.text.doubleValue<self.originalTotalPrice.doubleValue) {
        [self.view makeToast:@"保额不能低于订单总额" duration:1.5 position:CSToastPositionCenter];
        return;
        
    }
    NSString *insuranceFeeMoney =[Tools getHaveNum:floorNumber(self.insurancfeeTextfeild.text.doubleValue*0.005)];

    _myInsurance([NSString stringWithFormat:@"保费0.5%%：¥%@",insuranceFeeMoney],self.insurancfeeTextfeild.text);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextVC
{
    [self.view endEditing:YES];
    YHInsuranceSeviceViewController *insurance = [[YHInsuranceSeviceViewController alloc] init];
    insurance.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:insurance animated:YES];
    
}
#pragma mark--button click

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSString* nba=@"2014.9.26";
//    NSArray *p=[nbacomponentsSeparatedByString:@"."];
//    if (self.insurancfeeTextfeild.text.length <= 0) {
//        [self.view makeToast:@"当前投保额不能为空" duration:1 position:CSToastPositionCenter];
//        return NO;
//    }
    if ([textField.text containsString:string] &&[string isEqualToString:@"."]) {
        [self.view makeToast:@"输入数字格式不正确" duration:1 position:CSToastPositionCenter];
        return NO;
    }

    //判断小数点的位数
    if ([textField.text containsString:@"."]) {
        NSRange ran=[textField.text rangeOfString:@"."];
        int tt=range.location-ran.location;
        if (tt <= 2){
            return YES;
        }else{
            //        [self alertView:@"亲，您最多输入两位小数"];
            return NO;
        }
    }else
    {
        return YES;
    }

  
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.text.length <= 0) {
        [self.view makeToast:@"当前投保额不能为空" duration:1 position:CSToastPositionCenter];
        return ;
    }
    if (self.insurancfeeTextfeild.text.doubleValue<self.originalTotalPrice.doubleValue) {
        [self.view makeToast:@"保额不能低于订单总额" duration:1.5 position:CSToastPositionCenter];
        return ;
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length <= 0) {
        [self.view makeToast:@"当前投保额不能为空" duration:1 position:CSToastPositionCenter];
        return ;
    }
    if (self.insurancfeeTextfeild.text.doubleValue<self.originalTotalPrice.doubleValue) {
        [self.view makeToast:@"保额不能低于订单总额" duration:1.5 position:CSToastPositionCenter];
        return ;
    }
    
    NSString *insuranceFeeMoney =[Tools getHaveNum:floorNumber(textField.text.doubleValue*0.005)];
    self.insurancfeeLable.text =[NSString stringWithFormat:@"保费0.5%%：¥%@",insuranceFeeMoney];
}
//-(BOOL)textFieldDidEndEditing:(UITextField *)textField
//{
//
//    if (textField.text.length <= 0) {
//        [self.view makeToast:@"当前投保额不能为空" duration:1 position:CSToastPositionCenter];
//        return false;
//    }
//    if (self.insurancfeeTextfeild.text.doubleValue<self.originalTotalPrice.doubleValue) {
//        [self.view makeToast:@"保额不能低于订单总额" duration:1.5 position:CSToastPositionCenter];
//        return false;
//    }
//
//    NSString *insuranceFeeMoney =[Tools getHaveNum:floorNumber(textField.text.doubleValue*0.005)];
//    self.insurancfeeLable.text =[NSString stringWithFormat:@"保费0.5%%：¥%@",insuranceFeeMoney];
//    return YES;
//}
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
