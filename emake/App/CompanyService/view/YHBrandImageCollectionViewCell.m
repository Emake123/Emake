//
//  YHBrandImageCollectionViewCell.m
//  emake
//
//  Created by eMake on 2017/11/8.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHBrandImageCollectionViewCell.h"
#import "UIView+PSAutoLayout.h"
@implementation YHBrandImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *bottomView  = [[UIView alloc] init];
        bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        bottomView.layer.borderWidth = 1;
        bottomView.layer.borderColor = SepratorLineColor.CGColor;
        bottomView.layer.masksToBounds = YES;
        [self.contentView addSubview:bottomView];
        
        UIImageView *imageView  = [[UIImageView alloc] init];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.image = [UIImage imageNamed:@""];
        [bottomView addSubview:imageView];
        [imageView PSSetConstraint:10 Right:9 Top:7 Bottom:7];
        self.imageview = imageView;
        
    }
    
    return self;
}

@end
