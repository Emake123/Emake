//
//  YHAlertView.h
//  AlertViewTest
//
//  Created by 谷伟 on 2017/10/9.
//  Copyright © 2017年 谷伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHAlertViewDelegete <NSObject>
@optional

- (void)alertViewLeftBtnClick:(id)alertView;

- (void)alertViewRightBtnClick:(id)alertView  ;

- (void)alertViewRightBtnClick:(id)alertView  currentTitle:(NSString *)currentTitle;

@end

typedef void(^CallBackBlcok) (NSString *text);//1

@interface YHAlertView : UIView

@property (nonatomic, weak)UIViewController<YHAlertViewDelegete>* delegate;
@property (nonatomic, strong)id model;


//block
@property (nonatomic, copy)CallBackBlcok rightBlock;
@property (nonatomic, copy)CallBackBlcok leftBlock;;


//  block 警告框
- (instancetype)initWithDelegate:(id)delegate TopButtonTitle:(NSString *)topTitle BottomButtonTitle:(NSString *)bottomTitle;

//无代理  block 警告框
- (instancetype)initWithTitle:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;

//无图片的警告框
- (instancetype)initWithDelegete:(id)delegate Title:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;

- (instancetype)initWithDelegete:(id)delegate Title:(NSString *)title cancleButtonTitle:(NSString *)cancleButtonTitle;
//有图片的警告框
- (instancetype)initWithDelegete:(id)delegate image:(UIImage *)image Title:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;

- (instancetype)initWithTitle:(NSString *)title AndUpdateNecessaryText:(NSString *)text;

- (instancetype)initWithTitle:(NSString *)title AndUpdateUnNecessaryText:(NSString *)text;

//有tips的警告框
- (instancetype)initWithAlertViewTipsTDelegete:(id)delegate Title:(NSString *)title tips:(NSArray *)tipsArr rightButtonTitle:(NSString *)rightButtonTitle;


- (instancetype)initWithShoppingCartDelegete:(id)delegate image:(UIImage *)image Title:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle;



- (instancetype)initWithDelegete:(id)delegate Title:(NSString *)title bottomTitle:(NSString *)bottomTitle ButtonTitle:(NSString *)ButtonTitle;

- (void)showAnimated;   
- (void)closeAnimated;

@end
