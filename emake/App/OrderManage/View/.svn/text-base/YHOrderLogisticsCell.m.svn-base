//
//  YHOrderLogisticsCell.m
//  emake
//
//  Created by 袁方 on 2017/7/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderLogisticsCell.h"
#import "YHLabel.h"
@implementation YHOrderLogisticsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        YHButton *button = [YHButton initBorderStyleWithTitle:@"查看物流" color:APP_THEME_MAIN_COLOR];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button PSSetLeft:WidthRate(300)];
        [button PSSetSize:WidthRate(65) Height:HeightRate(25)];
        [button PSSetTop:HeightRate(20)];
        [button PSSetBottom:HeightRate(20)];
        [button PSSetCenterHorizontalAtItem:self.contentView];
        self.logisticsButton = button;
        
        
        UILabel *lablestate = [[UILabel alloc]init];
        lablestate.text = @"运单号：60040063178001";
        
        lablestate.font = [UIFont systemFontOfSize:AdaptFont(15)];
        lablestate.textColor = ColorWithHexString(@"333333");
        lablestate.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lablestate];
        [lablestate PSSetTop:HeightRate(0)];
        [lablestate PSSetLeft:WidthRate(15)];
        [lablestate PSSetHeight:HeightRate(30)];

        self.logisticsIdLabel =lablestate;
        
 
        
        UILabel *lableName = [[UILabel alloc]init];
        lableName.text = @"日期：2017-06-18";
        lableName.font = [UIFont systemFontOfSize:AdaptFont(15)];
        lableName.textColor = ColorWithHexString(@"333333");
        lableName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lableName];
        [lableName PSSetBottomAtItem:lablestate Length:HeightRate(0)];
        [lableName PSSetLeft:WidthRate(15)];
        [lableName PSSetHeight:HeightRate(30)];
        self.dateLabel = lableName;
//        [lableName PSSetSize:WidthRate(130) Height:HeightRate(30)];
        
        
        UILabel *lablePrice = [[UILabel alloc]init];
        lablePrice.text = @"已发数量：14件";
        lablePrice.font = [UIFont systemFontOfSize:AdaptFont(15)];
        lablePrice.textColor = ColorWithHexString(@"333333");
        lablePrice.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lablePrice];
        [lablePrice PSSetCenterHorizontalAtItem:lableName];
        [lablePrice PSSetRight:WidthRate(10)];
        self.numberIdLabel =lablePrice;
        
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.translatesAutoresizingMaskIntoConstraints = NO;
        lineView1.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
        [self addSubview:lineView1];
        [lineView1 PSSetBottom:0];
        [lineView1 PSSetLeft:0];
        [lineView1 PSSetSize:ScreenWidth Height:1];
        
    }
    return self;
}
@end
