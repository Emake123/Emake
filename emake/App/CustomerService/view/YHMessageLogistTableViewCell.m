//
//  YHMessageLogistTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/8/31.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMessageLogistTableViewCell.h"

@implementation YHMessageLogistTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(50), WidthRate(50))];
        self.headImage.image = [UIImage imageNamed:@"xiaoxi_wuliu_c"];
        self.headImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.headImage];
        
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.width.mas_equalTo(WidthRate(50));
            make.height.mas_equalTo(WidthRate(50));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelName.text = @"易智造官方客服";
        [self.contentView addSubview:_labelName];
        
        [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(9));
            make.left.mas_equalTo(WidthRate(68));
            make.height.mas_equalTo(HeightRate(32));
            make.width.mas_equalTo(WidthRate(150));
        }];
        
        _labelContent = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelContent.text = @"暂无消息";
        _labelContent.font = [UIFont systemFontOfSize:12];
        _labelContent.textColor = TextColor_A3A3A3;
        [self.contentView addSubview:_labelContent];
        _labelContent.numberOfLines = 3;
        [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_labelName.mas_bottom).offset(0);
            make.left.mas_equalTo(WidthRate(68));
            make.width.mas_equalTo(WidthRate(300));
            make.height.mas_equalTo(HeightRate(34));
            
        }];
        
        _labelTime = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelTime.font = [UIFont systemFontOfSize:12];
        _labelTime.textColor = TextColor_666666;
        _labelTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_labelTime];
        
        [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(17));
            make.centerY.mas_equalTo(_labelName.mas_centerY);
        }];
        
        
//        _labelMessage = [[UILabel alloc]initWithFrame:CGRectZero];
//        _labelMessage.font = [UIFont systemFontOfSize:12];
//        _labelMessage.backgroundColor = ColorWithHexString(SymbolTopColor);
//        _labelMessage.textColor = ColorWithHexString(@"ffffff");
//        _labelMessage.textAlignment = NSTextAlignmentRight;
//        _labelMessage.clipsToBounds = YES;
//        _labelMessage.layer.cornerRadius = HeightRate(8.5);
//        [self.contentView addSubview:_labelMessage];
//        _labelMessage.hidden = YES;
//        _labelMessage.
//        _labelMessage.textAlignment = NSTextAlignmentCenter;
//        [_labelMessage mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.right.mas_equalTo(WidthRate(-10));
//            make.height.mas_equalTo(HeightRate(35));
//            make.width.mas_equalTo(HeightRate(17));
//
//            make.centerY.mas_equalTo(_labelContent.mas_centerY);
//        }];
        
        UILabel *labelLine = [[UILabel alloc]initWithFrame:CGRectZero];
        labelLine.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:labelLine];
        [labelLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        
    }
    return self;
}
-(void)setDataModel:(YHLogistInfoModel *)model
{
//    [self.headImage sd_setImageWithURL:(nullable NSURL *)]
    self.labelName.text = @"交易物流消息";
    if (model.ShippingDate.length>10) {
         self.labelTime.text =[ model.ShippingDate substringToIndex:10];
    }else
    {
         self.labelTime.text = model.ShippingDate ;
        
    }
    NSString *infoStr = [NSString stringWithFormat:@"亲，订单号%@已发货，%@，运单号%@，司机号码%@，请注意查收！",model.ContractNo,model.ShippingName,model.LogisticsBillNo,model.ShippingPhone];
    self.labelContent.text = infoStr;
    
}


@end
