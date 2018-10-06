//
//  adressTableViewCell.m
//  emake
//
//  Created by eMake on 2017/9/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "adressTableViewCell.h"
#import "UIView+Common.h"

@implementation adressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化子视图
        [self initLayout];
    }
    return self;
}

- (void)initLayout
{
    
    UILabel *name = [[UILabel alloc] init];
    name.translatesAutoresizingMaskIntoConstraints = NO;
    name.font= [UIFont systemFontOfSize:14];
    name.textColor = ColorWithHexString(@"000000");
    [self.contentView addSubview:name];
    [name PSSetLeft:WidthRate(12)];
    [name PSSetTop:HeightRate(0)];
    [name PSSetSize:100 Height:30];
    _nameLable = name;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *phone = [[UILabel alloc] init];
    phone.translatesAutoresizingMaskIntoConstraints = NO;
    phone.textColor = ColorWithHexString(@"000000");
    
    phone.font= [UIFont systemFontOfSize:14];
    [self.contentView addSubview:phone];
    [phone PSSetRightAtItem:name Length:WidthRate(130)];
    [phone PSSetSize:100 Height:30];

    _phoneLable = phone;
    
    UILabel *adress = [[UILabel alloc] init];
    adress.translatesAutoresizingMaskIntoConstraints = NO;

    adress.numberOfLines= 0;
    adress.font= [UIFont systemFontOfSize:14];
    adress.textColor = ColorWithHexString(@"000000");
    
    [self.contentView addSubview:adress];
    [adress PSSetBottomAtItem:name Length:3];
    [adress PSSetLeft:12];
    [adress PSSetWidth:WidthRate(320)];
    _detailAddresLable =adress;
    UILabel *detailAdress = [[UILabel alloc] init];
    detailAdress.translatesAutoresizingMaskIntoConstraints = NO;
    detailAdress.font= [UIFont systemFontOfSize:14];
    [self.contentView addSubview:detailAdress];
    detailAdress.textColor = ColorWithHexString(@"000000");
    
    [detailAdress PSSetBottomAtItem:adress Length:0];
    [detailAdress PSSetLeft:12];
    [detailAdress PSSetSize:ScreenWidth Height:HeightRate(60)];

    UILabel *line = [[UILabel alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.font= [UIFont systemFontOfSize:14];
    [self.contentView addSubview:line];
    line.backgroundColor = SepratorLineColor;
    
//    [line PSSetBottomAtItem:detailAdress Length:3];
    [line PSSetBottom:0];
    [line PSSetSize:ScreenWidth Height:1];
    [line PSSetLeft:0];
    
    
}

@end
