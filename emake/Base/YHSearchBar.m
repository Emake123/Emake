//
//  YHSearchBar.m
//  emake
//
//  Created by eMake on 2017/12/1.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSearchBar.h"

@implementation YHSearchBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = SepratorLineColor.CGColor;
        self.layer.borderWidth = 1;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"search"];
        
        leftView.width = leftView.image.size.width+10 ;
        leftView.height = leftView.image.size.height-10;
        leftView.contentMode = UIViewContentModeCenter;
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.placeholder = @"搜索";
    }
    return self;
}

+(instancetype) searchBar
{
    return [[self alloc] init];
}


@end
