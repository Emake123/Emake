//
//  YHMainLastWeekCollectionViewCell.h
//  emake
//
//  Created by zhangshichao on 2018/10/16.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHMainLastWeekCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *labelTotal;
@property (nonatomic,strong)UILabel *labelItem1;
@property (nonatomic,strong)UILabel *labelItem1Number;
@property (nonatomic,strong)UILabel *labelItem2Number;

@property (nonatomic,strong)UILabel *labelItem2;
@property (nonatomic,strong)UILabel *labelItem1Price;
@property (nonatomic,strong)UILabel *labelItem2Price;

@property (nonatomic,strong)UIView *viewLastWeek;
-(void)setDataDict:(NSDictionary *)dict;
@end
