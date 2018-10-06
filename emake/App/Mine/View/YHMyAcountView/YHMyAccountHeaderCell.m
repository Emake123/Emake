//
//  YHMyAccountHeaderCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/4.
//  Copyright © 2018年 emake. All rights reserved.
//
#import "YHMyAccountHeaderCell.h"
@interface YHMyAccountHeaderCell()
@property (nonatomic,retain)UIImageView *bankImage;
@property (nonatomic,retain)UILabel *bankName;
@property (nonatomic,retain)UILabel *bankCardNo;
@property (nonatomic,retain)UIView *lineOne;
@end
@implementation YHMyAccountHeaderCell
- (instancetype)init{
    if (self = [super init]) {
        
        
        UIView *acountView = [[UIView alloc]init];
        acountView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        [self.contentView addSubview:acountView];
        
        [acountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(105));
        }];
        
        
        self.totalMoney = [[UILabel alloc]init];
        self.totalMoney.text = @"25000.00";
        self.totalMoney.textColor = [UIColor whiteColor];
        self.totalMoney.font =SYSTEM_FONT(AdaptFont(28));
        [acountView addSubview:self.totalMoney];
        
        [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(31));
            make.top.mas_equalTo(HeightRate(10));
            make.height.mas_equalTo(HeightRate(25));
        }];
        
        UILabel *labelRight = [[UILabel alloc]init];
        labelRight.text = @"总金额（元）";
        labelRight.textColor = [UIColor whiteColor];
        labelRight.font =SYSTEM_FONT(AdaptFont(12));
        [acountView addSubview:labelRight];
        
        [labelRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(31));
            make.top.mas_equalTo(self.totalMoney.mas_bottom);
        }];
        
        UILabel *labeltips = [[UILabel alloc]init];
        labeltips.text = @"友情提醒：提现所需缴纳的20%个税由易智造平台补贴。";
        labeltips.textColor = ColorWithHexString(@"FFFF00");
        labeltips.font =SYSTEM_FONT(AdaptFont(12));
        [acountView addSubview:labeltips];
        
        [labeltips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(31));
            make.bottom.mas_equalTo(labelRight.mas_bottom).offset(HeightRate(20));
        }];
        
        
        
        
//        UIImageView *iconWithDraw = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tixianmingxi"]];
//        [acountView addSubview:iconWithDraw];
//
//        [iconWithDraw mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.withDrawDetailButton.mas_left);
//            make.height.mas_equalTo(WidthRate(30));
//            make.width.mas_equalTo(WidthRate(30));
//            make.centerY.mas_equalTo(self.withDrawDetailButton.mas_centerY);
//        }];
        
        
        
        self.IncomeDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.IncomeDetailButton setTitle:@"收入明细" forState:UIControlStateNormal];
        [self.IncomeDetailButton setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
        self.IncomeDetailButton.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.IncomeDetailButton];
        
        [self.IncomeDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(acountView.mas_bottom).offset(HeightRate(5));
            make.width.mas_equalTo(ScreenWidth/2.1);
            
        }];
        
        UIView *lineOne = [[UIView alloc]init];
        lineOne.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:lineOne];
        
        [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(acountView.mas_bottom).offset(HeightRate(5));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(HeightRate(20));
        }];
        self.withDrawDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.withDrawDetailButton setTitle:@"提现明细" forState:UIControlStateNormal];
        [self.withDrawDetailButton setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
        self.withDrawDetailButton.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.withDrawDetailButton];
        
        [self.withDrawDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-0));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(acountView.mas_bottom).offset(HeightRate(5));
            make.width.mas_equalTo(HeightRate(ScreenWidth/2.1));

        }];
        
        
        self.topView = [[UIView alloc]init];
        self.topView.hidden = true;
        [self.contentView addSubview:self.topView];
        
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.withDrawDetailButton.mas_bottom).offset(HeightRate(5));
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(5));
        }];
       
        self.bankImage = [[UIImageView alloc]init];
        [self.topView addSubview:self.bankImage];
        
        [self.bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.width.mas_equalTo(WidthRate(34));
            make.height.mas_equalTo(WidthRate(34));
            make.top.mas_equalTo(HeightRate(22));
        }];
        
        self.bankName = [[UILabel alloc]init];
        self.bankName.text = @"农业银行";
        self.bankName.textColor = TextColor_333333;
        self.bankName.font = SYSTEM_FONT(AdaptFont(16));
        [self.topView addSubview:self.bankName];
        
        [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankImage.mas_right).offset(WidthRate(8));
            make.top.mas_equalTo(HeightRate(16));
            make.height.mas_equalTo(HeightRate(22));
        }];
        
        self.bankCardNo = [[UILabel alloc]init];
        self.bankCardNo.text = @"储值卡*************123456";
        self.bankCardNo.textColor = TextColor_949494;
        self.bankCardNo.font = SYSTEM_FONT(AdaptFont(16));
        [self.topView addSubview:self.bankCardNo];
        
        [self.bankCardNo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankImage.mas_right).offset(WidthRate(8));
            make.top.mas_equalTo(self.bankName.mas_bottom);
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        
        UIImageView *selectImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xuanzeyinhangka02"]];
        [self.topView addSubview:selectImage];
        
        [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-19));
            make.width.mas_equalTo(WidthRate(22));
            make.height.mas_equalTo(WidthRate(22));
            make.top.mas_equalTo(HeightRate(27));
        }];
        
        
        self.lineOne = [[UIView alloc]init];
        self.lineOne.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:self.lineOne];
        
        [self.lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(-0));
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(self.topView.mas_bottom);
        }];
        
        UILabel *labelSelect = [[UILabel alloc]init];
        labelSelect.text = @"我的银行卡";
        labelSelect.textColor = TextColor_333333;
        labelSelect.font = SYSTEM_FONT(AdaptFont(16));
        [self.contentView addSubview:labelSelect];
        
        [labelSelect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(72));
            make.top.mas_equalTo(self.lineOne.mas_bottom).offset(HeightRate(11));
            make.height.mas_equalTo(HeightRate(22));
            make.bottom.mas_equalTo(HeightRate(-5));

        }];
        
        UIImageView *otherBankImage =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bankc"]];
        [self.contentView addSubview:otherBankImage];
        
        [otherBankImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.width.mas_equalTo(WidthRate(30));
            make.height.mas_equalTo(WidthRate(30));
            make.centerY.mas_equalTo(labelSelect.mas_centerY);
        }];
        
        UIImageView *rightImage =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:rightImage];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-20));
            make.width.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(labelSelect.mas_centerY);
        }];
        
        self.selectBank = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.selectBank];
        
        [self.selectBank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineOne.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(41));
        }];
    
    }
    return self;
}
- (void)setData:(YHBankModel *)model{
    self.topView.hidden = false;
    self.bankName.text = model.CardBank;
    [self.bankImage sd_setImageWithURL:[NSURL URLWithString:model.CardLogo] placeholderImage:nil];
    NSString *cardString = [model.CardId stringByReplacingCharactersInRange:NSMakeRange(0, model.CardId.length-6) withString:@"************"];
    self.bankCardNo.text = [NSString stringWithFormat:@"%@%@",model.CardType,cardString];

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
