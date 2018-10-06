//
//  YHOrderFootTableViewCell.m
//  emake
//
//  Created by eMake on 2017/10/17.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderFootTableViewCell.h"
#import "YHLabel.h"
#import "UIView+PSAutoLayout.h"
//#import "YHLogisticsDetailButton.h"

static CGFloat const paidFont = 14;
static CGFloat const ferentFont = 12;

@interface YHOrderFootTableViewCell ()

@property(nonatomic,weak)UILabel *rateLable;
@property(nonatomic,weak)UILabel *numberLable;
@property(nonatomic,weak)UILabel *PreferentialPriceLable;

@property(nonatomic,weak)UILabel *totalPriceLable;//insurance

@property(nonatomic,weak)UILabel *freightPriceLable;

@property(nonatomic,weak)UILabel *payRateNameLabel;
@property(nonatomic,weak)UILabel *payRateBgLabel;
@property(nonatomic,weak)YHButton *PayAcountButton;
@property (nonatomic,assign)double payRate;
@property(nonatomic,weak)UILabel *insuranceRateNameLabel;
@property(nonatomic,weak)UILabel *insuranceRateBgLabel;

@property(nonatomic,weak)UILabel *taxTipsLabel;//含%17增值税


@property(nonatomic,weak)YHButton *insuranceAcountButton;
@property (nonatomic,assign)double insuranceRate;

@property (nonatomic,weak)UIView *line;
@property (nonatomic,weak)YHLabel *paidMoneyLabel;
@property (nonatomic,weak)UIView *bordview;

@end

@implementation YHOrderFootTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *item = [self progressView:nil rate:0.6 name:@"已付金额：" ];

        UILabel *lable = [[UILabel alloc] init];
        lable.backgroundColor = SepratorLineColor;
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:lable];
        [lable PSSetBottomAtItem:item Length:HeightRate(9)];
        [lable PSSetLeft:0];
        [lable PSSetSize:ScreenWidth Height:1];
        

        //含运费
        UILabel *freight = [[UILabel alloc] init];
        freight.translatesAutoresizingMaskIntoConstraints = NO;
        freight.text =@"含增值税";
        freight.textColor = ColorWithHexString(SymbolTopColor);
        freight.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        [self addSubview:freight];
        [freight PSSetRight:WidthRate(12)];
        [freight PSSetBottomAtItem:lable Length:WidthRate(5)];
        self.taxTipsLabel = freight;
        
        YHLabel *orderNumberLabel = [[YHLabel alloc] initWithText: NSLanguageLocalizedString(@"order id") textColor:BASE_FAINTLY_COLOR];
        orderNumberLabel.translatesAutoresizingMaskIntoConstraints   = NO;
        orderNumberLabel.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        orderNumberLabel.text = @"共2件商品";
        [self addSubview:orderNumberLabel];

        self.numberLable = orderNumberLabel;
        
        //合计
        YHLabel *totalLable = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
        totalLable.translatesAutoresizingMaskIntoConstraints = NO;
        totalLable.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        totalLable.text = @"合计:";
        [self addSubview:totalLable];
        
        UILabel *total = [[UILabel alloc] init];
        total.translatesAutoresizingMaskIntoConstraints = NO;
        total.font = [UIFont systemFontOfSize:AdaptFont(ferentFont+2)];
        total.textColor = ColorWithHexString(@"FA0C37");
        [self addSubview:total];
        [total PSSetBottomAtItem:freight Length:HeightRate(9)];
        [total PSSetRight:WidthRate(12)];
        self.totalPriceLable = total;
        
        [totalLable PSSetLeftAtItem:total Length:WidthRate(-3)];
        [orderNumberLabel PSSetLeftAtItem:totalLable Length:WidthRate(-10)];
        
      
        
        
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.translatesAutoresizingMaskIntoConstraints = NO;
        lineView1.backgroundColor =SepratorLineColor;
        [self addSubview:lineView1];
        [lineView1 PSSetBottomAtItem:orderNumberLabel Length:HeightRate(9)];
        [lineView1 PSSetLeft:0];
        [lineView1 PSSetSize:ScreenWidth Height:1];
        self.line = lineView1;
    }
    return self;
}
-(id)progressView:(id)item rate:(CGFloat)rate name:(NSString *)name
{
    YHLabel *paidMoneyLabel =  [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
    paidMoneyLabel.text =name;
    paidMoneyLabel.translatesAutoresizingMaskIntoConstraints =NO;
    paidMoneyLabel.font =[UIFont systemFontOfSize:AdaptFont(paidFont)];
    [self addSubview:paidMoneyLabel];
    [paidMoneyLabel PSSetTop:HeightRate(9)];
    [paidMoneyLabel PSSetLeft:WidthRate(18)];
    
    self.paidMoneyLabel = paidMoneyLabel;
    
    UIView *broderView =  [[UIView alloc] init];
    broderView.translatesAutoresizingMaskIntoConstraints = NO;
    broderView.layer.borderWidth = 1;
    broderView.layer.cornerRadius = 3;
    broderView.layer.masksToBounds = YES;
    broderView.layer.borderColor =ColorWithHexString(BASE_LINE_COLOR).CGColor;
    [self addSubview:broderView];
    [broderView PSSetRightAtItem:paidMoneyLabel Length:WidthRate(3)];
    
    YHLabel *appearslabel = [[YHLabel alloc]initWithTextColor:BASE_FAINTLY_COLOR];
    appearslabel.translatesAutoresizingMaskIntoConstraints   = NO;
    
    appearslabel.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
    [broderView addSubview:appearslabel];
    [appearslabel PSSetLeft:0];
    [appearslabel PSSetTop:0];
    [appearslabel PSSetBottom:0];
    
    
    YHLabel *appearsTextlabel = [[YHLabel alloc]initWithTextColor:BASE_FAINTLY_COLOR];
    appearsTextlabel.translatesAutoresizingMaskIntoConstraints   = NO;
    appearsTextlabel.backgroundColor = [UIColor clearColor];
    appearsTextlabel.text =@"120万／200万";
    [broderView addSubview:appearsTextlabel];
    appearsTextlabel.font =[UIFont systemFontOfSize:AdaptFont(paidFont)];
    
    [appearsTextlabel PSSetConstraint:WidthRate(5) Right:0 Top:0 Bottom:0];
    
    YHButton *payButton = [YHButton initBorderStyleWithTitle:@"付款账号" color:APP_THEME_MAIN_COLOR];
    payButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:payButton];
    [payButton PSSetHeight:HeightRate(20)];
    [payButton PSSetWidth:WidthRate(60)];
    
    [broderView PSSetSize:WidthRate(170) Height:HeightRate(14)];
    [payButton PSSetRightAtItem:broderView Length:WidthRate(43)];
    self.payRateNameLabel = appearsTextlabel;
    self.payRateBgLabel =appearslabel;
    payButton.hidden =NO;
    
    [payButton addTarget:self action:@selector(payAccButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];

    return paidMoneyLabel;
    
}
- (void)updateOrderFootViewWithOrder:(YHOrderContract *)orders
{
    _orderContract = orders;
    _order.sectionRecord =  orders.sectionRecord;
//    if (orders.TaxPrice.doubleValue>0) {
//        self.taxTipsLabel.textColor = [UIColor blackColor];
//        NSString *str = @"增值税";
//
//        NSString *priceStr =   [NSString stringWithFormat:@"%@:¥%@",str,[Tools getHaveNum:orders.TaxPrice.doubleValue]];//orders.GoodsAddValue
//
//        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:priceStr];
//        [att addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(SymbolTopColor) range:NSMakeRange(str.length+1, priceStr.length-str.length-1)];
//
//
//        self.taxTipsLabel.attributedText = att;
//    } else {
        self.taxTipsLabel.text = orders.GoodsAddValue;

//    }
//    self.numberLable.text= [NSString stringWithFormat:@"共%@件商品",orders.ContractQuantity];
    self.totalPriceLable.text =[NSString stringWithFormat:@"¥%.2f",round([orders.ContractAmount doubleValue]*100)/100];
    self.freightPriceLable.hidden =YES;
//    self.payRateNameLabel.text = [NSString stringWithFormat:@"%.2f/%.2f",round([orders.HasPayFee doubleValue]*100)/100,round([orders.ContractAmount doubleValue]*100)/100];
    if (orders.ContractAmount.floatValue ==0) {
        [self.payRateBgLabel PSSetWidth:0];
    }else{
//        CGFloat rate =orders.HasPayFee.floatValue/(orders.ContractAmount.floatValue);
//        if (rate>1 ) {
//            rate = 1;
//        }else if(rate<0)
//        {
//            rate=0;
//        }
//        CGFloat labelWidth = WidthRate(170) * (rate);
//        [self.payRateBgLabel PSSetWidth:labelWidth];
    }
    self.insuranceRateNameLabel.text = [NSString stringWithFormat:@"%@/%@",orders.InsuraceModel.InsuranceHasPayFee,orders.InsuraceModel.InsurdFee];
                                 
    if (orders.InsuraceModel.InsurdFee.floatValue ==0) {
        [self.insuranceRateBgLabel PSSetWidth:0];
    }else{
        
        CGFloat rate1 =orders.InsuraceModel.InsuranceHasPayFee.floatValue/orders.InsuraceModel.InsurdFee.floatValue;
        if (rate1>1 ) {
            rate1 = 1;
        }else if(rate1<0)
        {
            rate1=0;
        }
        CGFloat labelWidth1 = WidthRate(130) * (rate1);
        [self.insuranceRateBgLabel PSSetWidth:labelWidth1];
    }
    
    
}

-(void)setState:(NSString *)state
{
    _state = state;
    

    
    YHButton *customerServiceButton = [YHButton initBorderStyleWithTitle:NSLanguageLocalizedString(@"customer service")];
    customerServiceButton.translatesAutoresizingMaskIntoConstraints = NO;
    [customerServiceButton setImage:[UIImage imageNamed:@"dingdankefu"] forState:UIControlStateNormal];
    [customerServiceButton setImageEdgeInsets:UIEdgeInsetsMake(0, WidthRate(-5), 0, 0)];
    [customerServiceButton addTarget:self action:@selector(customerServiceButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:customerServiceButton];
    
    
    YHButton *contractButton = [YHButton initBorderStyleWithTitle:@"查看合同"];
    [contractButton addTarget:self action:@selector(contractButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    contractButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:contractButton];
    
    NSString *title = @"我的合同";
//    if ([self.orderContract.IsIncludeTax isEqualToString:@"1"]) {
        title = @"销售合同";
//    }else
//    {
//        title = @"销售订单";
//    }
    YHButton *uploadContractButton = [YHButton initBorderStyleWithTitle:title];
    [uploadContractButton addTarget:self action:@selector(uploadContractButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    uploadContractButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:uploadContractButton];
    
    YHButton *paymentVoucher = [YHButton initBorderStyleWithTitle:@"申请开票"];
    [paymentVoucher addTarget:self action:@selector(paymentVoucherClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    paymentVoucher.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:paymentVoucher];
    self.paymentVoucher = paymentVoucher;
    
    YHButton *deleteOrder = [YHButton initBorderStyleWithTitle:@"订单删除"];
    [deleteOrder addTarget:self action:@selector(deleteButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    deleteOrder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:deleteOrder];
    
    YHButton *renewOrder = [YHButton initBorderStyleWithTitle:@"订单恢复"];
    [renewOrder addTarget:self action:@selector(renewOrderButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    renewOrder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:renewOrder];
    
    YHLogisticsDetailButton *logisticsDetailButton = [YHLogisticsDetailButton initBorderStyleWithTitle:@"查看物流"];
    [logisticsDetailButton addTarget:self action:@selector(orderSlectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.logisticsDetailButton = logisticsDetailButton;
    [self addSubview:logisticsDetailButton];
    
//    YHButton *payButton = [YHButton initBorderStyleWithTitle:@"付款账号" color:APP_THEME_MAIN_COLOR];
//    payButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:payButton];
//    [payButton addTarget:self action:@selector(payAccButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    
    switch (state.integerValue) {
        case 0:
        {
            paymentVoucher.hidden = YES;
            deleteOrder.hidden =YES;
            logisticsDetailButton.hidden = YES;
            renewOrder.hidden = YES;
            contractButton.hidden = YES;
            
//            [payButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
//            [payButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
//            [payButton PSSetRight:WidthRate(10)];
            
            
            
            [uploadContractButton PSSetSize:WidthRate(80) Height:HeightRate(25)];
            [uploadContractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [uploadContractButton PSSetRight:WidthRate(10)];
            
            [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [customerServiceButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [customerServiceButton PSSetLeftAtItem:uploadContractButton Length:WidthRate(-10)];
            
            [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [contractButton PSSetRight:WidthRate(219)];
            [contractButton PSSetBottom:HeightRate(10)];
        }
            break;
        case 1:
        {
            deleteOrder.hidden =YES;
            logisticsDetailButton.hidden = YES;
            renewOrder.hidden = YES;
            contractButton.hidden = YES;

//            [payButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
//            [payButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
//            [payButton PSSetRight:WidthRate(10)];
        
            //            [customerServiceButton PSSetBottom:HeightRate(10)];
            
     
//            [contractButton PSSetBottom:HeightRate(10)];
            
            [paymentVoucher PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [paymentVoucher PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [paymentVoucher PSSetRight:WidthRate(10)];
            [paymentVoucher PSSetBottom:HeightRate(10)];
            
            [uploadContractButton PSSetSize:WidthRate(80) Height:HeightRate(25)];
            [uploadContractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
//            [uploadContractButton PSSetRight:WidthRate(80)];
            [uploadContractButton PSSetLeftAtItem:paymentVoucher Length:WidthRate(-10)];

            [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [customerServiceButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
//            [customerServiceButton PSSetRight:WidthRate(150)];
            [customerServiceButton PSSetLeftAtItem:uploadContractButton Length:WidthRate(-10)];

            
            [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [contractButton PSSetRight:WidthRate(290)];
        }
            break;
        case 2:
        {
            deleteOrder.hidden =YES;
            logisticsDetailButton.hidden = YES;
            renewOrder.hidden = YES;
            contractButton.hidden = YES;
            contractButton.hidden = YES;

//            payButton.hidden=YES;
            self.insuranceAcountButton.hidden = YES;
            self.PayAcountButton.hidden =YES;
            
           
            
            
            [paymentVoucher PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [paymentVoucher PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [paymentVoucher PSSetRight:WidthRate(10)];
            [paymentVoucher PSSetBottom:HeightRate(10)];
            
            [uploadContractButton PSSetSize:WidthRate(80) Height:HeightRate(25)];
            [uploadContractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
//            [uploadContractButton PSSetRight:WidthRate(80)];
            [uploadContractButton PSSetLeftAtItem:paymentVoucher Length:WidthRate(-10)];

            [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [customerServiceButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [customerServiceButton PSSetRight:WidthRate(170)];
            [customerServiceButton PSSetLeftAtItem:uploadContractButton Length:WidthRate(-10)];

            [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [contractButton PSSetRight:WidthRate(220)];
       
        }
            break;
        case 3:
        {
//            payButton.hidden=YES;

            deleteOrder.hidden =YES;
            renewOrder.hidden = YES;
            self.insuranceAcountButton.hidden = YES;
            self.PayAcountButton.hidden =YES;
            contractButton.hidden = YES;

            //            logisticsDetailButton.hidden = YES;
            
            [logisticsDetailButton PSSetSize:WidthRate(75) Height:HeightRate(25)];
            [logisticsDetailButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [logisticsDetailButton PSSetRight:WidthRate(10)];
            self.logisticsDetailButton = logisticsDetailButton;
            
            
            [paymentVoucher PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [paymentVoucher PSSetBottomAtItem:self.line Length:HeightRate(10)];
//            [paymentVoucher PSSetRight:WidthRate(95)];
            [paymentVoucher PSSetLeftAtItem:logisticsDetailButton Length:WidthRate(-10)];

            [paymentVoucher PSSetBottom:HeightRate(10)];
            
       
            
            [uploadContractButton PSSetSize:WidthRate(80) Height:HeightRate(25)];
            [uploadContractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [uploadContractButton PSSetRight:WidthRate(165)];
            [uploadContractButton PSSetLeftAtItem:paymentVoucher Length:WidthRate(-10)];

            
            [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [customerServiceButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [customerServiceButton PSSetRight:WidthRate(255)];
            [customerServiceButton PSSetLeftAtItem:uploadContractButton Length:WidthRate(-10)];

            [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [contractButton PSSetRight:WidthRate(305)];
            
        }
            break;
            
        default:
        {
//            payButton.hidden=YES;
            logisticsDetailButton.hidden =YES;
            paymentVoucher.hidden = YES;
            logisticsDetailButton.hidden = YES;
            contractButton.hidden = YES;
            customerServiceButton.hidden = YES;
            uploadContractButton.hidden = YES;
            self.insuranceAcountButton.hidden = YES;
            self.PayAcountButton.hidden =YES;
            contractButton.hidden = YES;

            
            [deleteOrder PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [deleteOrder PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [deleteOrder PSSetRight:WidthRate(10)];
            [deleteOrder PSSetBottom:HeightRate(10)];
            
            [renewOrder PSSetSize:WidthRate(60) Height:HeightRate(25)];
            [renewOrder PSSetBottomAtItem:self.line Length:HeightRate(10)];
            [renewOrder PSSetRight:WidthRate(80)];
        }
            break;
    }
    
    
}

-(void)uploadContractButtonClicked
{//uploadContractButtonClickedWithOrder
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(uploadContractButtonClickedWithOrder:)]) {
        [self.delegate uploadContractButtonClickedWithOrder:_orderContract];
    }
    
}
-(void)payAccButtonClickedWithOrder
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(payAccountOrderButtonClickedWithOrder:)]) {
        [self.delegate payAccountOrderButtonClickedWithOrder:_orderContract];
    }
}
-(void)insuranceButtonClickedWithOrder
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(insuranceOrderButtonClickedWithOrder:)]) {
        [self.delegate insuranceOrderButtonClickedWithOrder:_orderContract];
    }
}
- (void)orderSlectButtonClick:(YHLogisticsDetailButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderIsSlectButtonClick:)])
    {
        [self.delegate orderIsSlectButtonClick:button];
    }
    
}


- (void)deleteButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteOrderButtonClickedWithOrder:)]) {
        [self.delegate deleteOrderButtonClickedWithOrder:_orderContract];
    }
}

- (void)renewOrderButtonClickedWithOrder {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(renewOrderButtonClickedWithOrder:)]) {
//        [self.delegate renewOrderButtonClickedWithOrder:_orderContract];
//    }
}

- (void)customerServiceButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customerServiceButtonClickedWithOrder:)]) {
        [self.delegate customerServiceButtonClickedWithOrder:_orderContract];
    }
}

- (void)contractButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(contractButtonClickedWithOrder:)]) {
        [self.delegate contractButtonClickedWithOrder:_orderContract];
    }
}

- (void)paymentVoucherClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentVoucherClickedWithOrder:)]) {
        [self.delegate paymentVoucherClickedWithOrder:_orderContract];
    }
}
@end

