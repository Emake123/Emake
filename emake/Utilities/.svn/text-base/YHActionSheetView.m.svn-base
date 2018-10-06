//
//  YHActionSheetView.m
//  AlertViewTest
//
//  Created by 谷伟 on 2017/10/9.
//  Copyright © 2017年 谷伟. All rights reserved.
//

#import "YHActionSheetView.h"
@interface YHActionSheetView()
@property (nonatomic,strong)UIView *maskView;
@end
@implementation YHActionSheetView

- (instancetype)initWithDelegate:(id)delegate withCancleTitle:(NSString *)cancleTitle andItemArrayTitle:(NSArray *)titleArray{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.delegate = delegate;
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, (titleArray.count+1)*HeightRate(55)+HeightRate(48));
        
        UIButton *cancelBtn = [[UIButton alloc]init];
        cancelBtn.layer.cornerRadius = 5;
        [cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-HeightRate(21));
            make.height.mas_equalTo(HeightRate(55));
            make.width.mas_equalTo(WidthRate(296));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cancelBtn.mas_top).offset(-HeightRate(21));
            make.height.mas_equalTo(HeightRate(55*titleArray.count));
            make.width.mas_equalTo(WidthRate(296));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        for (int i=0 ; i<titleArray.count; i++) {
            
            UIButton *item = [[UIButton alloc]init];
            item.tag = 100 + i;
            [item setTitle:titleArray[i] forState:UIControlStateNormal];
            [item setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
            item.titleLabel.font = [UIFont systemFontOfSize:16];
            item.backgroundColor = [UIColor whiteColor];
            [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:item];
            
            
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-HeightRate(55)*i);
                make.height.mas_equalTo(HeightRate(55));
                make.left.mas_equalTo(WidthRate(3));
                make.right.mas_equalTo(WidthRate(3));
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
            
            UILabel *lineV = [[UILabel alloc]init];
            lineV.backgroundColor = SepratorLineColor;
            [view addSubview:lineV];
            
            [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-HeightRate(55)*i);
                make.height.mas_equalTo(0.5);
                make.left.mas_equalTo(WidthRate(0));
                make.right.mas_equalTo(WidthRate(0));
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
        }
    }
    return self;
}

- (instancetype)initShareWithDelegate:(id)delegate withCancleTitle:(NSString *)cancleTitle andItemArrayTitle:(NSArray *)titleArray{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.delegate = delegate;
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, (titleArray.count+1)*HeightRate(55)+HeightRate(48));
        
        
        UIButton *cancelBtn = [[UIButton alloc]init];
        cancelBtn.layer.cornerRadius =5;
        [cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-HeightRate(21));
            make.height.mas_equalTo(HeightRate(55));
            make.width.mas_equalTo(WidthRate(296));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius =5;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cancelBtn.mas_top).offset(-HeightRate(21));
            make.height.mas_equalTo(HeightRate(55*titleArray.count));
            make.width.mas_equalTo(WidthRate(296));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        for (int i=0 ; i<titleArray.count; i++) {
            
            UIButton *item = [[UIButton alloc]init];
            item.tag = 100 + i;
            [item setTitle:titleArray[i] forState:UIControlStateNormal];
            [item setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
            item.titleLabel.font = [UIFont systemFontOfSize:16];
            item.backgroundColor = [UIColor whiteColor];
            [item addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:item];
            
            
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-HeightRate(55)*i);
                make.height.mas_equalTo(HeightRate(55));
                make.left.mas_equalTo(WidthRate(3));
                make.right.mas_equalTo(WidthRate(3));
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
            
            UILabel *lineV = [[UILabel alloc]init];
            lineV.backgroundColor = SepratorLineColor;
            [view addSubview:lineV];
            
            [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-HeightRate(55)*i);
                make.height.mas_equalTo(0.5);
                make.left.mas_equalTo(WidthRate(0));
                make.right.mas_equalTo(WidthRate(0));
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
        }
    }
    return self;
}
- (void)showAnimated{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (void)cancle{
    
    [self.maskView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(actionSheetViewCancell)]) {
        
        [self.delegate actionSheetViewCancell];
        
    }
}
- (void)selectItem:(UIButton *)sender{
    
    [self.maskView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(actionSheetView:selectItemWithIndex:)]) {
        
        [self.delegate actionSheetView:self selectItemWithIndex:sender.tag-100];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
