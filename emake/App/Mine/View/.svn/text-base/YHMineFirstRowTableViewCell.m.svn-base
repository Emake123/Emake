//
//  YHMineFirstRowTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/6/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineFirstRowTableViewCell.h"

@implementation YHMineFirstRowTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = ColorWithHexString(StandardBlueColor);
        lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lable.text = @"0";
        [self addSubview:lable];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [lable PSSetCenterXPercent:0.20];
        [lable PSSetTop:HeightRate(5)];
        [lable PSSetSize:WidthRate(100) Height:HeightRate(20)];
        self.lableAccount = lable;
        
        UILabel *lableName = [[UILabel alloc] init];
        lableName.textAlignment = NSTextAlignmentCenter;
        lableName.text =@"我的账户";
        lableName.textColor = ColorWithHexString(@"333333");
        lableName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:lableName];
        lableName.translatesAutoresizingMaskIntoConstraints = NO;
        [lableName PSSetCenterXPercent:0.20];
        [lableName PSSetBottomAtItem:lable Length:HeightRate(3)];
        [lableName PSSetSize:WidthRate(110) Height:HeightRate(20)];
        
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeSystem];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+1;

        [self addSubview:button];
        [button PSSetCenterXPercent:0.20];
        [button PSSetTop:HeightRate(5)];
        [button PSSetSize:WidthRate(100) Height:HeightRate(43)];
        
        
        UILabel *lableCollection = [[UILabel alloc] init];
        lableCollection.textAlignment = NSTextAlignmentCenter;
        lableCollection.textColor = ColorWithHexString(StandardBlueColor);
        lableCollection.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lableCollection.text = @"0";
        [self addSubview:lableCollection];
        lableCollection.translatesAutoresizingMaskIntoConstraints = NO;
        [lableCollection PSSetCenterXPercent:0.5];
        [lableCollection PSSetTop:HeightRate(5)];
        [lableCollection PSSetSize:WidthRate(100) Height:HeightRate(20)];
        self.lableCollection = lableCollection;
        UILabel *lableCollectionName = [[UILabel alloc] init];
        lableCollectionName.textAlignment = NSTextAlignmentCenter;
        lableCollectionName.textColor = ColorWithHexString(@"333333");
        lableCollectionName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lableCollectionName.text = @"我的收藏";
        [self addSubview:lableCollectionName];
        lableCollectionName.translatesAutoresizingMaskIntoConstraints = NO;
        [lableCollectionName PSSetCenterXPercent:0.5];
        [lableCollectionName PSSetBottomAtItem:lableCollection Length:HeightRate(3)];
        [lableCollectionName PSSetSize:WidthRate(110) Height:HeightRate(20)];
        
        UIButton *button2  = [UIButton buttonWithType:UIButtonTypeSystem];
        button2.translatesAutoresizingMaskIntoConstraints = NO;
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag = 10+2;

        [self addSubview:button2];
        [button2 PSSetCenterXPercent:0.5];
        [button2 PSSetTop:HeightRate(5)];
        [button2 PSSetSize:WidthRate(100) Height:HeightRate(43)];
        
        UILabel *lableaAudit = [[UILabel alloc] init];
        lableaAudit.textAlignment = NSTextAlignmentCenter;
        lableaAudit.textColor = ColorWithHexString(StandardBlueColor);
        lableaAudit.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lableaAudit.text = @"认证";
        [self addSubview:lableaAudit];
        lableaAudit.translatesAutoresizingMaskIntoConstraints = NO;
        [lableaAudit PSSetCenterXPercent:0.8];
        [lableaAudit PSSetTop:HeightRate(5)];
        [lableaAudit PSSetSize:WidthRate(100) Height:HeightRate(20)];
        self.lableAudit = lableaAudit;
        UILabel *lableaAuditName = [[UILabel alloc] init];
        lableaAuditName.textAlignment = NSTextAlignmentCenter;
        lableaAuditName.textColor = ColorWithHexString(@"333333");
        lableaAuditName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        lableaAuditName.text = @"实名认证";

        [self addSubview:lableaAuditName];
        lableaAuditName.translatesAutoresizingMaskIntoConstraints = NO;
        [lableaAuditName PSSetCenterXPercent:0.8];
        [lableaAuditName PSSetBottomAtItem:lableaAudit Length:HeightRate(3)];
        [lableaAuditName PSSetSize:WidthRate(110) Height:HeightRate(20)];
        
        UIButton *button3  = [UIButton buttonWithType:UIButtonTypeSystem];
        button3.translatesAutoresizingMaskIntoConstraints = NO;
        button3.tag = 10+3;
        [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        [button3 PSSetCenterXPercent:0.80];
        [button3 PSSetTop:HeightRate(5)];
        [button3 PSSetSize:WidthRate(100) Height:HeightRate(43)];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = ColorWithHexString(@"F2F2F2");
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:line];
        [line PSSetSize:ScreenWidth Height:HeightRate(7)];
        [line PSSetBottomAtItem:lableName Length:10];
        [line PSSetLeft:0];
        [line PSSetBottom:0];
        
    }
    return self;
}

-(void)buttonClick:(UIButton *)button
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YHFirsrRowView:index:)]) {
        [self.delegate YHFirsrRowView:button index:button.tag-10];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
