//
//  YHInsuranceSeviceCell.m
//  emake
//
//  Created by 谷伟 on 2017/12/15.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHInsuranceSeviceCell.h"
@interface YHInsuranceSeviceCell()
@property (nonatomic,retain)UIImageView *InsuranceIcon;
@property (nonatomic,retain)UILabel *InsuranceCompanyName;
@property (nonatomic,retain)UILabel *CategoryName;
@property (nonatomic,retain)UILabel *Rate;
@property (nonatomic,retain)UILabel *InsuranceValidity;
@property (nonatomic,retain)UILabel *Excess;
@property (nonatomic,retain)UILabel *remark;
@property (nonatomic,retain)UILabel *ItemTips;
@end
@implementation YHInsuranceSeviceCell
- (instancetype)init{
    if (self = [super init]) {
        
        self.backgroundColor = ColorWithHexString(@"ffffff");
        
        self.InsuranceIcon = [[UIImageView alloc]init];
        self.InsuranceIcon.image = [UIImage imageNamed:@"logo-rencai"];
        self.InsuranceIcon.contentMode =  UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.InsuranceIcon];
        
        [self.InsuranceIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(20));
            make.width.mas_equalTo(WidthRate(80));
            make.height.mas_equalTo(HeightRate(46));
            make.top.mas_equalTo(HeightRate(27));
        }];
        
        self.InsuranceCompanyName = [[UILabel alloc]init];
        self.InsuranceCompanyName.font = [UIFont boldSystemFontOfSize:AdaptFont(14)];
        self.InsuranceCompanyName.textColor = TextColor_0A0A0A;
        self.InsuranceCompanyName.text =@"中国人民财产保险股份有限公司";
        [self.contentView addSubview:self.InsuranceCompanyName];
        
        [self.InsuranceCompanyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(112));
            make.height.mas_equalTo(HeightRate(20));
            make.top.mas_equalTo(HeightRate(24));
        }];
        
        
        self.CategoryName = [[UILabel alloc]init];
        self.CategoryName.font = [UIFont systemFontOfSize:AdaptFont(13)];
        self.CategoryName.textColor = TextColor_0A0A0A;
        self.CategoryName.text =@"投保产品类型：变压器";
        [self.contentView addSubview:self.CategoryName];
        
        [self.CategoryName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(112));
            make.height.mas_equalTo(HeightRate(19));
            make.top.mas_equalTo(self.InsuranceCompanyName.mas_bottom).offset(HeightRate(12));
        }];
        
        
        UIView *viewTwo = [self ItemView:11];
        [self.contentView addSubview:viewTwo];
        
        [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(WidthRate(100));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(self.InsuranceIcon.mas_bottom).offset(HeightRate(13));
        }];
        
        UIView *viewOne = [self ItemView:10];
        [self.contentView addSubview:viewOne];
        
        [viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(viewTwo.mas_left).offset(-WidthRate(20));
            make.width.mas_equalTo(WidthRate(100));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(self.InsuranceIcon.mas_bottom).offset(HeightRate(13));
        }];
        
        
        
        UIView *viewThree = [self ItemView:12];
        [self.contentView addSubview:viewThree];
        
        [viewThree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(viewTwo.mas_right).offset(WidthRate(15));
            make.width.mas_equalTo(WidthRate(100));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(self.InsuranceIcon.mas_bottom).offset(HeightRate(14));
        }];
        
        
        self.ItemTips = [[UILabel alloc]init];
        self.ItemTips.textColor = TextColor_666666;
        self.ItemTips.numberOfLines = 0;
        self.ItemTips.font = SYSTEM_FONT(AdaptFont(14));
        self.ItemTips.lineBreakMode = NSLineBreakByClipping;
//        self.ItemTips.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.ItemTips];
        
        [self.ItemTips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(337));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(viewTwo.mas_bottom).offset(HeightRate(15));
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.ItemTips.mas_bottom).offset(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(5);
        }];
        line.hidden = YES;
        
        UIImageView *rigthImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:rigthImage];
        
        [rigthImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-20));
            make.width.mas_equalTo(WidthRate(15));
            make.height.mas_equalTo(WidthRate(15));
            make.centerY.mas_equalTo(self.InsuranceIcon.mas_centerY);
            
        }];
    }
    return self;
}
- (UIView *)ItemView:(NSInteger)tag{
    
    UIView *view = [[UIView alloc]init];
    view.tag = tag;
    
    UIImageView *imageDote = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yuandian6x6"]];
    [view addSubview:imageDote];
    
    [imageDote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.width.mas_equalTo(WidthRate(8));
        make.height.mas_equalTo(WidthRate(8));
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UILabel *itemLabel = [[UILabel alloc]init];
    itemLabel.tag = 100;
    itemLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    itemLabel.text = @"1111";
    [view addSubview:itemLabel];
    
    [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageDote.mas_right).offset(WidthRate(6));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(HeightRate(19));
    }];
    return view;
}
- (void)setData:(YHInsuranceModel *)model{
    [self.InsuranceIcon sd_setImageWithURL:[NSURL URLWithString:model.InsuranceIcon]];
    self.InsuranceCompanyName.text = model.InsuranceCompanyName;
    NSString *CompanyNameText = [NSString stringWithFormat:@"投保产品类型：%@",model.CategoryName];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:CompanyNameText];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(APP_THEME_MAIN_COLOR) range:NSMakeRange(7, model.CategoryName.length)];
    self.CategoryName.attributedText = AttributedStr;
    
    UIView *one = [self.contentView viewWithTag:10];
    UILabel *labelOne = [one viewWithTag:100];
    NSString *RateText = [NSString stringWithFormat:@"保险费率：%@%%",model.Rate];
    NSMutableAttributedString *RateTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:RateText];
    [RateTextAttributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, model.Rate.length+1)];
    labelOne.attributedText = RateTextAttributedSting;
    
    UIView *Two = [self.contentView viewWithTag:11];
    UILabel *labelTwo = [Two viewWithTag:100];
    NSString *InsuranceValidityText = [NSString stringWithFormat:@"保险期限：%@",model.InsuranceValidity];
    NSMutableAttributedString *InsuranceValidityTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:InsuranceValidityText];
    [InsuranceValidityTextAttributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, model.InsuranceValidity.length)];
    labelTwo.attributedText = InsuranceValidityTextAttributedSting;
    
    UIView *Three = [self.contentView viewWithTag:12];
    UILabel *labelThree = [Three viewWithTag:100];
    NSString *ExcessText = [NSString stringWithFormat:@"赔付金额：%@%%",model.Excess];
    NSMutableAttributedString *ExcessTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:ExcessText];
    [ExcessTextAttributedSting addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, model.Excess.length+1)];
    labelThree.attributedText = ExcessTextAttributedSting;
    [self.ItemTips sizeToFit];
    self.ItemTips.text = [NSString stringWithFormat:@"%@  \n",model.Remark];
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
