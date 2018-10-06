//
//  YHProductAddSeviceModel.h
//  emake
//
//  Created by 张士超 on 2017/12/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHProductAddSeviceModel : NSObject

@property(nonatomic,strong)NSString *ProductId;
//@property(nonatomic,strong)NSString *ProductName;
//@property(nonatomic,strong)NSString *ProductPrice;
//@property(nonatomic,strong)NSString *arithType;

@property(nonatomic,strong)NSString *GoodsPrice;
@property(nonatomic,strong)NSString *GoodsTitle;
@property(nonatomic,strong)NSString *GoodsTypeName;
@property(nonatomic,strong)NSString *GoodsType;


@property(nonatomic,assign)BOOL isSelected;
@end

