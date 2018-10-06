//
//  YHOrderInvoiceInfoTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/4/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHOrderInvoiceInfoTableViewCell.h"

@implementation YHOrderInvoiceInfoTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *company = [[UILabel alloc] init];
        company.translatesAutoresizingMaskIntoConstraints = NO;
        company.font = [UIFont systemFontOfSize:AdaptFont(15)];
        company.text = @"易虎网科技有限公司";
        company.textColor = [UIColor blackColor];
        [self addSubview:company];
        [company PSSetTop:HeightRate(10)];
        [company PSSetLeft:WidthRate(15)];
        self.companyLable = company;
        
        UILabel *invoice = [[UILabel alloc] init];
        invoice.translatesAutoresizingMaskIntoConstraints = NO;
        invoice.font = [UIFont systemFontOfSize:AdaptFont(13)];
        invoice.text = @"企业税号：";
        invoice.textColor = [UIColor blackColor];
        [self addSubview:invoice];
        [invoice PSSetBottomAtItem:company Length:HeightRate(10)];
        [invoice PSSetLeft:WidthRate(15)];
        self.taxLable = invoice;
        
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        [right setImage:[UIImage imageNamed:@"right01"] forState:UIControlStateNormal];
        right.userInteractionEnabled = NO;
        right.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:right];
        [right PSSetCenterHorizontalAtItem:self];
        [right PSSetSize:WidthRate(25) Height:WidthRate(25)];
        [right PSSetRight:WidthRate(10)];
        

        UILabel *line2 = [[UILabel alloc] init];
        line2.translatesAutoresizingMaskIntoConstraints = NO;
        line2.backgroundColor = SepratorLineColor;
        [self addSubview:line2];
        [line2 PSSetBottomAtItem:invoice Length:HeightRate(10)];
        [line2 PSSetLeft:WidthRate(0)];
        [line2 PSSetSize:ScreenWidth Height:HeightRate(1.2)];
        [line2 PSSetBottom:0];

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
