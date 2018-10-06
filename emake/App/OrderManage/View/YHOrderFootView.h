//
//  YHOrderFootView.h
//  emake
//
//  Created by eMake on 2017/10/12.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YHOrderFootViewDelegate <NSObject>

- (void)orderHeaderVieWSectionExpandWithOrder:(YHOrder *)order;

- (void)orderHeaderVieWSectionNarrowWithOrder:(YHOrder *)order;

- (void)payButtonClickedWithOrder:(YHOrder *)order;

- (void)cancelOrderButtonClickedWithOrder:(YHOrder *)order;

- (void)customerServiceButtonClickedWithOrder:(YHOrder *)order;

- (void)contractButtonClickedWithOrder:(YHOrder *)order;

- (void)afterSaleClickedWithOrder:(YHOrder *)order;

- (void)paymentVoucherClickedWithOrder:(YHOrder *)order;

- (void)paySuccessButtonClickedWithOrder:(YHOrder *)order;
@end

// 需继承自UITableViewHeaderFooterView，不然无法通过headerViewForSection获取到
@interface YHOrderFootView : UIView

@property(nonatomic,copy)NSString *state;
@property (nonatomic, weak) UIButton *logisticsDetailButton;

@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, weak) id<YHOrderFootViewDelegate>delegate;

- (void)updateOrderFootViewWithOrder:(YHOrder *)orders;
@property (nonatomic, strong) YHOrder *order;


@end
