//
//  YHStoreCollectionViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/7/18.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHStoreCollectionViewCell.h"
@interface YHStoreCollectionViewCell()
@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *storeName;
@property (nonatomic,strong)UILabel *storeSaleTotal;
@property (nonatomic,strong)UILabel *storeSaleCount;
@property (nonatomic,strong)UIImageView *collectImage;
@end
@implementation YHStoreCollectionViewCell
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
        
        self.storeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shouyeshoucang"]];
        self.storeImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.storeImage];
        
        [self.storeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(3));
            make.width.mas_equalTo(WidthRate(34));
            make.height.mas_equalTo(WidthRate(34));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        self.storeName = [[UILabel alloc] init];
        self.storeName.font = SYSTEM_FONT(AdaptFont(10));
        self.storeName.text = @"珠开食品商贸";
        self.storeName.textColor = TextColor_333333;
        [self.contentView addSubview:self.storeName];
        
        [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.storeImage.mas_bottom).offset(HeightRate(3));
        }];
        
        self.storeSaleTotal = [[UILabel alloc] init];
        self.storeSaleTotal.font = SYSTEM_FONT(AdaptFont(10));
        self.storeSaleTotal.textColor = ColorWithHexString(@"9B9B9B");
        self.storeSaleTotal.text = @"销售额";
        [self.contentView addSubview:self.storeSaleTotal];
        
        [self.storeSaleTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.storeName.mas_bottom).offset(HeightRate(2));
        }];
        
        self.storeSaleCount = [[UILabel alloc] init];
        self.storeSaleCount.font = SYSTEM_FONT(AdaptFont(10));
        self.storeSaleCount.text = @"订单数";
        self.storeSaleCount.textColor = ColorWithHexString(@"9B9B9B");
        [self.contentView addSubview:self.storeSaleCount];
        
        [self.storeSaleCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.storeSaleTotal.mas_bottom).offset(HeightRate(2));
        }];
        
        self.collectImage = [[UIImageView alloc] init];
        self.collectImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.collectImage];
        self.collectImage.image =  [UIImage imageNamed:@"shouyeshoucang"];

        [self.collectImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.width.mas_equalTo(WidthRate(34));
            make.height.mas_equalTo(HeightRate(10));
            make.top.mas_equalTo(self.storeSaleCount.mas_bottom).offset(HeightRate(2));
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
    
    [self.storeImage sd_setImageWithURL:[NSURL URLWithString:model.StorePhoto] placeholderImage:nil];
    self.storeName.text = model.StoreName;
    NSLog(@"jiahg=========%@",[Tools getNsstringFromDouble:model.StoreSaleAmount.doubleValue isShowUNIT:YES]);
    self.storeSaleTotal.text = [NSString stringWithFormat:@"销售额: %@",[Tools getNsstringFromDouble:model.StoreSaleAmount.doubleValue isShowUNIT:YES]];
    self.storeSaleCount.text = [NSString stringWithFormat:@"订单数: %@单",model.StoreOrders];
    if ([model.IsCollect isEqualToString:@"1"]) {
        self.collectImage.hidden = false;
    }else{
        self.collectImage.hidden = true;
    }
}
@end
