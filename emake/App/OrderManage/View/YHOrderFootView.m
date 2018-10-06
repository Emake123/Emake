
//  YHOrderFootView.m
//  emake
//
//  Created by eMake on 2017/10/12.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderFootView.h"
#import "YHLabel.h"
#import "YHButton.h"
#import "UIView+PSAutoLayout.h"
#import "YHLogisticsDetailButton.h"

static CGFloat const paidFont = 12;
static CGFloat const ferentFont = 10;

@interface YHOrderFootView ()
@property(nonatomic,weak)UILabel *rateLable;
@property(nonatomic,weak)UILabel *numberLable;
@property(nonatomic,weak)UILabel *PreferentialPriceLable;

@property(nonatomic,weak)UILabel *totalPriceLable;
@property(nonatomic,weak)UILabel *bgLabel;

@property(nonatomic,weak)UILabel *freightPriceLable;

@property (nonatomic,assign)double rate;

@property (nonatomic,weak)UIView *line;
@property (nonatomic,weak)YHLabel *paidMoneyLabel;
@property (nonatomic,weak)UIView *bordview;

@end
@implementation YHOrderFootView


-(UIView *)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        //已付金额以及付款进度
        YHLabel *paidMoneyLabel =  [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
        paidMoneyLabel.text =@"已付金额：";
        paidMoneyLabel.translatesAutoresizingMaskIntoConstraints =NO;
        paidMoneyLabel.font =[UIFont systemFontOfSize:AdaptFont(paidFont)];
        
        [self addSubview:paidMoneyLabel];
        [paidMoneyLabel PSSetTop:HeightRate(10)];
        [paidMoneyLabel PSSetLeft:WidthRate(18)];
        self.paidMoneyLabel = paidMoneyLabel;
        
        UIView *broderView =  [[UIView alloc] init];
        broderView.translatesAutoresizingMaskIntoConstraints = NO;
        broderView.layer.borderWidth = 1;
        
        broderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:broderView];
        [broderView PSSetSize:WidthRate(155) Height:HeightRate(14)];
        [broderView PSSetRightAtItem:paidMoneyLabel Length:WidthRate(3)];
        self.bordview =broderView;
        self.rate = 0.6;
        YHLabel *appearslabel = [[YHLabel alloc]initWithTextColor:BASE_FAINTLY_COLOR];
        appearslabel.translatesAutoresizingMaskIntoConstraints   = NO;
        
        appearslabel.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
        CGFloat labelWidth = WidthRate(155) * _rate;
        [broderView addSubview:appearslabel];
        [appearslabel PSSetWidth:labelWidth];
        [appearslabel PSSetLeft:0];
        [appearslabel PSSetTop:0];
        [appearslabel PSSetBottom:0];
        
        self.bgLabel = appearslabel;
        
        YHLabel *appearsTextlabel = [[YHLabel alloc]initWithTextColor:BASE_FAINTLY_COLOR];
        appearsTextlabel.translatesAutoresizingMaskIntoConstraints   = NO;
        appearsTextlabel.backgroundColor = [UIColor clearColor];
        appearsTextlabel.text =@"120万／200万";
        [broderView addSubview:appearsTextlabel];
        appearsTextlabel.font =[UIFont systemFontOfSize:AdaptFont(paidFont)];
        
        [appearsTextlabel PSSetConstraint:0 Right:0 Top:0 Bottom:0];
        self.rateLable =appearslabel;
        
        CGFloat space=40;
        YHLabel *orderNumberLabel = [[YHLabel alloc] initWithText: NSLanguageLocalizedString(@"order id") textColor:BASE_FAINTLY_COLOR];
        orderNumberLabel.translatesAutoresizingMaskIntoConstraints   = NO;
        orderNumberLabel.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        orderNumberLabel.text = @"共2件商品";
        [self addSubview:orderNumberLabel];
        [orderNumberLabel PSSetLeft:WidthRate(18)];
        [orderNumberLabel PSSetBottomAtItem:paidMoneyLabel Length:HeightRate(10)];
        self.numberLable = orderNumberLabel;
        
        //合计
        YHLabel *totalLable = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
        totalLable.translatesAutoresizingMaskIntoConstraints = NO;
        totalLable.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        totalLable.text = @"合计:";
        [self addSubview:totalLable];
        [totalLable PSSetRightAtItem:orderNumberLabel Length:WidthRate(space)];
        
        YHLabel *total = [[YHLabel alloc] initWithTextColor:@"FA0C37"];
        total.translatesAutoresizingMaskIntoConstraints = NO;
        total.font =[UIFont systemFontOfSize:AdaptFont(ferentFont+2)];
        [self addSubview:total];
        [total PSSetRightAtItem:totalLable Length:WidthRate(5)];
        self.totalPriceLable = total;
        //已优惠
        YHLabel *PreferentialLable = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
        PreferentialLable.translatesAutoresizingMaskIntoConstraints = NO;
        PreferentialLable.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        PreferentialLable.text = @"已优惠:";
        [self addSubview:PreferentialLable];
        [PreferentialLable PSSetRightAtItem:total Length:WidthRate(space)];
        
        YHLabel *Preferential = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
        Preferential.translatesAutoresizingMaskIntoConstraints = NO;
        Preferential.font =[UIFont systemFontOfSize:AdaptFont(ferentFont)];
        Preferential.text = @"¥0";
        [self addSubview:Preferential];
        [Preferential PSSetRightAtItem:PreferentialLable Length:WidthRate(2)];
        self.PreferentialPriceLable = PreferentialLable;
        
        //含运费
        YHLabel *freight = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
        freight.translatesAutoresizingMaskIntoConstraints = NO;
        freight.text =@"(含运费¥0.00)";
        freight.font =[UIFont systemFontOfSize:AdaptFont(ferentFont-1)];
        [self addSubview:freight];
        [freight PSSetRightAtItem:Preferential Length:WidthRate(space)];
        self.freightPriceLable = freight;
        
        // lineView
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.translatesAutoresizingMaskIntoConstraints = NO;
        lineView1.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
        [self addSubview:lineView1];
        [lineView1 PSSetBottomAtItem:freight Length:10];
        [lineView1 PSSetLeft:0];
        [lineView1 PSSetSize:ScreenWidth Height:1];
        self.line = lineView1;
        
        UIView *lineBottomView = [[UIView alloc] init];
        lineBottomView.translatesAutoresizingMaskIntoConstraints = NO;
        lineBottomView.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
        [self addSubview:lineBottomView];
        [lineBottomView PSSetBottom:0];
        [lineBottomView PSSetLeft:0];
        [lineBottomView PSSetSize:ScreenWidth Height:10];
    }
    
    return self;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(116))];
    
    return head;
    
}

-(void)setState:(NSString *)state
{
    _state = state;
    
    YHButton *payButton = [YHButton initBorderStyleWithTitle:NSLanguageLocalizedString(@"pay") color:APP_THEME_MAIN_COLOR];
    payButton.translatesAutoresizingMaskIntoConstraints = NO;
    [payButton addTarget:self action:@selector(payButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    
    YHButton *customerServiceButton = [YHButton initBorderStyleWithTitle:NSLanguageLocalizedString(@"customer service")];
    customerServiceButton.translatesAutoresizingMaskIntoConstraints = NO;
    [customerServiceButton addTarget:self action:@selector(customerServiceButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    YHButton *contractButton = [YHButton initBorderStyleWithTitle:NSLanguageLocalizedString(@"contract")];
    [contractButton addTarget:self action:@selector(contractButtonClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
    contractButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if ([state isEqualToString:@"0"]) {
        [self addSubview:payButton];
        [self addSubview:customerServiceButton];
        [self addSubview:contractButton];
        [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
        [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
        
        
        [contractButton PSSetLeft:WidthRate(153)];
        [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
        
        [customerServiceButton PSSetRightAtItem:contractButton Length:WidthRate(9)];
        [payButton PSSetRightAtItem:customerServiceButton Length:WidthRate(9)];
        [payButton setTitle:@"待付预付款" forState:UIControlStateNormal];
        [payButton PSSetBottom:HeightRate(16)];
        [payButton PSSetRight:HeightRate(9)];
        [payButton PSSetSize:WidthRate(75) Height:HeightRate(25)];
        
    }else if ([state isEqualToString:@"1"])
    {
        [self addSubview:payButton];
        [self addSubview:customerServiceButton];
        [self addSubview:contractButton];
        [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
        [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
        YHButton *paymentVoucher = [YHButton initBorderStyleWithTitle:@"申请开票"];
        [paymentVoucher addTarget:self action:@selector(paymentVoucherClickedWithOrder) forControlEvents:UIControlEventTouchUpInside];
        paymentVoucher.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:paymentVoucher];
        [paymentVoucher PSSetSize:WidthRate(60) Height:HeightRate(25)];

        [contractButton PSSetLeft:WidthRate(99)];
        [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];

        [customerServiceButton PSSetRightAtItem:contractButton Length:WidthRate(9)];
        [paymentVoucher PSSetRightAtItem:customerServiceButton Length:WidthRate(9)];
        [payButton PSSetSize:WidthRate(75) Height:HeightRate(25)];
        [payButton PSSetRightAtItem:paymentVoucher Length:WidthRate(9)];
        [payButton setTitle:@"付尾款" forState:UIControlStateNormal];
        [payButton PSSetBottom:HeightRate(16)];
        [payButton PSSetRight:HeightRate(9)];
    }else if ([state isEqualToString:@"2"])
    {
        [self addSubview:customerServiceButton];
        [self addSubview:contractButton];
        [customerServiceButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
        [contractButton PSSetSize:WidthRate(60) Height:HeightRate(25)];
        YHLogisticsDetailButton *logisticsDetailButton = [YHLogisticsDetailButton initBorderStyleWithTitle:nil];
        [logisticsDetailButton addTarget:self action:@selector(logisticsDetailButtonClickedWithOrder:) forControlEvents:UIControlEventTouchUpInside];
        _isOpen = NO;
        [self addSubview:logisticsDetailButton];
        
        
        [contractButton PSSetLeft:WidthRate(140)];
        [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
        [customerServiceButton setTitle:@"申请开票" forState:UIControlStateNormal];
        
        [customerServiceButton PSSetRightAtItem:contractButton Length:WidthRate(9)];
        [logisticsDetailButton PSSetRightAtItem:customerServiceButton Length:WidthRate(9)];
        [logisticsDetailButton PSSetBottom:HeightRate(16)];
        [logisticsDetailButton PSSetRight:HeightRate(9)];
        [logisticsDetailButton PSSetSize:WidthRate(105) Height:HeightRate(25)];
        
        
    }else{
                [self.paidMoneyLabel PSSetSize:0.001 Height:0.001];
                [self.bordview PSSetSize:0.001 Height:0.001];
        [self addSubview:contractButton];
        [contractButton PSSetLeft:WidthRate(296)];
        [contractButton setTitle:@"删除订单" forState:UIControlStateNormal];
        
        [contractButton PSSetRight:WidthRate(9)];
        [contractButton PSSetBottomAtItem:self.line Length:HeightRate(10)];
        [contractButton PSSetBottom:HeightRate(16)];
    }
}

#pragma mark - IBActions
- (void)logisticsDetailButtonClickedWithOrder:(UIButton *)button {
    _isOpen = !_isOpen;
    if (_isOpen) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderHeaderVieWSectionExpandWithOrder:)]) {
            [self.delegate orderHeaderVieWSectionExpandWithOrder:_order];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(orderHeaderVieWSectionNarrowWithOrder:)]) {
            [self.delegate orderHeaderVieWSectionNarrowWithOrder:_order];
        }
    }
}

- (void)payButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(payButtonClickedWithOrder:)]) {
        [self.delegate payButtonClickedWithOrder:_order];
    }
}

- (void)cancelOrderButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClickedWithOrder:)]) {
        [self.delegate cancelOrderButtonClickedWithOrder:_order];
    }
}

- (void)customerServiceButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customerServiceButtonClickedWithOrder:)]) {
        [self.delegate customerServiceButtonClickedWithOrder:_order];
    }
}

- (void)contractButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(contractButtonClickedWithOrder:)]) {
        [self.delegate contractButtonClickedWithOrder:_order];
    }
}
- (void)afterSaleClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(afterSaleClickedWithOrder:)]) {
        [self.delegate afterSaleClickedWithOrder:_order];
    }
}
- (void)paymentVoucherClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentVoucherClickedWithOrder:)]) {
        [self.delegate paymentVoucherClickedWithOrder:_order];
    }
}
- (void)paySuccessButtonClickedWithOrder {
    if (self.delegate && [self.delegate respondsToSelector:@selector(paySuccessButtonClickedWithOrder:)]) {
        [self.delegate paySuccessButtonClickedWithOrder:_order];
    }
}

@end
