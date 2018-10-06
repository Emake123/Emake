//
//  TradeItemCell.m
//  emake
//
//  Created by 谷伟 on 2017/8/29.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "TradeItemCell.h"

@implementation TradeItemCell
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor =APP_THEME_MAIN_GRAY;
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeLabel.backgroundColor = TextColor_C4C4C4;
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.layer.cornerRadius = 3;
        timeLabel.layer.masksToBounds = YES;
        timeLabel.text = @"30分钟前";
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:timeLabel];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(13));
            make.width.mas_equalTo(WidthRate(69));
            make.height.mas_equalTo(HeightRate(23));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view.layer.cornerRadius = 3;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(WidthRate(15));
            make.right.mas_equalTo(WidthRate(-15));
            make.height.mas_equalTo(HeightRate(109));
        }];
        
        UILabel *orderStatus =[[UILabel alloc]initWithFrame:CGRectZero];
        orderStatus.text = @"订单已发货";
        orderStatus.font = [UIFont systemFontOfSize:14];
        orderStatus.textColor =  TextColor_FF9800;
        [view addSubview:orderStatus];
        
        [orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(WidthRate(17));
            make.height.mas_equalTo(HeightRate(32));
            make.width.mas_equalTo(WidthRate(75));
        }];
        
        UILabel *logisticsName =[[UILabel alloc]initWithFrame:CGRectZero];
        logisticsName.text = @"（德邦物流）";
        logisticsName.font = [UIFont systemFontOfSize:12];
        logisticsName.textColor =  TextColor_A3A3A3;
        [view addSubview:logisticsName];
        
        [logisticsName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(orderStatus.mas_right).offset(0);
            make.height.mas_equalTo(HeightRate(17));
            make.width.mas_equalTo(WidthRate(120));
            make.centerY.mas_equalTo(orderStatus.mas_centerY);
        }];
        
        UIImageView *goodImagview =[[UIImageView alloc]initWithFrame:CGRectZero];
        goodImagview.image = [UIImage imageNamed:@"S11"];
        [view addSubview:goodImagview];
        [goodImagview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(69));
            make.width.mas_equalTo(WidthRate(103));
            make.bottom.mas_equalTo(HeightRate(-6));
        }];
        
        UILabel *goodsName =[[UILabel alloc]initWithFrame:CGRectZero];
        goodsName.text = @"S11系列油浸式变压器";
        goodsName.font = [UIFont systemFontOfSize:14];
        [view addSubview:goodsName];
        
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(goodImagview.mas_right).offset(0);
            make.height.mas_equalTo(HeightRate(30));
            make.width.mas_equalTo(WidthRate(261));
            make.top.mas_equalTo(38);
        }];
        
        
        UILabel *transportNumber =[[UILabel alloc]initWithFrame:CGRectZero];
        transportNumber.text = @"S11系列油浸式变压器";
        transportNumber.font = [UIFont systemFontOfSize:12];
        transportNumber.textColor =  TextColor_A3A3A3;
        [view addSubview:transportNumber];
        
        [transportNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(goodImagview.mas_right).offset(0);
            make.height.mas_equalTo(HeightRate(17));
            make.width.mas_equalTo(WidthRate(165));
            make.bottom.mas_equalTo(HeightRate(-16));
        }];
    }
    return self;
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
