//
//  accountInformationView.m
//  emake
//
//  Created by eMake on 2017/10/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "accountInformationView.h"

@interface accountInformationView ()

@property(nonatomic,strong)UIView *BGView;
@property(nonatomic,strong)UILabel *item;


@end
@implementation accountInformationView

-(instancetype )initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"2b2b2b" alpha:0.33];
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor =[UIColor clearColor];
        bgview.center = self.center;
        bgview.bounds =CGRectMake(0, 0, WidthRate(300), HeightRate(400));
        bgview.clipsToBounds = NO;
        _BGView = [[UIView alloc] init];
        _BGView.backgroundColor = [UIColor whiteColor];
        _BGView.center = self.center;
        _BGView.bounds =CGRectMake(0, 0, WidthRate(300), HeightRate(150));
        _BGView.clipsToBounds = YES;
        _BGView.layer.cornerRadius = 6;
        _BGView.tag = self.tag;
        [self addSubview:_BGView];
        

        [self addSubview:bgview];
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.layer.cornerRadius = 17.5;
        closeBtn.layer.masksToBounds = YES;
        [closeBtn setImage: [UIImage imageNamed:@"shanchu" ] forState:UIControlStateNormal];
        [bgview addSubview:closeBtn ];
        closeBtn.frame = CGRectMake(WidthRate(130) , HeightRate(306), 35, 35);
        self.closeButton = closeBtn;
        
    }
    return self;
    
    
}


-(void)setNumberOfLines:(NSInteger )NumberOfLines
{
    _NumberOfLines = NumberOfLines;
    
    for (NSInteger i = 0; i< NumberOfLines; i++) {

        [self getitem:_BGView item:_item name:nil];
        if (self.listViewDelegate &&[self.listViewDelegate respondsToSelector:@selector(ListView:withIndex:flag:section:)]) {
            
            
            self.item.text = [self.listViewDelegate ListView:_BGView withIndex:i flag:self.flag section:self.section];
            self.item.textAlignment = self.lableTexTAliment;
        }
    }
    
}


-(UILabel *)getitem:(UIView *)backgrangdView item:(id)item name:(NSString *)name
{
    UILabel *nameLb = [[UILabel alloc] init];
    nameLb.translatesAutoresizingMaskIntoConstraints = NO;
    nameLb.text = name;
    nameLb.numberOfLines = 0;
    nameLb.font = [UIFont systemFontOfSize:AdaptFont(15)];
    nameLb.textAlignment = NSTextAlignmentCenter;
    [backgrangdView addSubview:nameLb];
    if (item) {
        [nameLb PSSetBottomAtItem:item Length:0];
    }else{
        
        [nameLb PSSetTop:HeightRate(0)];
        
    }
    [nameLb PSSetLeft:WidthRate(10)];
    [nameLb PSSetSize:WidthRate(backgrangdView.width-20) Height:HeightRate(50)];
    
    
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [backgrangdView addSubview:line];
    [line PSSetBottomAtItem:nameLb Length:-1];
    [line PSSetLeft:0];
    [line PSSetSize:backgrangdView.width Height:1];
    self.item = nameLb;

    return line;
    
    
}
@end
