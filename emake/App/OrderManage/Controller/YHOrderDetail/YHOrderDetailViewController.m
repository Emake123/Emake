//
//  YHOrderDetailViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/22.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHOrderDetailViewController.h"
#import "YHOrderTableViewCell.h"
#import "YHInsuranceSeviceViewController.h"
#import "YHOrderInsuranceViewController.h"
#import "YHOrderContractViewController.h"
#import "YHOrderInvoiceInfoViewController.h"
#import "YHQualificationApplyViewController.h"
#import "YHInvoiceListViewController.h"
#import "ChatNewViewController.h"
#import "adressModel.h"
#import "YHLabel.h"
#import "YHLookUpLogisticsViewController.h"
#import "accountInformationView.h"
@interface YHOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,YHListViewDelegate>
{
    accountInformationView *   account;
}
@property(nonatomic,strong)UITableView *mytable;
@property(nonatomic,assign)BOOL isShowInsuranceView;
//@property(nonatomic,assign)BOOL isStore;
//@property(nonatomic,assign)BOOL isIndustry;
@property(nonatomic,assign)BOOL isShowAdress;
@property(nonatomic,assign)CGFloat orderStateHeight;

@property(nonatomic,assign)CGFloat bottomHeight;

@end

@implementation YHOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self addRigthDetailButtonIsShowCart:false];
    
    self.isShowAdress = self.contract.Address.length;
    self.isShowInsuranceView =   self.contract.InsurdAmount.floatValue > @"2000".floatValue;
    self.isShowAdress = self.contract.Address.length>0?YES:(self.contract.ShippingInfo.count>0?YES:false);
    self.orderStateHeight = (self.contract.OrderState.integerValue>-2&&self.contract.OrderState.integerValue<3)?40:0;
    
//    NSString *isstoreStr = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
//    self.isStore = [isstoreStr isEqualToString:@"1"];
    self.view.backgroundColor = SepratorLineColor;
    
        if ([self.contract.OrderState isEqualToString:@"-2"] || self.contract.RemainInvoiceAmount.doubleValue<=0 || [self.contract.IsIncludeTax isEqualToString:@"0"]) {
            self.bottomHeight = 120;
        } else {
            
            self.bottomHeight = 170;
        }
        [self confinStoreBottomView];
   
 
    CGFloat tableHeight = (ScreenHeight)-(TOP_BAR_HEIGHT)-(HeightRate(self.bottomHeight));
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0,TOP_BAR_HEIGHT, ScreenWidth, tableHeight) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.estimatedRowHeight = HeightRate(40);
    table.estimatedSectionHeaderHeight = 60.0;
    table.rowHeight = UITableViewAutomaticDimension;

    [self.view addSubview:table];
    _mytable = table;
    
    

}


#pragma mark-- tableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contract.goodsModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHOrder *order = self.contract.goodsModelArr[indexPath.row];
    
    YHOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[YHOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [cell setRequestData:order withIsStore:YES isHidenFreight:(_contract.OrderState.integerValue == -2?YES:NO)];
    return cell;
    
}

#pragma mark-- tableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isShowAdress ==false) {
        return HeightRate(35);
    }
    return HeightRate(101);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat  progressViewHeight = [self.contract.OrderState isEqualToString:@"-2"]?0:70+self.orderStateHeight;
    
    CGFloat hight =  self.isShowInsuranceView?(110+progressViewHeight):68+progressViewHeight;
    return HeightRate(hight);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(67))];
    backView.backgroundColor = ColorWithHexString(@"99CCFF");
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, ScreenWidth, HeightRate(67));  // 设置显示的frame
////    gradientLayer.colors = @[(id)ColorWithHexString(@"99CCFF").CGColor];  // 设置渐变颜色
////        gradientLayer.locations = @[@0.2, @0.3, @0];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
//    gradientLayer.startPoint = CGPointMake(0, 0);   //
//    gradientLayer.endPoint = CGPointMake(1, 0);     //
//    [backView.layer addSublayer:gradientLayer];
//   
    adressModel *Model;
    if (self.contract.Address.length>0) {
         Model = [adressModel mj_objectWithKeyValues:self.contract.Address];
    }else if(self.contract.shipingModelArr.count>0)
    {
        NSDictionary *shipFirstDict = self.contract.ShippingInfo.firstObject;
        Model = [adressModel initWithName:shipFirstDict[@"Receiver"] MobileNumber:shipFirstDict[@"ReceiverPhone"] Adress:shipFirstDict[@"ReceiverAddress"]];
        
    }
    UIView *adressView = [self getCustomTopAdressView:Model];
    [backView addSubview:adressView];
    
    [self TitleHeadView:backView item:adressView];
        
    
        
   

    return backView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat  progressViewHeight = [self.contract.OrderState isEqualToString:@"-2"]?0:70+self.orderStateHeight;

    CGFloat hight =  self.isShowInsuranceView?(148+progressViewHeight):84+progressViewHeight;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(hight))];
    footView.backgroundColor =ColorWithHexString(@"ffffff");
    
    UILabel *line;
    if (self.isShowInsuranceView==YES) {
        UIButton *leftTipImage = [[UIButton alloc] init];
        [leftTipImage setImage:[UIImage imageNamed:@"bangzhu1"] forState:UIControlStateNormal];
        [leftTipImage addTarget:self action:@selector(helpButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:leftTipImage];
        [leftTipImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(40));
            make.width.mas_equalTo(WidthRate(34));
            make.top.mas_equalTo(HeightRate(0));
        }];
        
        
        
        UIImageView *imageright = [[UIImageView alloc] init];
        imageright.image = [UIImage imageNamed:@"right01"];
        imageright.contentMode = UIViewContentModeScaleAspectFit;
        [footView addSubview:imageright];
        [imageright mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(20));
            make.width.mas_equalTo(WidthRate(15));
            make.top.mas_equalTo(HeightRate(10));
            
        }];
        
        imageright.hidden = YES;

//
//        if (self.contract.OrderState.integerValue != -22 && self.contract.OrderState.integerValue != 20) {
//
//            UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [rightbtn addTarget:self action:@selector(rightBtnAddInsuranceClick:) forControlEvents:UIControlEventTouchUpInside];
//            [footView addSubview:rightbtn];
//            [rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(WidthRate(-5));
//                make.height.mas_equalTo(HeightRate(35));
//                make.width.mas_equalTo(WidthRate(130));
//                make.top.mas_equalTo(HeightRate(5));
//            }];
//            imageright.hidden = false;
//
//        }
        
        UILabel *insureFee = [[UILabel alloc] init];
        insureFee.textColor = ColorWithHexString(@"5792F0") ;
        insureFee.text = [NSString stringWithFormat:@"人保保费0.5%%：¥%@",[Tools getHaveNum:(floorNumber(self.contract.InsurdAmount.doubleValue*0.005))]];
        insureFee.font = [UIFont systemFontOfSize:AdaptFont(12)];
        insureFee.textAlignment = NSTextAlignmentRight;
        [footView addSubview:insureFee];
        [insureFee mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(imageright.mas_left).offset(WidthRate(-5));
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(20));
            make.top.mas_equalTo(HeightRate(10));
        }];
   
        line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [footView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(1));
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(insureFee.mas_bottom).offset(HeightRate(10));
            
        }];
    
    }

    UILabel *tipsRightLableTop = [[UILabel alloc] init];
    tipsRightLableTop.textColor = ColorWithHexString(SymbolTopColor) ;
    tipsRightLableTop.font = [UIFont systemFontOfSize:AdaptFont(13)];
    tipsRightLableTop.textAlignment = NSTextAlignmentRight;
    [footView addSubview:tipsRightLableTop];
    [tipsRightLableTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(0.01));
        if (self.isShowInsuranceView==YES) {
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(5));
        }else
        {
            make.top.mas_equalTo(HeightRate(5));
        }
    }];
    NSString *sympol = self.contract.CouponValue.doubleValue>0?@"-":@"";
    NSString *couponTitle = @"优惠券：";

    NSString *couponStr =[NSString stringWithFormat:@"%@%@¥%@",couponTitle,sympol,[Tools getHaveNum:self.contract.CouponValue.doubleValue]];
    NSMutableAttributedString *couponAttstr = [[NSMutableAttributedString alloc] initWithString:couponStr];
    [couponAttstr addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(@"F8695D") range:NSMakeRange(couponTitle.length, couponStr.length-couponTitle.length)];
    
    UILabel * couponLable = [[UILabel alloc] init];
    couponLable.textColor = ColorWithHexString(@"000000") ;
    couponLable.attributedText = couponAttstr;
    couponLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    couponLable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:couponLable];
    [couponLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(tipsRightLableTop.mas_bottom).offset(HeightRate(5));
    }];
    
    if ([self.contract.OrderStateName isEqualToString:@"已失效"] || self.contract.OrderState.integerValue == -2) {
        couponLable.hidden = YES;
        [couponLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(0.01));

        }];
    }
    UILabel *priceLable = [[UILabel alloc] init];
    priceLable.textColor = ColorWithHexString(StandardBlueColor) ;
    priceLable.text = [NSString stringWithFormat:@"¥%@", [Tools getHaveNum:self.contract.ContractAmount.doubleValue]];
    priceLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    priceLable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(couponLable.mas_bottom).offset(HeightRate(0));
       
    }];
    
    

    
    
    UILabel *fixlable = [[UILabel alloc] init];
    fixlable.textColor = ColorWithHexString(@"000000") ;
    fixlable.text = [NSString stringWithFormat:@"共%@件商品  合计：",self.contract.ContractQuantity];
    fixlable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    fixlable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:fixlable];
    [fixlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(priceLable.mas_left).offset(0);
        make.height.mas_equalTo(HeightRate(20));
        make.centerY.mas_equalTo(priceLable.mas_centerY).offset(HeightRate(0));
    }];
    
    UILabel *tipsRightLable = [[UILabel alloc] init];
    tipsRightLable.textColor = ColorWithHexString(SymbolTopColor) ;
//    tipsRightLable.text = [NSString stringWithFormat:@"%@",self.contract.GoodsAddValue];
    tipsRightLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    tipsRightLable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:tipsRightLable];
    [tipsRightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(priceLable.mas_bottom).offset(HeightRate(5));
        
    }];

//    if (self.contract.TaxPrice.doubleValue>0) {
//        tipsRightLable.textColor = [UIColor blackColor];
//        NSString *str = @"增值税";
//
//        NSString *priceStr =   [NSString stringWithFormat:@"%@:¥%@",str,[Tools getHaveNum:self.contract.TaxPrice.doubleValue]];//orders.GoodsAddValue
//
//        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:priceStr];
//        [att addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(SymbolTopColor) range:NSMakeRange(str.length+1, priceStr.length-str.length-1)];
//
//
//        tipsRightLableTop.attributedText = att;
//        [tipsRightLableTop mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(HeightRate(20));
//        }];
//        [tipsRightLable mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
//        tipsRightLable.hidden = YES;
//        tipsRightLableTop.hidden = false;
//
//    } else {
        tipsRightLableTop.hidden = YES;
        tipsRightLable.hidden = false;
        
        [tipsRightLableTop mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(0.01));
        }];
        [tipsRightLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(30));
        }];
        tipsRightLable.text = [NSString stringWithFormat:@"(%@)",self.contract.GoodsAddValue];
        
//    }
    
    UILabel *lineT = [[UILabel alloc] init];
    lineT.backgroundColor = SepratorLineColor;
    [footView addSubview:lineT];
    lineT.translatesAutoresizingMaskIntoConstraints = NO;
    [lineT PSSetLeft:0];
    [lineT PSSetSize:ScreenWidth Height:1];
    [lineT PSSetBottomAtItem:tipsRightLable Length:HeightRate(8)];
    if (![self.contract.OrderState isEqualToString:@"-2"]) {
        
    UILabel *  lable =  [self progressView:footView byItem:lineT rate:0 name:@"已付金额"];
        if (self.contract.OrderState.integerValue!=3) {
            UILabel *stateLable = [[UILabel alloc] init];
            stateLable.textColor = ColorWithHexString(@"666666") ;
            //        stateLable.text =@"●预付款 ———●生产中———●生产完成 ———●尾款";
            stateLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
            stateLable.textAlignment = NSTextAlignmentCenter;
            [footView addSubview:stateLable];
            [stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(0));
                make.height.mas_equalTo(HeightRate(30));
                make.width.mas_equalTo(ScreenWidth);
                make.top.mas_equalTo(lable.mas_bottom).offset(HeightRate(0));
                
            }];
            NSString *str =@"●付预付款 ———●生产中———●生产完成 ———●尾款";
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            
            if (self.contract.OrderState.integerValue==0) {
                
                
            }else if (self.contract.OrderState.integerValue==1)
            {
                [attrStr addAttribute:NSForegroundColorAttributeName
                                value:ColorWithHexString(StandardBlueColor)
                                range:NSMakeRange(0, 13)];
            }else if( self.contract.OrderState.integerValue==2)
            {
                [attrStr addAttribute:NSForegroundColorAttributeName
                                value:ColorWithHexString(StandardBlueColor)
                                range:NSMakeRange(0, 21)];
            }
            stateLable.attributedText = attrStr;

        }
       

    }else
    {
        lineT.hidden = YES;
    }
    
    
    
    return footView;
}

-(UILabel *)getHaveMoneyState:(UIView *)bgview bottomItem:(UILabel *)item name:(NSString *)name price:(NSString *)price state:(NSString *)state ispay:(BOOL)ispay
{
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.textColor = ColorWithHexString(@"1E1E1E") ;
    nameLable.text = [NSString stringWithFormat:@"%@",name];
    nameLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [bgview addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(item.mas_bottom).offset(HeightRate(5));
        
    }];
    
    UILabel *priceLable = [[UILabel alloc] init];
    priceLable.textColor = ColorWithHexString(@"1E1E1E") ;
    priceLable.text = [NSString stringWithFormat:@"%@",price];
    priceLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [bgview addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLable.mas_right).offset(WidthRate(0));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(item.mas_bottom).offset(HeightRate(5));
        
    }];
    
    UILabel *stateLable = [[UILabel alloc] init];

    stateLable.text = [NSString stringWithFormat:@"%@",state];
    stateLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    stateLable.textAlignment = NSTextAlignmentCenter;
    stateLable.layer.cornerRadius = 8;
    stateLable.clipsToBounds = YES;
    [bgview addSubview:stateLable];
    [stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-15));
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(53);
        make.top.mas_equalTo(item.mas_bottom).offset(HeightRate(5));
        
    }];
    
    if(ispay==YES)
    {
        stateLable.backgroundColor = ColorWithHexString(SymbolTopColor) ;
        stateLable.textColor = ColorWithHexString(@"ffffff") ;


    }else
    {
        stateLable.backgroundColor = ColorWithHexString(@"F2F2F2") ;
        stateLable.textColor = ColorWithHexString(@"999999") ;

    }
    
    return nameLable;
    
}
#pragma mark--buttonclick
//调zhuan到保险服务页面
-(void)helpButtonClick
{
    YHInsuranceSeviceViewController *insurance = [[YHInsuranceSeviceViewController alloc] init];
    insurance.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:insurance animated:YES];
}
//调zhuan到保单页面
-(void)rightBtnAddInsuranceClick:(UIButton *)button
{
    
//    YHOrderContract *contract = self.dataArray[button.tag-100];
    
    YHOrderInsuranceViewController *vc = [[YHOrderInsuranceViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.contract = self.contract.ContractNo;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//wode 合同
-(void)uploadContractButtonClickedWithOrder
{
    
    YHOrderContractViewController *contractViewController = [[YHOrderContractViewController alloc] init];
    contractViewController.contractID = self.contract.ContractNo;
     contractViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contractViewController animated:YES];
    
}

//申请发票
- (void)paymentVoucherClickedWithOrder:(UIButton *)button {
    
    
    
    if (self.contract.RemainInvoiceAmount.doubleValue>0) {
    
        [[YHJsonRequest shared] getUserInvoiceManageSuccessBlock:^(NSArray *invoicelist) {
            
            
            if (invoicelist.count > 0) {
                
                YHOrderInvoiceInfoViewController *invoice = [[YHOrderInvoiceInfoViewController alloc] init];
                
                invoice.hidesBottomBarWhenPushed = YES;
                invoice.contractNo = self.contract.ContractNo;
                [self.navigationController pushViewController:invoice animated:YES];
                
            }else
            {
                
                YHQualificationApplyViewController *invoice = [[YHQualificationApplyViewController alloc]init];
                invoice.ContractNo = self.contract.ContractNo;
                invoice.refNo = @"";
                invoice.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:invoice animated:YES];
                
            }
            
        } fialureBlock:^(NSString *errorMessages) {
            
            [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter ];
            
        }];
    }else
    {
        if ([button.currentTitle isEqualToString:@"查看发票"]) {
            YHInvoiceListViewController *vc = [[YHInvoiceListViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            return;
        }
    }
}

//客服
- (void)customerServiceButtonClick:(UIButton *)button {
    NSString *userID = Userdefault(LOGIN_USERID) ;
    [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:_contract.StoreId];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    vc.storeName = _contract.StoreName;
    vc.storeAvata =_contract.StorePhoto;
    vc.isCatagory =![_contract.CategoryBName containsString:@"输配电"];

    if([button.currentTitle isEqualToString:@"合同洽谈"])
    {
        YHOrder *order = self.contract.goodsModelArr.firstObject;
        vc.isFromCartConfirm = YES;
        YHChatOrderContract *chatOrder = [YHChatOrderContract initWithContractNo:self.contract.ContractNo GoodsTitle:order.GoodsTitle ContractAmount:self.contract.ContractAmount ContractQuantity:self.contract.ContractQuantity GoodsSeriesIcon:order.GoodsSeriesIcon GoodsExplain:order.GoodsExplain IsStore:[NSString stringWithFormat:@"%d",(![self.contract.CategoryBName isEqualToString:@"输配电"])]];
        NSString *jsonstr = [chatOrder mj_JSONString];
        vc.isPostOrder = true;
        vc.jsonStr = jsonstr;
    }
    vc.listID = [NSString stringWithFormat:@"%@_%@",self.contract.StoreId,userID];
    vc.storeID = self.contract.StoreId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//保险服务打款 = 删除订单
-(void)rcommBtnClick:(UIButton *)button{
    
    if([button.currentTitle isEqualToString:@"付预付款"]){
        [MobClick event:@"PaymentAccount" label:@"付款账号"];
        account = [[accountInformationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        account.listViewDelegate = self;
        account.section = 0;
        account.flag = 10;
        account.lableTexTAliment = NSTextAlignmentCenter;
        account.NumberOfLines = 3;
        [[UIApplication sharedApplication].keyWindow addSubview:account];
        [account.closeButton addTarget:self action:@selector(dimissview) forControlEvents:UIControlEventTouchUpInside];
    }else if([button.currentTitle isEqualToString:@"删除订单"]){
        //        YHOrderContract *contract = self.dataArray[button.tag-100];
        [self deleteOrderButtonClickedWithOrder:self.contract];
    }else if([button.currentTitle isEqualToString:@"合同洽谈"]){
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:self.contract.StoreId];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
        ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
        YHOrder *order = self.contract.goodsModelArr.firstObject;
        vc.isFromCartConfirm = YES;
        vc.isCatagory =![_contract.CategoryBName containsString:@"输配电"];

        YHChatOrderContract *chatOrder = [YHChatOrderContract initWithContractNo:self.contract.ContractNo GoodsTitle:order.GoodsTitle ContractAmount:self.contract.ContractAmount ContractQuantity:self.contract.ContractQuantity GoodsSeriesIcon:order.GoodsSeriesIcon GoodsExplain:order.GoodsExplain IsStore:[NSString stringWithFormat:@"%d",(![self.contract.CategoryBName isEqualToString:@"输配电"])]];
        NSString *jsonstr = [chatOrder mj_JSONString];
        vc.storeName = self.contract.StoreName;
        vc.storeAvata = self.contract.StorePhoto;
        vc.isPostOrder = true;
        vc.jsonStr = jsonstr;
        vc.isPostOrder = YES;
        vc.listID = [NSString stringWithFormat:@"%@_%@",self.contract.StoreId,userID];
        vc.storeID = self.contract.StoreId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([button.currentTitle isEqualToString:@"物流详情"])
    {
        YHLookUpLogisticsViewController *vc = [[YHLookUpLogisticsViewController alloc] init];
        vc.logsticsNumber = self.contract.ContractNo;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)dimissview
{
    [UIView animateWithDuration:.5 animations:^{
        
        account.center = self.view.center;
        account.bounds = CGRectZero;
        [account removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
    }];
    
}
//订单删除
- (void)deleteOrderButtonClickedWithOrder:( YHOrderContract *)orderContract {
    //初始化警告框
    
    YHAlertView *alert = [[YHAlertView alloc] initWithTitle:@"确定删除订单" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    alert.model = orderContract;
    
    alert.rightBlock = ^(NSString *str){   // 1
        
        
                [self.view showWait:@"删除中" viewType:CurrentView];
                [[YHJsonRequest shared] deleteOrderManageContratNo:self.contract.ContractNo SucceededBlock:^(NSString *successMessage) {
                    
                    [self.view hideWait:CurrentView];
                 
                    [self.view makeToast:successMessage duration:2 position:CSToastPositionCenter];
                } failedBlock:^(NSString *errorMessage) {
                    [self.view hideWait:CurrentView];
                    
                }];
        
        
        
    };
    [alert showAnimated];
    
    
    
}
#pragma mark---accountInformationView 打款界面 delegate
-(NSString *)ListView:(UIView *)listView withIndex:(NSInteger)index flag:(NSInteger)flag section:(NSInteger)section
{
    //因为contract的所有的
    NSString *insuranceSting;
    NSString *paySting;
    
    switch (index) {
        case 0:
        {
            paySting  = [NSString stringWithFormat:@"收款方:%@",self.contract.NameOfPartyA];
            insuranceSting = [NSString stringWithFormat:@"收款方:%@",self.contract.BankOfPartyA];
            
        }
            break;
        case 1:
        {
            paySting  = [NSString stringWithFormat:@"开户行:%@",self.contract.BankOfPartyA];
            insuranceSting = [NSString stringWithFormat:@"开户行:%@",self.contract.NameOfPartyA];
            
        }
            break;
        case 2:
        {
            paySting  = [NSString stringWithFormat:@"银行卡账号:%@",self.contract.AccountOfPartyA];
            insuranceSting   = [NSString stringWithFormat:@"银行卡账号:%@",self.contract.AccountOfPartyA];
        }
            break;
        default:
            break;
    }
    return paySting;
}
#pragma mark---bottom UI
-(void)confinBottomView{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(self.bottomHeight));
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(2));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(HeightRate(0));
        
    }];

    UILabel *contractNo = [[UILabel alloc] init];
    contractNo.textColor = ColorWithHexString(@"666666") ;
    contractNo.text = [NSString stringWithFormat:@"合同号：%@",self.contract.ContractNo];
    contractNo.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [bottomView addSubview:contractNo];
    [contractNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(10));
    }];
    
    
    UIButton *myContractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [myContractBtn addTarget:self action:@selector(uploadContractButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    myContractBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [myContractBtn setImage:[UIImage imageNamed:@"right02"] forState:UIControlStateNormal];
    [bottomView addSubview:myContractBtn];
//    [myContractBtn setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
    [myContractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(30));
        make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(15));
        make.width.mas_equalTo(WidthRate(80));
    }];
    
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = SepratorLineColor;
    [bottomView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(1));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(contractNo.mas_bottom).offset(HeightRate(5));
        
    }];
    UILabel *line3;
    if (![self.contract.OrderState isEqualToString:@"-2"]) {
        
        
        
        if ([self.contract.IsIncludeTax isEqualToString:@"1"]) {
            
            UILabel *invoceLable = [[UILabel alloc] init];
            invoceLable.textColor = ColorWithHexString(@"666666") ;
            invoceLable.text = [NSString stringWithFormat:@"申请开票"];
            invoceLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
            [bottomView addSubview:invoceLable];
            [invoceLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(10));
                make.height.mas_equalTo(HeightRate(20));
                make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(5));
                
            }];
            
            UIButton *myinvocetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [myinvocetBtn addTarget:self action:@selector(paymentVoucherClickedWithOrder:) forControlEvents:UIControlEventTouchUpInside];
            [myinvocetBtn setImage:[UIImage imageNamed:@"right01"] forState:UIControlStateNormal];
            myinvocetBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
            
            [bottomView addSubview:myinvocetBtn];
            [myinvocetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(WidthRate(-10));
                make.height.mas_equalTo(HeightRate(30));
                make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(5));
                make.width.mas_equalTo(WidthRate(80));
                
            }];
            
            myinvocetBtn.userInteractionEnabled = YES;
            
            if (self.contract.RemainInvoiceAmount.doubleValue>0) {
                [myinvocetBtn setTitle:@"申请开票" forState:UIControlStateNormal];
                
            }else
            {
                [myinvocetBtn setTitle:@"查看发票" forState:UIControlStateNormal];
                
            }
            [myinvocetBtn setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
            
            line3 = [[UILabel alloc] init];
            line3.backgroundColor = SepratorLineColor;
            [bottomView addSubview:line3];
            [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(0));
                make.height.mas_equalTo(HeightRate(1));
                make.width.mas_equalTo(ScreenWidth);
                make.top.mas_equalTo(myinvocetBtn.mas_bottom).offset(HeightRate(5));
                
            }];
        }
        
        
        
    }
    
    UIButton *myCustomsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myCustomsBtn.layer.borderWidth = 1;
    myCustomsBtn.layer.borderColor =ColorWithHexString(StandardBlueColor).CGColor;
    [myCustomsBtn setTitleColor:ColorWithHexString(@"999999") forState:UIControlStateNormal];
    myCustomsBtn.layer.masksToBounds = YES;
    myCustomsBtn.layer.cornerRadius = HeightRate(15);
    myCustomsBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [myCustomsBtn addTarget:self action:@selector(customerServiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [myCustomsBtn setImage:[UIImage imageNamed:@"dingdankefu"] forState:UIControlStateNormal];
    [myCustomsBtn setTitle:@"  小二" forState:UIControlStateNormal];
    [bottomView addSubview:myCustomsBtn];
    [myCustomsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(30));
        if (line3) {
            make.top.mas_equalTo(line3.mas_bottom).offset(HeightRate(10));
        }else
        {
            make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(10));
        }
        make.width.mas_equalTo(WidthRate(120));
        
    }];
}

-(void)confinStoreBottomView
{

    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(self.bottomHeight));
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = ColorWithHexString(@"EEEEEE");
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(6));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(HeightRate(0));
        
    }];
    
    UILabel *contractNo = [[UILabel alloc] init];
    contractNo.textColor = ColorWithHexString(@"666666") ;
    contractNo.text = [NSString stringWithFormat:@"订单号：%@",self.contract.ContractNo];
    contractNo.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [bottomView addSubview:contractNo];
    [contractNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(10));
    }];
    
    UILabel *dateLable = [[UILabel alloc] init];
    dateLable.textColor = ColorWithHexString(@"666666") ;
    dateLable.text = [NSString stringWithFormat:@"创建时间：%@",self.contract.InDate];
    dateLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [bottomView addSubview:dateLable];
    [dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(contractNo.mas_bottom).offset(HeightRate(5));
        
    }];
    
    UIButton *myContractBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    myContractBtn.layer.borderWidth = 1;
//    myContractBtn.layer.borderColor =SepratorLineColor.CGColor;
//    myContractBtn.layer.masksToBounds = YES;
//    myContractBtn.layer.cornerRadius = HeightRate(15);
    [myContractBtn setImage:[UIImage imageNamed:@"right01"] forState:UIControlStateNormal];
//    [myContractBtn setTitle:@">" forState:UIControlStateNormal];
    [myContractBtn addTarget:self action:@selector(uploadContractButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    myContractBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    //    myContractBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
    [bottomView addSubview:myContractBtn];
    [myContractBtn setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
    [myContractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(60));
        make.height.mas_equalTo(HeightRate(30));
        make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(15));
        make.width.mas_equalTo(WidthRate(160));
    }];
    myContractBtn.hidden = YES;
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = SepratorLineColor;
    [bottomView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(1));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(dateLable.mas_bottom).offset(HeightRate(5));
        
    }];
    UILabel *line3;
    if (![self.contract.OrderState isEqualToString:@"-2"]) {
        
        myContractBtn.hidden = false;
        
        if ([self.contract.IsIncludeTax isEqualToString:@"1"] && self.contract.RemainInvoiceAmount.doubleValue>0) {
            
            UILabel *invoceLable = [[UILabel alloc] init];
            invoceLable.textColor = ColorWithHexString(@"666666") ;
            invoceLable.text = [NSString stringWithFormat:@"发票"];
            invoceLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
            //    nameLable.textAlignment = NSTextAlignmentRight;
            [bottomView addSubview:invoceLable];
            [invoceLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(10));
                make.height.mas_equalTo(HeightRate(20));
                make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(5));
                
            }];
            
            UIButton *myinvocetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            myinvocetBtn.layer.borderWidth = 1;
//            myinvocetBtn.layer.borderColor =SepratorLineColor.CGColor;
//            myinvocetBtn.layer.masksToBounds = YES;
//            myinvocetBtn.layer.cornerRadius = HeightRate(15);
            [myinvocetBtn addTarget:self action:@selector(paymentVoucherClickedWithOrder:) forControlEvents:UIControlEventTouchUpInside];
            [myinvocetBtn setImage:[UIImage imageNamed:@"right01"] forState:UIControlStateNormal];
            myinvocetBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
            
            [bottomView addSubview:myinvocetBtn];
            [myinvocetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(WidthRate(60));
                make.height.mas_equalTo(HeightRate(30));
                make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(5));
                make.width.mas_equalTo(WidthRate(160));
                
            }];
            
            myinvocetBtn.userInteractionEnabled = YES;
            
            
            line3 = [[UILabel alloc] init];
            line3.backgroundColor = SepratorLineColor;
            [bottomView addSubview:line3];
            [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(0));
                make.height.mas_equalTo(HeightRate(1));
                make.width.mas_equalTo(ScreenWidth);
                make.top.mas_equalTo(myinvocetBtn.mas_bottom).offset(HeightRate(5));
                
            }];
        }
    
    
        
    }
    
 
    
    UIButton *myConmmonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myConmmonBtn.layer.borderWidth = 1;
    myConmmonBtn.layer.borderColor =ColorWithHexString(StandardBlueColor).CGColor;
    [myConmmonBtn setTitleColor:ColorWithHexString(@"999999") forState:UIControlStateNormal];
    myConmmonBtn.layer.masksToBounds = YES;
    myConmmonBtn.layer.cornerRadius = HeightRate(15);
    myConmmonBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [myConmmonBtn addTarget:self action:@selector(rcommBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if(![self.contract.OrderStateName isEqualToString:@"已失效"])
    {
        
        if (self.contract.OrderState.integerValue == -2) {
            
            [myConmmonBtn setTitle:@"合同洽谈" forState:UIControlStateNormal];
            
        }else if(self.contract.OrderState.integerValue == 3 )
        {
            [myConmmonBtn setTitle:@"物流详情" forState:UIControlStateNormal];
        }else if(self.contract.OrderState.integerValue == -1 )
        {
            [myConmmonBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }else if(self.contract.OrderState.integerValue == 0 )
        {
            [myConmmonBtn setTitle:@"付预付款" forState:UIControlStateNormal];
            
        }else
        {
            [myConmmonBtn setTitle:@"付尾款" forState:UIControlStateNormal];

        }
 
    }else
    {
        [myConmmonBtn setTitle:@"删除订单" forState:UIControlStateNormal];

    }
    [bottomView addSubview:myConmmonBtn];
    [myConmmonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(30));
        if (line3) {
            make.top.mas_equalTo(line3.mas_bottom).offset(HeightRate(10));
        }else
        {
            make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(10));
        }
        make.width.mas_equalTo(WidthRate(120));
        
    }];
    if (self.contract.OrderState.integerValue != -2 ||[self.contract.OrderStateName isEqualToString:@"已失效"] ) {
        UIButton *myCustomsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myCustomsBtn.layer.borderWidth = 1;
        myCustomsBtn.layer.borderColor =ColorWithHexString(StandardBlueColor).CGColor;
        [myCustomsBtn setTitleColor:ColorWithHexString(@"999999") forState:UIControlStateNormal];
        myCustomsBtn.layer.masksToBounds = YES;
        myCustomsBtn.layer.cornerRadius = HeightRate(15);
        myCustomsBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [myCustomsBtn addTarget:self action:@selector(customerServiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        if (self.contract.OrderState.integerValue == -2) {
//
//            [myCustomsBtn setTitle:@"合同洽谈" forState:UIControlStateNormal];
//
//        }else
//        {
            [myCustomsBtn setImage:[UIImage imageNamed:@"kufu3030"] forState:UIControlStateNormal];
            [myCustomsBtn setTitle:@"  小二" forState:UIControlStateNormal];
//        }
        
        [bottomView addSubview:myCustomsBtn];
        [myCustomsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(myConmmonBtn.mas_left).offset(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(30));
            if (line3) {
                make.top.mas_equalTo(line3.mas_bottom).offset(HeightRate(10));
            }else
            {
                make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(10));
            }
            make.width.mas_equalTo(WidthRate(120));
            
        }];
    }
    
}


-(UIView *)getCustomTopAdressView:(adressModel *)adressModel
{
   
    
    UIView * adressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(78))];
    
    if (self.isShowAdress ==false) {
        adressView.hidden = YES;
        adressView.frame = CGRectMake(0, 0, ScreenWidth, HeightRate(0.01));
        
    }else{
        adressView.backgroundColor = ColorWithHexString(@"99CCFF");
        
        UIImageView *adressImageView = [[UIImageView alloc] init];
        adressImageView.contentMode = UIViewContentModeScaleAspectFit;
        adressImageView.image = [UIImage imageNamed:@"dizhi_icons"];
        [ adressView addSubview:adressImageView];
        
        [adressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(WidthRate(16));
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(WidthRate(20));
            make.centerY.mas_equalTo(adressView.mas_centerY);
            
        }];
        
        UILabel *nameInfoLable  =[[UILabel alloc] init];
        nameInfoLable.text  = [NSString stringWithFormat:@"%@    %@",adressModel.UserName,adressModel.MobileNumber];
        nameInfoLable.textColor = ColorWithHexString(@"ffffff");
        nameInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:nameInfoLable];
        [nameInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(HeightRate(15));
        }];
        
        UILabel *adressInfoLable  =[[UILabel alloc] init];
        adressInfoLable.text  = [NSString stringWithFormat:@"%@%@%@%@%@",adressModel.Province,adressModel.City,adressModel.County,adressModel.District,adressModel.Address];;
        adressInfoLable.numberOfLines = 0;
        //        adressInfoLable.lineBreakMode = NSLineBreakByWordWrapping;
        adressInfoLable.textColor = ColorWithHexString(@"ffffff");
        adressInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:adressInfoLable];
        [adressInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(35));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(nameInfoLable.mas_bottom).offset(5);
        }];
          
       
    }
   
    return  adressView;
}
-(void)TitleHeadView:(UIView *)customHeadView item:(UIView *)addressView
{
    UIView *companyView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
    companyView.backgroundColor = ColorWithHexString(@"FAFAFA");
    [customHeadView addSubview:companyView];
    companyView.translatesAutoresizingMaskIntoConstraints = NO;
    [companyView PSSetBottomAtItem:addressView Length:0];
    [companyView PSSetLeft:0];
    [companyView PSSetSize:ScreenWidth Height:HeightRate(35)];
    
   
        UIImageView * shopHeadImageView = [[UIImageView alloc] init];
        //        shopHeadImageView.image = [UIImage imageNamed:@"placehold"];
        [shopHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.contract.StorePhoto]];
        shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
        shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [companyView addSubview:shopHeadImageView ];
        [shopHeadImageView PSSetLeft:WidthRate(10)];
        [shopHeadImageView PSSetSize:WidthRate(20) Height:HeightRate(20)];
        [shopHeadImageView PSSetCenterHorizontalAtItem:companyView];
        
        UILabel *companyLabelName = [[UILabel alloc] init];
        companyLabelName.text = self.contract.StoreName;
        companyLabelName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        companyLabelName.textColor = ColorWithHexString(@"333333");
        [companyView addSubview:companyLabelName];
        companyLabelName.translatesAutoresizingMaskIntoConstraints= NO;
        [companyLabelName PSSetRightAtItem:shopHeadImageView Length:WidthRate(5)];
        
        UILabel *shopGoodsInvoiceLable = [[UILabel alloc] init];
        shopGoodsInvoiceLable.text = @"含税";
        shopGoodsInvoiceLable.textAlignment = NSTextAlignmentCenter;
        shopGoodsInvoiceLable.font = [UIFont systemFontOfSize:AdaptFont(9)];
        shopGoodsInvoiceLable.textColor = ColorWithHexString(@"ffffff");
        shopGoodsInvoiceLable.layer.cornerRadius = 6;
        shopGoodsInvoiceLable.clipsToBounds = YES;
        shopGoodsInvoiceLable.backgroundColor = ColorWithHexString(@"FFCC00");
        [companyView addSubview:shopGoodsInvoiceLable];
        shopGoodsInvoiceLable.translatesAutoresizingMaskIntoConstraints= NO;
        [shopGoodsInvoiceLable PSSetRightAtItem:companyLabelName Length:WidthRate(5)];
        [shopGoodsInvoiceLable PSSetSize:WidthRate(33) Height:HeightRate(17)];
    shopGoodsInvoiceLable.hidden = !self.contract.IsIncludeTax.boolValue;
    if (shopGoodsInvoiceLable.hidden==false ) {
        [shopGoodsInvoiceLable PSSetSize:WidthRate(33) Height:HeightRate(17)];
        
    }else
    {
        [shopGoodsInvoiceLable PSSetSize:WidthRate(0.01) Height:HeightRate(17)];
        
    }
    
    UILabel *superGroupLable = [[UILabel alloc] init];
    superGroupLable.text = @"团";
    superGroupLable.textAlignment = NSTextAlignmentCenter;
    superGroupLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    superGroupLable.textColor = ColorWithHexString(@"ffffff");
    superGroupLable.layer.cornerRadius = 3;
    superGroupLable.clipsToBounds = YES;
    superGroupLable.backgroundColor = ColorWithHexString(@"F8695D");
    [companyView addSubview:superGroupLable];
    superGroupLable.translatesAutoresizingMaskIntoConstraints= NO;
    [superGroupLable PSSetRightAtItem:shopGoodsInvoiceLable Length:WidthRate(5)];
    [superGroupLable PSSetSize:WidthRate(14) Height:HeightRate(17)];
    bool ishiden =self.contract.SuperGroupDetailId.length>0?false:YES;
    superGroupLable.hidden = ishiden;
    
    UILabel *superOrder = [[UILabel alloc] init];
    
    superOrder.text = @"已付定金";
    superOrder.textAlignment = NSTextAlignmentCenter;
    superOrder.font = [UIFont systemFontOfSize:AdaptFont(9)];
    superOrder.textColor = ColorWithHexString(@"F8695D");
    superOrder.layer.borderColor =  ColorWithHexString(@"F8695D").CGColor;
    superOrder.layer.borderWidth = 1;
    superOrder.layer.cornerRadius = 6;
    superOrder.clipsToBounds = YES;
    //            superOrder.backgroundColor = ColorWithHexString(@"FFCC00");
    [companyView addSubview:superOrder];
    superOrder.translatesAutoresizingMaskIntoConstraints= NO;
    [superOrder PSSetRightAtItem:superGroupLable Length:WidthRate(5)];
    [superOrder PSSetSize:WidthRate(55) Height:HeightRate(17)];
    superOrder.hidden =self.contract.SuperGroupDetailId.length>0?false:YES;

    
    //订单状态
    YHLabel *orderStatusLabel = [[YHLabel alloc] initWithTextColor:@"FA0C37"];
    orderStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    orderStatusLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
    [companyView addSubview:orderStatusLabel];
    orderStatusLabel.textAlignment = NSTextAlignmentRight;
    //        [orderStatusLabel PSSetRightAtItem:orderDateLabel Length:WidthRate(18)];
    [orderStatusLabel PSSetRight:WidthRate(10)];
    [orderStatusLabel PSSetCenterHorizontalAtItem:companyView];
    [orderStatusLabel PSSetWidth:WidthRate(55)];
    
    
    
    orderStatusLabel.text = self.contract.OrderStateName;

    
    
   
    
}
-(void)getheadView:(UIView *)headView item:(UIView *)addressView
{
    
    
      UIView *  orderTopView = [[UIView alloc] init];
        orderTopView.backgroundColor = ColorWithHexString(@"F7F7F7");
        orderTopView.clipsToBounds = NO;
    orderTopView.translatesAutoresizingMaskIntoConstraints = NO;
    [headView addSubview:orderTopView];
    [orderTopView PSSetBottomAtItem:addressView Length:3];
    [orderTopView PSSetLeft:0];
    [orderTopView PSSetSize:ScreenWidth Height:HeightRate(33)];

    
    YHLabel *orderIdItemLabel = [[YHLabel alloc] initWithText: NSLanguageLocalizedString(@"order id") textColor:BASE_FAINTLY_COLOR];
    orderIdItemLabel.translatesAutoresizingMaskIntoConstraints   = NO;
    orderIdItemLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
    [orderTopView addSubview:orderIdItemLabel];
    
    [orderIdItemLabel PSSetLeft:WidthRate(12)];
    [orderIdItemLabel PSSetCenterHorizontalAtItem:orderTopView];
    
    //订单号
    YHLabel *orderIdLabel = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
    orderIdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    orderIdLabel.text = [NSString stringWithFormat:@"%@",self.contract.ContractNo] ;
    orderIdLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
    [orderTopView addSubview:orderIdLabel];
    [orderIdLabel PSSetRightAtItem:orderIdItemLabel Length:WidthRate(5)];
    
    //订单日期
    YHLabel *orderDateLabel = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
    orderDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    orderDateLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
    orderDateLabel.text = self.contract.AddWhen;
    [orderTopView addSubview:orderDateLabel];
    [orderDateLabel PSSetRightAtItem:orderIdLabel Length:WidthRate(36)];
    
    //订单状态
    YHLabel *orderStatusLabel = [[YHLabel alloc] initWithTextColor:@"FA0C37"];
    orderStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    orderStatusLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
    [orderTopView addSubview:orderStatusLabel];
    orderStatusLabel.textAlignment = NSTextAlignmentRight;
    //        [orderStatusLabel PSSetRightAtItem:orderDateLabel Length:WidthRate(18)];
    [orderStatusLabel PSSetRight:WidthRate(10)];
    [orderStatusLabel PSSetCenterHorizontalAtItem:orderDateLabel];
    [orderStatusLabel PSSetWidth:WidthRate(55)];
//
//    if ( [self.contract.OrderState isEqual:@(0)]) {
//
//        if([self.contract.IsOut isEqualToString:@"0"])
//        {
//            orderStatusLabel.text = @"已失效";
//
//        }else
//        {
    
            orderStatusLabel.text = self.contract.OrderStateName;
//        }
//
//    }else
//    {
//        orderStatusLabel.text = self.contract.OrderStateName;
//
//    }
    



}

-(id)progressView:(UIView *)bgView byItem:(id)item rate:(CGFloat)rate name:(NSString *)name
{
    
    UIView *progressView = [[UIView alloc] init];
    progressView.translatesAutoresizingMaskIntoConstraints  = false;
    [bgView addSubview:progressView];
    [progressView PSSetBottomAtItem:item Length:HeightRate(0)];
    [progressView PSSetLeft:WidthRate(0)];
    [progressView PSSetSize:ScreenWidth Height:HeightRate(50)];
    
    YHLabel *paidMoneyLabel =  [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
    paidMoneyLabel.text =name;
    paidMoneyLabel.translatesAutoresizingMaskIntoConstraints =NO;
    paidMoneyLabel.font =[UIFont systemFontOfSize:AdaptFont(13)];
    [progressView addSubview:paidMoneyLabel];
    //    [paidMoneyLabel PSSetTop:HeightRate(10)];
    [paidMoneyLabel PSSetLeft:WidthRate(18)];
    [paidMoneyLabel PSSetCenterHorizontalAtItem:progressView];
    
    
    UIView *broderView =  [[UIView alloc] init];
    broderView.translatesAutoresizingMaskIntoConstraints = NO;
    broderView.layer.borderWidth = 1;
    broderView.layer.cornerRadius = 3;
    broderView.layer.masksToBounds = YES;
    broderView.layer.borderColor =ColorWithHexString(BASE_LINE_COLOR).CGColor;
    [progressView addSubview:broderView];
    [broderView PSSetRightAtItem:paidMoneyLabel Length:WidthRate(3)];
    
    YHLabel *appearslabel = [[YHLabel alloc]initWithTextColor:BASE_FAINTLY_COLOR];
    appearslabel.translatesAutoresizingMaskIntoConstraints   = NO;
    
    appearslabel.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
    [broderView addSubview:appearslabel];
    [appearslabel PSSetLeft:0];
    [appearslabel PSSetTop:0];
    [appearslabel PSSetHeight:HeightRate(30)];
//    [appearslabel PSSetCenterHorizontalAtItem:progressView];
    [broderView PSSetSize:WidthRate(240) Height:HeightRate(30)];

    
    
    YHLabel *appearsTextlabel = [[YHLabel alloc]initWithTextColor:BASE_FAINTLY_COLOR];
    appearsTextlabel.translatesAutoresizingMaskIntoConstraints   = NO;
    appearsTextlabel.backgroundColor = [UIColor clearColor];
    appearsTextlabel.text =@"120万／200万";
    [broderView addSubview:appearsTextlabel];
    appearsTextlabel.font =[UIFont systemFontOfSize:AdaptFont(13)];
    
    [appearsTextlabel PSSetConstraint:WidthRate(5) Right:0 Top:0 Bottom:0];
    
    
    
    appearsTextlabel.text = [NSString stringWithFormat:@"%.2f/%.2f",round([self.contract.HasPayFee doubleValue]*100)/100,round([self.contract.ContractAmount doubleValue]*100)/100];
    if (self.contract.ContractAmount.floatValue ==0) {
        [appearslabel PSSetWidth:0];
    }else{
        CGFloat rate =self.contract.HasPayFee.floatValue/(self.contract.ContractAmount.floatValue);
        if (rate>1 ) {
            rate = 1;
        }else if(rate<0)
        {
            rate=0;
        }
        CGFloat labelWidth = WidthRate(240) * (rate);
        [appearslabel PSSetWidth:labelWidth];
    }
    
    return progressView;
    
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
