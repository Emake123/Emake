//
//  ProductPriceModel.h
//  emake
//
//  Created by eMake on 2017/8/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductPriceModel : NSObject

//ProductionFee
@property (nonatomic,copy)NSString *GoodsCode;
//@property (nonatomic,strong)NSNumber *DropDown;
@property (nonatomic,copy)NSString *GoodsPrice;


@property (nonatomic,copy)NSDictionary *DropDown;
@property (nonatomic,copy)NSString *ProductId;
@property (nonatomic,copy)NSString *ProductPrice;

@end
