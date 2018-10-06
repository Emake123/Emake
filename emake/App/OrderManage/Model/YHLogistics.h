//
//  YHLogistics.h
//  emake
//
//  Created by 袁方 on 2017/7/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHLogistics : NSObject

@property(nonatomic,copy)NSString *ShippingState;
@property(nonatomic,copy)NSString *ShippingRemark;
@property(nonatomic,strong)NSArray *Goods;
@property(nonatomic,copy)NSString *ShippingFee;
@property(nonatomic,copy)NSString *ReceiverAddress;
@property(nonatomic,copy)NSString *ContractNo;
@property(nonatomic,copy)NSString *LogisticsBillNo;
@property(nonatomic,copy)NSString *ShippingPhone;
@property(nonatomic,copy)NSString *ReceiverPhone;
@property(nonatomic,copy)NSString *ShippingNo;
@property(nonatomic,copy)NSString *ShippingPlate;
@property(nonatomic,copy)NSString *Receiver;
@property(nonatomic,copy)NSString *ShippingDate;
@property(nonatomic,copy)NSString *ShippingName;


@property(nonatomic,assign)NSInteger ShippingTotalNumber;

@end
