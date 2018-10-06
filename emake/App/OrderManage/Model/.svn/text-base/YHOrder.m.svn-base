//
//  Order.m
//  emake
//
//  Created by 袁方 on 2017/7/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrder.h"

@implementation YHOrderAddSevice
@end
@implementation YHOrder

+ (void)load {
    [YHOrder mj_setupObjectClassInArray:^NSDictionary *{
        return @{ @"logisticsArray" : @"YHLogistics" };
    }];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{ @"orderId" : @"id" };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (property.type.typeClass == [NSDate class]) {
        return [NSDate dateFromString:oldValue];
    }
    return oldValue;
}


@end
