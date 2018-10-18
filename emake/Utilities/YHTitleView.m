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
@property (nonatomic,retain)UIScrollView *titleScrolview;
@property (nonatomic,assign)CGFloat titleOffset;

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

- (instancetype)initWithTitleFont:(NSInteger)size delegate:(id)delegate andTitleArray:(NSArray *)titleArray andTitleHeight:(CGFloat )TitleHeight andScrolweight:(CGFloat )Scrolweight
{
    if (self = [super init]) {
    
    NSInteger count = titleArray.count;
    self.backgroundColor = [UIColor whiteColor];
    self.titles = titleArray;
    self.delegate = delegate;
    self.titleButtonArray = [NSMutableArray arrayWithCapacity:titleArray.count];
        CGFloat titleWidth =0;
        
        UIScrollView *cloudTitleScrollView = [[UIScrollView alloc] init];
        cloudTitleScrollView.showsVerticalScrollIndicator = false;
        cloudTitleScrollView.showsHorizontalScrollIndicator = false;
        cloudTitleScrollView.pagingEnabled = YES;
        cloudTitleScrollView.alwaysBounceVertical = false;
        cloudTitleScrollView.alwaysBounceHorizontal = YES;
        [self addSubview:cloudTitleScrollView];
        [cloudTitleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(Scrolweight);
            make.height.mas_equalTo(HeightRateCommon(TitleHeight));
            make.left.mas_equalTo(WidthRate(0));
            
        }];
        self.titleScrolview = cloudTitleScrollView;
        
        CGFloat leftWidth =05;
        CGFloat leftSpace =0;
        CGFloat ButtonSpace =0;
        CGFloat Buttonwith =0;

        UIButton *button;
    for (int i = 0; i< count; i++) {
        NSString *Title = [NSString stringWithFormat:@"%@",titleArray[i]];
        CGFloat space = WidthRate(10);
        CGFloat itemwidth =Title.length *(size+1);
         leftSpace = leftSpace+space*(i+1);


        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.translatesAutoresizingMaskIntoConstraints = false;
        [btn setTitle:Title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = SYSTEM_FONT(size);
        btn.tag = 100+i;
        //            btn.backgroundColor = [UIColor redColor];
        
        if (count<=3) {
            ButtonSpace = 0;
            Buttonwith =ScreenWidth/count;
            btn.frame = CGRectMake(0, 0, ScreenWidth/count, HeightRateCommon(TitleHeight));

        }else
        {
            ButtonSpace = 20;
            Buttonwith = itemwidth;
            btn.frame = CGRectMake(leftWidth, 0, itemwidth, HeightRateCommon(TitleHeight));

        }
        [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
        [cloudTitleScrollView addSubview:btn];
        [self.titleButtonArray addObject:btn];
        titleWidth = titleWidth + Title.length*(size+1)+space*(i+1);
        leftWidth = leftWidth + itemwidth+space*(i+1);
//        [btn PSSetSize:Buttonwith Height:HeightRateCommon(TitleHeight)];
//        [btn PSSetTop:0];
//        if (button == nil) {
//            [btn PSSetLeft:WidthRate(ButtonSpace)];
//
//        }else
//        {
//            [btn PSSetRightAtItem:button Length:WidthRate(ButtonSpace)];
//        }
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(Buttonwith);
            make.height.mas_equalTo(HeightRateCommon(TitleHeight));
            if (button==nil) {
                make.left.mas_equalTo(WidthRate(ButtonSpace));

            }else
            {
                make.left.mas_equalTo(button.mas_right).offset(WidthRate(ButtonSpace));

            }
            make.top.mas_equalTo(0);

        }];
        button = btn;
    }
        self.titleViewWidth = titleWidth<ScreenWidth?ScreenWidth:titleWidth;
        cloudTitleScrollView.contentSize = CGSizeMake( self.titleViewWidth, HeightRateCommon(TitleHeight));
//        self.frame = CGRectMake(0, 0, titleWidth, HeightRateCommon(TitleHeight));
        UIButton *firstBtn =(UIButton *)self.titleButtonArray.firstObject;;
    [firstBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
    if(titleArray.count>0)
    {
        CGSize length = [titleArray[0] sizeWithAttributes:@{NSFontAttributeName:firstBtn.titleLabel.font}];
        self.lineView = [[UIView alloc]init];//WithFrame:CGRectMake(0, 0, firstBtn.width, firstBtn.width)];
        self.lineView.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
//        self.lineView.center = CGPointMake(firstBtn.centerX, TitleHeight-1);
//        self.lineView.bounds = CGRectMake(0, 0, firstBtn.width, 3);
        [cloudTitleScrollView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(firstBtn.mas_centerX);
            make.width.mas_equalTo(length.width);
            make.height.mas_equalTo(2);
            make.top.mas_equalTo(firstBtn.mas_bottom).offset(1);
            
        }];
    }
}
    return self;
    
}
-(void)hidenBottonline
{
    self.lineView.hidden = YES;
}
- (void)selectTitleItemWithIndex:(NSInteger)index{
    
    UIButton *selectBtn =(UIButton *)self.titleButtonArray[index];//[self viewWithTag:100+index];
    for (int i = 0; i<self.titles.count; i++) {
        
        UIButton *btn = (UIButton *)self.titleButtonArray[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    CGSize size = [selectBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:selectBtn.titleLabel.font}];
//
    [UIView animateWithDuration:0.5 animations:^{
        [selectBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];

        if (self.lineView.isHidden == false) {
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(selectBtn.mas_centerX);
                make.width.mas_equalTo(size.width);
                make.top.mas_equalTo(selectBtn.mas_bottom).offset(-2);
                make.height.mas_equalTo(2);
            }];
        }
     
//
    } completion:^(BOOL finished) {
        if (self.titleScrolview && self.titleButtonArray.count>3) {
            CGFloat widthSpath = 0;
            if ((selectBtn.x+selectBtn.width)>ScreenWidth) {
                widthSpath = selectBtn.x+selectBtn.width-ScreenWidth;
                self.titleScrolview.contentOffset = CGPointMake(widthSpath, 0) ;

            } else {

            }

        }
    }];

    if ([self.delegate respondsToSelector:@selector(titleView:selectItemWithIndex:)]) {

        [self.delegate titleView:self selectItemWithIndex:selectBtn.tag-100];

    }

}
- (void)selectItemWithIndex:(NSInteger)index{
    
    UIButton *selectBtn =(UIButton *)self.titleButtonArray[index];//[self viewWithTag:100+index];
    [self selectItem:selectBtn];
}
- (void)ChageItemWithIndex:(NSInteger)index{
    UIButton *selectBtn =(UIButton *)self.titleButtonArray[index];//(UIButton *)[self viewWithTag:100+index];
//    NSArray *views = self.titleButtonArray;
    for (int i = 0; i<self.titles.count; i++) {
        
        UIButton *btn = (UIButton *)self.titleButtonArray[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    CGSize size = [selectBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:selectBtn.titleLabel.font}];

    [UIView animateWithDuration:0.5 animations:^{
        [selectBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.lineView.width = size.width;
        self.lineView.center = CGPointMake(selectBtn.centerX, selectBtn.centerY+selectBtn.height/2.0) ;
        
    } completion:^(BOOL finished) {
        if (self.titleScrolview && self.titleButtonArray.count>2) {
            CGFloat widthSpath = 0;
            if ((selectBtn.x+selectBtn.width)>ScreenWidth) {
               widthSpath = selectBtn.x+selectBtn.width-ScreenWidth;
                self.titleScrolview.contentOffset = CGPointMake(widthSpath, 0) ;

            } else {
                
            }
            
        }
    }];
    
}
- (void)selectItem:(UIButton *)sender{
    
    NSArray *views = self.subviews;
    for (int i = 0; i<self.titles.count; i++) {
        
        UIButton *btn = (UIButton *)self.titleButtonArray[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (self.titleScrolview && self.titleButtonArray.count>2) {
        CGFloat widthSpath = 0;
        if ((sender.x+sender.width)>ScreenWidth) {
            widthSpath = sender.x+sender.width-ScreenWidth;
            self.titleScrolview.contentOffset = CGPointMake(widthSpath, 0) ;
            
        } else {
            
        }
        
    }
    CGSize size = [sender.currentTitle sizeWithAttributes:@{NSFontAttributeName:sender.titleLabel.font}];

    [UIView animateWithDuration:0.5 animations:^{
        [sender setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.lineView.width = size.width;
        self.lineView.center = CGPointMake(sender.centerX, sender.centerY+sender.height/2.0) ;
       
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
