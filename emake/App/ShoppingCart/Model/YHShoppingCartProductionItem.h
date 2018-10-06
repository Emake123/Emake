//
//  YHShoppingCartItem.h
//  emake
//
//  Created by 袁方 on 2017/7/25.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHShoppingCartProductionItem : NSObject

@property (nonatomic, copy) NSString *productionClassName;
@property (nonatomic, copy) NSString *productionItemName;
//@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL isSelected;

//allselect ===0（默认不刷新） 2局部刷新 3全部刷新
@property (nonatomic, assign) int allSelect;

@property(nonatomic,strong)NSNumber *GoodsNumber;
@property(nonatomic,copy)NSString *GoodsSeriesImageUrl;
@property(nonatomic,strong)NSNumber *GoodsPrice;
@property(nonatomic,strong)NSNumber *MaterialFee;
@property(nonatomic,strong)NSNumber *ProductionFee;
@property(nonatomic,copy)NSString *GoodsSeriesName;
@property(nonatomic,copy)NSString *GoodsSize;
@property(nonatomic,copy)NSString *GoodsWeight;
@property(nonatomic,copy)NSString *GoodsName;
@property(nonatomic,copy)NSString *OrderNo;
@end
