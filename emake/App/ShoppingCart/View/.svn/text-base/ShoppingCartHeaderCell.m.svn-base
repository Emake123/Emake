//
//  ShoppingCartHeaderCell.m
//  emake
//
//  Created by 谷伟 on 2017/9/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "ShoppingCartHeaderCell.h"

@implementation ShoppingCartHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)init{
    
    self = [super init];
    if (self) {
        self.selectSectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectSectionBtn setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        [self.selectSectionBtn setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.selectSectionBtn];
        
        [self.selectSectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(WidthRate(25));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(HeightRate(3));
            
        }];
        
        UIImageView *storeImageView = [[UIImageView alloc] init];
        storeImageView .image = [UIImage imageNamed:@""];
        storeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:storeImageView];
        [storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectSectionBtn.mas_right).offset(WidthRate(6));
            make.width.mas_equalTo(WidthRate(20));
            make.height.mas_equalTo(HeightRate(20));
            make.centerY.mas_equalTo(self.selectSectionBtn.mas_centerY);
        }];
        self.storeImageView = storeImageView;
        
        self.seriesLabel = [[UILabel alloc]init];
        self.seriesLabel.text =@"SBH15系列";
        self.seriesLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
        self.seriesLabel.textColor = TextColor_0A0A0A;
        [self.contentView addSubview:self.seriesLabel];
        
        [self.seriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(storeImageView.mas_right).offset(WidthRate(6));
            make.height.mas_equalTo(WidthRate(25));
            make.top.mas_equalTo(HeightRate(6));
            make.centerY.mas_equalTo(self.selectSectionBtn.mas_centerY);
        }];
        
        
        UILabel *lineLabel =[[UILabel alloc]init];
        lineLabel.backgroundColor = SepratorLineColor;
        
        [self.contentView addSubview:lineLabel];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];

    }
    return self;
}
@end
