//
//  YHPayViewController.h
//  emake
//
//  Created by zhangshichao on 2018/9/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "PSVCBase.h"
typedef void(^paySuccessBlock)(BOOL isSuccess);

@interface YHPayViewController : PSVCBase

@property(nonatomic,assign)BOOL isHidenTopTitle;
@property(nonatomic,assign)paySuccessBlock successBlock;
@property(nonatomic,strong)NSString *payOrderMoney;
@property(nonatomic,strong)NSDictionary *payParams;
@property(nonatomic,strong)NSString *OrderNo;
@property(nonatomic,assign)NSInteger recordIndex;


@end
