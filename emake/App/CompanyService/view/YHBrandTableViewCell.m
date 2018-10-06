//
//  YHBrandTableViewCell.m
//  emake
//
//  Created by eMake on 2017/11/6.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHBrandTableViewCell.h"
#import "UIView+PSAutoLayout.h"


@implementation YHBrandTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.translatesAutoresizingMaskIntoConstraints = NO;
        imageview.image = [UIImage imageNamed:@""];
        imageview.translatesAutoresizingMaskIntoConstraints = NO;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.autoresizesSubviews = YES;
        imageview.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:imageview];
        [imageview PSSetLeft:WidthRate(2)];
        [imageview PSSetTop:HeightRate(10)];
        [imageview PSSetBottom:HeightRate(15)];
        [imageview PSSetSize:WidthRate(64) Height:HeightRate(75)];

        self.companyImageview = imageview;
        
        
        CGFloat spaceLeft = 74;

        //公司名称
        UILabel *companyName = [[UILabel alloc] init];
        companyName.text = @"江苏网为非晶科技有限公司";
        companyName.font = [UIFont systemFontOfSize:AdaptFont(12)];
        companyName.textColor =  ColorWithHexString(@"000000");
        companyName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:companyName];
        [companyName PSSetLeft:WidthRate(spaceLeft)];
        [companyName PSSetTop:HeightRate(18)];
        [companyName PSSetWidth:WidthRate(237)];
        self.companyName = companyName;
//        向左箭头
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setImage:[UIImage imageNamed:@"direction_right"] forState:UIControlStateNormal];
        [self addSubview:button];
        [button PSSetRight:WidthRate(5)];
        [button PSSetCenterHorizontalAtItem:imageview];
        [button PSSetSize:WidthRate(17) Height:HeightRate(17)];
        self.rightButton = button;
        
        
        //        品牌授类型
        UILabel *brandKind = [[UILabel alloc] init];
        brandKind.text = @"品牌类型：品牌";
        brandKind.font = [UIFont systemFontOfSize:AdaptFont(12)];
        brandKind.textColor =  ColorWithHexString(@"000000");
        brandKind.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:brandKind];
        [brandKind PSSetLeft:WidthRate(spaceLeft)];
        [brandKind PSSetBottomAtItem:companyName Length:HeightRate(5)];
        self.brandKind = brandKind;
        
        
//        品牌授权费
        UILabel *brandFee = [[UILabel alloc] init];
        brandFee.text = @"品牌授权费:2%";
        brandFee.font = [UIFont systemFontOfSize:AdaptFont(12)];
        brandFee.textColor =  ColorWithHexString(@"000000");
        brandFee.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:brandFee];
        [brandFee PSSetLeft:WidthRate(spaceLeft)];
        [brandFee PSSetBottomAtItem:brandKind Length:HeightRate(5)];
        self.brandFee = brandFee;
        
        UILabel *lable = [[UILabel alloc] init];
        lable.backgroundColor =SepratorLineColor;
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:lable];
        [lable PSSetSize:ScreenWidth Height:HeightRate(1)];
        [lable PSSetLeft:0];
        [lable PSSetBottom:1];
    }
    
    return self;
    
}

@end
