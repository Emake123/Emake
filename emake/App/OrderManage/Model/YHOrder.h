//
//  Order.h
//  emake
//
//  Created by 袁方 on 2017/7/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

// 订单状态
typedef NS_ENUM(NSInteger, OrderStatus) {
    OrderStatusNotStart,
    OrderStatusStart,
    OrderStatusFinished,
    OrderStatusCanceled
};

// 订单付款状态
typedef NS_ENUM(NSInteger, OrderPaymentStatus) {
    
    OrderPaymentStatusNotStart, // 待付款
    OrderPaymentStatusNotReceive, // 已付款
    OrderPaymentStatusFinished, // 已完成
};

// 订单物流发货状态
typedef NS_ENUM(NSInteger, OrderLogisticsSentStatus) {
    OrderLogisticsSentStatusNotStart,// 未发货
    OrderLogisticsSentStatusStart, // 部分发货
    OrderLogisticsSentStatusFinished, // 全部发货
};

// 订单物流收货状态
typedef NS_ENUM(NSInteger, OrderLogisticsReceivedStatus) {
    OrderLogisticsReceivedStatusNotStart,// 未收货
    OrderLogisticsReceivedStatusStart, // 部分收到货
    OrderLogisticsReceivedStatusFinished, // 全部收到货
};

// 订单发票状态
typedef NS_ENUM(NSInteger, OrderInvoiceStatus) {
    OrderInvoiceStatusNotStart,// 未开票
    OrderInvoiceStatusHalf, // 申请开票
    OrderInvoiceStatuStart, // 开票中
    OrderInvoiceStatusFinished // 已开票
};
@interface YHOrderAddSevice : NSObject
//@property (nonatomic, copy) NSString *ProductName;
//@property (nonatomic, copy) NSString *ProductNumber;
//@property (nonatomic, copy) NSString *ProductPrice;
//@property (nonatomic, copy) NSString *arithType;
//@property (nonatomic, copy) NSString *AddSeriesName;

@property (nonatomic, copy) NSString *ProductId;
@property (nonatomic, copy) NSString *GoodsPrice;
@property (nonatomic, copy) NSString *GoodsTypeName;
@property (nonatomic, copy) NSString *GoodsTitle;
@property (nonatomic, copy) NSString *GoodsType;


@end
@interface YHOrder : NSObject
@property (nonatomic, copy) NSString *GoodsExplain;
@property (nonatomic, copy) NSString *GoodsSeriesCode;
@property (nonatomic, copy) NSString *GoodsSeriesIcon;
@property (nonatomic, copy) NSString *GoodsTitle;
@property (nonatomic, copy) NSString *GoodsNumber;

@property (nonatomic, copy) NSString *MainProductId;

@property (nonatomic, copy) NSString *MainProductPrice;//单价
@property (nonatomic, copy) NSString *ProductGroupPrice;//小计

@property(nonatomic,assign)NSInteger sectionRecord;//记录section

@property (nonatomic, strong) NSArray *AddServiceInfo;
@property (nonatomic, strong) NSArray *AddServiceArr;


@property (nonatomic, copy) NSString *TotalShippingFee;//运费

@property (nonatomic, copy) NSString *TotalProductGroupPrice;//运费
@property (nonatomic, strong) NSString *SuperGroupDetailId;

@property (nonatomic, copy) NSString *GoodsSeriesPhotos;//

@end
