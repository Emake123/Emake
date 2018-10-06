//
//  productFootView.m
//  emake
//
//  Created by 张士超 on 2017/12/27.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "productFootView.h"

@implementation productFootView


-(UIView *)getItemView:(UIView *)bgview Title:(NSString *)Title lable:(UILabel *)insurancePriced  Title:(NSString *)Title isShowPrice:(BOOL)isShow Num:(NSString *)num
{
    //    if (_b) {
    //    [insuranceView removeFromSuperview];
    UIView * insuranceView= [[UIView alloc] init];
    
    [bgview addSubview:insuranceView];
    //        bgview = [[UIView alloc] init];
    
    UILabel *insuranceLable = [[UILabel alloc]init];
    insuranceLable.textColor = TextColor_636263;
    insuranceLable.text =Title; //@"保险";
    insuranceLable.font = SYSTEM_FONT(AdaptFont(14));
    [insuranceView addSubview:insuranceLable];
    [insuranceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(26));
        make.height.mas_equalTo(HeightRate(25));
        make.top.mas_equalTo(HeightRate(13));
    }];
    
    
    UIImageView *addOrDecreaseImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addOrDecrease"]];
    [insuranceView addSubview:addOrDecreaseImage1];
    [addOrDecreaseImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-11));
        make.height.mas_equalTo(HeightRate(30));
        make.width.mas_equalTo(WidthRate(145));
        make.centerY.mas_equalTo(insuranceLable.mas_centerY);
        
    }];
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(28)];
    [addBtn setTitleColor:ColorWithHexString(@"bbbbbb") forState:UIControlStateNormal];
    [insuranceView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(NextView.mas_bottom).offset(HeightRate(17));
        make.centerY.mas_equalTo(insuranceLable.mas_centerY);
        
        make.right.mas_equalTo(WidthRate(-12));
        make.height.mas_equalTo(HeightRate(24));
        make.width.mas_equalTo(WidthRate(40));
        
    }];
    
    UITextField * insuranceText = [[UITextField alloc]init];
    insuranceText.text =[NSString stringWithFormat:@"1"];
    insuranceText.textAlignment =NSTextAlignmentCenter;
    insuranceText.keyboardType = UIKeyboardTypeNumberPad;
    insuranceText.font = [UIFont systemFontOfSize:AdaptFont(15)];
    insuranceText.textColor = TextColor_383838;
//    insuranceText.delegate = self;
    insuranceText.inputAccessoryView = [self addToolbar];
    [insuranceView addSubview:insuranceText];
    [insuranceText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(addBtn.mas_left).offset(WidthRate(-3));
        make.width.mas_equalTo(WidthRate(50));
        make.centerY.mas_equalTo(insuranceLable.mas_centerY);
        make.height.mas_equalTo(HeightRate(26));
    }];
    
    UIButton *decreseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [decreseBtn setTitleColor:ColorWithHexString(@"bbbbbb") forState:UIControlStateNormal];
    decreseBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(28)];
    
    [insuranceView addSubview:decreseBtn];
    
    [decreseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(insuranceLable.mas_centerY);
        make.right.mas_equalTo(insuranceText.mas_left).offset(-5);
        make.height.mas_equalTo(HeightRate(24));
        make.width.mas_equalTo(WidthRate(35));
    }];
    
    if (isShow ==YES) {
        UILabel *insurancePrice = [[UILabel alloc] init];
        insurancePrice.textColor = ColorWithHexString(StandardBlueColor);
        insurancePrice.text = @"¥0";
        [insuranceView addSubview:insurancePrice];
       insurancePriced = insurancePrice;
        [insurancePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(82));
            make.height.mas_equalTo(HeightRate(23));
            make.left.mas_equalTo(insuranceLable.mas_right).offset(WidthRate(15));
            make.centerY.mas_equalTo(insuranceLable.mas_centerY);
        }];
        [addBtn addTarget:self action:@selector(addInsranceNumber) forControlEvents:UIControlEventTouchUpInside];
        [decreseBtn addTarget:self action:@selector(decreseInsranceNumber) forControlEvents:UIControlEventTouchUpInside];
//        self.insuranceText = insuranceText;
        
        
    }else
    {
//        self.addItemBtn = addBtn;
//        [self.addItemBtn addTarget:self action:@selector(addNumber) forControlEvents:UIControlEventTouchUpInside];
//        self.decreseItemBtn =  decreseBtn;
//        [self.decreseItemBtn addTarget:self action:@selector(decreseNumber) forControlEvents:UIControlEventTouchUpInside];
//        self.Number = insuranceText;
    }
    //    }
//    if (isShow == YES) {
//        self.insuranceText.text = num;
//
//    } else {
//
//        self.Number.text = num;
//
//    }
    
    return insuranceView;
}

-(void)addInsranceNumber
{
    
    
}
-(void)decreseInsranceNumber
{
    
    
}
- (UIToolbar *)addToolbar{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    
    return _bgView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
