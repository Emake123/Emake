//
//  YHShoppingCartProduction.h
//  emake
//
//  Created by 袁方 on 2017/7/25.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHShoppingCartProductionClass : NSObject

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) NSString *productionClassName;
@property (nonatomic, strong) NSMutableArray *productionItems;

@end
