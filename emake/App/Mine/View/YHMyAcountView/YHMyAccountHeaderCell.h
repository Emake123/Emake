//
//  YHMyAccountHeaderCell.h
//  emake
//
//  Created by 谷伟 on 2018/1/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBankModel.h"
@interface YHMyAccountHeaderCell : UITableViewCell
@property (nonatomic,retain)UIButton *selectBank;
@property (nonatomic,retain)UILabel *totalMoney;
@property (nonatomic,retain)UIButton *withDrawDetailButton;
@property (nonatomic,retain)UIButton *IncomeDetailButton;
@property (nonatomic,retain)UIView *topView;

- (void)setData:(YHBankModel *)model;
@end
