//
//  verificationCodeView.m
//  emake
//
//  Created by eMake on 2017/8/21.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "verificationCodeView.h"



static CGFloat const TipContainerViewWidth = 290.0f;
static CGFloat const TipContainerViewHeight = 180.0f;
static CGFloat const TipContainerViewCornerRadius = 7.0f;

static CGFloat const TipImageViewLeftMargin = 130.0f;
static CGFloat const TipImageViewTopMargin = 10.0f;
static CGFloat const TipImageViewWidth = 30.0f;
static CGFloat const TipImageViewHeight = 30.0f;

static CGFloat const TipLabelLeftMargin = 20.0f;
static CGFloat const TipLabelTopMargin = 50.0f;
static CGFloat const TipLabelWidth = 250.0f;
static CGFloat const TipLabelHeight = 120.0f;
static CGFloat const TipLabelFontSize = 12.0f;
static CGFloat const TipLabelTextLineSpacing = 6.0;

@implementation verificationCodeView



+(void)getVerificationCode{
    
    CustomIOSAlertView *tipAlertView = [[CustomIOSAlertView alloc] init];
    [tipAlertView setContainerView:[self  createContainerView]];
    [tipAlertView setButtonTitles:@[]];
    [tipAlertView setCloseOnTouchUpOutside:true];
    [tipAlertView show];
}
+(UIView *)createContainerView {
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TipContainerViewWidth, TipContainerViewHeight)];
    [containerView.layer setCornerRadius:TipContainerViewCornerRadius];
    containerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(TipImageViewLeftMargin, TipImageViewTopMargin, TipImageViewWidth, TipImageViewHeight)];
    tipImageView.image = [UIImage imageNamed:@"tip_error"];
    [containerView addSubview:tipImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(TipLabelLeftMargin, TipLabelTopMargin, TipLabelWidth, TipLabelHeight)];
    tipLabel.numberOfLines = 0;
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font = [UIFont systemFontOfSize: TipLabelFontSize];
    NSString *tip = NSLanguageLocalizedString(@"why no captcha");
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:tip];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:TipLabelTextLineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tip length])];
    tipLabel.attributedText = attributedString;
    [tipLabel sizeToFit];
    [containerView addSubview:tipLabel];
    return containerView;
    return nil;
}

+(void)openCountdownWithButton:(UIButton *)button{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:button.tag?button.tag:60];
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            NSString *timeStr = [NSString stringWithFormat:NSLanguageLocalizedString(@"countdown tip"), interval];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = NO;
                [ button setTitle:timeStr forState:UIControlStateNormal];
                [button setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
            });
        } else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = YES;
                [button setTitle:@"重新获取验证码" forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
    
}



@end
