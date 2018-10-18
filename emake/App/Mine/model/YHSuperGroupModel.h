//
//  YHSuperGroupModel.h
//  emake
//
//  Created by zhangshichao on 2018/9/18.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSuperGroupInfoModel : NSObject

@property(nonatomic,strong)NSString *Day;
@property(nonatomic,strong)NSString *DeliveryDate;
@property(nonatomic,strong)NSString *EffectHour;
@property(nonatomic,strong)NSString *GroupPrice;
@property(nonatomic,strong)NSString *Hour;
@property(nonatomic,strong)NSString *PeopleNumber;
@property(nonatomic,strong)NSString *PeopleReadyNumber;
@property(nonatomic,strong)NSString *SetNum;
@property(nonatomic,strong)NSString *StartTime;
@property(nonatomic,strong)NSString *SuperGroupDetailId;
@property(nonatomic,strong)NSString *SuperGroupId;
@property(nonatomic,strong)NSString *FrontMoney;
@property(nonatomic,strong)NSString *IsJoin;//自己是否参加这团 0 未 1已加入

@property(nonatomic,strong)NSString *IsSuccess;//拼团是否成功 0 未成功 1成功

@end
@interface YHSuperGroupDetailModel : NSObject

@property(nonatomic,strong)NSString *EffectHour;
@property(nonatomic,strong)NSString *StartTime;
@property(nonatomic,strong)NSString *Hour;
@property(nonatomic,strong)NSString *PeopleNumber;
@property(nonatomic,strong)NSString *PeopleReadyNumber;
@property(nonatomic,strong)NSString *SetNum;
@property(nonatomic,strong)NSString *SuperGroupId;
@property(nonatomic,strong)NSString *Day;
@property(nonatomic,strong)NSString *GroupPrice;


@end
@interface YHSuperGroupModel : NSObject

@property(nonatomic,strong)NSString *Hour;
@property(nonatomic,strong)NSString *OldPrice;
@property(nonatomic,strong)NSString *GoodsExplain;
@property(nonatomic,strong)NSString *GoodsSeriesPhotos;
@property(nonatomic,strong)NSString *EndAt;
@property(nonatomic,strong)NSString *GoodsAddValue;
@property(nonatomic,strong)NSString *GroupName;
@property(nonatomic,strong)NSString *GoodsSeriesCode;
@property(nonatomic,strong)NSString *Day;
@property(nonatomic,strong)NSString *GroupPrice;
@property(nonatomic,strong)NSString *IsInvoice;
@property(nonatomic,strong)NSString *ProductId;
@property(nonatomic,strong)NSString *SuperGroupId;
@property(nonatomic,strong)NSString *GroupState;//拼团状态 0进行中 1即将开始 2已结束

@property(nonatomic,strong)NSString *GoodsSeriesKeywords;
@property(nonatomic,strong)NSString *TaxDesc;
@property(nonatomic,strong)NSString *StoreName;
@property(nonatomic,strong)NSString *StorePhoto;

@property(nonatomic,strong)NSString *FrontMoney;
@property(nonatomic,strong)NSString *StoreId;
@property(nonatomic,strong)NSString *CategoryBId;
@property(nonatomic,strong)YHSuperGroupInfoModel *infoModel;
@property(nonatomic,strong)NSString *OrderNo;


@end
