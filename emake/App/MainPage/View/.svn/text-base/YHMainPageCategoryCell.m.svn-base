//
//  YHMainPageCategoryCell.m
//  emake
//
//  Created by 谷伟 on 2018/3/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainPageCategoryCell.h"
@interface YHMainPageCategoryCell()
@property (nonatomic,retain)UIImageView *itemImage;
@property (nonatomic,retain)UILabel *label;
@end
@implementation YHMainPageCategoryCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemImage = [[UIImageView alloc]init];
        self.itemImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.itemImage];
        
        [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(WidthRate(38));
            make.height.mas_equalTo(HeightRate(40));
            make.top.mas_equalTo(0);
        }];
        
        self.label = [[UILabel alloc]init];
        self.label.text =@"变压器";
        self.label.font = SYSTEM_FONT(AdaptFont(11.5));
        [self.contentView addSubview:self.label];
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.itemImage.mas_centerX);
//            make.bottom.mas_equalTo(-5);
            make.top.mas_equalTo(self.itemImage.mas_bottom).offset(HeightRate(5));

        }];
    }
    return self;
}
- (void)setData:(NSDictionary *)dict isLastObjict:(BOOL)isLastObject{
    if (isLastObject == YES) {
        [self.itemImage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"FactoryIcon"]] placeholderImage:nil];
        [self.itemImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(60));
            
        }];
        self.label.hidden = YES;
    }else
    {
        [self.itemImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(40));
            
        }];
        self.label.hidden = false;

        [self.itemImage sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"CategoryCIcon"]] placeholderImage:nil];
        self.label.text = [dict objectForKey:@"CategoryCName"];
    }

}
@end
