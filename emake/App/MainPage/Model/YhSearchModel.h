//
//  YhSearchModel.h
//  emake
//
//  Created by 张士超 on 2018/6/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YhSearchModel : NSObject




@property(nonatomic,copy)NSString *GoodsSeriesCode;
@property(nonatomic,copy)NSString *GoodsSeriesName;
@property(nonatomic,copy)NSString *GoodsSeriesIcon;
@property(nonatomic,copy)NSString *GoodsSeriesPhotos;

@property(nonatomic,copy)NSString *CategoryId;
@property(nonatomic,copy)NSString *PriceRange;
//收藏
@property(nonatomic,copy)NSString *RefNo;

@property(nonatomic,copy)NSString *GoodsSeriesTitle;
@property(nonatomic,copy)NSString *StoreId;
@property(nonatomic,copy)NSString *StoreName;
@property(nonatomic,copy)NSDictionary *StoreOwner;
@property(nonatomic,copy)NSString *GoodsSale;
@property(nonatomic,copy)NSDictionary *Store;
@property(nonatomic,copy)NSString *StorePhoto;
@property(nonatomic,copy)NSString *StoreNum;

@end
