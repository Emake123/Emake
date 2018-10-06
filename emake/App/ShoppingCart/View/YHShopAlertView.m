//
//  YHShopAlertView.m
//  emake
//
//  Created by 张士超 on 2018/4/8.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHShopAlertView.h"
#import "Tools.h"
@interface YHShopAlertView()
@property (nonatomic,strong)UIView *maskView;
@end
@implementation YHShopAlertView

- (instancetype)initWithShoppingCartprice:(NSString *)price  pirceFee:(NSString *)priceFee  pirceTotalFee:(NSString *)pirceTotalFee{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.7];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRateCommon(260));
        
        self.center = self.maskView.center;
        
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor = [UIColor whiteColor];
        bgview.clipsToBounds = YES;
        bgview.layer.cornerRadius = 6;
        [self addSubview:bgview];
        bgview.translatesAutoresizingMaskIntoConstraints = NO;
        [bgview PSSetWidth:WidthRate(300)];
        [bgview PSSetCenterX];
        [bgview PSSetCenterHorizontalAtItem:self];
        
        UIImageView *tipImage = [[UIImageView alloc] init];
        tipImage.image = [UIImage imageNamed:@"tishifuhao"];
        tipImage.translatesAutoresizingMaskIntoConstraints= false;
        [bgview addSubview:tipImage];
        [tipImage PSSetCenterX];
        [tipImage PSSetTop:HeightRate(20)];
        [tipImage PSSetSize:WidthRate(45) Height:HeightRate(45)];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        lable.text  =  @"是否申请开票？";
        lable.textAlignment= NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lable.textColor = ColorWithHexString(@"000000");
        [bgview addSubview:lable];
        [lable PSSetCenterX];
        [lable PSSetSize:WidthRate(135) Height:HeightRate(35)];
        [lable PSSetBottomAtItem:tipImage Length:HeightRate(5)];
        
        
        NSString *priceStr = [NSString stringWithFormat:@"¥%@",price];
        UILabel *item =  [self getItem:bgview ByItem:lable topSpace:3 lableTitle:@"商品总额:" titleColor:TipsForInputColor price:priceStr priceColor:@"000000"];
        NSString *priceStr1 = [NSString stringWithFormat:@"¥%@",priceFee];
        UILabel *item1 =  [self getItem:bgview ByItem:item topSpace:0 lableTitle:@"增值税:" titleColor:TipsForInputColor price:priceStr1 priceColor:SymbolTopColor];
        
        UILabel *line1 = [[UILabel alloc] init];
        line1.translatesAutoresizingMaskIntoConstraints = NO;
        line1.backgroundColor = SepratorLineColor;
        [bgview addSubview:line1];
        line1.hidden = YES;
        [line1 PSSetBottomAtItem:item1 Length:HeightRate(3)];
        [line1 PSSetHeight:HeightRate(1)];
        [line1 PSSetLeft:0];
        [line1 PSSetRight:0];
        
        UILabel *lableTips = [[UILabel alloc] init];
        lableTips.translatesAutoresizingMaskIntoConstraints = NO;
        lableTips.text  =  @"订单商品税点详情请咨询客服";
        lableTips.textAlignment= NSTextAlignmentCenter;
        lableTips.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lableTips.textColor = ColorWithHexString(TipsForInputColor);
        [bgview addSubview:lableTips];
        [lableTips PSSetCenterX];
        [lableTips PSSetLeft:0];
//        [lableTips PSSetSize:WidthRate(135) Height:HeightRate(35)];
        [lableTips PSSetBottomAtItem:line1 Length:HeightRate(5)];
        
        UILabel *line2 = [[UILabel alloc] init];
        line2.translatesAutoresizingMaskIntoConstraints = NO;
        line2.backgroundColor = SepratorLineColor;
        [bgview addSubview:line2];
        [line2 PSSetBottomAtItem:lableTips Length:HeightRate(3)];
        [line2 PSSetHeight:HeightRate(1)];
        [line2 PSSetLeft:0];
        [line2 PSSetRight:0];
        NSString *priceStr2 = [NSString stringWithFormat:@"¥%@",pirceTotalFee];

        UILabel *item2 =  [self getItem:bgview ByItem:line2 topSpace:0 lableTitle:@"订单总额:" titleColor:TipsForInputColor price:priceStr2 priceColor:StandardBlueColor];
        
        
        UILabel *line = [[UILabel alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = SepratorLineColor;
        [bgview addSubview:line];
        [line PSSetBottomAtItem:item2 Length:HeightRate(5)];
        [line PSSetHeight:HeightRate(1)];
        [line PSSetLeft:0];
        [line PSSetRight:0];
        
        UILabel *Viline = [[UILabel alloc] init];
        Viline.backgroundColor = SepratorLineColor;
        Viline.translatesAutoresizingMaskIntoConstraints = NO;
        [bgview addSubview:Viline];
        [Viline PSSetCenterX];
        [Viline PSSetBottomAtItem:line Length:HeightRate(0)];
        [Viline PSSetHeight:HeightRate(45)];
        [Viline PSSetWidth:WidthRate(1)];
        [Viline PSSetBottom:0];
        
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [leftBtn setTitle:@"否" forState:UIControlStateNormal];
        [leftBtn setTitleColor:ColorWithHexString(TipsForInputColor) forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [leftBtn addTarget:self action:@selector(leftSureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:leftBtn];
        [leftBtn PSSetLeft:0];
        [leftBtn PSSetHeight:HeightRate(45)];
        [leftBtn PSSetBottomAtItem:line Length:0];
        [leftBtn PSSetWidth:WidthRate(149)];
        self.falseBtn = leftBtn;
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [rightBtn setTitle:@"是" forState:UIControlStateNormal];
        [rightBtn setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
//        [rightBtn addTarget:self action:@selector(rightSureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgview addSubview:rightBtn];
        [rightBtn PSSetRight:0];
        [rightBtn PSSetHeight:HeightRate(45)];
        [rightBtn PSSetWidth:WidthRate(149)];
        [rightBtn PSSetBottomAtItem:line Length:0];
        self.sureBtn = rightBtn;
    }
    return self;
}

-(UILabel *)getItem:(UIView *)item ByItem:(id)byitem topSpace:(CGFloat)topspace lableTitle:( NSString*)title titleColor:(NSString *)titlecolor price:(NSString *)price priceColor:(NSString *)priceColor
{
    UILabel *lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.text  =  title;
    lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lable.textColor = ColorWithHexString(titlecolor);
    [item addSubview:lable];
    [lable PSSetSize:WidthRate(135) Height:HeightRate(35)];
    [lable PSSetLeft:WidthRate(40)];
    [lable PSSetBottomAtItem:byitem Length:HeightRate(topspace)];
    
    
    UILabel *lable1 = [[UILabel alloc] init];
    lable1.translatesAutoresizingMaskIntoConstraints = NO;
    lable1.text  =  price;
    lable1.textAlignment = NSTextAlignmentRight;
    lable1.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lable1.textColor = ColorWithHexString(priceColor);
    [item addSubview:lable1];
    [lable1 PSSetSize:WidthRate(135) Height:HeightRate(35)];
    [lable1 PSSetCenterHorizontalAtItem:lable];
    [lable1 PSSetRight:WidthRate(40)];
    if ([title isEqualToString:@"增值税:"]) {
        UILabel *lineLable = [[UILabel alloc] init];
        lineLable.translatesAutoresizingMaskIntoConstraints = NO;
        lineLable.backgroundColor = SepratorLineColor;
        [item addSubview:lineLable];
        [lineLable PSSetLeft:WidthRate(40)];
        [lineLable PSSetRight:WidthRate(40)];
        [lineLable PSSetHeight:HeightRate(1)];
        [lineLable PSSetBottomAtItem:lable1 Length:2];
    }
    
    
    return lable;
    
}
-(void)leftSureBtnClick
{
    [self.maskView removeFromSuperview];

}
-(void)closeAnimated
{
    [self.maskView removeFromSuperview];
    
}
- (void)showAnimated{
    //这里移除之前的view重新加载下

    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity,CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
