//
//  YHLogisticsDetailsCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/17.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHLogisticsDetailsCell.h"
@interface YHLogisticsDetailsCell()
@property (nonatomic,retain)UILabel *typeLabel;
@property (nonatomic,retain)UILabel *numberLabel;
@end
@implementation YHLogisticsDetailsCell
- (instancetype)init{
    if (self = [super init]) {
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.typeLabel.text =@"200kVA-国标45#油";
        self.typeLabel.font = SYSTEM_FONT(AdaptFont(14));
        self.typeLabel.textColor = ColorWithHexString(@"333333");

        self.typeLabel.textAlignment = NSTextAlignmentLeft;
        self.typeLabel.numberOfLines = 0;
        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(WidthRate(200));
        }];
        
        
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.numberLabel.text =@"5件";
        self.numberLabel.textColor = ColorWithHexString(@"999999");
        self.numberLabel.font = SYSTEM_FONT(AdaptFont(14));
        self.numberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-14);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth/2);
        }];
        
//        UILabel *line = [[UILabel alloc]init];
//        line.backgroundColor =SepratorLineColor;
//        [self.contentView addSubview:line];
//        
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(0);
//            make.top.mas_equalTo(0);
//            make.bottom.mas_equalTo(0.8);
//        }];

    }
    return self;
}
- (void)setLeftText:(NSString *)leftText andRigthText:(NSString *)rightText{
    
    self.typeLabel.text = leftText;
    self.numberLabel.text = rightText;
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
