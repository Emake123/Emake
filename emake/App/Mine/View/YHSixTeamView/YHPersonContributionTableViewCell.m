//
//  YHPersonContributionTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/1/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHPersonContributionTableViewCell.h"

@implementation YHPersonContributionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor greenColor];
        UILabel *orderLable = [[UILabel alloc] init];
        orderLable.translatesAutoresizingMaskIntoConstraints = NO;
        orderLable.text = @"订单：A717171771";
        orderLable.textColor = ColorWithHexString(@"333333");
        orderLable.font =  [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:orderLable];
        [orderLable PSSetLeft:WidthRate(17)];
        [orderLable PSSetTop:HeightRate(20)];
        self.orderLable = orderLable;
        
      
        
        UILabel *priceLable = [[UILabel alloc] init];
        priceLable.translatesAutoresizingMaskIntoConstraints = NO;
        priceLable.text = @"+1000元";
        priceLable.textColor = ColorWithHexString(@"1E1E1E");//FFAC00
        priceLable.font =  [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:priceLable];
        [priceLable PSSetRight:WidthRate(13)];
        [priceLable PSSetCenterHorizontalAtItem:orderLable];
        
        self.Pricelable= priceLable;
        
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.translatesAutoresizingMaskIntoConstraints = NO;
        nameLable.text = @"张ss";
        nameLable.textColor = ColorWithHexString(@"333333");
        nameLable.font =  [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:nameLable];
        [nameLable PSSetLeft:WidthRate(17)];
        [nameLable PSSetBottomAtItem:orderLable Length:HeightRate(0)];
        [nameLable PSSetHeight:HeightRate(30)];
        self.nameLable = nameLable;
        
        UILabel *nameDetailLable = [[UILabel alloc] init];
        nameDetailLable.translatesAutoresizingMaskIntoConstraints = NO;
        nameDetailLable.text = @"分销商";
        nameDetailLable.textColor = ColorWithHexString(@"999999");
        nameDetailLable.font =  [UIFont systemFontOfSize:AdaptFont(12)];
        [self addSubview:nameDetailLable];
        [nameDetailLable PSSetRightAtItem:nameLable Length:WidthRate(10)];
        
        [nameDetailLable PSSetHeight:HeightRate(30)];

        self.detailLable = nameDetailLable;
        
        UILabel *tipPriceLable = [[UILabel alloc] init];
        tipPriceLable.translatesAutoresizingMaskIntoConstraints = NO;
        tipPriceLable.text = @"100";
        tipPriceLable.textColor = ColorWithHexString(StandardBlueColor);
        tipPriceLable.font =  [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:tipPriceLable];
//        [tipPriceLable PSSetCenterHorizontalAtItem:nameLable];
        [tipPriceLable PSSetBottomAtItem:orderLable Length:HeightRate(0)];
        [tipPriceLable PSSetRight:WidthRate(13)];
        [tipPriceLable PSSetHeight:HeightRate(30)];

        self.commitMoneyLable = tipPriceLable;
        
        UILabel *tipLable = [[UILabel alloc] init];
        tipLable.translatesAutoresizingMaskIntoConstraints = NO;
        tipLable.text = @"提成价格：";
        tipLable.textColor = ColorWithHexString(@"999999");
        tipLable.font =  [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:tipLable];
//        [tipLable PSSetRightAtItem:nameDetailLable Length:WidthRate(10)];
        [tipLable PSSetCenterHorizontalAtItem:tipPriceLable];
        [tipLable PSSetLeftAtItem:tipPriceLable Length:0];
        self.commitTipsLable = tipLable;
        
        UILabel *dateLable = [[UILabel alloc] init];
        dateLable.translatesAutoresizingMaskIntoConstraints = NO;
        dateLable.text = @"2017-12-28";
        dateLable.textColor = ColorWithHexString(@"999999");
        dateLable.font =  [UIFont systemFontOfSize:AdaptFont(12)];
        [self addSubview:dateLable];
        //        [dateLable PSSetLeft:WidthRate(17)];
        //        [dateLable PSSetBottomAtItem:orderLable Length:HeightRate(8)];
        //        [dateLable PSSetBottom:HeightRate(5)];
        [dateLable PSSetLeft:WidthRate(17)];
        [dateLable PSSetBottomAtItem:nameLable Length:HeightRate(0)];
        [dateLable PSSetHeight:HeightRate(30)];
        self.Datelable= dateLable;
        
        UILabel *line = [[UILabel alloc] init];
        line.translatesAutoresizingMaskIntoConstraints =NO;
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line PSSetBottomAtItem:dateLable Length:HeightRate(5)];
        [line PSSetLeft:0];
        [line PSSetSize:ScreenWidth Height:1];
        [line PSSetBottom:0];
        
    }
    
    return self;
    
}

@end
