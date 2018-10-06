//
//  YHProductSeriesModel.h
//  emake
//
//  Created by 谷伟 on 2017/12/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHProductSeriesModel : NSObject
@property(nonatomic,copy)NSString *CategoryId;
@property(nonatomic,copy)NSString *CategoryName;
@property(nonatomic,retain)NSArray *CategorySeries;
@property(nonatomic,assign)BOOL isSelect;
@end
