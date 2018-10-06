//
//  YHStoreOrderNewTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/7/27.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHStoreOrderNewTableViewCell.h"

static CGFloat const GoodsNameFont = 15.f;
static CGFloat const GoodsDetailFont = 13.0f;
static CGFloat const GoodsAddFont = 11.0f;

static CGFloat const spaceLeft = 95.0f;
@interface YHStoreOrderNewTableViewCell()
@property(nonatomic,strong)UIImageView *productImage;

@property(nonatomic,strong)UILabel *productNameLable;
//@property(nonatomic,strong)UILabel *productPriceLable;
@property(nonatomic,strong)UILabel *productNumberLable;

@property (nonatomic,strong)UILabel *lbOrderDetail;
@end
@implementation YHStoreOrderNewTableViewCell

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
        [capacityLabel PSSetHeight:HeightRate(35)];
        [capacityLabel PSSetRight:WidthRate(8)];
        self.lbOrderDetail = capacityLabel;
        
        //
        //产品价格
        UILabel *priceLable = [[UILabel alloc] init];
        priceLable.translatesAutoresizingMaskIntoConstraints = NO;
        priceLable.font = [UIFont systemFontOfSize:AdaptFont(GoodsNameFont)];
        priceLable.text = @"X1";
        priceLable.textColor =  TextColor_666666;
        priceLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:priceLable];
        self.productNumberLable = priceLable;
        [priceLable PSSetRight:WidthRate(7)];
        [priceLable PSSetBottomAtItem:capacityLabel Length:HeightRate(10)];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        lable.backgroundColor = SepratorLineColor;
        [self addSubview:lable];
        [lable PSSetBottomAtItem:priceLable Length:HeightRate(10)];
        [lable PSSetLeft:0];
        [lable PSSetSize:ScreenWidth Height:HeightRate(0.5)];
        [lable PSSetBottom:HeightRate(0)];
    }
    return self;
}

-(void)setRequestData:(YHOrder *)order
{
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:order.GoodsSeriesIcon]];
    
    self.productNameLable.text = [NSString stringWithFormat:@"%@",order.GoodsTitle];
    self.lbOrderDetail.text = order.GoodsExplain;
    
    self.productNumberLable.text =[NSString stringWithFormat:@"x%@",order.GoodsNumber];
    CGFloat height = [order.GoodsExplain boundingRectWithSize:CGSizeMake(ScreenWidth-WidthRate(100), 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptFont(15.0)]} context:nil].size.height ;
    if (height>50) {
        [self.lbOrderDetail PSUpdateConstraintsHeight:HeightRate(height+20)];
        
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
