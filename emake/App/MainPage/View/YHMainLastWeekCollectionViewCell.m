//
//  YHMainLastWeekCollectionViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/10/16.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainLastWeekCollectionViewCell.h"

@implementation YHMainLastWeekCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //上周订单
        self.viewLastWeek = [[UIView alloc]init];
        self.viewLastWeek.backgroundColor = [UIColor whiteColor];
        self.viewLastWeek.layer.cornerRadius = WidthRate(4);
        
        [self.contentView addSubview:self.viewLastWeek];
        [self.viewLastWeek mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(HeightRateCommon(160));
            make.left.mas_equalTo(0);
            
        }];
        
        UIImageView *orderImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingdanicon"]];
//        orderImage.frame = CGRectMake(WidthRate(25), HeightRate(6.5), WidthRate(18), HeightRate(18));
        [self.viewLastWeek addSubview:orderImage];
        [orderImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.width.mas_equalTo(WidthRate(18));
            make.height.mas_equalTo(HeightRateCommon(18));
            make.left.mas_equalTo(13);
            
        }];
        
        
        UILabel *labelTitle = [[UILabel alloc]init];
        labelTitle.text = @"上周订单";
        labelTitle.font = [UIFont systemFontOfSize:AdaptFont(13)];
        //    labelTitle.frame = CGRectMake(WidthRate(53), HeightRate(8.5), WidthRate(60), HeightRate(14));
        [self.viewLastWeek addSubview:labelTitle];
        [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(orderImage.mas_centerY);
            make.height.mas_equalTo(HeightRateCommon(14));
            make.left.mas_equalTo(orderImage.mas_right).offset(WidthRate(5));
            
        }];
        
        self.labelTotal = [[UILabel alloc]init];
        self.labelTotal.font = [UIFont systemFontOfSize:AdaptFont(12)];
        self.labelTotal.textAlignment = NSTextAlignmentRight;
        self.labelTotal.textColor = [UIColor blackColor];
        self.labelTotal.frame = CGRectMake(0, HeightRate(8.5), ScreenWidth - WidthRate(20), HeightRate(14));
        [self.viewLastWeek addSubview:self.labelTotal];
        [self.labelTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(orderImage.mas_centerY);
            make.height.mas_equalTo(HeightRateCommon(14));
            make.right.mas_equalTo(WidthRate(-8));
            
        }];
        
       
        
        self.labelItem1 = [[UILabel alloc]init];
        self.labelItem1.font = [UIFont systemFontOfSize:AdaptFont(12)];
        //    self.labelItem1.textAlignment = NSTextAlignmentRight;
        self.labelItem1.textColor = [UIColor blackColor];
//        self.labelItem1.frame = CGRectMake(0, HeightRate(8.5), ScreenWidth - WidthRate(20), HeightRate(14));
        [self.viewLastWeek addSubview:self.labelItem1];
        [self.labelItem1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(labelTitle.mas_bottom).offset(HeightRate(8));
            make.height.mas_equalTo(HeightRateCommon(40));
            make.left.mas_equalTo(WidthRate(13));
            
        }];
        self.labelItem1Number = [[UILabel alloc]init];
        self.labelItem1Number.font = [UIFont systemFontOfSize:AdaptFont(12)];
        //    self.labelItem1.textAlignment = NSTextAlignmentRight;
        self.labelItem1Number.textColor = [UIColor blackColor];
        self.labelItem1Number.frame = CGRectMake(0, HeightRate(8.5), ScreenWidth - WidthRate(20), HeightRate(14));
        [self.viewLastWeek addSubview:self.labelItem1Number];
        [self.labelItem1Number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.labelItem1.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRateCommon(40));
            make.centerX.mas_equalTo(self.viewLastWeek.mas_centerX);
            
        }];
        
        self.labelItem1Price = [[UILabel alloc]init];
        self.labelItem1Price.font = [UIFont systemFontOfSize:AdaptFont(12)];
        self.labelItem1.textAlignment = NSTextAlignmentRight;
        self.labelItem1Price.textColor = ColorWithHexString(StandardBlueColor);
        self.labelItem1Price.frame = CGRectMake(0, HeightRate(8.5), ScreenWidth - WidthRate(20), HeightRate(14));
        [self.viewLastWeek addSubview:self.labelItem1Price];
        [self.labelItem1Price mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.mas_equalTo(self.labelItem1.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRateCommon(40));
            make.right.mas_equalTo(WidthRate(-13));
            
        }];
        
        self.labelItem2 = [[UILabel alloc]init];
        self.labelItem2.font = [UIFont systemFontOfSize:AdaptFont(12)];
        //    self.labelItem2.textAlignment = NSTextAlignmentRight;
        self.labelItem2.textColor = [UIColor blackColor];
        [self.viewLastWeek addSubview:self.labelItem2];
        [self.labelItem2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelItem1.mas_bottom).offset(HeightRate(0));
            //        make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(HeightRateCommon(40));
            make.left.mas_equalTo(WidthRate(13));
            
        }];
        self.labelItem2Number = [[UILabel alloc]init];
        self.labelItem2Number.font = [UIFont systemFontOfSize:AdaptFont(12)];
        //    self.labelItem2.textAlignment = NSTextAlignmentRight;
        self.labelItem2Number.textColor = [UIColor blackColor];
        [self.viewLastWeek addSubview:self.labelItem2Number];
        [self.labelItem2Number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.labelItem2.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRateCommon(40));
            make.centerX.mas_equalTo(self.viewLastWeek.mas_centerX);
            
        }];
        
        self.labelItem2Price = [[UILabel alloc]init];
        self.labelItem2Price.font = [UIFont systemFontOfSize:AdaptFont(12)];
        self.labelItem2.textAlignment = NSTextAlignmentRight;
        self.labelItem2Price.textColor = ColorWithHexString(StandardBlueColor);;
        [self.viewLastWeek addSubview:self.labelItem2Price];
        [self.labelItem2Price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.labelItem2.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRateCommon(40));
            make.right.mas_equalTo(WidthRate(-13));
            
        }];
     
        
    }
    return self;
    
}
-(void)setDataDict:(NSDictionary *)dict
{
    if (dict.count>0) {
        NSString *  all_Prices = [dict objectForKey:@"TotalAmount"];
        NSString *allPrice = [Tools getNsstringFromDouble:all_Prices.doubleValue isShowUNIT:NO];
        NSString *str = [NSString stringWithFormat:@"总额  ¥%@",allPrice];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(APP_THEME_MAIN_COLOR) range:NSMakeRange(3,str.length-3)];
        [AttributedStr addAttribute:NSFontAttributeName value:SYSTEM_FONT(AdaptFont(14)) range:NSMakeRange(3,str.length-3)];
        self.labelTotal.attributedText = AttributedStr;
        NSString *price = [Tools getHaveNum:[dict[@"IndustrialAmount"] doubleValue]];
        NSString *price2 = [Tools getHaveNum:[dict[@"ConsumerAmount"] doubleValue]];
        
        NSString *str1 = [NSString stringWithFormat:@"%@",@"工业品"];
        self.labelItem1.text = str1;
        self.labelItem1Price.text =[NSString stringWithFormat:@"¥%@",price];
        
        NSString *str2 = [NSString stringWithFormat:@"%@",@"消费品"];
        
        self.labelItem1Number.text = [NSString stringWithFormat:@"%@笔",dict[@"IndustrialQty"]];
        self.labelItem2Number.text = [NSString stringWithFormat:@"%@笔",dict[@"ConsumerQty"]];
        
        self.labelItem2.text = str2;
        self.labelItem2Price.text =[NSString stringWithFormat:@"¥%@",price2];
        
    }
 
}
@end
