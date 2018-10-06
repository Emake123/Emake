//
//  YHSuperGroupConfirmOrderInfoTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupConfirmOrderInfoTableViewCell.h"

@implementation YHSuperGroupConfirmOrderInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor = ColorWithHexString(@"F2F2F2");
        bgview.layer.cornerRadius = HeightRate(24);
        bgview.layer.borderColor = ColorWithHexString(@"F8695D").CGColor;
        bgview.layer.borderWidth= 1;
        bgview.clipsToBounds= YES;
        [self addSubview:bgview];
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(353));
            make.top.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(48));
            //            make.bottom.mas_equalTo(WidthRate(10));
//            make.centerY.mas_equalTo(self.mas_centerY).offset(HeightRate(0));
            make.centerX.mas_equalTo(self.mas_centerX).offset(HeightRate(0));
        }];
        
        UILabel *prouctExplainLine = [[UILabel alloc] init];
        prouctExplainLine.backgroundColor = ColorWithHexString(@"F8695D");
        prouctExplainLine.layer.cornerRadius = HeightRate(22);
        prouctExplainLine.text = @"5人团";
        prouctExplainLine.textAlignment = NSTextAlignmentCenter;
        prouctExplainLine.textColor = ColorWithHexString(@"ffffff");
        prouctExplainLine.font = [UIFont systemFontOfSize:AdaptFont(12)];
        prouctExplainLine.clipsToBounds = YES;
        [bgview addSubview:prouctExplainLine];
        [prouctExplainLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HeightRate(44));
            make.left.mas_equalTo(WidthRate(2));
            make.centerY.mas_equalTo(bgview.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(44));
        }];
        self.peopleGroupNumberLable = prouctExplainLine;
        
        UILabel *freightPrice = [[UILabel alloc]init];
        freightPrice.text =@"¥30000 ";
        freightPrice.textColor = ColorWithHexString(@"333333");
        freightPrice.font = [UIFont systemFontOfSize:AdaptFont(18)];
        [bgview addSubview:freightPrice];
        [freightPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(prouctExplainLine.mas_right).offset(WidthRate(10));
            make.centerY.mas_equalTo(bgview.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(27));
            
        }];
        self.freightPrice = freightPrice ;
        
        UILabel *dateComit = [[UILabel alloc]init];
        dateComit.text =@"交期：2018-09-21";
        dateComit.textColor = ColorWithHexString(@"333333");
        dateComit.font = [UIFont systemFontOfSize:AdaptFont(10)];
        [bgview addSubview:dateComit];
        [dateComit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(freightPrice.mas_right).offset(WidthRate(5));
            make.centerY.mas_equalTo(freightPrice.mas_centerY).offset(HeightRate(0));
        }];
        self.dateComit = dateComit;
        
        
        UILabel *orderNum = [[UILabel alloc]init];
        orderNum.text =@"订购量：1000件";
        orderNum.textColor = ColorWithHexString(@"333333");
        orderNum.font = [UIFont systemFontOfSize:AdaptFont(10)];
        [self addSubview:orderNum];
        [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(11));
            make.top.mas_equalTo(bgview.mas_bottom).offset(HeightRate(13));
        }];
        
        self.orderNum = orderNum;
        
        UILabel *orderMoney = [[UILabel alloc]init];
        orderMoney.text =@"定金：¥1000.00";
        orderMoney.textColor = ColorWithHexString(@"F8695D");
        orderMoney.font = [UIFont systemFontOfSize:AdaptFont(20)];
        [self addSubview:orderMoney];
        [orderMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-11));
            make.top.mas_equalTo(bgview.mas_bottom).offset(HeightRate(13));
        }];
        self.orderMoney = orderMoney;
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(11));
            make.right.mas_equalTo(WidthRate(-11));
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(orderMoney.mas_bottom).offset(HeightRate(40));
//            make.bottom.mas_equalTo(HeightRate(-50));

        }];
        
        UILabel *endDate = [[UILabel alloc]init];
        endDate.text =@"还剩 12 : 59 : 35 结束";
        endDate.textColor = ColorWithHexString(@"333333");
        endDate.font = [UIFont systemFontOfSize:AdaptFont(14)];
        endDate.backgroundColor = ColorWithHexString(@"ffffff");
        [self addSubview:endDate];
        [endDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(line.mas_centerX).offset(WidthRate(0));
            make.centerY.mas_equalTo(line.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(30));

        }];
        self.endDate = endDate;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
