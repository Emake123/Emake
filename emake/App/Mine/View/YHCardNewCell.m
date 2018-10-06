//
//  YHCardNewCell.m
//  emake
//
//  Created by 谷伟 on 2017/9/5.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCardNewCell.h"
@interface YHCardNewCell()



@end
@implementation YHCardNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    }
- (instancetype)init{
    self = [super init];
    if (self) {
        _cardImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _cardImageView.image = [UIImage imageNamed:@"wo_mingpian"];
        [self.contentView addSubview:_cardImageView];
        
        
        [_cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(WidthRate(18));
            make.right.mas_equalTo(-WidthRate(18));
            make.top.mas_equalTo(HeightRate(15));
            make.height.mas_equalTo(HeightRate(200));
        }];
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelName.text = @"姓名";
        _labelName.textColor = TextColor_737273;
        _labelName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_labelName];
        [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(18));
            make.top.mas_equalTo(_cardImageView.mas_bottom).offset(20);
            make.width.mas_equalTo(WidthRate(35));
            make.height.mas_equalTo(WidthRate(25));
        }];
        
        _labelNameText = [[UITextField alloc]initWithFrame:CGRectZero];
        _labelNameText.text = @"芮力";
        _labelNameText.font = [UIFont systemFontOfSize:14];
        _labelNameText.textColor = TextColor_ABABAB;
        [self.contentView addSubview:_labelNameText];
        [_labelNameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_labelName.mas_right).offset(WidthRate(20));
            make.centerY.mas_equalTo(_labelName.mas_centerY);
            make.height.mas_equalTo(WidthRate(30));
            make.right.mas_equalTo(WidthRate(-38));
        }];
        
        UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectZero];
        lineLabel1.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLabel1];
        [lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(62));
            make.right.mas_equalTo(WidthRate(-38));
            make.top.mas_equalTo(_labelNameText.mas_bottom).offset(2);
            make.height.mas_equalTo(0.5);
        }];
        
        
        UILabel *labelPhone = [[UILabel alloc]initWithFrame:CGRectZero];
        labelPhone.text = @"手机";
        labelPhone.textColor = TextColor_737273;
        labelPhone.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:labelPhone];
        [labelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(18));
            make.top.mas_equalTo(_labelName.mas_bottom).offset(15);
            make.width.mas_equalTo(WidthRate(35));
            make.height.mas_equalTo(WidthRate(25));
        }];
        
        _labelPhoneText = [[UITextField alloc]initWithFrame:CGRectZero];
        _labelPhoneText.text = @"13211590002";
        _labelPhoneText.font = [UIFont systemFontOfSize:14];
        _labelPhoneText.textColor = TextColor_ABABAB;
        [self.contentView addSubview:_labelPhoneText];
        [_labelPhoneText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelPhone.mas_right).offset(WidthRate(20));
            make.right.mas_equalTo(WidthRate(-38));
            make.centerY.mas_equalTo(labelPhone.mas_centerY);
            make.height.mas_equalTo(WidthRate(30));
        }];
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectZero];
        lineLabel2.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLabel2];
        [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(62));
            make.right.mas_equalTo(WidthRate(-38));
            make.top.mas_equalTo(_labelPhoneText.mas_bottom).offset(2);
            make.height.mas_equalTo(0.5);
        }];

        UILabel *labelCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        labelCompany.text = @"单位";
        labelCompany.textColor = TextColor_737273;
        labelCompany.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:labelCompany];
        [labelCompany mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(18));
            make.top.mas_equalTo(labelPhone.mas_bottom).offset(15);
            make.width.mas_equalTo(WidthRate(35));
            make.height.mas_equalTo(WidthRate(25));
        }];
        
        _labelCompanyText = [[UITextField alloc]initWithFrame:CGRectZero];
        _labelCompanyText.text = @"易虎网科科技南京股份有限公司";
        _labelCompanyText.font = [UIFont systemFontOfSize:14];
        _labelCompanyText.textColor = TextColor_ABABAB;
        [self.contentView addSubview:_labelCompanyText];
        [_labelCompanyText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelCompany.mas_right).offset(WidthRate(20));
            make.centerY.mas_equalTo(labelCompany.mas_centerY).offset(HeightRate(-3));
            make.height.mas_equalTo(WidthRate(40));
            make.right.mas_equalTo(-WidthRate(38));
        }];
        
        UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectZero];
        lineLabel3.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLabel3];
        [lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(62));
            make.right.mas_equalTo(WidthRate(-38));
            make.top.mas_equalTo(labelCompany.mas_bottom).offset(2);
            make.height.mas_equalTo(0.3);
        }];

        UILabel *labelDistrict = [[UILabel alloc]initWithFrame:CGRectZero];
        labelDistrict.text = @"地区";
        labelDistrict.textColor = TextColor_737273;
        labelDistrict.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:labelDistrict];
        [labelDistrict mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(18));
            make.top.mas_equalTo(labelCompany.mas_bottom).offset(15);
            make.width.mas_equalTo(WidthRate(35));
            make.height.mas_equalTo(WidthRate(25));
        }];
        
        
        
        _labelDistrictText = [[UITextField alloc]initWithFrame:CGRectZero];
        _labelDistrictText.text = @"南京市江宁区水阁路8号";
        _labelDistrictText.font = [UIFont systemFontOfSize:14];
        _labelDistrictText.textColor = TextColor_ABABAB;
        _labelDistrictText.userInteractionEnabled = NO;
        [self.contentView addSubview:_labelDistrictText];
        [_labelDistrictText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelDistrict.mas_right).offset(WidthRate(20));
            make.right.mas_equalTo(WidthRate(-45));
            make.centerY.mas_equalTo(labelDistrict.mas_centerY);
            make.height.mas_equalTo(WidthRate(35));
            
        }];
        
        self.rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:self.rightImage];
        
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WidthRate(22));
            make.width.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(labelDistrict.mas_centerY);
        }];
        
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectBtn setTitleColor:TextColor_ABABAB forState:UIControlStateNormal];
        self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [self.contentView addSubview:self.selectBtn];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.rightImage.mas_left).offset(0);
            make.width.mas_equalTo(WidthRate(50));
            make.height.mas_equalTo(HeightRate(23));
            make.centerY.mas_equalTo(labelDistrict.mas_centerY);
        }];
        
        UILabel *lineLabel4 = [[UILabel alloc]initWithFrame:CGRectZero];
        lineLabel4.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLabel4];
        [lineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(62));
            make.right.mas_equalTo(WidthRate(-38));
            make.top.mas_equalTo(labelDistrict.mas_bottom).offset(2);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *labelAdress = [[UILabel alloc]initWithFrame:CGRectZero];
        labelAdress.text = @"地址";
        labelAdress.textColor = TextColor_737273;
        labelAdress.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:labelAdress];
        [labelAdress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(18));
            make.top.mas_equalTo(labelDistrict.mas_bottom).offset(15);
            make.width.mas_equalTo(WidthRate(35));
            make.height.mas_equalTo(WidthRate(25));
        }];
        
        _labelAdressText = [[UITextField alloc]initWithFrame:CGRectZero];
        _labelAdressText.text = @"南京市江宁区水阁路8号";
        _labelAdressText.font = [UIFont systemFontOfSize:14];
        _labelAdressText.textColor = TextColor_ABABAB;
        [self.contentView addSubview:_labelAdressText];
        [_labelAdressText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelAdress.mas_right).offset(WidthRate(20));
            make.right.mas_equalTo(WidthRate(-45));
            make.centerY.mas_equalTo(labelAdress.mas_centerY);
            make.height.mas_equalTo(WidthRate(35));
        }];
        
        UILabel *lineLabel5 = [[UILabel alloc]initWithFrame:CGRectZero];
        lineLabel5.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLabel5];
        [lineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(62));
            make.right.mas_equalTo(WidthRate(-38));
            make.top.mas_equalTo(labelAdress.mas_bottom).offset(2);
            make.height.mas_equalTo(0.5);
        }];

    }
    return self;
}
- (void)setData:(UserInfoModel *)model{
    
    
    [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:model.RawCardUrl] placeholderImage:[UIImage imageNamed:@"wo_mingpian"]];
    self.labelNameText.text = model.RealName;
    self.labelPhoneText.text = model.TelCell;
    self.labelCompanyText.text = model.Company;
    self.labelAdressText.text = model.Address;
    self.labelDistrictText.text = [NSString stringWithFormat:@"%@ %@",model.Province,model.City];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
