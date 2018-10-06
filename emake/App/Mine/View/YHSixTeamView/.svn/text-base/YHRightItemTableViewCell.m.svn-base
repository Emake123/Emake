//
//  YHRightItemTableViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHRightItemTableViewCell.h"
@interface YHRightItemTableViewCell()
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *labelMember;
@property (nonatomic,retain)UILabel *labelLeader;
@property (nonatomic,retain)UILabel *labelItem;
@end
@implementation YHRightItemTableViewCell
- (instancetype)init{
    if (self = [super init]) {
        
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        backView.layer.cornerRadius = WidthRate(3);
        
        [self.contentView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(15));
            make.right.mas_equalTo(WidthRate(-15));
            make.top.mas_equalTo(HeightRate(10));
            make.bottom.mas_equalTo(0);
        }];
        
        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"renwubaopeitu"]];
        [backView addSubview:leftImage];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(WidthRate(13)));
            make.width.mas_equalTo(WidthRate(54));
            make.height.mas_equalTo(HeightRate(53));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.title = [[UILabel alloc]init];
        self.title.font = SYSTEM_FONT(AdaptFont(16));
        self.title.textColor = TextColor_FFFF00;
        self.title.text = @"奖金2万元";
        self.title.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:self.title];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(HeightRate(13));
            make.height.mas_equalTo(WidthRate(24));
        }];
        
        self.labelLeader = [[UILabel alloc]init];
        self.labelLeader.font = SYSTEM_FONT(AdaptFont(12));
        self.labelLeader.textColor = [UIColor whiteColor];
        self.labelLeader.text = @"队长：5000元";
        self.labelLeader.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:self.labelLeader];
        
        [self.labelLeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(self.title.mas_bottom).offset(HeightRate(0));
            make.height.mas_equalTo(WidthRate(18));
        }];
        
        self.labelMember = [[UILabel alloc]init];
        self.labelMember.font = SYSTEM_FONT(AdaptFont(12));
        self.labelMember.textColor = [UIColor whiteColor];
        self.labelMember.text = @"队员：15000元";
        self.labelMember.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:self.labelMember];
        
        [self.labelMember mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(self.labelLeader.mas_bottom).offset(HeightRate(0));
            make.height.mas_equalTo(WidthRate(18));
        }];
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor whiteColor];
        [Tools drawDashLine:backView lineLength:WidthRate(1) lineSpacing:1 lineColor:[UIColor redColor]];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-120));
            make.width.mas_equalTo(WidthRate(1));
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        self.labelItem = [[UILabel alloc]init];
        self.labelItem.font = [UIFont boldSystemFontOfSize:AdaptFont(14)];
        self.labelItem.textColor = [UIColor whiteColor];
        self.labelItem.text = @"100万任务包";
        self.labelItem.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:self.labelItem];
        
        [self.labelItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView.mas_right).offset(WidthRate(12));
            make.top.mas_equalTo(HeightRate(13));
            make.height.mas_equalTo(WidthRate(20));
        }];
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.layer.cornerRadius = HeightRate(14);
        self.selectBtn.backgroundColor = [UIColor whiteColor];
        [self.selectBtn setTitle:@"领取" forState:UIControlStateNormal];
        [self.selectBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.selectBtn.titleLabel.font =SYSTEM_FONT(AdaptFont(14));

        [self.contentView addSubview:self.selectBtn];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineView.mas_right).offset(WidthRate(12));
            make.height.mas_equalTo(HeightRate(28));
            make.width.mas_equalTo(WidthRate(84));
            make.top.mas_equalTo(self.labelItem.mas_bottom).offset(HeightRate(10));
        }];
        
    }
    return self;
}

-(void)requestData:(YHTeamMakeTaskModel *)model
{
    self.title.text  = [NSString stringWithFormat:@"奖金%@万元",model.TaskBonus];
    self.labelLeader.text  = [NSString stringWithFormat:@"队长：%@元",model.TaskBonusLeader];
    self.labelMember.text  = [NSString stringWithFormat:@"队员：%@元",model.TaskBonusMember];
    self.labelItem.text = [NSString stringWithFormat:@"%@万任务包",model.TaskMoney];
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
