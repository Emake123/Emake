//
//  YHMineCommonCell.m
//  emake
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHMineCommonCell.h"

@implementation YHMineCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.line.backgroundColor = SepratorLineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
