//
//  YHStoreListCollectionViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/7/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHStoreListCollectionViewCell.h"
@interface YHStoreListCollectionViewCell()
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *storeName;
@property (nonatomic,strong)UILabel *storeSaleTotal;
@property (nonatomic,strong)UILabel *storeSaleCount;
@property (nonatomic,strong)UIImageView *collectImage;
@property (nonatomic,strong)UIButton *connactButton;
@property (nonatomic,strong)YHStoreModel *model;
@end

@implementation YHStoreListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        UILabel *lineV = [[UILabel alloc]init];
        lineV.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:lineV];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        self.collectImage = [[UIImageView alloc] init];
        self.collectImage.contentMode = UIViewContentModeScaleAspectFit;
        self.collectImage.image = [UIImage imageNamed:@"shouyeshoucang"];
        [self.contentView addSubview:self.collectImage];
        
        [self.collectImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(WidthRate(29));
            make.height.mas_equalTo(HeightRate(10));
            make.top.mas_equalTo(HeightRate(12));
        }];
        
        self.storeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        self.storeImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.storeImage];
        
        [self.storeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(12));
            make.width.mas_equalTo(WidthRate(90));
            make.height.mas_equalTo(WidthRate(90));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = SYSTEM_FONT(AdaptFont(14));
        self.storeName.text = @"珠开食品商贸";
        self.storeName.textColor = TextColor_333333;
        [self.contentView addSubview:self.storeName];
        
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.storeImage.mas_bottom).offset(HeightRate(7));
        }];
        
        self.storeSaleTotal = [[UILabel alloc] init];
        self.storeSaleTotal.font = SYSTEM_FONT(AdaptFont(12));
        self.storeSaleTotal.textColor = ColorWithHexString(@"9B9B9B");
        self.storeSaleTotal.text = @"销售额";
        [self.contentView addSubview:self.storeSaleTotal];
        
        [self.storeSaleTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.storeName.mas_bottom).offset(HeightRate(5));
        }];
        
        self.storeSaleCount = [[UILabel alloc] init];
        self.storeSaleCount.font = SYSTEM_FONT(AdaptFont(10));
        self.storeSaleCount.text = @"订单数";
        self.storeSaleCount.textColor = ColorWithHexString(@"9B9B9B");
        [self.contentView addSubview:self.storeSaleCount];
        
        [self.storeSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.storeSaleTotal.mas_bottom).offset(HeightRate(5));
        }];
        
        self.connactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.connactButton setTitle:@"联系客服" forState:UIControlStateNormal];
        self.connactButton.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.connactButton setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.connactButton.layer.borderWidth = WidthRate(1);
        self.connactButton.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
        self.connactButton.layer.cornerRadius = HeightRate(14);
        [self.connactButton addTarget:self action:@selector(connectServers) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.connactButton];
        
        [self.connactButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.height.mas_equalTo(HeightRate(28));
            make.width.mas_equalTo(WidthRate(125));
            make.bottom.mas_equalTo(HeightRate(-13));
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(1);
        }];
    }
    return self;
}
- (void)setData:(YHStoreModel *)model{
    self.model = model;
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:model.StorePhoto] placeholderImage:nil];
    self.storeName.text = model.StoreName;
    self.storeSaleTotal.text = [NSString stringWithFormat:@"销售额: ¥%@",[Tools getHaveNum:model.StoreSales.doubleValue ]];
    self.storeSaleCount.text = [NSString stringWithFormat:@"订单数: %ld",model.StoreOrders.integerValue];
    if ([model.IsCollect isEqualToString:@"1"]) {
        self.collectImage.hidden = false;
    }else{
        self.collectImage.hidden = true;
    }
}
- (void)connectServers{
    if (self.connactBlock) {
        self.connactBlock(self.model);
    }
}
@end
