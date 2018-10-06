//
//  YHShoppingTeamOrderTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/1/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHShoppingTeamOrderTableViewCell.h"

@implementation YHShoppingTeamOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        [button setTitle:@"  红苹果团队A" forState:UIControlStateNormal];
        [button setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
        [self addSubview:button];
        [button PSSetSize:WidthRate(160) Height:HeightRate(35)];
        [button PSSetLeft:WidthRate(8)];
        [button PSSetTop:HeightRate(6)];
        [button PSSetBottom:HeightRate(6)];
        self.titleButton = button;
        
        UILabel *lable=[[UILabel alloc] init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        lable.text = @"www";
        lable.textColor = ColorWithHexString(StandardBlueColor) ;
        [self addSubview:lable];
        
        [lable PSSetRight:WidthRate(10)];
        [lable PSSetCenterHorizontalAtItem:button];
        self.priceLable = lable;
    
    }
    
    return self;
}
@end
