//
//  YHActionSheetView.h
//  AlertViewTest
//
//  Created by 谷伟 on 2017/10/9.
//  Copyright © 2017年 谷伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHActionSheetViewDelegete <NSObject>

@required

- (void)actionSheetView:(id)actionSheet selectItemWithIndex:(NSInteger)index;

@optional
- (void)actionSheetViewCancell;

@end

@interface YHActionSheetView : UIView

@property (nonatomic, weak)UIViewController<YHActionSheetViewDelegete>* delegate;

- (instancetype)initWithDelegate:(id)delegate withCancleTitle:(NSString *)cancleTitle andItemArrayTitle:(NSArray *)titleArray;

- (void)showAnimated;

@end
