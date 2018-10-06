//
//  YHTitleView.m
//  TitleSelectView
//
//  Created by 谷伟 on 2017/10/16.
//  Copyright © 2017年 谷伟. All rights reserved.
//

#import "YHTitleView.h"
@interface YHTitleView()
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,retain)NSArray *titles;
@end
@implementation YHTitleView

- (instancetype)initWithFrame:(CGRect)rect titleFont:(NSInteger)size delegate:(id)delegate andTitleArray:(NSArray *)titleArray{
    
    if (self = [super initWithFrame:rect]) {
        
        NSInteger count = titleArray.count;
        self.backgroundColor = [UIColor whiteColor];
        self.titles = titleArray;
        self.delegate = delegate;
        self.titleButtonArray = [NSMutableArray arrayWithCapacity:titleArray.count];
        for (int i = 0; i< count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            NSString *Title = [NSString stringWithFormat:@"%@",self.t[]];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = SYSTEM_FONT(AdaptFont(size));
            btn.tag = 100+i;
//            btn.backgroundColor = [UIColor redColor];
            btn.frame = CGRectMake(rect.size.width*i/count, 0, rect.size.width/count, self.bounds.size.height);
            [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.titleButtonArray addObject:btn];
        }
        UIButton *firstBtn =(UIButton *)[self viewWithTag:100];
        [firstBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        if(titleArray.count>0)
        {
            CGSize length = [titleArray[0] sizeWithAttributes:@{NSFontAttributeName:firstBtn.titleLabel.font}];
            self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-HeightRate(3), length.width, HeightRate(3))];
            self.lineView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
            self.lineView.centerX = firstBtn.centerX;
            [self addSubview:self.lineView];
        }
    }
    return self;
}
- (void)selectItemWithIndex:(NSInteger)index{
    
    UIButton *selectBtn =(UIButton *)[self viewWithTag:100+index];
    [self selectItem:selectBtn];
}
- (void)ChageItemWithIndex:(NSInteger)index{
    UIButton *selectBtn =(UIButton *)[self viewWithTag:100+index];
    NSArray *views = self.subviews;
    for (int i = 0; i<self.titles.count; i++) {
        
        UIButton *btn = (UIButton *)views[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [selectBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        CGSize length = [self.titles[index] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptFont(14)]}];
        self.lineView.width = length.width;
        self.lineView.centerX = selectBtn.centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)selectItem:(UIButton *)sender{
    
    NSArray *views = self.subviews;
    for (int i = 0; i<self.titles.count; i++) {
        
        UIButton *btn = (UIButton *)views[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [sender setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        CGSize length = [self.titles[sender.tag - 100] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptFont(14)]}];
        self.lineView.width = length.width;
        self.lineView.centerX = sender.centerX;
        
    } completion:^(BOOL finished) {
        
    }];
    if ([self.delegate respondsToSelector:@selector(titleView:selectItemWithIndex:)]) {
        
        [self.delegate titleView:self selectItemWithIndex:sender.tag-100];
        
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
