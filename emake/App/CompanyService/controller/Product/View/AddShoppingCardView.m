//
//  AddShoppingCardView.m
//  emake
//
//  Created by eMake on 2017/9/1.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "AddShoppingCardView.h"
#import "UIView+Common.h"

static CGFloat const LineViewHeight = 1.0f;
@implementation AddShoppingCardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)getAddShoppingView:(UIView *)view
{
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:bottomView];
    [bottomView PSSetConstraint:0 Right:0 Top:HeightRate(ScreenHeight-62) Bottom:0];
    
    _addToShoppingcart = [UIButton buttonWithType:UIButtonTypeSystem];
    _addToShoppingcart.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:_addToShoppingcart];
    _addToShoppingcart.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
    _addToShoppingcart.userInteractionEnabled = YES;
    _addToShoppingcart.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [_addToShoppingcart setTitle:@"加入\n购物车" forState:UIControlStateNormal];
    _addToShoppingcart.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _addToShoppingcart.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [_addToShoppingcart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addToShoppingcart PSSetTop:0];
    [_addToShoppingcart PSSetSize:WidthRate(82) Height:HeightRate(62)];
    [_addToShoppingcart PSSetRight:0];
    
    _customSeviceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _customSeviceButton.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:_customSeviceButton];
    _customSeviceButton.backgroundColor = ColorWithHexString(@"FAAF1E");
    _customSeviceButton.userInteractionEnabled = YES;
    _customSeviceButton.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [_customSeviceButton setTitle:@"客服" forState:UIControlStateNormal];
    [_customSeviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_customSeviceButton PSSetTop:0];
    [_customSeviceButton PSSetSize:WidthRate(54) Height:HeightRate(62)];
    [_customSeviceButton PSSetRight:WidthRate(82)];

    
    UILabel *markLb = [[UILabel alloc] init];
    markLb.translatesAutoresizingMaskIntoConstraints = NO;
    markLb.textColor = ColorWithHexString(StandardBlueColor);
    markLb.text = @"¥";
    markLb.font = [UIFont systemFontOfSize:AdaptFont(16)];
    [bottomView addSubview: markLb];
    [markLb PSSetCenterHorizontalAtItem:bottomView];
    [markLb PSSetLeft:WidthRate(100)];
    
    UILabel *priceLb = [[UILabel alloc] init];
    priceLb.translatesAutoresizingMaskIntoConstraints = NO;
    priceLb.textColor = ColorWithHexString(StandardBlueColor);
    priceLb.font = [UIFont systemFontOfSize:AdaptFont(18)];
    priceLb.text = @"0";
    [bottomView addSubview:priceLb];
    [priceLb PSSetRightAtItem:markLb Length:3];
    self.salePriceLabel = priceLb;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.left.mas_equalTo(bottomView.mas_left);
        make.right.mas_equalTo(_addToShoppingcart);
        make.height.mas_equalTo(LineViewHeight);
    }];
    
}
-(UILabel *)getPriceLable:(UIView *)bgview Item:(id)item name:(NSString *)name color:(NSString *)color top:(CGFloat)top
{
    UILabel * nameLable = [[UILabel alloc] init];
    nameLable.translatesAutoresizingMaskIntoConstraints = NO;
    nameLable.textColor = ColorWithHexString(color);
    nameLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    nameLable.text  = name;
    nameLable.textAlignment = NSTextAlignmentLeft;
    [bgview addSubview:nameLable];
    if (item == nil) {
        [nameLable PSSetTop:HeightRate(top)];
        [nameLable PSSetLeft:WidthRate(12)];
        
    }else
    {[nameLable PSSetRightAtItem:item Length:WidthRate(60)];
    
    }
    
     UILabel *priceLb = [[UILabel alloc] init];
    priceLb.translatesAutoresizingMaskIntoConstraints = NO;
    priceLb.textColor = ColorWithHexString(color);
    priceLb.font = [UIFont systemFontOfSize:AdaptFont(12)];
    priceLb.text = @"0";
    [bgview addSubview:priceLb];
    [priceLb PSSetRightAtItem:nameLable Length:WidthRate(11)];
    

    UILabel *markLb = [[UILabel alloc] init];
    markLb.translatesAutoresizingMaskIntoConstraints = NO;
    markLb.textColor = ColorWithHexString(color);
    markLb.text = @"¥";
    markLb.font = [UIFont systemFontOfSize:AdaptFont(8)];
    [bgview addSubview: markLb];
    [markLb PSSetRightAtItem:nameLable Length:3];
    if (item) {
        nameLable.font = [UIFont systemFontOfSize:AdaptFont(15)];
        priceLb.font = [UIFont systemFontOfSize:AdaptFont(15)];
        markLb.font = [UIFont systemFontOfSize:AdaptFont(10)];



    }
    if ([name isEqualToString:@"材料成本:"]) {
        self.materialPriceabel = priceLb;
        
    } else if([name isEqualToString:@"制造费用:"])
    {
        self.makeProductLable = priceLb;
        
        
    } else if ([name isEqualToString:@"销售价:"])
    {
        self.salePriceLabel = priceLb;
    
    }
    
    return nameLable;


}

@end
