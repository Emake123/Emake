//
//  InviteMessageCellTableViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/16.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "InviteMessageCellTableViewCell.h"
@interface InviteMessageCellTableViewCell()
@property (nonatomic,retain)UIImageView *leaderImage;
@property (nonatomic,retain)UILabel *leaderName;
@property (nonatomic,retain)UILabel *content;
@end
@implementation InviteMessageCellTableViewCell
- (instancetype)init{
    if (self = [super init]) {
        
        self.leaderImage = [[UIImageView alloc] init];
        self.leaderImage.contentMode = UIViewContentModeScaleAspectFit;
        self.leaderImage.layer.masksToBounds = YES;
        [self.contentView addSubview:self.leaderImage];
        self.leaderImage.layer.cornerRadius = 23;
        [self.leaderImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(WidthRate(15));
            make.width.mas_equalTo(46);
            make.height.mas_equalTo(46);
        }];
        
        self.leaderName = [[UILabel alloc]init];
        self.leaderName.text = @"团长大大";
        self.leaderName.textColor = TextColor_333333;
        self.leaderName.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.leaderName];
        
        [self.leaderName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(12));
            make.left.mas_equalTo(self.leaderImage.mas_right).offset(WidthRate(12));
            make.height.mas_equalTo(HeightRate(20));
        }];
        
        
        self.content = [[UILabel alloc]init];
        self.content.text = @"邀请你加入青苹果团队A（100万任务团队）";
        self.content.textColor = TextColor_333333;
        self.content.font = SYSTEM_FONT(AdaptFont(13));
        self.content.numberOfLines = 0;
        
        [self.contentView addSubview:self.content];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.leaderName.mas_bottom).offset(HeightRate(3));
            make.left.mas_equalTo(self.leaderImage.mas_right).offset(WidthRate(12));
            make.right.mas_equalTo(WidthRate(-80));
        }];
        
        self.agree = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.agree setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.agree.layer.borderWidth = 1;
        self.agree.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
        self.agree.layer.cornerRadius = HeightRate(14);
        self.agree.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.agree setTitle:@"同意" forState:UIControlStateNormal];
        [self.contentView addSubview:self.agree];
        
        [self.agree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.width.mas_equalTo(WidthRate(55));
            make.height.mas_equalTo(HeightRate(28));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setData:(YHInviteMessageModel *)model{
    self.leaderName.text = model.RealName;
    [self.leaderImage sd_setImageWithURL:[NSURL URLWithString:model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"tuanzhangs"]];
    NSString *contentText = [NSString stringWithFormat:@"邀请您加入他的团队"];
    NSMutableAttributedString *TextAttributedSting = [[NSMutableAttributedString alloc]initWithString:contentText];
    [TextAttributedSting addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(APP_THEME_MAIN_COLOR) range:NSMakeRange(5, model.GroupName.length)];
    self.content.attributedText = TextAttributedSting;
    if ([model.InviteState isEqualToString:@"1"]) {
        self.agree.userInteractionEnabled = false;
        [self.agree setTitle:@"已同意" forState:UIControlStateNormal];
        [self.agree setTitleColor:TextColor_636263 forState:UIControlStateNormal];
        self.agree.layer.borderColor = TextColor_636263.CGColor;
        [self.agree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(70));
        }];
    }else if ([model.InviteState isEqualToString:@"2"]) {
        [self.agree setTitle:@"已过期" forState:UIControlStateNormal];
        [self.agree setTitleColor:TextColor_636263 forState:UIControlStateNormal];
        self.agree.userInteractionEnabled = false;
        self.agree.layer.borderColor = TextColor_636263.CGColor;
        [self.agree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(70));
        }];
    }else{
        self.agree.userInteractionEnabled = true;
        [self.agree setTitle:@"同意" forState:UIControlStateNormal];
        [self.agree setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.agree.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
