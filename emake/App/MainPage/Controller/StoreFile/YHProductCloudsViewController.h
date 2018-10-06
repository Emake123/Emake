//
//  YHProductCloudsViewController.h
//  emake
//
//  Created by zhangshichao on 2018/9/10.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "PSVCBase.h"

@interface YHProductCloudsViewController : PSVCBase
@property (nonatomic,copy)NSString *storeId;
@property (nonatomic,copy)NSString *storeName;
@property (nonatomic,copy)NSString *catagory;
@property (nonatomic,copy)NSDictionary *catagoryDic;
@property (nonatomic,assign)NSInteger recordIndex;//记录云工厂
@property (nonatomic,assign)NSInteger recordItemIndex;

@end
