//
//  YHOrderContract.m
//  emake
//
//  Created by eMake on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderContract.h"

//@interface YHOrderShippingInfo : NSObject
@implementation YHOrderShippingInfo

@end

@implementation YHOrderPaymentInfo

@end

@implementation YHOrderPaymentInsuraceInfo

@end

@implementation YHOrderInsurace

@end

@implementation YHChatOrderContract
+(instancetype)initWithContractNo:(NSString *)ContractNo GoodsTitle:(NSString *)GoodsTitle ContractAmount:(NSString *)ContractAmount ContractQuantity:(NSString *)ContractQuantity GoodsSeriesIcon:(NSString *)GoodsSeriesIcon  GoodsExplain:(NSString *)GoodsExplain IsStore:(NSString *)IsStore
{
    YHChatOrderContract *orderChat =[[ YHChatOrderContract alloc] init];
    orderChat.ContractNo = ContractNo;
    orderChat.GoodsTitle = GoodsTitle;
    orderChat.ContractAmount = ContractAmount;
    orderChat.ContractQuantity = ContractQuantity;
    orderChat.GoodsSeriesIcon = GoodsSeriesIcon;
    orderChat.GoodsExplain = GoodsExplain;
    orderChat.IsStore = IsStore;


    return orderChat;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
@implementation YHOrderContract

@end
