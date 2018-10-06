//
//  YHFriendRankingCell.m
//  emake
//
//  Created by 谷伟 on 2017/9/6.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHFriendRankingCell.h"
#import "RankModel.h"
@interface YHFriendRankingCell ()

@property (nonatomic,strong)UIImageView *imageView1;
@property (nonatomic,strong)UIImageView *imageView2;
@property (nonatomic,strong)UIImageView *imageView3;
@end
@implementation YHFriendRankingCell
- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.headImage1 = [[UIImageView alloc]init];
        self.headImage1.image = [UIImage imageNamed:@"login_logo"];
        self.headImage1.layer.cornerRadius = WidthRate(65/2);
        self.headImage1.clipsToBounds = YES;
        self.headImage1.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.headImage1];
        
        [self.headImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(32));
            make.top.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(WidthRate(65));
            make.height.mas_equalTo(WidthRate(65));
        }];
        
        self.imageView1 = [[UIImageView alloc]init];
        self.imageView1.image = [UIImage imageNamed:@"paihangbang_jin"];
        [self.contentView addSubview:self.imageView1];
        
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headImage1.mas_centerX);
            make.centerY.mas_equalTo(self.headImage1.mas_centerY);
            make.width.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(WidthRate(95));
        }];
        
        self.labelName1 = [[UILabel alloc]init];
        self.labelName1.text = @"李子易";
        self.labelName1.textAlignment = NSTextAlignmentCenter;
        self.labelName1.font = [UIFont systemFontOfSize:AdaptFont(14)];
        self.labelName1.textColor = TextColor_666666;
        [self.contentView addSubview:self.labelName1];
        
        
        [self.labelName1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImage1.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self.headImage1.mas_centerX);
            make.height.mas_equalTo(HeightRate(20));
        }];
        
        
        self.labelScore1 = [[UILabel alloc]init];
        self.labelScore1.text = @"已获得27积分";
        self.labelScore1.textAlignment = NSTextAlignmentCenter;
        self.labelScore1.textColor = TextColor_B3B3B3;
        self.labelScore1.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:self.labelScore1];
        
        
        [self.labelScore1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelName1.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self.headImage1.mas_centerX);
            make.height.mas_equalTo(HeightRate(16));
        }];
        
        self.headImage2 = [[UIImageView alloc]init];
        self.headImage2.image = [UIImage imageNamed:@"login_logo"];
        self.headImage2.layer.cornerRadius = WidthRate(65/2);
        self.headImage2.clipsToBounds = YES;
        self.headImage2.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.headImage2];
        
        [self.headImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(WidthRate(65));
            make.height.mas_equalTo(WidthRate(65));
        }];
        
        self.imageView2 = [[UIImageView alloc]init];
        self.imageView2.image = [UIImage imageNamed:@"paihangbang_yin"];
        [self.contentView addSubview:self.imageView2];
        
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headImage2.mas_centerX);
            make.centerY.mas_equalTo(self.headImage2.mas_centerY);
            make.width.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(WidthRate(95));
        }];
        
        self.labelName2 = [[UILabel alloc]init];
        self.labelName2.text = @"周大仁";
        self.labelName2.textColor = TextColor_666666;
        self.labelName2.textAlignment = NSTextAlignmentCenter;
        self.labelName2.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:self.labelName2];
        
    
        
        
        [self.labelName2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImage2.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self.headImage2.mas_centerX);
            make.height.mas_equalTo(HeightRate(20));
        }];
        
        
        self.labelScore2 = [[UILabel alloc]init];
        self.labelScore2.text = @"已获得21积分";
        self.labelScore2.textColor = TextColor_B3B3B3;
        self.labelScore2.textAlignment = NSTextAlignmentCenter;
        self.labelScore2.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:self.labelScore2];
        
        
        [self.labelScore2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelName2.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self.headImage2.mas_centerX);
            make.height.mas_equalTo(HeightRate(16));
        }];
        
        self.headImage3 = [[UIImageView alloc]init];
        self.headImage3.image = [UIImage imageNamed:@"login_logo"];
        self.headImage3.layer.cornerRadius = WidthRate(65/2);
        self.headImage3.clipsToBounds = YES;
        self.headImage3.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.headImage3];
        
        [self.headImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-32));
            make.top.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(WidthRate(65));
            make.height.mas_equalTo(WidthRate(65));
        }];
        
        self.imageView3 = [[UIImageView alloc]init];
        self.imageView3.image = [UIImage imageNamed:@"paihangbang_tong"];
        [self.contentView addSubview:self.imageView3];
        
        [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headImage3.mas_centerX);
            make.centerY.mas_equalTo(self.headImage3.mas_centerY);
            make.width.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(WidthRate(95));
        }];
        
        self.labelName3 = [[UILabel alloc]init];
        self.labelName3.text = @"王晨晨";
        self.labelName3.textAlignment = NSTextAlignmentCenter;
        self.labelName3.textColor = TextColor_666666;
        self.labelName3.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:self.labelName3];
        
        
        [self.labelName3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headImage3.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self.headImage3.mas_centerX);
            make.height.mas_equalTo(HeightRate(20));
        }];
        
        
        self.labelScore3 = [[UILabel alloc]init];
        self.labelScore3.text = @"已获得15积分";
        self.labelScore3.textColor = TextColor_B3B3B3;
        self.labelScore3.textAlignment = NSTextAlignmentCenter;
        self.labelScore3.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self.contentView addSubview:self.labelScore3];
        
        
        [self.labelScore3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelName3.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self.headImage3.mas_centerX);
            make.height.mas_equalTo(HeightRate(16));
        }];
        
    }
    return self;
}
- (void)setData:(NSMutableArray *)array{
    
    if (array.count == 0) {
        
        self.labelName1.hidden = true;
        self.labelScore1.hidden = true;
        self.imageView1.hidden = true;
        self.headImage1.hidden = true;
        
        self.labelName2.hidden = true;
        self.labelScore2.hidden = true;
        self.imageView2.hidden = true;
        self.headImage2.hidden = true;
        
        self.labelName3.hidden = true;
        self.imageView3.hidden = true;
        self.labelScore3.hidden = true;
        self.headImage3.hidden = true;
        
    }else if (array.count == 1){
        RankModel *one = array[0];
        self.labelName1.text = one.RealName;
        self.labelScore1.text = [NSString stringWithFormat:@"已获得%@积分",one.Score];
        [self.headImage1 sd_setImageWithURL:[NSURL URLWithString:one.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
        
        self.labelName2.hidden = true;
        self.labelScore2.hidden = true;
        self.imageView2.hidden = true;
        self.headImage2.hidden = true;
        
        self.labelName3.hidden = true;
        self.imageView3.hidden = true;
        self.labelScore3.hidden = true;
        self.headImage3.hidden = true;
        
    }else if (array.count == 2){
        
        RankModel *one = array[0];
        self.labelName1.text = one.RealName;
        self.labelScore1.text = [NSString stringWithFormat:@"已获得%@积分",one.Score];
        [self.headImage1 sd_setImageWithURL:[NSURL URLWithString:one.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
        
        RankModel *two = array[1];
        self.labelName2.text = two.RealName;
        self.labelScore2.text = [NSString stringWithFormat:@"已获得%@积分",two.Score];
        [self.headImage2 sd_setImageWithURL:[NSURL URLWithString:two.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
        
        self.labelName3.hidden = true;
        self.labelScore3.hidden = true;
        self.imageView3.hidden = true;
        self.headImage3.hidden = true;
        
    }else{
        
        RankModel *one = array[0];
        self.labelName1.text = one.RealName;
        self.labelScore1.text = [NSString stringWithFormat:@"已获得%@积分",one.Score];
        [self.headImage1 sd_setImageWithURL:[NSURL URLWithString:one.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
        
        RankModel *two = array[1];
        self.labelName2.text = two.RealName;
        self.labelScore2.text = [NSString stringWithFormat:@"已获得%@积分",two.Score];
        [self.headImage2 sd_setImageWithURL:[NSURL URLWithString:two.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
        
        RankModel *three = array[2];
        self.labelName3.text = three.RealName;
        self.labelScore3.text = [NSString stringWithFormat:@"已获得%@积分",three.Score];
        [self.headImage3 sd_setImageWithURL:[NSURL URLWithString:three.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
