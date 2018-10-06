//
//  ShoppingCartNewCell.h
//  emake
//
//  Created by 谷伟 on 2017/9/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHShoppingCartModel.h"
@interface ShoppingCartNewCell : UITableViewCell


@property (nonatomic,strong)UIButton *selectItemBtn;

@property (nonatomic,strong)UIButton *addItemBtn;

@property (nonatomic,strong)UIButton *decreseItemBtn;

@property (nonatomic,strong)UIButton *EditBtn;

@property (nonatomic,retain)UIView *changedView;

@property (nonatomic,retain)UIView *editView;

@property (nonatomic,strong)UITextField *Number;

@property(nonatomic,strong)UIButton *endEdit;
- (instancetype)initCell;
- (void)setData:(YHShoppingCartModel *)model;
@end
