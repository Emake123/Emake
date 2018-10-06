//
//  YHSelectView.h
//  emake
//
//  Created by 谷伟 on 2017/10/26.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YHSelectViewDelegete <NSObject>
@optional

- (void)selectView:(id)selectView selectItemWithIndex:(NSInteger)index;


@end

@interface YHSelectView : UIView

@property (nonatomic, weak)UIViewController<YHSelectViewDelegete>* delegate;

- (instancetype)initWithDelegat:(id)delegate andTitle:(NSString *)title items:(NSArray *)titles;

- (void)showAnimated;
@end

