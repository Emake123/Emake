//
//  YHMissonCreatSuccessView.m
//  emake
//
//  Created by 谷伟 on 2018/1/7.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMissonCreatSuccessView.h"
@interface YHMissonCreatSuccessView()
@property (nonatomic,strong)UIView *maskView;
@end
@implementation YHMissonCreatSuccessView
- (instancetype)initCreatTitle:(NSString *)title missionName:(NSString *)name content:(NSString *)contentText{
    self = [super init];
    if (self) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 3;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRate(206));
        
        self.center = self.maskView.center;
        
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        topView.layer.cornerRadius = 3;
        [self addSubview:topView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(58));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        titleLabel.text = title;
        [topView addSubview:titleLabel];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.height.mas_equalTo(HeightRate(28));
        }];
        
        UILabel *missonLabel = [[UILabel alloc]init];
        missonLabel.textColor = TextColor_333333;
        missonLabel.font = SYSTEM_FONT(AdaptFont(17));
        missonLabel.text = name;
        [topView addSubview:missonLabel];
        
        [missonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(13));
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        contentLabel.font = SYSTEM_FONT(AdaptFont(16));
        NSString *content = [NSString stringWithFormat:@"%@ 任务团队创建成功",contentText];
        NSMutableAttributedString *contentTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:content];
        [contentTextAttributedSting addAttribute:NSFontAttributeName value:SYSTEM_FONT(AdaptFont(20)) range:NSMakeRange(0, contentText.length+1)];
        contentLabel.attributedText = contentTextAttributedSting;
        [topView addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(6));
            make.height.mas_equalTo(HeightRate(32));
        }];
        
        

        UIButton *goMission = [UIButton buttonWithType:UIButtonTypeCustom];
        goMission.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        [goMission setTitle:@"前往" forState:UIControlStateNormal];
        [goMission setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [goMission addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        goMission.layer.cornerRadius = 3;
        [self addSubview:goMission];

        [goMission mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HeightRate(10));
            make.width.mas_equalTo(WidthRate(250));
            make.height.mas_equalTo(WidthRate(36));
        }];
    }
    return self;
}
- (void)showAnimated{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity,CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (instancetype)initInviteTitle:(NSString *)title missionName:(NSString *)name content:(NSString *)contentText{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 3;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRate(206));
        
        self.center = self.maskView.center;
        
        UIView *topView = [[UIView alloc]init];
//        topView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        topView.layer.cornerRadius = 3;
        [self addSubview:topView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        
        UIView *topTitleView = [[UIView alloc]init];
        topTitleView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        topTitleView.layer.cornerRadius = 3;
        [topView addSubview:topTitleView];
        
        [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(58));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        titleLabel.text = @"信息发送成功";
        [topTitleView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topTitleView.mas_centerX);
            make.centerY.mas_equalTo(topTitleView.mas_centerY);
//            make.height.mas_equalTo(HeightRate(28));
        }];
        
        [topTitleView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disappear)]];

        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [delete addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        [delete setImage:[UIImage imageNamed:@"shouye_shanchu"] forState:UIControlStateNormal];
        [topView addSubview:delete];
        
    
        [delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.top.mas_equalTo(HeightRate(10));
            make.width.mas_equalTo(WidthRate(11));
            make.height.mas_equalTo(WidthRate(11));
        }];
        
        NSString *inviteText = [NSString stringWithFormat:@"邀请 %@ 加入 ",title];

        UILabel *missonLabel = [[UILabel alloc]init];
        missonLabel.textColor = ColorWithHexString(StandardBlueColor);
        missonLabel.font = SYSTEM_FONT(AdaptFont(17));
        missonLabel.text = [NSString stringWithFormat:@"%@\n%@",inviteText,name];
        [topView addSubview:missonLabel];
        
        [missonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(topTitleView.mas_bottom).offset(HeightRate(13));
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        contentLabel.font = SYSTEM_FONT(AdaptFont(20));
        NSString *content = [NSString stringWithFormat:@"我的任务团队"];
        NSMutableAttributedString *contentTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:content];
        [contentTextAttributedSting addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:AdaptFont(20)] range:NSMakeRange(0, contentText.length+1)];
        contentLabel.attributedText = contentTextAttributedSting;
        [topView addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(6));
            make.height.mas_equalTo(HeightRate(32));
        }];
        
        UIButton *label = [[UIButton alloc]init];
        [label setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        label.titleLabel.font = SYSTEM_FONT(AdaptFont(17));
        [label setTitle:@"确定" forState:UIControlStateNormal];
        label.layer.cornerRadius = 6;
        label.layer.masksToBounds = YES;
        label.backgroundColor = ColorWithHexString(StandardBlueColor);
        [label addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HeightRate(22));
            make.height.mas_equalTo(HeightRate(30));
            make.width.mas_equalTo(WidthRate(270));
            make.bottom.mas_equalTo(HeightRate(10));
        }];
        
    }
    return self;
}
- (instancetype)initDisbandView{
    if (self = [super init]) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 3;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRate(206));
        
        self.center = self.maskView.center;
        
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        topView.layer.cornerRadius = 3;
        [self addSubview:topView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(58));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        NSString *inviteText = @"解散团队";
        titleLabel.text = inviteText;
        [topView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.height.mas_equalTo(HeightRate(28));
        }];
        
        UILabel *missonLabel = [[UILabel alloc]init];
        missonLabel.textColor = TextColor_333333;
        missonLabel.numberOfLines = 2;
        missonLabel.font = SYSTEM_FONT(AdaptFont(17));
        missonLabel.text = @"解散团体后你将失去团队成员，确认要解散吗？";
        [topView addSubview:missonLabel];
        
        [missonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(16));
            make.width.mas_equalTo(WidthRate(247));
            make.height.mas_equalTo(HeightRate(54));
        }];
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.backgroundColor = TextColor_CCCCCC;
        [cancle setTitle:@"再想想" forState:UIControlStateNormal];
        [cancle setTitleColor:TextColor_868686 forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        cancle.layer.cornerRadius = 3;
        [self addSubview:cancle];
        
        [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(30));
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(14));
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(WidthRate(36));
        }];
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        [confirm setTitle:@"确认" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        confirm.layer.cornerRadius = 3;
        [self addSubview:confirm];
        
        [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-30));
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(14));
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(WidthRate(36));
        }];
    }
    return self;
}
- (instancetype)initEliminateMemeberView{
    if (self = [super init]) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 3;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRate(206));
        
        self.center = self.maskView.center;
        
        UIView *topView = [[UIView alloc]init];
        topView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        topView.layer.cornerRadius = 3;
        [self addSubview:topView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(58));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        NSString *inviteText = @"移除成员";
        titleLabel.text = inviteText;
        [topView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.centerY.mas_equalTo(topView.mas_centerY);
            make.height.mas_equalTo(HeightRate(28));
        }];
        
        UILabel *missonLabel = [[UILabel alloc]init];
        missonLabel.textColor = TextColor_333333;
        missonLabel.numberOfLines = 2;
        missonLabel.textAlignment = NSTextAlignmentCenter;
        missonLabel.font = SYSTEM_FONT(AdaptFont(17));
        missonLabel.text = @"您确定要移除该成员吗？";
        [topView addSubview:missonLabel];
        
        [missonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(16));
            make.width.mas_equalTo(WidthRate(247));
            make.height.mas_equalTo(HeightRate(54));
        }];
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.backgroundColor = TextColor_CCCCCC;
        [cancle setTitle:@"再想想" forState:UIControlStateNormal];
        [cancle setTitleColor:TextColor_868686 forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        cancle.layer.cornerRadius = 3;
        [self addSubview:cancle];
        
        [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(30));
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(14));
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(WidthRate(36));
        }];
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        [confirm setTitle:@"确认" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        confirm.layer.cornerRadius = 3;
        [self addSubview:confirm];
        
        [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-30));
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(14));
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(WidthRate(36));
            make.bottom.mas_equalTo(WidthRate(10));

        }];
    }
    return self;
}
- (instancetype)initJoinSuccess:(NSString *)invitor missionName:(NSString *)name content:(NSString *)contentText{
    if (self = [super init]) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 3;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRate(206));
        
        self.center = self.maskView.center;
        
        UIView *topView = [[UIView alloc]init];
        topView.layer.cornerRadius = 3;
        [self addSubview:topView];
        
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        
        UIView *topTitleView = [[UIView alloc]init];
        topTitleView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        topTitleView.layer.cornerRadius = 3;
        [topView addSubview:topTitleView];
        
        [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(58));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        titleLabel.text = @"邀请信息";
        [topTitleView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topTitleView.mas_centerX);
            make.centerY.mas_equalTo(topTitleView.mas_centerY);
        }];
        
        [topTitleView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disappear)]];
        
        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [delete addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        [delete setImage:[UIImage imageNamed:@"shouye_shanchu"] forState:UIControlStateNormal];
        [topView addSubview:delete];
        
        
        [delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.top.mas_equalTo(HeightRate(10));
            make.width.mas_equalTo(WidthRate(11));
            make.height.mas_equalTo(WidthRate(11));
        }];
        
        NSString *inviteText = [NSString stringWithFormat:@"%@%@邀请您加入 ",invitor,name];
        
        UILabel *missonLabel = [[UILabel alloc]init];
        missonLabel.textColor = ColorWithHexString(StandardBlueColor);
        missonLabel.font = SYSTEM_FONT(AdaptFont(17));
        missonLabel.text = [NSString stringWithFormat:@"%@\n%@",inviteText,name];
        [topView addSubview:missonLabel];
        
        [missonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(topTitleView.mas_bottom).offset(HeightRate(13));
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        contentLabel.font = SYSTEM_FONT(AdaptFont(20));
        NSString *content = [NSString stringWithFormat:@"他的团队"];
        NSMutableAttributedString *contentTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:content];
        [contentTextAttributedSting addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:AdaptFont(20)] range:NSMakeRange(0, contentText.length+1)];
        contentLabel.attributedText = contentTextAttributedSting;
        [topView addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX);
            make.top.mas_equalTo(missonLabel.mas_bottom).offset(HeightRate(6));
            make.height.mas_equalTo(HeightRate(32));
        }];
        
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.backgroundColor = TextColor_CCCCCC;
        [cancle setTitle:@"再想想" forState:UIControlStateNormal];
        [cancle setTitleColor:TextColor_868686 forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(thinkSB) forControlEvents:UIControlEventTouchUpInside];
        cancle.layer.cornerRadius = 3;
        [topView addSubview:cancle];
        
        [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX).offset(WidthRate(-70));
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HeightRate(22));
            make.bottom.mas_equalTo(HeightRate(10));
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(WidthRate(36));
        }];
        
        UIButton *confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        [confirm setTitle:@"确定" forState:UIControlStateNormal];
        [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        confirm.layer.cornerRadius = 3;
        [topView addSubview:confirm];
        
        [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(topView.mas_centerX).offset(WidthRate(70));
            make.top.mas_equalTo(contentLabel.mas_bottom).offset(HeightRate(22));
            make.bottom.mas_equalTo(HeightRate(10));
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(WidthRate(36));
        }];
    }
    return self;
}
- (void)disappear{
    if (self.block) {
        self.block(@"");
    }
    [self.maskView removeFromSuperview];
}
- (void)thinkSB{
    if (self.block) {
        self.block(@"thinkAgain");
    }
    [self.maskView removeFromSuperview];
}
- (void)remove{
    [self.maskView removeFromSuperview];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
