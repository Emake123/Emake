//
//  UIButton+Common.m
//  emake
//
//  Created by chenyi on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "UIButton+Common.h"

@implementation UIButton (Common)

-(void)SetButtonMaskBath
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(self.frame.size.height/2,self.frame.size.height/2)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}
- (void)setButtonShowType:(RSButtonType)type
{
    [self layoutIfNeeded];
    
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    
    CGFloat space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width + 4;
//    CGFloat    imageWidth = self.imageView.frame.size.width;
    switch (type) {
        case RSButtonTypeRight:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,imageFrame.size.width - space, 0, -(imageFrame.size.width - space))];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0, imageFrame.origin.x - titleFrame.origin.x)];
        }
            break;
        case RSButtonTypeLeft:
        {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,titleFrame.size.width + space, 0, -(titleFrame.size.width + space))];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0, titleFrame.origin.x - imageFrame.origin.x)];
        }
            break;
        case RSButtonTypeBottom:
        {
//            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            /* 获取按钮文字的宽度 获取按钮图片和文字的间距 获取图片宽度 */
//            CGFloat    space = 10;// 图片和文字的间距
//            CGFloat    titleWidth = 60;
//            UIImage    * btnImage = self.currentImage;// 11*6
//            CGFloat    imageWidth = btnImage.size.width;
//            /*当然，为了防止文字内容过多，要做一点预防*/
//            CGFloat    btnWidth = 200;// 按钮的宽度
//            if (titleWidth > btnWidth - imageWidth - space) {
//                titleWidth = btnWidth- imageWidth - space;
//            }
//            CGFloat    imageHeight = self.currentImage.size.height;
//            CGFloat    titleHeight = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
//            [self setImageEdgeInsets:UIEdgeInsetsMake(-(imageHeight*0.5 + space*0.5), titleWidth*0.5, imageHeight*0.5 + space*0.5, -titleWidth*0.5)];
//            [self setTitleEdgeInsets:UIEdgeInsetsMake(titleHeight*0.5 + space*0.5, -imageWidth*0.5, -(titleHeight*0.5 + space*0.5), imageWidth*0.5)];
//
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
            [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height ,-self.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
            [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -self.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
        }
            break;
        case RSButtonTypeTop:
        {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-(imageFrame.size.width), imageFrame.size.height + space, 0)];
            
            [self setImageEdgeInsets:UIEdgeInsetsMake(titleFrame.size.height + space,(titleFrame.size.width), 0, 0)];
        }
            break;
        default:
            break;
    }
    
}

-(void) verticalImageAndTitle: (CGFloat) spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize  = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width),ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width)
        titleSize.width = frameSize.width;
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight-imageSize.height), 0, 0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight-titleSize.height), 0);
    
}

- (void)layoutSubviews11
{
    [super layoutSubviews];
    //设置图片的尺寸
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //设置label的尺寸
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}
-(void)setimageTopAndTitleDown
{
    CGFloat gap = 10.f;
    CGFloat labelWidth = self.titleLabel.bounds.size.width;
    CGFloat imageWidth = self.imageView.bounds.size.width;
    CGFloat imageHeight = self.imageView.bounds.size.height;
    CGFloat labelHeight = self.titleLabel.bounds.size.height;
    
    // 这里都计算完毕了，很简单，例如 imageWidth是A  labelWidth是B
    // 那么image要居中就要X轴移动 （A+B）/2 - A/2
    // label要居中就要X轴移动 （A+B）/2 - B/2
    // Y轴移动就直接除以2 然后加上间隙就好了
    // 图片中心对齐控件XY轴的偏移量
    CGFloat imageOffSetX = labelWidth / 2;
    CGFloat imageOffSetY = imageHeight / 2 + gap / 2;
    CGFloat labelOffSetX = imageWidth / 2;
    CGFloat labelOffSetY = labelHeight / 2 + gap / 2;
    // 上图下字
    // 让UIButton能保证边缘自适应 居中的时候需要
    // 当上下排布的时候，要根据edge来填充content大小
    CGFloat maxWidth = MAX(imageWidth,labelWidth); // 上下排布宽度肯定变小 获取最大宽度的那个
    CGFloat changeWidth = imageWidth + labelWidth - maxWidth; // 横向缩小的总宽度
    CGFloat maxHeight = MAX(imageHeight,labelHeight); // 获取最大高度那个 （就是水平默认排布的时候的原始高度）
    CGFloat changeHeight = imageHeight + labelHeight + gap - maxHeight; // 总高度减去原始高度就是纵向宽大宗高度
    self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffSetY, imageOffSetX, imageOffSetY, -imageOffSetX);
    self.titleEdgeInsets = UIEdgeInsetsMake(labelOffSetY, -labelOffSetX, -labelOffSetY, labelOffSetX);
    self.contentEdgeInsets = UIEdgeInsetsMake(changeHeight - labelOffSetY, - changeWidth / 2, labelOffSetY, -changeWidth / 2);
}
@end
