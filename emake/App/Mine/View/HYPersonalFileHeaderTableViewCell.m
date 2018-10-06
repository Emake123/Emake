//
//  HYPersonalFileHeaderTableViewCell.m
//  emake
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "HYPersonalFileHeaderTableViewCell.h"

@implementation HYPersonalFileHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headImageView.layer.cornerRadius = 30;
    self.headImageView.clipsToBounds = YES;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.line.backgroundColor = SepratorLineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
