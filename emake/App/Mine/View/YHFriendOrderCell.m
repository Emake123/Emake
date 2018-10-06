//
//  YHFriendOrderCell.m
//  emake
//
//  Created by 谷伟 on 2017/9/6.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHFriendOrderCell.h"

@implementation YHFriendOrderCell
- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.orderID = [[UILabel alloc]init];
        self.orderID.text = @"订单编号：6758902006899";
        self.orderID.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.orderID];
        
        [self.orderID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (WidthRate(15));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(HeightRate(14));
        }];
        
        
        self.orderCatagory = [[UILabel alloc]init];
        self.orderCatagory.text = @"类       别：资质认证";
        self.orderCatagory.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.orderCatagory];
        
        [self.orderCatagory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (WidthRate(15));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(self.orderID.mas_bottom).offset(HeightRate(2));
        }];

        self.orderAmount = [[UILabel alloc]init];
        self.orderAmount.text = @"金       额：876903元";
        self.orderAmount.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.orderAmount];
        
        [self.orderAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (WidthRate(15));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(self.orderCatagory.mas_bottom).offset(HeightRate(2));
        }];
        
        self.orderGet = [[UILabel alloc]init];
        self.orderGet.text = @"提       成：23480元";
        self.orderGet.font = [UIFont systemFontOfSize:14];
        self.orderGet.textColor = TextColor_22CBD6;
        [self.contentView addSubview:self.orderGet];
        
        [self.orderGet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (WidthRate(15));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(self.orderAmount.mas_bottom).offset(HeightRate(2));
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
- (void)setData:(NSDictionary *)dic{
    self.orderID.text = [NSString stringWithFormat:@"订单编号：%@",[dic objectForKey:@"contractNo"]];
    self.orderCatagory.text = [NSString stringWithFormat:@"类       别：%@",[dic objectForKey:@"OrderTypeName"]];
    self.orderAmount.text = [NSString stringWithFormat:@"金       额：¥%@",[dic objectForKey:@"Price"]];
    self.orderGet.text = [NSString stringWithFormat:@"提       成：¥%@",[dic objectForKey:@"Percentage"]];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
