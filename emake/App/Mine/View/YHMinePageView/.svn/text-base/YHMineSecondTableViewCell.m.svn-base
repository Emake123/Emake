//
//  YHMineSecondTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/6/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineSecondTableViewCell.h"
#import "PSButtonBase.h"
@implementation YHMineSecondTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        PSButtonTextDonw *button  = [[PSButtonTextDonw alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"我的地址" forState:UIControlStateNormal];
        button.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wodedizhi"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+1;
        
        [self addSubview:button];
        [button PSSetCenterXPercent:0.15];
        [button PSSetTop:HeightRate(15)];
        [button PSSetSize:WidthRate(100) Height:HeightRate(40)];
        
        
        
        
        PSButtonTextDonw *button2  = [PSButtonTextDonw buttonWithType:UIButtonTypeCustom];
        button2.translatesAutoresizingMaskIntoConstraints = NO;
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 10+2;
        [button2 setTitle:@"发票管理" forState:UIControlStateNormal];
        button2.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button2 setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"kaipiaojilu"] forState:UIControlStateNormal];
        [self addSubview:button2];
        [button2 PSSetCenterXPercent:0.37];
        [button2 PSSetTop:HeightRate(15)];
        [button2 PSSetSize:WidthRate(100) Height:HeightRate(40)];
        
        
        
        PSButtonTextDonw *button3  = [PSButtonTextDonw buttonWithType:UIButtonTypeCustom];
        button3.translatesAutoresizingMaskIntoConstraints = NO;
        [button3 setTitle:@"分享APP" forState:UIControlStateNormal];
        button3.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button3 setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"wo_fenxiang"] forState:UIControlStateNormal];
        button3.tag = 10+3;
        [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        [button3 PSSetCenterXPercent:0.60];
        [button3 PSSetTop:HeightRate(15)];
        [button3 PSSetSize:WidthRate(100) Height:HeightRate(40)];
        
        PSButtonTextDonw *button4  = [PSButtonTextDonw buttonWithType:UIButtonTypeCustom];
        button4.translatesAutoresizingMaskIntoConstraints = NO;
        [button4 setTitle:@"使用说明" forState:UIControlStateNormal];
        button4.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button4 setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [button4 setImage:[UIImage imageNamed:@"shiyongshuoming"] forState:UIControlStateNormal];
        button4.tag = 10+4;
        [button4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button4];
        [button4 PSSetCenterXPercent:0.85];
        [button4 PSSetTop:HeightRate(15)];
        [button4 PSSetSize:WidthRate(100) Height:HeightRate(40)];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = ColorWithHexString(@"F2F2F2");
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:line];
        [line PSSetSize:ScreenWidth Height:HeightRate(1)];
        [line PSSetBottomAtItem:button Length:HeightRate(15)];
        [line PSSetLeft:0];
        [line PSSetBottom:0];
        
    }
    return self;
}

-(void)buttonClick:(PSButtonTextDonw *)button
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YHSecondRowView:index:)]) {
        [self.delegate YHSecondRowView:button index:button.tag-10];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
