//
//  YHShareView.h
//  emake
//
//  Created by 张士超 on 2018/6/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHShareView : UIView

- (instancetype)initShareWithContentTitle:(NSString *)sharetitle theOtherTitle:(NSString *)Othertitle image:(NSArray *)shareImages url:(NSString *)shareUrlStr withCancleTitle:(NSString *)cancleTitle ;

- (void)showAnimated;


@end
