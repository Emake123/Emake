//
//  YHSendFileTipsView.m
//  emake
//
//  Created by 张士超 on 2018/5/30.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSendFileTipsView.h"


@interface YHSendFileTipsView()
@property (nonatomic,strong)UIView *maskView;
@property (nonatomic,strong)NSString *fileUrl;
@property (nonatomic,strong)NSString *filename;


@end
@implementation YHSendFileTipsView

- (instancetype)initWithDelegete:(id)delegate andFileurl:(NSString *)url andFileName:(NSString *)fileName{
    
    self = [super init];
    if (self) {
        
        self.fileUrl = url;
        self.filename = fileName;

        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIColor *color = [UIColor blackColor];
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.3];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = WidthRate(3);
        self.frame = CGRectMake(0, 0, WidthRate(280), HeightRate(170));
        self.center = self.maskView.center;
        self.delegate = delegate;
        
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont boldSystemFontOfSize:AdaptFont(16)];
        label.text = @"发送";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(15));
            make.left.mas_equalTo(WidthRate(10));
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(30));

        }];
        
        
        UILabel *fileNameLabel = [[UILabel alloc]init];
        fileNameLabel.font = SYSTEM_FONT(AdaptFont(13));
        fileNameLabel.text = [NSString stringWithFormat:@"[文件] %@",fileName];
        fileNameLabel.textColor = TextColor_666666;
        fileNameLabel.numberOfLines = 0;
        [self addSubview:fileNameLabel];
        
        [fileNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom).offset(WidthRate(10));
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(WidthRate(260));
            make.height.mas_equalTo(HeightRate(60));
            
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(fileNameLabel.mas_bottom).offset(WidthRate(10));
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(0.7));
        }];
        
        
        UILabel *lineH = [[UILabel alloc]init];
        lineH.backgroundColor = SepratorLineColor;
        [self addSubview:lineH];
        
        [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(WidthRate(1));
//            make.bottom.mas_equalTo(WidthRate(0));

            make.height.mas_equalTo(HeightRate(45));
        }];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(line.mas_bottom);
            make.width.mas_equalTo(WidthRate(139.5));
            make.height.mas_equalTo(HeightRate(45));
        }];
        
        UIButton *rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [rigthBtn setTitle:@"发送" forState:UIControlStateNormal];
        [rigthBtn addTarget:self action:@selector(rightbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rigthBtn];
        
        [rigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(line.mas_bottom);
            make.width.mas_equalTo(WidthRate(139.5));
            make.height.mas_equalTo(HeightRate(45));
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
- (void)leftbuttonclick:(UIButton *)btn{
    [self.maskView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(alertViewLeftBtnClick:)]) {
        [self.delegate alertViewLeftBtnClick:self];
    }
}
- (void)rightbuttonclick:(UIButton *)btn{
    [self.maskView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(alertViewRightBtnClick: withFileUrl: withfileName:)]) {
        [self.delegate alertViewRightBtnClick:self withFileUrl:self.fileUrl withfileName:self.filename];
    }
    
}
@end
