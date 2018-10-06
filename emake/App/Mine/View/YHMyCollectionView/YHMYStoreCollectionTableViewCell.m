//
//  YHMYStoreCollectionTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/7/29.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMYStoreCollectionTableViewCell.h"

@implementation YHMYStoreCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView * imageview    = [[UIImageView alloc] init];
        imageview.translatesAutoresizingMaskIntoConstraints = NO;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.image = [UIImage imageNamed:@"placehold"];
        imageview.layer.borderWidth =  1;
        imageview.layer.borderColor = SepratorLineColor.CGColor;
        [self addSubview:imageview];
        [imageview PSSetLeft:WidthRate(13)];
        [imageview PSSetSize:WidthRate(70) Height:HeightRate(70)];
        [imageview PSSetTop:HeightRate(10)];
        [imageview PSSetBottom:HeightRate(10)];
        self.GoodsImageView = imageview;
        
     
        
        UILabel *GoodsName = [[UILabel alloc] init];
        GoodsName.translatesAutoresizingMaskIntoConstraints = NO;
        GoodsName.text = @"队nanfei";
        GoodsName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        GoodsName.numberOfLines = 0;
        GoodsName.textColor = ColorWithHexString(@"333333");
        [self addSubview:GoodsName];
        [GoodsName PSSetSize:WidthRate(120) Height:HeightRate(34)];
        [GoodsName PSSetLeft:WidthRate(90)];
        //        [imageview PSSetCenterHorizontalAtItem:self];
        [GoodsName PSSetTop:HeightRate(15)];
        self.GoodsName = GoodsName;
        
        UILabel *detailName = [[UILabel alloc] init];
        detailName.translatesAutoresizingMaskIntoConstraints = NO;
        detailName.text = @"bidk大";
        detailName.font = [UIFont systemFontOfSize:AdaptFont(13)];
        detailName.textColor = ColorWithHexString(@"999999");
        [self addSubview:detailName];
        [detailName PSSetBottomAtItem:GoodsName Length:WidthRate(10)];
        [detailName PSSetLeft:WidthRate(90)];
        self.StoreName = detailName;
//        [detailName PSSetSize:WidthRate(120) Height:HeightRate(34)];
//        [detailName PSSetBottomAtItem:leadImage Length:3];
        //        self.detailLable = detailName;
        
        
        UIButton *enterStore = [UIButton buttonWithType:UIButtonTypeCustom];
        enterStore.translatesAutoresizingMaskIntoConstraints = NO;
        [enterStore setTitle:@"进店 >" forState:UIControlStateNormal];
        [enterStore setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
        enterStore.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:enterStore];
        [enterStore PSSetRightAtItem:detailName Length:WidthRate(15)];
        [enterStore PSSetSize:WidthRate(80) Height:HeightRate(25)];
        self.EnterStoreBUtton = enterStore;
        
        UIButton *concelColletionStore = [UIButton buttonWithType:UIButtonTypeCustom];
        concelColletionStore.translatesAutoresizingMaskIntoConstraints = NO;
        [concelColletionStore setTitle:@"取消收藏" forState:UIControlStateNormal];
        [concelColletionStore setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
        concelColletionStore.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
        concelColletionStore.layer.borderWidth = 1;
        concelColletionStore.clipsToBounds = YES;
        concelColletionStore.layer.cornerRadius = HeightRate(14);
        concelColletionStore.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:concelColletionStore];
//        [concelColletionStore PSSetHAtItem:detailName Length:WidthRate(15)];
        [concelColletionStore PSSetCenterHorizontalAtItem:GoodsName];
        [concelColletionStore PSSetRight:WidthRate(30)];
        [concelColletionStore PSSetSize:WidthRate(86) Height:HeightRate(28)];
        self.ConcelColletionButtton = concelColletionStore;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line PSSetLeft:WidthRate(0)];
        [line PSSetSize:ScreenWidth Height:HeightRate(1)];
        [line PSSetBottom:HeightRate(0)];
    }
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
