//
//  YHInvoiceListCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHInvoiceListCell.h"
#import "Tools.h"
@interface YHInvoiceListCell()
@property (nonatomic,retain)UILabel *stateLable;
@property (nonatomic,retain)UILabel *applyTime;
@property (nonatomic,retain)UILabel *invoiceType;
@property (nonatomic,retain)UILabel *invoiceHead;
@property (nonatomic,retain)UILabel *saler;
@property (nonatomic,retain)UILabel *total;
@property (nonatomic,retain)UILabel *total1;

@property (nonatomic,retain)UILabel *shipNo;
@property (nonatomic,retain)UILabel *shipCompany;
@end
@implementation YHInvoiceListCell
- (instancetype)init{
    if (self = [super init]) {
        
        self.stateLable =[[UILabel alloc]init];
        self.stateLable.text = @"";
        self.stateLable.font = SYSTEM_FONT(AdaptFont(14));
        self.stateLable.textColor = TextColor_3D3D3D;
        [self.contentView addSubview:self.stateLable];
        
        [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(23));
            make.top.mas_equalTo(HeightRate(10));
        }];
        
        self.detailBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.detailBtn setTitle:@"订单明细" forState:UIControlStateNormal];
        self.detailBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        self.detailBtn.layer.borderWidth = 1;
        self.detailBtn.layer.cornerRadius = 3;
        self.detailBtn.layer.borderColor = SepratorLineColor.CGColor;
        [self.detailBtn setTitleColor:TextColor_636263 forState:UIControlStateNormal];
        [self.contentView addSubview:self.detailBtn];
        
        [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-16));
            make.height.mas_equalTo(HeightRate(27));
            make.top.mas_equalTo(HeightRate(10));
            make.width.mas_equalTo(HeightRate(65));
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.7);
            make.top.mas_equalTo(HeightRate(44));
        }];
        
        self.applyTime =[[UILabel alloc]init];
        self.applyTime.text = @"申请时间：2017.10.17 16:49";
        self.applyTime.font = SYSTEM_FONT(AdaptFont(14));
        self.applyTime.textColor = TextColor_636263;
        self.applyTime.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.applyTime];
        
        [self.applyTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24)); 
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(10));
        }];
        
        self.invoiceType =[[UILabel alloc]init];
        self.invoiceType.text = @"发票类型：纸质增值税普通发票";
        self.invoiceType.font = SYSTEM_FONT(AdaptFont(14));
        self.invoiceType.textColor = TextColor_636263;
        self.invoiceType.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.invoiceType];
        
        [self.invoiceType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.applyTime.mas_bottom);
        }];
        
        self.invoiceHead =[[UILabel alloc]init];
        self.invoiceHead.text = @"发票抬头：易虎网科技有限公司";
        self.invoiceHead.font = SYSTEM_FONT(AdaptFont(14));
        self.invoiceHead.textColor = TextColor_636263;
        self.invoiceHead.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.invoiceHead];
        
        [self.invoiceHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.invoiceType.mas_bottom);
        }];
        
        self.total =[[UILabel alloc]init];
        self.total.text = @"加税合计：12000元";
        self.total.font = SYSTEM_FONT(AdaptFont(14));
        self.total.textColor = TextColor_636263;
        self.total.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.total];
        
        [self.total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.invoiceHead.mas_bottom);
        }];
        self.shipCompany =[[UILabel alloc]init];
        self.shipCompany.text = @"物流单号：";
        self.shipCompany.font = SYSTEM_FONT(AdaptFont(14));
        self.shipCompany.textColor = TextColor_636263;
        self.shipCompany.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.shipCompany];
        
        [self.shipCompany mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.total.mas_bottom);
        }];
        
        self.shipNo =[[UILabel alloc]init];
        self.shipNo.text = @"物流单号：";
        self.shipNo.font = SYSTEM_FONT(AdaptFont(14));
        self.shipNo.textColor = TextColor_636263;
        self.shipNo.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.shipNo];
        
        [self.shipNo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.shipCompany.mas_bottom);
        }];

    }
    return self;
}
- (void)setData:(YHInvoiceListModel *)model{
    
    if ([model.InvoiceState isEqualToString:@"-1"]) {
        self.stateLable.text =@"已作废";
    }else if ([model.InvoiceState isEqualToString:@"0"]){
        self.stateLable.text =@"开票中";
        self.stateLable.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.shipNo.hidden = true;
        self.shipCompany.hidden = true;
        [self.shipNo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.shipCompany mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else if ([model.InvoiceState isEqualToString:@"1"]){
        self.stateLable.text =@"已寄出";
        self.shipNo.hidden = false;
        self.shipCompany.hidden = false;
    }else if([model.InvoiceState isEqualToString:@"2"]){
        self.stateLable.text =@"已寄出";
        self.shipNo.hidden = false;
        self.shipCompany.hidden = false;
    }
    self.applyTime.text = [NSString stringWithFormat:@"申请时间：%@",model.InvoiceDate];
    if ([model.InvoiceType isEqualToString:@"0"]) {
        self.invoiceType.text = @"发票类型：增值税专用发票";
        
    }else if ([model.InvoiceType isEqualToString:@"1"]) {
        self.invoiceType.text = @"发票类型：增值税普通发票";
    }else{
        self.invoiceType.text = @"";
    }
    self.invoiceHead.text = [NSString stringWithFormat:@"发票抬头：%@",model.InvoiceTitle];
    self.total.text = [NSString stringWithFormat:@"开票金额：%@元",[Tools getHaveNum:model.InvoiceAmount.doubleValue]];

    if (model.ExpressNo.length != 0) {
        self.shipNo.text = [NSString stringWithFormat:@"快递单号：%@",model.ExpressNo];
    }
    if (model.ExpressCompany.length != 0) {
        self.shipCompany.text = [NSString stringWithFormat:@"快递公司：%@",model.ExpressCompany];
    }
    
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
