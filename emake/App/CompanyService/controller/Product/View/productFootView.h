//
//  productFootView.h
//  emake
//
//  Created by 张士超 on 2017/12/27.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHProductFootViewDelegate;
@protocol YHProductFootViewDelegate <NSObject>

@end
@interface productFootView : UIView


@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,assign)id delegate;

-(UIView *)getColollectionFootViewTitle:(NSString *)Title isShowPrice:(BOOL)isShow Num:(NSString *)num insuranc:(UILabel *)insurancePriceLable;

@end
