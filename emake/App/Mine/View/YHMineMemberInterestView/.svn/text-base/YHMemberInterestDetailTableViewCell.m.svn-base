//
//  YHMemberInterestDetailTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/20.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMemberInterestDetailTableViewCell.h"
@interface YHMemberInterestDetailTableViewCell()


@end
@implementation YHMemberInterestDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *nickNameLable = [[UILabel alloc] init];
        nickNameLable.textColor = ColorWithHexString(@"333333");
        nickNameLable.text = @"昵称";
        nickNameLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:nickNameLable];
        nickNameLable.translatesAutoresizingMaskIntoConstraints = false;
        [nickNameLable PSSetLeft:WidthRate(18)];
        [nickNameLable PSSetTop:HeightRate(10)];
        [nickNameLable PSSetWidth:WidthRate(90)];
        self.nickNameLable = nickNameLable;
        
        UILabel *catagoryLable = [[UILabel alloc] init];
        catagoryLable.textColor = ColorWithHexString(@"F8695D");
        catagoryLable.text = @"输配电";
        catagoryLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
        [self addSubview:catagoryLable];
        catagoryLable.translatesAutoresizingMaskIntoConstraints = false;
        [catagoryLable PSSetRightAtItem:nickNameLable Length:WidthRate(10)];
        self.catagoryLable = catagoryLable;
        
        UILabel *phoneNumberLable = [[UILabel alloc] init];
        phoneNumberLable.textColor = ColorWithHexString(@"333333");
        phoneNumberLable.text = @"18356533731";
        phoneNumberLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:phoneNumberLable];
        phoneNumberLable.translatesAutoresizingMaskIntoConstraints = false;
        [phoneNumberLable PSSetLeft:WidthRate(18)];
        [phoneNumberLable PSSetBottomAtItem:nickNameLable Length:HeightRate(10)];
        [phoneNumberLable PSSetWidth:WidthRate(90)];
        self.phoneNumberLable = phoneNumberLable;
        
        UILabel *dateLable = [[UILabel alloc] init];
        dateLable.textColor = ColorWithHexString(@"CCCCCC");
        dateLable.text = @"2017-12-18 15:45:20";
        dateLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
        [self addSubview:dateLable];
        dateLable.translatesAutoresizingMaskIntoConstraints = false;
        [dateLable PSSetRightAtItem:phoneNumberLable Length:WidthRate(10)];

        self.dateLable = dateLable;
        
        UILabel *moneyLable = [[UILabel alloc] init];
        moneyLable.textColor = ColorWithHexString(StandardBlueColor);
        moneyLable.text = @"2000";
        moneyLable.font = [UIFont systemFontOfSize:AdaptFont(20)];
        [self addSubview:moneyLable];
        moneyLable.translatesAutoresizingMaskIntoConstraints = false;
        [moneyLable PSSetRight:WidthRate(15)];
        [moneyLable PSSetCenterHorizontalAtItem:dateLable];
        self.moneyLable = moneyLable;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        line.translatesAutoresizingMaskIntoConstraints = false;
        [line PSSetLeft:WidthRate(17)];
        [line PSSetRight:WidthRate(15)];
        [line PSSetHeight:HeightRate(1)];
        [line PSSetBottomAtItem:dateLable Length:HeightRate(10)];
        [line PSSetBottom:HeightRate(0)];


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
