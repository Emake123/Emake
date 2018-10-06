//
//  AddShoppingCardView.h
//  emake
//
//  Created by eMake on 2017/9/1.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddShoppingCardView : UIView
@property UILabel *salePriceLabel;
@property UILabel *materialPriceabel;
@property UILabel *makeProductLable;
@property UIButton *addToShoppingcart;
@property UIButton *customSeviceButton;

-(void)getAddShoppingView:(UIView *)view;

@end
