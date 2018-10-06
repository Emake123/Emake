//
//  YHStoreDetailModel.h
//  emake
//
//  Created by 谷伟 on 2018/7/20.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YHProductGoodsModel : NSObject
@property (nonatomic,copy)NSString *GoodsPriceMax;
@property (nonatomic,copy)NSString *GoodsPriceMin;
@property (nonatomic,copy)NSString *GoodsSale;
@property (nonatomic,copy)NSString *GoodsSeriesCode;
@property (nonatomic,copy)NSString *GoodsSeriesIcon;
@property (nonatomic,copy)NSString *GoodsSeriesName;
@property (nonatomic,copy)NSString *PriceRange;
@property (nonatomic,copy)NSString *GoodsSeriesPhotos;

//@property (nonatomic,assign)BOOL select;


@end
@interface YHProductCatagoryModel : NSObject
@property (nonatomic,copy)NSString *CategoryId;
@property (nonatomic,copy)NSString *CategoryName;
@property (nonatomic,copy)NSArray *CategorySeries;


@property (nonatomic,copy)NSArray *GoodsArr;
@property (nonatomic,assign)BOOL select;

@end
@interface YHStoreDetailModel : NSObject
@property (nonatomic,copy)NSArray *StoreCategoryList;
@property (nonatomic,copy)NSString *StoreBusinessCategory;
@property (nonatomic,copy)NSString *StoreName;
@property (nonatomic,copy)NSString *StoreId;
@property (nonatomic,copy)NSString *StoreSales;
@property (nonatomic,copy)NSString *IsCollect;
@property (nonatomic,copy)NSNumber *StoreOrders;
@property (nonatomic,copy)NSArray *CategoryList;
@property (nonatomic,copy)NSString *StorePhoto;
@property (nonatomic,copy)NSString *StoreSummary;
//@property (nonatomic,copy)NSString *MobileNumber;
@property (nonatomic,copy)NSString *RealName;
@property (nonatomic,copy)NSString *RefNo;
@property (nonatomic,copy)NSDictionary *StoreOwner;
@property (nonatomic,copy)NSArray *SeriesArr;




@end
