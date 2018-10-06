//
//  YHOrderInvoiceTableViewCell.m
//  emake
//
//  Created by eMake on 2017/9/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderInvoiceTableViewCell.h"
@implementation YHOrderInvoiceTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];
        [self.contentView addSubview:button];
        [button PSSetLeft:WidthRate(16)];
        [button PSSetSize:WidthRate(36) Height:HeightRate(36)];
        [button PSSetCenterHorizontalAtItem:self.contentView];
        self.selectBtn = button;
        
        UILabel *lableName = [[UILabel alloc]init];
        lableName.text = @"sbh15-200kva-1台";
        lableName.font = [UIFont systemFontOfSize:AdaptFont(12)];
        lableName.textColor = ColorWithHexString(@"0a0a0a");
        lableName.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lableName];
        [lableName PSSetTop:HeightRate(16)];
        [lableName PSSetLeft:WidthRate(80)];
        [lableName PSSetSize:WidthRate(117) Height:HeightRate(23)];
        self.lbName =lableName;
        
        UILabel *lablePrice = [[UILabel alloc]init];
        lablePrice.text = @"¥24000.0";
        lablePrice.font = [UIFont systemFontOfSize:AdaptFont(12)];
        lablePrice.textColor = ColorWithHexString(@"0a0a0a");
        lablePrice.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lablePrice];
        [lablePrice PSSetRightAtItem:lableName Length:WidthRate(50)];
        self.lbPrice =lablePrice;
        
        UILabel *lablestate = [[UILabel alloc]init];
        lablestate.text = @"已付款";
        lablestate.font = [UIFont systemFontOfSize:AdaptFont(12)];
        lablestate.textColor = ColorWithHexString(@"0a0a0a");
        lablestate.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:lablestate];
        [lablestate PSSetBottomAtItem:lableName Length:3];
        [lablestate PSSetLeft:WidthRate(80)];
        self.lbState = lablestate;
    }
        return self;
    
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}



@end
