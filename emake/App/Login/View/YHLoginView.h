//
//  YHLoginView.h
//  emake
//
//  Created by eMake on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHLoginView : UIView

-(void)loginVIewWith:(UIView *)BackgroudView;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong)  UIButton *fogetBtn;
@property (nonatomic, strong)  UIButton *showPasswordBtn;
@property (nonatomic, strong) UITextField *textPhone;
@property (nonatomic, strong) UITextField *textPassword;
// 微信登录
@property (nonatomic, strong)  UIButton *weChatLoginBtn;

@end
