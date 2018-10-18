//
//  HRAdView.m
//  AutoAdLabelScroll
//
//  Created by 陈华荣 on 16/4/6.
//  Copyright © 2016年 陈华荣. All rights reserved.
//

#import "HRAdView.h"
#import "YHMainShoppingModel.h"
#define ViewHeight  self.bounds.size.height
#define ViewWidth  self.bounds.size.width

@interface HRAdView ()
/**
 *  文字广告条前面的图标
 */
@property (nonatomic, strong) UIImageView *headImageView;
/**
 *  轮流显示的两个Label
 */
@property (nonatomic, strong) UIView *oneView;
//@property (nonatomic, strong) UIView *twoView;
@property (nonatomic, strong) UILabel *commpanyLabel;
//@property (nonatomic, strong) UILabel *commpanyLabelTwo;
@property (nonatomic, strong) UILabel *Amount;
//@property (nonatomic, strong) UILabel *AmountTwo;
@property (nonatomic, strong) UILabel *detailLabel;
//@property (nonatomic, strong) UILabel *detailLabelTwo;


@end

@implementation HRAdView
{
    NSUInteger index;
    CGFloat margin;
    BOOL isBegin;
}


- (instancetype)initWithTitles:(NSArray *)lastWeekArray{
    
    self = [super init];
    
    if (self) {
        margin = 0;
        self.clipsToBounds = YES;
        self.lastWeekArray = lastWeekArray;
        self.headImg = nil;
        self.labelFont = [UIFont systemFontOfSize:16];
        self.color = [UIColor blackColor];
        self.time = 2.0f;
        self.textAlignment = NSTextAlignmentLeft;
        self.isHaveHeadImg = NO;
        self.isHaveTouchEvent = NO;
        index = 0;
        if (!_headImageView) {
            _headImageView = [UIImageView new];
        }
       
        if (!self.oneView) {
            ;
          
            NSDictionary *dic = lastWeekArray.firstObject;
            NSString *name = dic[@"RealName"];
            NSString *resultStr = @"";
            if (name.length>1) {
                resultStr =[NSString stringWithFormat:@"%@**",[name substringToIndex:1]];
            }else
            {
                resultStr =[NSString stringWithFormat:@"%@**",name];
                
            }
            NSString *totalPrice = [NSString stringWithFormat:@"已获得%@元现金",[Tools getHaveNum:[dic[@"TotalCashIn"] doubleValue]]];
            self.oneView = [[UIView alloc]init];
            self.oneView.backgroundColor = [UIColor whiteColor];
            self.commpanyLabel = [[UILabel alloc]init];
            self.commpanyLabel.font =  [UIFont systemFontOfSize:AdaptFont(14)];
            
            self.commpanyLabel.text = resultStr;
            [self.oneView addSubview:self.commpanyLabel];
            
            [self.commpanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(0));
                make.top.mas_equalTo(HeightRate(10));
            }];
            
            self.Amount = [[UILabel alloc] init];
            self.Amount.font = SYSTEM_FONT(AdaptFont(13));
            self.Amount.textAlignment = NSTextAlignmentRight;
            self.Amount.textColor = ColorWithHexString(@"333333");
            self.Amount.text = totalPrice;
            [self.oneView addSubview:self.Amount];
            
            [self.Amount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(WidthRate(-25));
                make.centerY.mas_equalTo(self.commpanyLabel.mas_centerY);
                make.height.mas_equalTo(WidthRate(26));
            }];
            
            
            [self addSubview:self.oneView];
        }
        if (self.lastWeekArray.count <= 1) {
            return  self;
        }

    }
    return self;
}
- (void)timeRepeat{
    if (self.lastWeekArray.count == 0) {
        return;
    }
    if (index != self.lastWeekArray.count-1) {
        index++;
    }else{
        index = 0;
    }
    NSString *resultStr = @"";

    NSDictionary *dic = self.lastWeekArray[index];
    NSString *name = dic[@"RealName"];
    if (name.length>1) {
        resultStr =[NSString stringWithFormat:@"%@**",[name substringToIndex:1]];
    }else
    {
        resultStr =[NSString stringWithFormat:@"%@**",name];

    }
    NSString *totalPrice = [NSString stringWithFormat:@"已获得%@元现金",[Tools getHaveNum:[dic[@"TotalCashIn"] doubleValue]]];

    self.commpanyLabel.text = resultStr;
    self.Amount.text = [NSString stringWithFormat:@"%@",totalPrice];
    
    
    
    self.oneView.frame = CGRectMake(0, ViewHeight, ScreenWidth, ViewHeight);
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.oneView.frame = CGRectMake(0, -0, ScreenWidth, ViewHeight);
        
    } completion:^(BOOL finished) {
        
    }];
  
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.isHaveHeadImg) {
        [self addSubview:self.headImageView];
        self.headImageView.frame = CGRectMake(0, 0, ViewHeight,ViewHeight);
        margin = 0;
    }else{
        
        if (self.headImageView) {
            [self.headImageView removeFromSuperview];
            self.headImageView = nil;
        }
        margin = 0;
    }
    
    self.oneView.frame = CGRectMake(0, 0, ScreenWidth, ViewHeight);
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(timeRepeat) userInfo:self repeats:YES];
    }
    return _timer;
}
- (void)beginScroll{
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
- (void)paseScroll{
    
    [self.timer invalidate];
    self.timer = nil;
}
- (void)closeScroll{
    
    [self.timer invalidate];
    self.timer = nil;
}
- (void)setIsHaveHeadImg:(BOOL)isHaveHeadImg{
    _isHaveHeadImg = isHaveHeadImg;
    
}
- (void)setIsHaveTouchEvent:(BOOL)isHaveTouchEvent{
    if (isHaveTouchEvent) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }else{
        self.userInteractionEnabled = NO;
    }
}

- (void)setTime:(NSTimeInterval)time{
    _time = time;
    if (self.timer.isValid) {
        [self.timer isValid];
        self.timer = nil;
    }
}

- (void)setHeadImg:(UIImage *)headImg{
    _headImg = headImg;
    
    self.headImageView.image = headImg;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    self.oneView.backgroundColor = [UIColor redColor];
//    self.twoView.backgroundColor = RGBColor(245, 250, 255);
}

- (void)clickEvent:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    [self.lastWeekArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
}


@end
