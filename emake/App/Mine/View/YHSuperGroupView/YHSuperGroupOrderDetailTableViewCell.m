//
//  YHSuperGroupOrderDetailTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupOrderDetailTableViewCell.h"

@implementation YHSuperGroupOrderDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *prouctExplainLine = [[UILabel alloc] init];
 
        prouctExplainLine.text = @"还差2人拼团成功";
        prouctExplainLine.textAlignment = NSTextAlignmentCenter;
        prouctExplainLine.textColor = ColorWithHexString(@"333333");
        prouctExplainLine.font = [UIFont systemFontOfSize:AdaptFont(13)];
        prouctExplainLine.clipsToBounds = YES;
        [self addSubview:prouctExplainLine];
        [prouctExplainLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(WidthRate(10));
            make.centerX.mas_equalTo(self.mas_centerX).offset(HeightRate(0));
        }];
        self.peopleTipLable = prouctExplainLine;
        
        
        
        
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor = ColorWithHexString(@"ffffff");
//        bgview.layer.cornerRadius = HeightRate(24);
//        bgview.layer.borderColor = ColorWithHexString(@"F8695D").CGColor;
//        bgview.layer.borderWidth= 1;
//        bgview.clipsToBounds= YES;
        [self addSubview:bgview];
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(prouctExplainLine.mas_bottom).offset(HeightRate(15));
            make.height.mas_equalTo(HeightRate(60));
            make.left.mas_equalTo(0);
        }];
        self.peopleView = bgview;

        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"pintuanchenggongw"] ;
        
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(90));
            make.top.mas_equalTo(prouctExplainLine.mas_bottom).offset(HeightRate(10));
            make.height.mas_equalTo(HeightRate(90));
            make.right.mas_equalTo(WidthRate(-40));
        }];
        self.successImageView = imageView;

        
        UILabel *dateComit = [[UILabel alloc]init];
        dateComit.text =@"交期：2018-09-21";
        dateComit.textColor = ColorWithHexString(@"333333");
        dateComit.font = [UIFont systemFontOfSize:AdaptFont(10)];
        [bgview addSubview:dateComit];
        [dateComit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bgview.mas_bottom).offset(HeightRate(25));
            make.centerX.mas_equalTo(self.mas_centerX).offset(HeightRate(0));
        }];
        self.dateComit = dateComit;
        
        
       
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(11));
            make.right.mas_equalTo(WidthRate(-11));
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(dateComit.mas_bottom).offset(HeightRate(20));

            
        }];
        
        UILabel *endDate = [[UILabel alloc]init];
        endDate.text =@"还剩 12 : 59 : 35 结束";
        endDate.textColor = ColorWithHexString(@"333333");
        endDate.font = [UIFont systemFontOfSize:AdaptFont(14)];
        endDate.backgroundColor = ColorWithHexString(@"ffffff");
        [self addSubview:endDate];
        [endDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(line.mas_centerX).offset(WidthRate(0));
            make.centerY.mas_equalTo(line.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(30));
            
        }];
        self.endDate = endDate;
        
        UIButton *paySelectButton = [[UIButton alloc] init];
        [paySelectButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
        [paySelectButton setTitle:@"查看订单" forState:UIControlStateNormal];
        paySelectButton.layer.cornerRadius = 6;
        paySelectButton.clipsToBounds = YES;
        paySelectButton.backgroundColor = ColorWithHexString(StandardBlueColor);
        [self addSubview:paySelectButton];
        [paySelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(endDate.mas_bottom).offset(HeightRate(45));
            make.right.mas_equalTo(-WidthRate(15));
            make.left.mas_equalTo(WidthRate(15));
            make.height.mas_equalTo(HeightRate(40));
            make.bottom.mas_equalTo(HeightRate(-10));

        }];
        self.successButton = paySelectButton;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
