//
//  YHBrandModel.h
//  emake
//
//  Created by eMake on 2017/11/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YHBrandListImageModel : NSObject

@property(nonatomic,copy)NSString *PicRefNo;
@property(nonatomic,copy)NSString *PicType;
@property(nonatomic,copy)NSString *PicTypeName;
@property(nonatomic,copy)NSString *PicName;
@property(nonatomic,copy)NSString *PicUrl;
@property(nonatomic,copy)NSString *GoodsSeriesCode;
@property(nonatomic,copy)NSString *GoodsParamName;
@property(nonatomic,copy)NSString *GoodsSeriesName;


@end
@interface YHBrandListModel : NSObject
@property(nonatomic,strong)NSArray *Brands;
@property(nonatomic,copy)NSString *CategoryId;
@property(nonatomic,copy)NSString *CategoryName;

@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,strong)NSMutableArray *BrandArr;

@end
@interface YHBrandModel : NSObject
@property(nonatomic,copy)NSString *Adress;
@property(nonatomic,copy)NSString *BrandBigicon;
@property(nonatomic,copy)NSString *BrandIcon;
@property(nonatomic,copy)NSString *BrandName;

@property(nonatomic,copy)NSString *BusinessLicense;
@property(nonatomic,copy)NSString *CategoryId;
@property(nonatomic,copy)NSString *CategoryName;
@property(nonatomic,copy)NSString *CompanyName;
@property(nonatomic,copy)NSString *Phone;
@property(nonatomic,copy)NSString *Contacts;
@property(nonatomic,copy)NSString *Rate;
@property(nonatomic,copy)NSString *RefNo;
@property(nonatomic,copy)NSString *Risk;
@property(nonatomic,copy)NSString *Service;
@property(nonatomic,copy)NSString *PicName;

@property(nonatomic,copy)NSArray *industry_list;
@property(nonatomic,copy)NSArray *system_list;
@property(nonatomic,copy)NSArray *zizhi_list;


@property(nonatomic,copy)NSArray *industryImageArr;
@property(nonatomic,copy)NSArray *systemImageArr;
@property(nonatomic,copy)NSArray *zizhiImageArr;

@property(nonatomic,copy)NSArray *picArr;

@end
