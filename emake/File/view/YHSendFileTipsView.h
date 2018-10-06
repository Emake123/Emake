//
//  YHSendFileTipsView.h
//  emake
//
//  Created by 张士超 on 2018/5/30.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YHSendFileTipsViewDelegete <NSObject>
@optional

- (void)alertViewLeftBtnClick:(id)alertView;


- (void)alertViewRightBtnClick:(id)alertView withFileUrl:(NSString *)fileurl withfileName:(NSString *)fileName;;

@end
@interface YHSendFileTipsView : UIView
@property (nonatomic, weak)UIViewController<YHSendFileTipsViewDelegete>* delegate;

- (instancetype)initWithDelegete:(id)delegate andFileurl:(NSString *)url andFileName:(NSString *)fileName;

- (void)showAnimated;
@end
