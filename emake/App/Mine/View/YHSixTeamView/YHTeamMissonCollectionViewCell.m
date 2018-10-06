//
//  YHTeamMissonCollectionViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHTeamMissonCollectionViewCell.h"
#import "Tools.h"

@interface YHTeamMissonCollectionViewCell()
@property (nonatomic,retain)UILabel *labelTitle;
@property (nonatomic,retain)UILabel *lableTsakTitle;

@property (nonatomic,retain)UILabel *labelMoney;
@property (nonatomic,retain)UILabel *labelGreen;
@property (nonatomic,retain)UILabel *labelState;
@property (nonatomic,retain)UILabel *labelPeople;
@end
@implementation YHTeamMissonCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.borderWidth = WidthRate(1);
        self.contentView.layer.borderColor = TextColor_CCCCCC.CGColor;
        self.contentView.layer.cornerRadius = WidthRate(3);
        self.labelTitle = [[UILabel alloc]init];
        self.labelTitle.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.labelTitle.textColor = [UIColor whiteColor];
        self.labelTitle.font = [UIFont boldSystemFontOfSize:AdaptFont(16)];
        self.labelTitle.layer.cornerRadius = WidthRate(3);
        self.labelTitle.clipsToBounds = YES;
        self.labelTitle.text = @"500万任务团队";
        self.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.labelTitle];
        
        [self.labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(30));
        }];
        
        self.lableTsakTitle  = [[UILabel alloc] init];
        self.lableTsakTitle.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.lableTsakTitle.textColor = [UIColor whiteColor];
        self.lableTsakTitle.font = [UIFont boldSystemFontOfSize:AdaptFont(10)];
        self.lableTsakTitle.layer.cornerRadius = WidthRate(3);
        self.lableTsakTitle.clipsToBounds = YES;
        self.lableTsakTitle.text = @"500万任务团队";
        self.lableTsakTitle.lineBreakMode = NSLineBreakByTruncatingTail;
        self.lableTsakTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lableTsakTitle];
        
        [self.lableTsakTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.labelTitle.mas_bottom).offset(HeightRate(-3));
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(20));
        }];
        UILabel *progressImage = [[UILabel alloc]init];
        progressImage.backgroundColor = TextColor_C8D8EC;
        progressImage.layer.borderColor = TextColor_C0BEBE.CGColor;
        progressImage.layer.borderWidth = WidthRate(1);
        [self.contentView addSubview:progressImage];
        
        [progressImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(self.lableTsakTitle.mas_bottom).offset(HeightRate(8));
            make.width.mas_equalTo(WidthRate(140));
            make.height.mas_equalTo(HeightRate(20));
        }];
        
        
        
        self.labelGreen = [[UILabel alloc]init];
        self.labelGreen.textColor = TextColor_666666;
        self.labelGreen.font = SYSTEM_FONT(AdaptFont(14));
        self.labelGreen.backgroundColor = TextColor_4DBECD;
        self.labelGreen.alpha = 0.8;
        [self.contentView addSubview:self.labelGreen];
        
        
        [self.labelGreen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(progressImage.mas_left);
            make.top.mas_equalTo(progressImage.mas_top);
            make.bottom.mas_equalTo(progressImage.mas_bottom);
            make.width.mas_equalTo(WidthRate(60));
        }];
        
        self.labelMoney = [[UILabel alloc]init];
        self.labelMoney.textColor = TextColor_666666;
        self.labelMoney.font = SYSTEM_FONT(AdaptFont(14));
        self.labelMoney.text = @"0";
        [self.contentView addSubview:self.labelMoney];
        
        [self.labelMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(progressImage.mas_left).offset(WidthRate(7));
            make.top.mas_equalTo(progressImage.mas_top);
            make.bottom.mas_equalTo(progressImage.mas_bottom);
        }];
        
        self.labelState = [[UILabel alloc]init];
        self.labelState.textColor = [UIColor whiteColor];
        self.labelState.backgroundColor = TextColor_FBA631;
        self.labelState.text = @"未启动";
        self.labelState.textAlignment = NSTextAlignmentCenter;
        self.labelState.layer.cornerRadius = WidthRate(3);
        self.labelState.clipsToBounds = YES;
        self.labelState.font = [UIFont boldSystemFontOfSize:AdaptFont(13)];
        [self.contentView addSubview:self.labelState];
        
        [self.labelState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(75));
            make.top.mas_equalTo(self.labelMoney.mas_bottom).offset(HeightRate(14));
            make.height.mas_equalTo(HeightRate(23));
            make.right.mas_equalTo(WidthRate(-30));
        }];
        
        self.labelPeople = [[UILabel alloc]init];
        self.labelPeople.textColor = TextColor_FBA631;
        self.labelPeople.text = @"4/6人";
        self.labelPeople.textAlignment = NSTextAlignmentCenter;
        self.labelPeople.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:self.labelPeople];
        [self.labelPeople mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.labelState.mas_centerY);
            make.height.mas_equalTo(HeightRate(23));
            make.left.mas_equalTo(WidthRate(15));
        }];
        
    }
    return self;
    
}
-(void)requestDate:(teamModel *)model
{
    NSString *title = [NSString stringWithFormat:@"%@\n%@",model.GroupName,model.GroupDescription];
    NSMutableAttributedString *addStr = [[NSMutableAttributedString alloc] initWithString:title];
    [addStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:AdaptFont(10)] range:NSMakeRange(model.GroupName.length+1, model.GroupDescription.length)];
    [addStr addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(@"FFFFFF") range:NSMakeRange(model.GroupName.length+1, model.GroupDescription.length)];
    self.labelTitle.text = model.GroupName;
    self.lableTsakTitle.text = model.GroupDescription;
    CGFloat rate = model.CurrentMoney/model.CompleteMoney;
    
    double width  = (rate>1?1:rate) *WidthRate(140);
    [self.labelGreen mas_updateConstraints:^(MASConstraintMaker *make) {
       make.width.mas_equalTo(width); 
    }];


    NSString *currentMoney = [Tools getNsstringFromDouble:model.CurrentMoney isShowUNIT:YES];

    self.labelMoney.text = currentMoney;

    NSString *stateStr = [model.CompleteTag isEqualToString:@"0"]?@"未启动":[model.CompleteTag isEqualToString:@"1"]?@"已启动":@"已完成";
    
        NSString *colorStr = [model.CompleteTag isEqualToString:@"0"]?@"FBA631":[model.CompleteTag isEqualToString:@"1"]?@"4DBECD":@"C9C9C9";
    self.labelState.text = stateStr;
    self.labelState.backgroundColor = ColorWithHexString(colorStr);
    NSString *Text = [NSString stringWithFormat:@"%@/%@人",model.CurrentNumber,model.MaxLimitNumber];
    NSMutableAttributedString *TextAttributedSting = [[NSMutableAttributedString alloc]initWithString:Text];
    [TextAttributedSting addAttribute:NSForegroundColorAttributeName value:TextColor_999999 range:NSMakeRange(model.CurrentNumber.length, 1)];
    [TextAttributedSting addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(APP_THEME_MAIN_COLOR) range:NSMakeRange(model.CurrentNumber.length+1,model.MaxLimitNumber.length+1)];
    self.labelPeople.attributedText = TextAttributedSting;
}
@end
