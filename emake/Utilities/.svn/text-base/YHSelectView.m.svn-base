//
//  YHSelectView.m
//  emake
//
//  Created by 谷伟 on 2017/10/26.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSelectView.h"
@interface YHSelectView()
@property (nonatomic,strong)UIView *maskView;
@property (nonatomic,strong)UIButton *delete;
@end
@implementation YHSelectView

- (instancetype)initWithDelegat:(id)delegate andTitle:(NSString *)title items:(NSArray *)titles{
    
    if (self = [super init]) {
        
        NSInteger count = titles.count;
        self.backgroundColor = [UIColor clearColor];
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        self.frame = CGRectMake(0, 0, WidthRate(286), HeightRate(45*(count+1)));
        
        self.center = self.maskView.center;
        
        for (int i = 0; i<count+1; i++) {
        
            if (i==0 ) {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRate(45)*i, WidthRate(286), HeightRate(45))];
                label.text =title;
                label.layer.cornerRadius = 5;
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
                [self addSubview:label];
            }else{
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame =CGRectMake(0, HeightRate(45)*i, WidthRate(286), HeightRate(45));
                btn.tag = 100 + i;
                [btn setTitle:titles[i-1] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];
                
                UILabel *line = [[UILabel alloc]init];
                line.backgroundColor =SepratorLineColor;
                line.frame = CGRectMake(15, HeightRate(44.5)*i, WidthRate(256), HeightRate(0.5));
                [self addSubview:line];
                
            }
            
        }
        
        self.delete = [UIButton buttonWithType:UIButtonTypeCustom];
        self.delete.frame = CGRectMake(WidthRate(266),0, WidthRate(20),HeightRate(20));
        [self.delete addTarget:self action:@selector(removeSelctview) forControlEvents:UIControlEventTouchUpInside];
        [self.delete setImage:[UIImage imageNamed:@"shouye_shanchu"] forState:UIControlStateNormal];
        [self addSubview:self.delete];
        
    }
    return self;
}
- (void)selectItem:(UIButton *)sender{
    
    [self.maskView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(selectView:selectItemWithIndex:)]) {
        [self.delegate selectView:self selectItemWithIndex:sender.tag - 100];
    }
}
- (void)removeSelctview{
    
    [self.maskView removeFromSuperview];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
