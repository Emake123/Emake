//
//  YHMineFirstRowTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/6/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineFirstRowTableViewCell.h"
#import "PSButtonBase.h"
@interface YHMineFirstRowTableViewCell()
@property(nonatomic,weak)PSButtonTextDonw *auditButton;
@property(nonatomic,weak)PSButtonTextDonw *collectionAndShareButton;
@property(nonatomic,weak)PSButtonTextDonw *adressAndIntroductionButton;
@property(nonatomic,weak)PSButtonTextDonw *invoiceAndSeviceButton;
@property(nonatomic,assign)NSInteger row;


@end
@implementation YHMineFirstRowTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        PSButtonTextDonw *button  = [[PSButtonTextDonw alloc] init];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setTitle:@"我的账户" forState:UIControlStateNormal];
        button.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 10+1;

        [self addSubview:button];
        [button PSSetCenterXPercent:0.2];
        [button PSSetTop:HeightRate(15)];
        [button PSSetSize:WidthRate(100) Height:HeightRate(40)];
        
       self.collectionAndShareButton = button;

        
        PSButtonTextDonw *button2  = [PSButtonTextDonw buttonWithType:UIButtonTypeCustom];
        button2.translatesAutoresizingMaskIntoConstraints = NO;
        [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button2.tag = 10+2;
       
        button2.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button2 setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [self addSubview:button2];
        [button2 PSSetCenterXPercent:0.5];
        [button2 PSSetTop:HeightRate(15)];
        [button2 PSSetSize:WidthRate(100) Height:HeightRate(40)];
        self.adressAndIntroductionButton = button2;

        
        PSButtonTextDonw *button3  = [PSButtonTextDonw buttonWithType:UIButtonTypeCustom];
        button3.translatesAutoresizingMaskIntoConstraints = NO;
        [button3 setTitle:@"合伙人申请" forState:UIControlStateNormal];
        button3.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [button3 setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"hehuorenshenqing"] forState:UIControlStateNormal];
//        button3.tag = 10+3;
        [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        [button3 PSSetCenterXPercent:0.8];
        [button3 PSSetTop:HeightRate(15)];
        [button3 PSSetSize:WidthRate(100) Height:HeightRate(40)];
        self.invoiceAndSeviceButton = button3;
        
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
-(void)setData:(UserInfoModel *)model
{


}
-(void)setChangeNameAndImage:(BOOL )isChange
{
    if (isChange==false) {
        self.row = 0 ;
         [self.collectionAndShareButton setTitle:@"我的收藏" forState:UIControlStateNormal];
        [self.collectionAndShareButton setImage:[UIImage imageNamed:@"shoucang-s"] forState:UIControlStateNormal];
        
        [self.adressAndIntroductionButton setTitle:@"我的地址" forState:UIControlStateNormal];
        [self.adressAndIntroductionButton setImage:[UIImage imageNamed:@"wodedizhi"] forState:UIControlStateNormal];

        [self.invoiceAndSeviceButton setTitle:@"发票管理" forState:UIControlStateNormal];
        [self.invoiceAndSeviceButton setImage:[UIImage imageNamed:@"kaipiaojilu"] forState:UIControlStateNormal];
    }else
    {
        self.row = 3 ;

        [self.collectionAndShareButton setTitle:@"分享APP" forState:UIControlStateNormal];
        [self.collectionAndShareButton setImage:[UIImage imageNamed:@"wo_fenxiang"] forState:UIControlStateNormal];
        
        [self.adressAndIntroductionButton setTitle:@"使用说明" forState:UIControlStateNormal];
        [self.adressAndIntroductionButton setImage:[UIImage imageNamed:@"shiyongshuoming"] forState:UIControlStateNormal];
        
        [self.invoiceAndSeviceButton setTitle:@"易智造客服" forState:UIControlStateNormal];
        [self.invoiceAndSeviceButton setImage:[UIImage imageNamed:@"wo-yizhizaokefu"] forState:UIControlStateNormal];
    }
    self.collectionAndShareButton.tag = self.row+11;

    self.adressAndIntroductionButton.tag = self.row+12;
    self.invoiceAndSeviceButton.tag = self.row+13;

}
-(void)buttonClick:(PSButtonTextDonw *)button
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YHFirsrRowView:index:)]) {//index 1,2,3
        [self.delegate YHFirsrRowView:button index:button.tag-10];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
