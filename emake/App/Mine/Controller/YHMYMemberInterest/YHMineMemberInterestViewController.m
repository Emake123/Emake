//
//  YHMineMemberInterestViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/11.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineMemberInterestViewController.h"
#import "YHMemberInterestTableViewCell.h"
#import "YHMemberPayTableViewCell.h"
#import "YHMemberExperienceViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "YHPayViewController.h"
#import "YHProductDetailsViewController.h"
#import "YHCommonWebViewController.h"
@interface YHMineMemberInterestViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,YHAlertViewDelegete>

@property(nonatomic,strong)TPKeyboardAvoidingScrollView *scroll;
@property(nonatomic,strong)NSDictionary *getDataDic;
@property(nonatomic,strong)NSMutableArray *CatagoryNameArray;

@property(nonatomic,strong)UILabel *freightMoneyLable;
@property(nonatomic,strong)UIButton *payMoneyButton;

@property(nonatomic,strong)NSMutableDictionary *reordSelectDic;
@property(nonatomic,assign)double totalPrice;
@property(nonatomic,strong)NSString * payfeightPrice;
@property(nonatomic,strong) NSString * myVipState ;
@property(nonatomic,strong) NSString * couponCodeStr ;

@end

@implementation YHMineMemberInterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的会员权益";
    self.CatagoryNameArray  = [NSMutableArray array];
    self.reordSelectDic  = [NSMutableDictionary dictionary];
    self.couponCodeStr = @"";
    [self getMyVipData];
    self.myVipState =Userdefault(VipState);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotify:) name:NsuserDefaultsPaySuccessState object:nil];
    
}
-(void)payNotify:(NSNotification *)notify
{
    
    BOOL isSuccess = notify.userInfo[@"NsuserDefaultsPaySuccessState"];
   
    YHAlertView *alert =  [[YHAlertView alloc] initWithDelegete:self Title:isSuccess?@"支付成功":@"支付失败" bottomTitle:@"客服热线：400-867-0211" ButtonTitle:isSuccess?@"会员开通成功":@"重新支付"];
    [alert showAnimated];
    
    
}
-(void)getMyVipData{
    
    [[YHJsonRequest shared] getAppVipUserSuccessBlock:^(NSDictionary *success) {
        self.getDataDic = success;
        [self configUI];

    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotify:) name:NsuserDefaultsPaySuccessState object:nil];
    
}


-(void)configUI
{
    NSArray *IdentifyCategorys = self.getDataDic[@"IdentifyCategorys"];

    TPKeyboardAvoidingScrollView *memberScrollView =[[TPKeyboardAvoidingScrollView alloc] init];
    memberScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    memberScrollView.delegate = self;
    [self.view addSubview:memberScrollView];
    [memberScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];
    self.scroll = memberScrollView;
    
    UIView *topBackView = [[UIView alloc] init];
    topBackView.backgroundColor = ColorWithHexString(@"333333");
    [memberScrollView addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(101));
    }];
    
    UIImageView *topTitleImageView = [[UIImageView alloc] init];
    topTitleImageView.image = [UIImage imageNamed:@"huiyuan01"];
    [memberScrollView addSubview:topTitleImageView];
    [topTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(15));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(120));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *topTitleLable = [[UILabel alloc] init];
    topTitleLable.text = @"易智造会员";
    topTitleLable.font = [UIFont systemFontOfSize:AdaptFont(15)];
    topTitleLable.textColor = [UIColor whiteColor];
    [topTitleImageView addSubview:topTitleLable];
    [topTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topTitleImageView.mas_centerY);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UIButton *memberExplainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    memberExplainButton.layer.borderColor = ColorWithHexString(@"CC894F").CGColor;
    memberExplainButton.layer.borderWidth = 1;
    memberExplainButton.backgroundColor = ColorWithHexString(@"F3D9AA");
    memberExplainButton.layer.cornerRadius = HeightRate(12);
    memberExplainButton.clipsToBounds = YES;
    memberExplainButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(AdaptFont(10))];
    [memberExplainButton setTitle:@"会员说明" forState:UIControlStateNormal];
    [memberExplainButton setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
    [memberExplainButton addTarget:self action:@selector(VipIntroductionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topBackView addSubview:memberExplainButton];
    [memberExplainButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(topTitleImageView.mas_centerY);
        make.top.mas_equalTo(HeightRate(15));
        make.right.mas_equalTo(-WidthRate(10));
        make.width.mas_equalTo(WidthRate(72));
        make.height.mas_equalTo(HeightRate(24));
    }];
    
    UIView *memberInfoView = [[UIView alloc] init];
    memberInfoView.backgroundColor  = ColorWithHexString(@"F3D9AA");
    memberInfoView.layer.cornerRadius = 6;
    memberInfoView.clipsToBounds = YES;
    [memberScrollView addSubview:memberInfoView];
    
    
//    NSString *VipState = Userdefault(VipState);
    if (IdentifyCategorys.count==0 || self.myVipState.integerValue==3) {
        
        [memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topTitleImageView.mas_bottom).offset(HeightRate(10));
            make.centerX.mas_equalTo(memberScrollView.mas_centerX);
            make.width.mas_equalTo(WidthRate(352));
            make.height.mas_equalTo(HeightRate(60));
        }];
        
        UIView *item1 = [self getCatagoryMemberInfoViewCatagoryName:@"未开通" memberinfo:@"会员权益：订单额9.7折"];
        [memberInfoView addSubview:item1];
        [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(10));
            make.left.mas_equalTo(WidthRate(12));
            make.width.mas_equalTo(WidthRate(352));
            make.height.mas_equalTo(HeightRate(40));
        }];
    }else if(IdentifyCategorys.count==1)
    {
        [memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topTitleImageView.mas_bottom).offset(HeightRate(10));
            make.centerX.mas_equalTo(memberScrollView.mas_centerX);
            make.width.mas_equalTo(WidthRate(352));
            make.height.mas_equalTo(HeightRate(60));
        }];
        
        NSDictionary *catagoryItem = IdentifyCategorys[0];
        NSString *freightPrice =[Tools getHaveNum:([catagoryItem[@"DisCount"] doubleValue]*100)];
        NSString *endDate = catagoryItem[@"EndAt"];
        NSString *endAt = endDate.length>10?[endDate substringToIndex:10]:endDate;
        NSString *vipStr =[NSString stringWithFormat:@"会员权益：订单额%@折，%@到期",freightPrice ,endAt];
        UIView *item1 = [self getCatagoryMemberInfoViewCatagoryName:catagoryItem[@"CategoryBName"] memberinfo:vipStr];
        [memberInfoView addSubview:item1];
        [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(1));
            make.left.mas_equalTo(WidthRate(12));
            make.width.mas_equalTo(WidthRate(352));
            make.height.mas_equalTo(HeightRate(40));
        }];
        [self.CatagoryNameArray addObject:catagoryItem[@"CategoryBName"]];
        
    }else
    {
        [memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topTitleImageView.mas_bottom).offset(HeightRate(10));
            make.centerX.mas_equalTo(memberScrollView.mas_centerX);
            make.width.mas_equalTo(WidthRate(352));
            make.height.mas_equalTo(HeightRate(90));
        }];
        for (int i= 0; i < IdentifyCategorys.count; i++) {
            NSDictionary *catagoryItem = IdentifyCategorys[i];
            CGFloat freightPrice =[catagoryItem[@"DisCount"] doubleValue] ;
            NSString *endDate = catagoryItem[@"EndAt"];
            NSString *endAt = endDate.length>10?[endDate substringToIndex:10]:endDate;
            NSString *vipStr =[NSString stringWithFormat:@"会员权益：订单额%@折，%@到期",[Tools getHaveNum:freightPrice],endAt];
            UIView *item1 = [self getCatagoryMemberInfoViewCatagoryName:catagoryItem[@"CategoryBName"] memberinfo:vipStr];
            [memberInfoView addSubview:item1];
            [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(HeightRate(40*i+5));
                make.left.mas_equalTo(WidthRate(12));
                make.width.mas_equalTo(WidthRate(352));
                make.height.mas_equalTo(HeightRate(40));
            }];
            [self.CatagoryNameArray addObject:catagoryItem[@"CategoryBName"]];

        }
      
        
    }
    
    
    UITableView *mytable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    mytable.dataSource = self;
    mytable.delegate = self;
    mytable.scrollEnabled = false;
    mytable.backgroundColor = [UIColor whiteColor];
    mytable.sectionHeaderHeight =0;
    mytable.sectionFooterHeight = 0;
    mytable.rowHeight = HeightRate(60);
    mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [memberScrollView addSubview:mytable];
    [mytable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(memberInfoView.mas_bottom).offset(HeightRate(0));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(150));
    }];
    
    UILabel *payBottomLine = [[UILabel alloc] init];
    payBottomLine.backgroundColor = ColorWithHexString(@"F2F2F2");
    [memberScrollView addSubview:payBottomLine];
    [payBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mytable.mas_bottom).offset(HeightRate(3));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(1));
    }];
    
    UITextField *FreightCodeTextfield = [[UITextField alloc] init];
    FreightCodeTextfield.placeholder = @"        输入优惠码";
    FreightCodeTextfield.backgroundColor = ColorWithHexString(@"F2F2F2");
    FreightCodeTextfield.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [memberScrollView addSubview:FreightCodeTextfield];
    [FreightCodeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payBottomLine.mas_bottom).offset(HeightRate(10));
        make.left.mas_equalTo(WidthRate(18));
        make.width.mas_equalTo(WidthRate(340));
        make.height.mas_equalTo(HeightRate(38));
    }];
    FreightCodeTextfield.delegate = self;
    
    UILabel *textBottomLine = [[UILabel alloc] init];
    textBottomLine.backgroundColor = ColorWithHexString(@"F2F2F2");
    [memberScrollView addSubview:textBottomLine];
    [textBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(FreightCodeTextfield.mas_bottom).offset(HeightRate(10));
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(1));
    }];
    
    UILabel *freightPriceLable = [[UILabel alloc] init];
    freightPriceLable.text = @"优惠价：200";
    freightPriceLable.font = [UIFont systemFontOfSize:AdaptFont(15)];
    freightPriceLable.textColor = ColorWithHexString(@"D70606");
    [memberScrollView addSubview:freightPriceLable];
    [freightPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textBottomLine.mas_bottom).offset(HeightRate(5));
        make.right.mas_equalTo(FreightCodeTextfield.mas_right);
    }];
    freightPriceLable.hidden = YES;
    self.freightMoneyLable = freightPriceLable;
    
    UIButton *tasteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tasteButton setTitle:@"免费领取30天体验" forState:UIControlStateNormal];
    [tasteButton setTitleColor:ColorWithHexString(@"CC894F") forState:UIControlStateNormal];
    tasteButton.layer.borderColor = ColorWithHexString(@"CC894F").CGColor ;
//    [tasteButton addTarget:self action:@selector(memberExpericeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    tasteButton.layer.borderWidth = 1;
    tasteButton.layer.cornerRadius = 6;
    tasteButton.clipsToBounds = YES;
    [tasteButton addTarget:self action:@selector(getMemberVibWithFreeInvalidTimeButtonClick)  forControlEvents:UIControlEventTouchUpInside];
    [memberScrollView addSubview:tasteButton];
    [tasteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textBottomLine.mas_bottom).offset(HeightRate(130));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(40));

    }];
    tasteButton.hidden = self.isExperienceVip;
    
    UIButton *payMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payMoneyButton setTitle:@"需支付0元" forState:UIControlStateNormal];
    [payMoneyButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [payMoneyButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];

    payMoneyButton.backgroundColor = ColorWithHexString(@"D70606");
    payMoneyButton.layer.cornerRadius = 6;
    payMoneyButton.clipsToBounds = YES;
    [memberScrollView addSubview:payMoneyButton];
    self.payMoneyButton = payMoneyButton ;
    [payMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tasteButton.mas_bottom).offset(HeightRate(15));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(40));
//        make.bottom.mas_equalTo(HeightRate(-40));

    }];
}

-(void)payButtonClick
{
    if(self.payfeightPrice.floatValue==0)
    {
        [self.view makeToast:@"请选择要开通的品类" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    NSArray *arr = self.reordSelectDic.allKeys;
    if (arr.count>0) {
        NSString* arrJson = [arr mj_JSONString];
        YHPayViewController *vc = [[YHPayViewController alloc] init];
        vc.isHidenTopTitle = YES;
        vc.payOrderMoney = self.payfeightPrice;
        vc.payParams = @{@"TotalAmount":@"0.01",@"PayClass":@"1",@"Params":@{@"CategoryBIds":arr,@"CouponCode":self.couponCodeStr}};
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        [self.view makeToast:@"请选择要开通的品类" duration:1.5 position:CSToastPositionCenter];
    }
   
    
}

-(void)memberExpericeButtonClick
{
    YHMemberExperienceViewController *vc = [[YHMemberExperienceViewController alloc] init];
    vc.VipDate = self.getDataDic[@"OneYearLater"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)CheckVipCoupon:(NSString *)couponStr
{
    if (couponStr.length<=0) {
        return;
    }

    [[YHJsonRequest shared] getAppCheckVipCoupon:@{@"CouponCode":couponStr} SuccessBlock:^(NSArray *success) {
        self.freightMoneyLable.hidden = false;
        self.couponCodeStr = couponStr;
        [self conculatePrice:success];
       
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}
-(void)conculatePrice:(NSArray *)success
{
    double freightTotalMoney = self.totalPrice;

    double freightMoney = 0;
    if (self.reordSelectDic.count ==2 ) {
        for (NSDictionary *dic in success) {
            freightMoney += [dic[@"CouponPrice"] doubleValue];
            
        }
    }else if (self.reordSelectDic.count ==1)
    {
        for (NSDictionary *dic in success) {
            NSString *key =self.reordSelectDic.allKeys.firstObject;
            if ([key isEqualToString:dic[@"CategoryBId"]]) {
                freightMoney += [dic[@"CouponPrice"] doubleValue];
                
            }
            
            
        }
        
    }
    
    if (self.reordSelectDic.count>0) {
        self.freightMoneyLable.text = [NSString stringWithFormat:@"优惠：¥%@",[Tools getHaveNum:freightMoney]];
//        [self.payMoneyButton setTitle:[NSString stringWithFormat:@"需支付%@元",[Tools getHaveNum:(freightTotalMoney-freightMoney)]] forState:UIControlStateNormal];
        
    }
    self.payfeightPrice = [Tools getHaveNum:(freightTotalMoney-freightMoney)];
        [self.payMoneyButton setTitle:[NSString stringWithFormat:@"需支付%@元",[Tools getHaveNum:(freightTotalMoney-freightMoney)]] forState:UIControlStateNormal];

    
}
#pragma mark---table delegate datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section ==0) {
        NSArray *catagorys = self.getDataDic[@"Categorys"];
        
        return catagorys.count;
//    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==1) {
        YHMemberPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMemberPayTableViewCell"];
        
        if (cell == nil) {
            cell = [[YHMemberPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHMemberPayTableViewCell"];
        }
     
        return cell;
    }else
    {
    YHMemberInterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMemberInterestTableViewCell"];
    
    if (cell == nil) {
        cell = [[YHMemberInterestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHMemberInterestTableViewCell"];
    }
        NSArray *catagorys = self.getDataDic[@"Categorys"];
        NSDictionary *catagoryDict = catagorys[indexPath.row];
        
        if (self.myVipState.integerValue==3) {
            cell.memberStateLable.text = @"（待开通）";

        }else
        { if ([self.CatagoryNameArray containsObject:catagoryDict[@"CategoryName"]]) {
            cell.memberStateLable.text = @"（已开通）";
            
            
         }else
         {
            
            cell.memberStateLable.text = @"（待开通）";
         }
            
        }
        
        
        if (cell.slectBgView==YES) {
            cell.memberView.backgroundColor = ColorWithHexString(@"FFFFCC");
            [self.reordSelectDic setObject:catagoryDict[@"VipFee"] forKey:catagoryDict[@"CategoryId"]];
            self.totalPrice += [catagoryDict[@"VipFee"] doubleValue];
            

        }else
        {
            if ([self.reordSelectDic.allKeys containsObject:catagoryDict[@"CategoryId"]]) {
                [self.reordSelectDic removeObjectForKey:catagoryDict[@"CategoryId"]];

            }
            cell.memberView.backgroundColor = ColorWithHexString(@"ffffff");

        }
        
        [self conculatePrice:nil];

    cell.memberMoneyLable.text =[NSString stringWithFormat:@"¥%@／年",catagoryDict[@"VipFee"]] ;
    cell.catagoryNameLable.text =catagoryDict[@"CategoryName"];
    return cell;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSArray *catagorys = self.getDataDic[@"Categorys"];
        NSDictionary *catagoryDict = catagorys[indexPath.row];
        
        if (![self.CatagoryNameArray containsObject:catagoryDict[@"CategoryName"]] || self.myVipState.integerValue==3) {
        YHMemberInterestTableViewCell *cell = ( YHMemberInterestTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//            cell.memberView.backgroundColor = ColorWithHexString(@"FFFFCC");
            cell.slectBgView =  !cell.slectBgView;
            self.totalPrice = 0;
            [tableView reloadData];
        }
    }
    
}

-(void)getMemberVibWithFreeInvalidTimeButtonClick
{
    [[YHJsonRequest shared] getAppVipExperienceSuccessBlock:^(NSDictionary *success) {
        
        [self.view makeToast:@"领取成功" duration:1.5 position:CSToastPositionCenter];

    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}
-(void)getMemberVibWithPayedMoneyInvalidTimeButtonClick
{
    
}
#pragma mark----自定义view
-(UIView *)getCatagoryMemberInfoViewCatagoryName:(NSString *)CatagoryName memberinfo:(NSString *)memberinfo
{
    UIView *memberInfoView = [[UIView alloc] init];
    
    UILabel *catagoryLable = [[UILabel alloc] init];
    catagoryLable.backgroundColor = ColorWithHexString(@"ffffff");
    catagoryLable.text = CatagoryName;
    catagoryLable.textAlignment = NSTextAlignmentCenter;
    catagoryLable.layer.borderWidth =1;
    catagoryLable.layer.borderColor = ColorWithHexString(@"CC894F").CGColor;
    catagoryLable.layer.cornerRadius = HeightRate(15);
    catagoryLable.clipsToBounds = YES;
    [memberInfoView addSubview:catagoryLable];
    [catagoryLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(100));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *memberLable = [[UILabel alloc] init];
//    memberLable.backgroundColor = ColorWithHexString(@"ffffff");
    memberLable.text = memberinfo;
    memberLable.font = [UIFont systemFontOfSize:AdaptFont(11)];
    memberLable.textAlignment = NSTextAlignmentCenter;
    [memberInfoView addSubview:memberLable];
    [memberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(catagoryLable.mas_centerY);
        make.left.mas_equalTo(catagoryLable.mas_right).offset(5);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    
    return memberInfoView;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.reordSelectDic.count == 0) {
        [self.view makeToast:@"请先选择经营品类" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    [self CheckVipCoupon:textField.text];
}
-(void)alertViewRightBtnClick:(id )alertView  currentTitle:(NSString *)currentTitle
{
    YHAlertView *alertViewS = (YHAlertView *)alertView;

    //    @"查看详情":@"重新支付"
    [alertViewS closeAnimated];

    if ([currentTitle isEqualToString:@"会员开通成功"]) {

        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[YHProductDetailsViewController class]]) {
                YHProductDetailsViewController *vc11 = (YHProductDetailsViewController *)vc;
                [self.navigationController popToRootViewControllerAnimated:vc11];

                return;
            }
        }
        [self.navigationController popToRootViewControllerAnimated:YES];


    }else
    {

    }
    
}

-(void)VipIntroductionButtonClick
{
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"会员说明";
    vc.URLString = UserVipInstructionURL;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
