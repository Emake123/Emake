//
//  PlaceholderTextView.m
//  NewBZT
//
//  Created by zl on 17/1/13.
//  Copyright © 2017年 zl. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:AdaptFont(14)];
        self.placeholderColor = TextColor_BBBBBB;
        self.placeholder = @"请输入内容";
        
        UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
        [topView setBarStyle:UIBarStyleDefault];
        
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
        
        
        NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
     
        
        [topView setItems:buttonsArray];
        [self setInputAccessoryView:topView];
        
           }
    return self;
} 

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withAttributes:attrs];
}

-(void)dismissKeyBoard
{
    [self resignFirstResponder];
}

// 布局子控件的时候需要重绘
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
    
}
// 设置属性的时候需要重绘，所以需要重写相关属性的set方法
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length) { // 因为是在文本改变的代理方法中判断是否显示placeholder，而通过代码设置text的方式又不会调用文本改变的代理方法，所以再此根据text是否不为空判断是否显示placeholder。
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (attributedText.length) {
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
