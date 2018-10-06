//
//  YHQualificationInputView.h
//  emake
//
//  Created by 谷伟 on 2017/10/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHQualificationInputView : UIView

@property(nonatomic,retain)UIButton *rightSelectBtn;

- (instancetype)initWith:(NSString *)leftText andRightBtnTitle:(NSString *)title;

@end
