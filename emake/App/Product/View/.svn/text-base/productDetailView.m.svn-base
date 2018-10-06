//
//  productDetailView.m
//  emake
//
//  Created by eMake on 2017/8/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "productDetailView.h"
#import "PSCommon.h"
#import "PSButtonBase.h"
#import "productParamModel.h"

@implementation productDetailView

-(void)productParagramView:(UIView *)view withimage:(NSString *)image productSerialName:(NSString *)serialName params:(NSArray *)array
{
    UIImageView *imageView = [[UIImageView alloc] init ];
    [imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.autoresizesSubviews = YES;

    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:imageView ];
    [imageView PSSetCenterX];
    [imageView PSSetTop:HeightRate(60)];
    [imageView PSSetLeft:0];
    [imageView PSSetRight:0];
    [imageView PSSetHeight:HeightRate(228)];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[view createImageWithColor:[UIColor colorWithHexString:BASE_LINE_COLOR]]];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:line];
    [line PSSetSize:ScreenWidth Height:0.5];
    [line PSSetBottomAtItem:imageView Length:1];
    
    UILabel *lbName = [[UILabel alloc] init];
    lbName.translatesAutoresizingMaskIntoConstraints = NO;
    lbName.textColor = ColorWithHexString(@"1b1b1b");
    lbName.font = [lbName.font fontWithSize:AdaptFont(16)];
    [view addSubview:lbName];
    [lbName setText:serialName];
    [lbName PSSetLeft:WidthRate(12)];
    [lbName PSSetBottomAtItem:line Length:HeightRate(10)];
    
    UIImageView *Quality = [[UIImageView alloc] initWithImage:[view createImageWithColor:[UIColor colorWithHexString:BASE_LINE_COLOR]]];
    Quality.translatesAutoresizingMaskIntoConstraints = NO;
    Quality.image = [UIImage imageNamed:@"goodsdetail_quality "];
    [view addSubview:Quality];
    [Quality PSSetSize:WidthRate(12) Height:HeightRate(12)];
    [Quality PSSetLeft:WidthRate(12)];
    [Quality PSSetBottomAtItem:lbName Length:10];

    
    UILabel *lb_1 = [[UILabel alloc] init];
    lb_1.translatesAutoresizingMaskIntoConstraints = NO;
    lb_1.font = [lb_1.font fontWithSize:AdaptFont(12)];
    [view addSubview:lb_1];
    [lb_1 setText:@"原厂质保三年"];
    [lb_1 PSSetLeft:WidthRate(33)];
    [lb_1 PSSetRightAtItem:Quality Length:7];

   UIImageView * lineVertical = [[UIImageView alloc] initWithImage:[view createImageWithColor:[UIColor colorWithHexString:BASE_LINE_COLOR]]];
    lineVertical.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:lineVertical];
    [lineVertical PSSetSize:0.5 Height:HeightRate(51)];
    [lineVertical PSSetBottomAtItem:line Length:HeightRate(7)];
    [lineVertical PSSetLeft:WidthRate(305)];
    
    _shareBtn = [[PSButtonBase alloc] init];
    
    [_shareBtn setImage:[UIImage imageNamed:@"shoucang_wu"] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"shoucang_you"] forState:UIControlStateSelected];
    
    _shareBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:_shareBtn];
    [_shareBtn PSSetSize:WidthRate(40) Height:HeightRate(30)];
    [_shareBtn PSSetBottomAtItem:line Length:WidthRate(7)];
    [_shareBtn PSSetLeft:WidthRate(318)];
    
    UILabel *shareLb = [[UILabel alloc] init];
    shareLb.translatesAutoresizingMaskIntoConstraints = NO;
    shareLb.font = [lb_1.font fontWithSize:14];
    [shareLb setTextColor:[UIColor colorWithHexString:@"000000"]];
    [view addSubview:shareLb];
    [shareLb setText:@"关注"];
    shareLb.textAlignment = NSTextAlignmentCenter;
    [shareLb PSSetSize:WidthRate(40) Height:HeightRate(20)];
    [shareLb PSSetBottomAtItem:_shareBtn Length:2];
    [shareLb PSSetLeft:WidthRate(318)];
    shareLb.hidden = YES;
    _shareBtn.hidden =YES;
    lineVertical.hidden = YES;
    

    line = [[UIImageView alloc] initWithImage:[view createImageWithColor:[UIColor colorWithHexString:BASE_LINE_COLOR]]];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:line];
    [line PSSetSize:ScreenWidth Height:0.5];
    [line PSSetBottomAtItem:lb_1 Length:HeightRate(10)];
//    line.hidden =YES;
    
    UIScrollView *scrolview = [[UIScrollView alloc] init];
    scrolview.translatesAutoresizingMaskIntoConstraints = NO;
    scrolview.contentSize =CGSizeMake(ScreenWidth, HeightRate(236+60));
    scrolview.contentOffset = CGPointMake(0, 0);
    scrolview.showsVerticalScrollIndicator =YES;
    scrolview.alwaysBounceVertical = YES;
    
  
    [view addSubview:scrolview];
    [scrolview PSSetLeft:WidthRate(0)];
    [scrolview PSSetBottomAtItem:line Length:HeightRate(5)];
    [scrolview PSSetSize:ScreenWidth Height:HeightRate(266)];
    self.scrolView = scrolview;
    
    for (int i = 0; i < array.count; i++) {
        productIndex *model = array[i];
            UIView *item= [self getPagramView:scrolview item:nil name:model.ParamName placeholdName:model.ParamName top:8 tag:10+i total:array.count];
            [item PSSetTop:35*i+8];
            [item PSSetLeft:0];
        [item PSSetSize:ScreenWidth Height:HeightRate(40)];

        
    }
    

 


}
-(UIView * )getPagramView:(UIView *)bgview item:(id)item name:(NSString *)name placeholdName:(NSString *)place top:(CGFloat)top tag:(NSInteger)tag total:(NSInteger)total
{
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [bgview addSubview:view];
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.translatesAutoresizingMaskIntoConstraints = NO;
    lbTitle.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [view addSubview:lbTitle];
    
    [lbTitle setText:name];
    [lbTitle setTextAlignment:NSTextAlignmentRight];
    lbTitle.adjustsFontSizeToFitWidth =YES;
    [lbTitle PSSetLeft:WidthRate(12)];
    [lbTitle PSSetTop:top];
    [lbTitle PSSetSize:WidthRate(60) Height:35];
    
    UILabel * lbCapacity =  [[UILabel alloc] init];
    lbCapacity.translatesAutoresizingMaskIntoConstraints = NO;
    lbCapacity.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [lbCapacity setTextColor:[UIColor colorWithHexString:BASE_LINE_COLOR]];
    [lbCapacity setText:place];
    lbCapacity.tag = tag;
    lbCapacity.userInteractionEnabled = YES;
    [view addSubview:lbCapacity];
   
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = ColorWithHexString(BASE_LINE_COLOR);
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [view  addSubview:line];
    [line PSSetBottomAtItem:lbCapacity Length:HeightRate(-8)];
    [line PSSetLeft:WidthRate(72+10)];
    [line PSSetHeight:1];
    [line PSSetWidth:WidthRate(270)];
    
    UIImageView *tipView = [[UIImageView alloc] init];
    tipView.image = [UIImage imageNamed:@"direction_down"];
    tipView.translatesAutoresizingMaskIntoConstraints = NO;
    [view  addSubview:tipView];
    [tipView PSSetSize:14 Height:14];
    if ([name isEqualToString:@"电压等级1"] )//@"电压等级
        
    {

    } else if ([name isEqualToString:@"备注1"])
    {

    }
   else{
        lbCapacity.text = [NSString stringWithFormat:@"请选者%@",place];
        [tipView PSSetRightAtItem:lbTitle Length:WidthRate(264)];
        

    }
    [lbCapacity PSSetRightAtItem:lbTitle Length:WidthRate(14)];
    [lbCapacity PSSetSize:WidthRate(280) Height:HeightRate(40)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onParams:)];
    [lbCapacity addGestureRecognizer: tap];
    UIView *tapview = [tap view];
    tapview.tag = tag;
    lbCapacity.userInteractionEnabled = YES;
    return view;

}
-(void)onParams:(UITapGestureRecognizer *)tap
{
    UILabel *lable =(UILabel *) [tap view];
    if (_delegate &&[self.delegate respondsToSelector:@selector(productParamsLable:index:)]) {
        [self.delegate productParamsLable:lable index:lable.tag-10];
    }
    
}
@end
