//
//  YHProductDetailSearchTableViewCell.m
//  emake
//
//  Created by eMake on 2017/11/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHProductDetailSearchTableViewCell.h"
#import "UIView+PSAutoLayout.h"
@implementation YHProductDetailSearchTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
        UIImageView  *productImageview  = [[UIImageView alloc] init];
        productImageview.translatesAutoresizingMaskIntoConstraints = NO;
        productImageview.layer.borderWidth = 1;
        productImageview.layer.borderColor = SepratorLineColor.CGColor;
        productImageview.contentMode = UIViewContentModeScaleAspectFit;
        productImageview.autoresizesSubviews = YES;
        productImageview.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        [self.contentView addSubview:productImageview];
        [productImageview PSSetTop:HeightRate(14)];
        [productImageview PSSetLeft: WidthRate(19)];
        [productImageview PSSetSize:WidthRate(77) Height:HeightRate(75)];
        self.productImageView = productImageview;
        
        UILabel *nameLable  = [[UILabel alloc] init];
        nameLable.translatesAutoresizingMaskIntoConstraints = NO;
        nameLable.text = @"SCBH15-100kVA-国标全铜45#油";
        nameLable.textColor = ColorWithHexString(@"0A0A0A");
        nameLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:nameLable];
        [nameLable PSSetLeft:WidthRate(118)];
        [nameLable PSSetTop:HeightRate(28)];
        self.nameLable = nameLable;
        
        UILabel *priceLable  = [[UILabel alloc] init];
        priceLable.translatesAutoresizingMaskIntoConstraints = NO;
        priceLable.text = @"¥30000";
        priceLable.textColor = ColorWithHexString(@"4DBECD");
        priceLable.font = [UIFont systemFontOfSize:AdaptFont(15)];
        [self.contentView addSubview:priceLable];
        [priceLable PSSetLeft:WidthRate(118)];
        [priceLable PSSetBottomAtItem:nameLable Length:HeightRate(8)];
        self.priceLable = priceLable;
        
        
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
