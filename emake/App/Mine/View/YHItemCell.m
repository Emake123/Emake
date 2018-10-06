//
//  YHItemCell.m
//  emake
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHItemCell.h"
@interface YHItemCell()
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@end
@implementation YHItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.line.hidden =YES;
    self.firstItemName.textColor = ColorWithHexString(@"6D6D6D");
    self.firstBadge.textColor =  ColorWithHexString(@"ffffff");
    self.firstBadge.layer.borderColor = TextColor_FFAC00.CGColor;
    self.firstBadge.backgroundColor = TextColor_FFAC00;
    self.firstBadge.layer.cornerRadius = 7;
    self.firstBadge.clipsToBounds = YES;
    
    self.secondItemName.textColor = ColorWithHexString(@"6D6D6D");
    self.secondBadge.textColor = ColorWithHexString(@"ffffff");
    self.secondBadge.layer.borderColor = TextColor_FFAC00.CGColor;
    self.secondBadge.backgroundColor = TextColor_FFAC00;
    self.secondBadge.clipsToBounds = YES;
    self.secondBadge.layer.cornerRadius = 7;
    
    self.thirdItemName.textColor = ColorWithHexString(@"6D6D6D");
    self.thirdBadge.textColor = ColorWithHexString(@"ffffff");
    self.thirdBadge.layer.borderColor = TextColor_FFAC00.CGColor;
    self.thirdBadge.backgroundColor = TextColor_FFAC00;
    self.thirdBadge.clipsToBounds = YES;
    self.thirdBadge.layer.cornerRadius = 7;

    self.fourthItemName.textColor = ColorWithHexString(@"6D6D6D");
    self.fourthBadge.textColor = ColorWithHexString(@"ffffff");
    self.fourthBadge.backgroundColor = TextColor_FFAC00;
    self.fourthBadge.clipsToBounds = YES;
    self.fourthBadge.layer.borderColor = TextColor_FFAC00.CGColor;
    self.fourthBadge.layer.cornerRadius = 7;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
