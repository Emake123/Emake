//
//  YHOrderFootTableViewCell.h
//  emake
//
//  Created by eMake on 2017/10/17.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHButton.h"
#import "YHLogisticsDetailButton.h"
#import "YHOrderContract.h"
@protocol YHOrderFootViewDelegate <NSObject>

//- (void)renewOrderButtonClickedWithOrder:( YHOrderContract *)orderContract;;
//
- (void)payAccountOrderButtonClickedWithOrder:( YHOrderContract *)orderContract;
//
- (void)insuranceOrderButtonClickedWithOrder:( YHOrderContract *)orderContract;

- (void)deleteOrderButtonClickedWithOrder:( YHOrderContract *)orderContract;

- (void)orderIsSlectButtonClick:(YHLogisticsDetailButton *)button;

- (void)customerServiceButtonClickedWithOrder:( YHOrderContract *)orderContract;

- (void)contractButtonClickedWithOrder:( YHOrderContract *)orderContract;

- (void)uploadContractButtonClickedWithOrder:( YHOrderContract *)orderContract;

- (void)paymentVoucherClickedWithOrder:( YHOrderContract *)orderContract;

@end

@interface YHOrderFootTableViewCell : UITableViewCell
@property (nonatomic, weak) id<YHOrderFootViewDelegate>delegate;
@property(nonatomic,copy)NSString *state;
@property (nonatomic, strong) YHOrder *order;
@property (nonatomic, strong) YHOrderContract *orderContract;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) YHLogisticsDetailButton *logisticsDetailButton;

@property (nonatomic, strong) YHButton *paymentVoucher;

- (void)updateOrderFootViewWithOrder:(YHOrderContract *)orders;

@end

