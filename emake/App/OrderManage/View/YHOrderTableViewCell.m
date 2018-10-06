//
//  YHOrderTableViewCell.m
//  emake
//
//  Created by eMake on 2017/10/12.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderTableViewCell.h"
#import "UIConfig.h"
#import "UIView+PSAutoLayout.h"
static CGFloat const GoodsNameFont = 15.f;
static CGFloat const GoodsDetailFont = 13.0f;
static CGFloat const GoodsAddFont = 11.0f;

static CGFloat const spaceLeft = 95.0f;

@implementation YHOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //产品image
        UIImageView *productionImageView = [[UIImageView alloc] init];
        productionImageView.translatesAutoresizingMaskIntoConstraints = NO;
        productionImageView.backgroundColor = ColorWithHexString(@"ffffff");
        productionImageView.image = [UIImage imageNamed:@"placehold"];
        [self addSubview:productionImageView];
        productionImageView.contentMode = UIViewContentModeScaleAspectFit;
        productionImageView.autoresizesSubviews = YES;
        productionImageView.layer.borderWidth = 1;
        productionImageView.layer.borderColor = SepratorLineColor.CGColor;
        productionImageView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [productionImageView PSSetSize:WidthRate(74) Height:HeightRate(69)];
        [productionImageView PSSetLeft:WidthRate(12)];
        [productionImageView PSSetTop:HeightRate(13)];
        self.productImage = productionImageView;
        
        //产品名称
        UILabel *productNameLable = [[UILabel alloc] init];
        productNameLable.translatesAutoresizingMaskIntoConstraints = NO;
        productNameLable.numberOfLines = 0;
        productNameLable.text = @"200kv-scb11-quanklu";
        productNameLable.font = [UIFont systemFontOfSize:AdaptFont(GoodsNameFont)];
        [self addSubview:productNameLable];
        [productNameLable PSSetTop:HeightRate(11)];
        [productNameLable PSSetLeft:WidthRate(spaceLeft)];
        [productNameLable PSSetRight:WidthRate(10)];
        self.productNameLable = productNameLable;

    
        UILabel *capacityLabel = [[UILabel alloc] init];
        capacityLabel.translatesAutoresizingMaskIntoConstraints = NO;
        capacityLabel.text = @";";
        capacityLabel.font = [UIFont systemFontOfSize:AdaptFont(GoodsDetailFont)];
        capacityLabel.textColor =ColorWithHexString(BASE_FAINTLY_COLOR);
        capacityLabel.numberOfLines = 0;
        capacityLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
        [self addSubview:capacityLabel];
        [capacityLabel PSSetBottomAtItem:productNameLable Length:HeightRate(3)];
        [capacityLabel PSSetLeft:WidthRate(spaceLeft)];
        [capacityLabel PSSetRight:WidthRate(8)];
        self.lbOrderDetail = capacityLabel;
       
//
        //产品价格
        UILabel *priceLable = [[UILabel alloc] init];
        priceLable.translatesAutoresizingMaskIntoConstraints = NO;
        priceLable.font = [UIFont systemFontOfSize:AdaptFont(GoodsNameFont)];
        priceLable.text = @"¥28888";
        priceLable.textColor =  TextColor_666666;
        priceLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:priceLable];
        self.productPriceLable = priceLable;
        [priceLable PSSetRight:WidthRate(7)];
        [priceLable PSSetBottomAtItem:capacityLabel Length:HeightRate(10)];
        
        
        UIView *addView = [[UIView alloc] init];
        addView.translatesAutoresizingMaskIntoConstraints = NO;
        addView.backgroundColor = ColorWithHexString(@"ffffff");//@"FFFBF5"
        [self addSubview:addView];
        [addView PSSetBottomAtItem:priceLable Length:HeightRate(13)];
        [addView PSSetLeft:0];
        [addView PSSetWidth:ScreenWidth];
        self.addSeviceView = addView;
       
        //数量
        UILabel *numberLable = [[UILabel alloc] init];
        numberLable.translatesAutoresizingMaskIntoConstraints = NO;
        numberLable.font = [UIFont systemFontOfSize:AdaptFont(GoodsDetailFont)];
        numberLable.text = @"x2";
        numberLable.textColor =ColorWithHexString(BASE_FAINTLY_COLOR);
        [self addSubview:numberLable];
        [numberLable PSSetRight:WidthRate(9)];
        [numberLable PSSetBottomAtItem:addView Length:HeightRate(3)];
        self.productNumberLable = numberLable;

        //小计
        UILabel *weightLabel = [[UILabel alloc] init];
        weightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        weightLabel.text = @"￥1801000.00";
        weightLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        weightLabel.textColor =ColorWithHexString(StandardBlueColor);
        [self addSubview:weightLabel];
        [weightLabel PSSetRight:WidthRate(6)];
        [weightLabel PSSetBottomAtItem:numberLable Length:HeightRate(3)];
          self.smallPrice = weightLabel;
        
        UILabel *weight = [[UILabel alloc] init];
        weight.font = [UIFont systemFontOfSize:AdaptFont(12)];
        weight.text = @"小计";
        weight.translatesAutoresizingMaskIntoConstraints = NO;
        weight.textColor =TextColor_666666;
        [self addSubview:weight];
        [weight PSSetLeftAtItem:weightLabel Length:0];
        
//        运费
        UILabel *freitFee = [[UILabel alloc] init];
        freitFee.font = [UIFont systemFontOfSize:AdaptFont(12)];
        freitFee.text = @"运费";
        freitFee.translatesAutoresizingMaskIntoConstraints = NO;
        freitFee.textColor =TextColor_666666;
        [self addSubview:freitFee];
        [freitFee PSSetBottomAtItem:weight Length:3];
        [freitFee PSSetRight:WidthRate(6)];
        self.freitFee = freitFee;
        
        UILabel *lable = [[UILabel alloc] init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        lable.backgroundColor = SepratorLineColor;
        [self addSubview:lable];
        [lable PSSetBottomAtItem:freitFee Length:3];
        [lable PSSetLeft:0];
        [lable PSSetSize:ScreenWidth Height:HeightRate(0.5)];
        [lable PSSetBottom:HeightRate(0)];

    }
    return self;
}

-(void)setRequestData:(YHOrder *)order withIsStore:(BOOL)isStore  isHidenFreight:(BOOL)isHiden
{
    
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:order.GoodsSeriesIcon]];
    
    self.productNameLable.text = [NSString stringWithFormat:@"%@",order.GoodsTitle];
    self.lbOrderDetail.text = order.GoodsExplain;
    
    self.productNumberLable.text =[NSString stringWithFormat:@"x%@",order.GoodsNumber];
    
    self.productPriceLable.text = [NSString stringWithFormat:@"¥%.2f",round([order.MainProductPrice doubleValue]*100)/100];
    
    self.smallPrice.text = [NSString stringWithFormat:@"¥%.2f",round([order.TotalProductGroupPrice doubleValue]*100)/100];
    //#warning 运费 等待加字段
    self.freitFee.text = [NSString stringWithFormat:@"运费：¥%.2f",round([order.TotalShippingFee doubleValue]*100)/100];
    self.freitFee.hidden = isHiden;
        
        if (order.AddServiceArr.count ==0)
        {
            self.addSeviceView.hidden = YES;
            
        }else
        {
            CGFloat height = order.AddServiceArr.count*25;
            [self.addSeviceView PSSetHeight:HeightRate(height)];
            self.addSeviceView.hidden = NO;
        }
        for ( int i = 0;i < order.AddServiceArr.count;i++) {
            YHOrderAddSevice *sevice = order.AddServiceArr[i];
            NSString *leftText;
            if ([sevice.GoodsType isEqualToString:@"2"]) {
                if(i==0)
                {
                    leftText = [NSString stringWithFormat:@"%@:%@",sevice.GoodsTypeName,sevice.GoodsTitle];
                }else
                {
                    leftText = [NSString stringWithFormat:@"           %@",sevice.GoodsTitle];
                    
                }
                
            }else{
                leftText = [NSString stringWithFormat:@"%@:%@",sevice.GoodsTypeName,sevice.GoodsTitle];
            }
            NSString *rigthText = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:sevice.GoodsPrice.doubleValue]];
            UIView *view = [self itemView:leftText rightText:rigthText];
            CGFloat viewY =25*i;
            view.frame = CGRectMake(0, HeightRate(viewY), ScreenWidth, HeightRate(25));
            [self.addSeviceView addSubview:view];
            
         }
    
    
}

- (UIView *)itemView:(NSString *)leftText rightText:(NSString *)rightText{
    
    UIView *view = [[UIView alloc]init];
    
    UILabel *labelLeft = [[UILabel alloc]init];
    labelLeft.text  = leftText;
    labelLeft.textColor = ColorWithHexString(@"333333");
    labelLeft.tag = 10;
    labelLeft.font = SYSTEM_FONT(AdaptFont(13));
    [view addSubview:labelLeft];
    
    [labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(8));
        make.centerY.mas_equalTo(view.centerY);
    }];
    
    UILabel *labelRigth = [[UILabel alloc]init];
    labelRigth.text  = rightText;
    labelRigth.textColor = ColorWithHexString(@"A1A1A1");
    labelRigth.font = SYSTEM_FONT(AdaptFont(13));
    [view addSubview:labelRigth];
    
    [labelRigth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-WidthRate(8));
        make.centerY.mas_equalTo(view.centerY);
        
    }];
    
    return view;
}
@end
