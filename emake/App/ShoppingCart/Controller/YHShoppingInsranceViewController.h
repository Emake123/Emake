//
//  YHShoppingInsranceViewController.h
//  emake
//
//  Created by 张士超 on 2018/5/24.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "PSVCBase.h"
typedef void(^InsuranceFeeBlock)(NSString *myinsurancefee,NSString *myinsuranceMoney);

@interface YHShoppingInsranceViewController : PSVCBase
@property (nonatomic,copy)InsuranceFeeBlock myInsurance;

@property(nonatomic,strong)NSString *totalPrice;
@property(nonatomic,strong)NSString *originalTotalPrice;

@end
