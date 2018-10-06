//
//  YHMineThirdTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/6/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineThirdTableViewCell.h"

@implementation YHMineThirdTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
      
        
        
        UIImageView *bgImageview = [[UIImageView alloc] init];
        bgImageview.contentMode = UIViewContentModeScaleAspectFit;
        bgImageview.image = [UIImage imageNamed:@"wodechaojituan"];
        bgImageview.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bgImageview];
        [bgImageview PSSetSize:WidthRate(352) Height:HeightRate(82)];
        [bgImageview PSSetLeft:WidthRate(11)];
        [bgImageview PSSetTop:HeightRate(5)];
//        [bgImageview PSSetConstraint:WidthRate(11) Right:WidthRate(11) Top:HeightRate(11) Bottom:HeightRate(11)];
        
        
//        UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:@"我的团队" forState:UIControlStateNormal];
//        [button setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
//        button.backgroundColor = ColorWithHexString(StandardBlueColor);
//        button.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
//        [self addSubview:button];
//        button.translatesAutoresizingMaskIntoConstraints = NO;
//        [button PSSetLeft:WidthRate(21)];
//        [button PSSetCenterHorizontalAtItem:self];
//        [button PSSetSize:WidthRate(78) Height:HeightRate(30)];
//        self.TeamButton = button;
        
        UILabel *nameLable = [[UILabel alloc] init];
        nameLable.text= @"我的超级团";
        nameLable.font = [UIFont systemFontOfSize:AdaptFont(16)];
        nameLable.textColor = ColorWithHexString(@"ffffff");
        [self addSubview:nameLable];;
        nameLable.translatesAutoresizingMaskIntoConstraints = false;
        [nameLable PSSetLeft:WidthRate(20)];
        
        [nameLable PSSetCenterHorizontalAtItem:self];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = ColorWithHexString(@"F2F2F2");
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:line];
        line.hidden = YES;
        [line PSSetSize:ScreenWidth Height:HeightRate(0.5)];
        [line PSSetBottomAtItem:bgImageview Length:HeightRate(0)];
        [line PSSetLeft:0];
        [line PSSetBottom:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
