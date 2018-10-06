//
//  YHMainSearchKeyWordsTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/6/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainSearchKeyWordsTableViewCell.h"

@implementation YHMainSearchKeyWordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setData:(NSArray *)arr
{
    CGFloat TotalWidth = 0;
    UILabel *item;
    CGFloat recordxx =0;
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *str = arr[i];
        CGRect rect = [str boundingRectWithSize:CGSizeMake(WidthRate(300), 40) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptFont(11)]} context:nil];
        
        CGFloat w = rect.size.width+30;
        CGFloat h = 30;
        
        TotalWidth += w+10;
        
        
        int yy = (int)(WidthRate(TotalWidth)/(ScreenWidth-30));
        CGFloat Y = yy*40 +10;
        NSLog(@"cell===Totalwidth=%f,yy=%d,",TotalWidth,yy);

     
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = ColorWithHexString(@"333333");
        lable.font = [UIFont systemFontOfSize:AdaptFont(11)];
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = ColorWithHexString(@"E4E4E4").CGColor;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = str;
        lable.tag = i+10;
        [self addSubview:lable];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [lable PSSetSize:WidthRate(w) Height:HeightRate(30)];

        if (item == nil | recordxx != yy) {
            [lable PSSetLeft:WidthRate(15)];
            [lable PSSetTop:HeightRate(Y)];
        }else
        {
            [lable PSSetRightAtItem:item Length:WidthRate(10)];
            [lable PSSetTop:HeightRate(Y)];
        }
        lable.userInteractionEnabled = YES;
        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick:)]];
        item = lable;
        recordxx = yy;
    }
    
}
-(void)lableClick:(UITapGestureRecognizer *)gesture
{
    UILabel *lable = (UILabel *)gesture.view;
    
    if (self.searchkeywordsDelegate && [self.searchkeywordsDelegate respondsToSelector:@selector(YhsearchKeyWords:index:)]) {
        
        [self.searchkeywordsDelegate YhsearchKeyWords:lable index:lable.tag-10];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
