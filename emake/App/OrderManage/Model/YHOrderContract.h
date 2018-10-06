//
//  YHOrderContract.h
//  emake
//
//  Created by eMake on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YHOrderShippingInfo : NSObject

@property(nonatomic,strong)NSNumber *ShippingNumber;//个数
@property(nonatomic,copy)NSString *ShippingNo;//物流运单号
@property(nonatomic,copy)NSString *ShippingDate;//物流时间

@end

@interface YHOrderInsurace : NSObject

@property(nonatomic,strong)NSNumber *InsurdFee;//保险总价
@property(nonatomic,strong)NSNumber *InsuranceHasPayFee;//已付保险金额
@property(nonatomic,strong)NSNumber *InsurdAmount;//保额


@end

@interface YHOrderPaymentInfo : NSObject//公司

@property(nonatomic,copy)NSString *AccountOfPartyA;//账号
@property(nonatomic,copy)NSString *BankOfPartyA;//银行
@property(nonatomic,copy)NSString *NameOfPartyA;//银行支行

@end

@interface YHOrderPaymentInsuraceInfo : NSObject//保险服务

@property(nonatomic,copy)NSString *AccountOfPartyA;//账号
@property(nonatomic,copy)NSString *BankOfPartyA;//银行
@property(nonatomic,copy)NSString *NameOfPartyA;//银行支行

@end


@interface YHChatOrderContract : NSObject//

@property(nonatomic,copy)NSString *ContractNo;
@property(nonatomic,copy)NSString *GoodsTitle;
@property(nonatomic,copy)NSString *ContractAmount;
@property(nonatomic,copy)NSString *ContractQuantity;//总个数
@property(nonatomic,copy)NSString *GoodsSeriesIcon;
@property(nonatomic,copy)NSString *GoodsExplain;
@property(nonatomic,copy)NSString *IsStore;

+(instancetype)initWithContractNo:(NSString *)ContractNo GoodsTitle:(NSString *)GoodsTitle ContractAmount:(NSString *)ContractAmount ContractQuantity:(NSString *)ContractQuantity GoodsSeriesIcon:(NSString *)GoodsSeriesIcon  GoodsExplain:(NSString *)GoodsExplain IsStore:(NSString *)IsStore;

@end



@interface YHOrderContract : NSObject


@property(nonatomic,copy)NSString *ContractNo;
@property(nonatomic,copy)NSString *ContractQuantity;//商品总个数
@property(nonatomic,copy)NSString *OrderStateName;
@property(nonatomic,copy)NSString *InsurdAmount;
@property(nonatomic,copy)NSString *IsIncludeTax;
@property(nonatomic,copy)NSString *StoreId;
@property(nonatomic,copy)NSString *StoreName;
@property(nonatomic,copy)NSString *StorePhoto;

@property(nonatomic,copy)NSString *Address;
@property(nonatomic,copy)NSString *InDate;
@property(nonatomic,copy)NSString *HasPayFee;



@property(nonatomic,copy)NSString *AccountOfPartyA;
@property(nonatomic,copy)NSString *AddWhen;
@property(nonatomic,copy)NSString *BankOfPartyA;
@property(nonatomic,copy)NSString *ContractAmount;
@property(nonatomic,copy)NSString *GoodsAddValue;
@property(nonatomic,copy)NSString *NameOfPartyA;

@property(nonatomic,copy)NSString *OrderState; //-2待签订   0待付款  1生产中    2生产完成   3已发货
@property(nonatomic,copy)NSString *CouponValue;

@property(nonatomic,strong)NSString *RemainInvoiceAmount;//剩余开票金额
@property(nonatomic,strong)NSArray *ProductList;//ProductList
@property(nonatomic,strong)NSDictionary *Insurance;//InsuranceFee
@property(nonatomic,strong)NSDictionary *PaymentInfo;//
@property(nonatomic,strong)NSDictionary *PaymentInsuraceInfo;//
@property(nonatomic,strong)NSArray *ShippingInfo;//
@property(nonatomic,strong)NSDictionary *StoreOwner;//
@property(nonatomic,strong)NSString *SuperGroupDetailId;//
@property(nonatomic,strong)NSString *CategoryBName;//
@property(nonatomic,strong)NSString *InsuranceFee;//人保保费

@property(nonatomic,strong)NSString *IsOut;//IsOut  '0' 已失效 '1' 未失效

//存储其他模型数据
@property(nonatomic,strong)YHOrderInsurace *InsuraceModel;//保险
@property(nonatomic,strong)YHOrderPaymentInfo *PaymentInfoModel;//付款信息
@property(nonatomic,strong)YHOrderPaymentInsuraceInfo *PaymentInsuraceInfoModel;//保险信息
@property(nonatomic,strong)NSArray *goodsModelArr;//运费
@property(nonatomic,strong)NSArray *shipingModelArr;//物流

@property(nonatomic,assign)NSInteger sectionRecord;//记录section
@property (assign, nonatomic) BOOL isExpandSection;


@end


