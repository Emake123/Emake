//
//  YHJoinSuperGroupView.h
//  emake
//
//  Created by zhangshichao on 2018/9/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YHSuperGroupPayDelegate<NSObject>
//index 0 微信支付  1支付宝支付
-(void)superGroupPay:(UIView *)superGroupPayView payIndex:(NSInteger)index;
@end
@interface YHJoinSuperGroupView : UIView
-(instancetype)initWithJoinSuperGroupViewWithprouctExplain:(NSString *)prouctExplain depositMoney:(NSString *)depositMoney prouctNumber:(NSString *)prouctNumber Delegate:(id)delegate;
- (void)showAnimated;

- (void)removeView;
@end
