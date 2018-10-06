//
//  YHQualificationOrderTableViewCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationOrderTableViewCell.h"
@interface YHQualificationOrderTableViewCell()
@property (nonatomic,retain)UILabel *orderNum;
@property (nonatomic,retain)UILabel *orderTime;
@property (nonatomic,retain)UILabel *orderState;

@property (nonatomic,retain)UILabel *companyName;
@property (nonatomic,retain)UILabel *cerName;
@property (nonatomic,retain)UILabel *cerCenter;
@property (nonatomic,retain)UILabel *cerSeries;
@property (nonatomic,retain)UILabel *cerTotal;

@property (nonatomic,retain)UILabel *cerFee;
@property (nonatomic,retain)UILabel *serversFee;

@end
@implementation YHQualificationOrderTableViewCell
- (instancetype)init{
    if (self = [super init]) {
        
        self.orderNum = [[UILabel alloc]init];
        self.orderNum.text =@"订单号：201706230001";
        self.orderNum.textColor = TextColor_555555;
        self.orderNum.font = SYSTEM_FONT(AdaptFont(12));
        [self.contentView addSubview:self.orderNum];
        
        [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(HeightRate(20));
            make.top.mas_equalTo(HeightRate(11));
        }];
        
        self.orderTime = [[UILabel alloc]init];
        self.orderTime.text =@"2017/06/22";
        self.orderTime.textColor = TextColor_555555;
        self.orderTime.font = SYSTEM_FONT(AdaptFont(12));
        [self.contentView addSubview:self.orderTime];
        
        [self.orderTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.orderNum.mas_right).offset(WidthRate(40));
            make.height.mas_equalTo(HeightRate(20));
            make.top.mas_equalTo(HeightRate(11));
        }];
        
        self.orderState = [[UILabel alloc]init];
        self.orderState.text =@"待付款";
        self.orderState.textColor = [UIColor redColor];
        self.orderState.font = SYSTEM_FONT(AdaptFont(12));
        [self.contentView addSubview:self.orderState];
        
        [self.orderState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-20));
            make.height.mas_equalTo(HeightRate(33));
            make.centerY.mas_equalTo(self.orderTime.mas_centerY);
        }];
        
        
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = TextColor_F7F7F7;
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(HeightRate(35));
            make.height.mas_equalTo(HeightRate(101));
        }];
        
        self.companyName =[[UILabel alloc]init];
        self.companyName.text = @"企业名称：易虎网科技南京有限公司";
        self.companyName.font = SYSTEM_FONT(AdaptFont(13));
        self.companyName.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.companyName];
        
        [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(HeightRate(5));
        }];
        
        self.cerName =[[UILabel alloc]init];
        self.cerName.text = @"认证机构：北京华夏认证中心";
        self.cerName.font = SYSTEM_FONT(AdaptFont(13));
        self.cerName.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.cerName];
        
        [self.cerName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.companyName.mas_bottom);
        }];
        
        self.cerCenter =[[UILabel alloc]init];
        self.cerCenter.text = @"认证类型：新企业认证";
        self.cerCenter.font = SYSTEM_FONT(AdaptFont(13));
        self.cerCenter.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.cerCenter];
        
        [self.cerCenter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.cerName.mas_bottom);
        }];
        
        self.cerSeries =[[UILabel alloc]init];
        self.cerSeries.text = @"销售方：XXXXXXX公司";
        self.cerSeries.font = SYSTEM_FONT(AdaptFont(13));
        self.cerSeries.textAlignment = NSTextAlignmentLeft;
        [view addSubview:self.cerSeries];
        
        [self.cerSeries mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(self.cerCenter.mas_bottom);
        }];
        
        self.accountBtnTwo =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.accountBtnTwo setTitle:@"打款账号" forState:UIControlStateNormal];
        self.accountBtnTwo.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
        self.accountBtnTwo.layer.borderWidth = 1;
        self.accountBtnTwo.layer.cornerRadius = 3;
        self.accountBtnTwo.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
        [self.accountBtnTwo setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [self.contentView addSubview:self.accountBtnTwo];
        
        [self.accountBtnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-11));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(view.mas_bottom).offset(HeightRate(9));
            make.width.mas_equalTo(HeightRate(65));
        }];
        
        
        self.serversFee =[[UILabel alloc]init];
        self.serversFee.text = @"咨询费：￥10000";
        self.serversFee.font = SYSTEM_FONT(AdaptFont(12));
        self.serversFee.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.serversFee];
        
        [self.serversFee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WidthRate(80));
            make.height.mas_equalTo(HeightRate(31));
            make.top.mas_equalTo(view.mas_bottom).offset(HeightRate(9));
        }];
        
        self.accountBtnOne =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.accountBtnOne setTitle:@"打款账号" forState:UIControlStateNormal];
        self.accountBtnOne.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
        self.accountBtnOne.layer.borderWidth = 1;
        self.accountBtnOne.layer.cornerRadius = 3;
        self.accountBtnOne.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
        [self.accountBtnOne setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [self.contentView addSubview:self.accountBtnOne];
        
        [self.accountBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-192));
            make.height.mas_equalTo(HeightRate(25));
            make.centerY.mas_equalTo(self.serversFee.mas_centerY);
            make.width.mas_equalTo(HeightRate(65));
        }];
        
        self.cerFee =[[UILabel alloc]init];
        self.cerFee.text = @"认证费：￥35700";
        self.cerFee.font = SYSTEM_FONT(AdaptFont(12));
        self.cerFee.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.cerFee];
        
        [self.cerFee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-196));
            make.height.mas_equalTo(HeightRate(31));
            make.centerY.mas_equalTo(self.serversFee.mas_centerY);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.7);
            make.top.mas_equalTo(HeightRate(177));
        }];
        
        self.serversBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.serversBtn setTitle:@"客服" forState:UIControlStateNormal];
        self.serversBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
        self.serversBtn.layer.borderWidth = 1;
        self.serversBtn.layer.cornerRadius = 3;
        self.serversBtn.layer.borderColor = SepratorLineColor.CGColor;
        [self.serversBtn setTitleColor:TextColor_0A0A0A forState:UIControlStateNormal];
        [self.contentView addSubview:self.serversBtn];
        
        [self.serversBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(12));
            make.width.mas_equalTo(HeightRate(65));
        }];
        self.invoceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.invoceBtn setTitle:@"开票申请" forState:UIControlStateNormal];
        self.invoceBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
        self.invoceBtn.layer.borderWidth = 1;
        self.invoceBtn.layer.cornerRadius = 3;
        self.invoceBtn.layer.borderColor = SepratorLineColor.CGColor;
        [self.invoceBtn setTitleColor:TextColor_0A0A0A forState:UIControlStateNormal];
        [self.contentView addSubview:self.invoceBtn];
        
        [self.invoceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.serversBtn.mas_left).offset(-WidthRate(9));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(12));
            make.width.mas_equalTo(HeightRate(65));
        }];
        
    }
    return self;
}
- (void)updateSubVies{
    
    self.accountBtnOne.hidden = true;
    self.accountBtnTwo.hidden = true;
    
    [self.serversFee mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-WidthRate(6));
       
    }];
    [self.cerFee mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-WidthRate(125));
        
    }];

    
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
