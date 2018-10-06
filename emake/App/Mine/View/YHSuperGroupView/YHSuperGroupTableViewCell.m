//
//  YHSuperGroupTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/13.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupTableViewCell.h"

@interface YHSuperGroupTableViewCell  ()
@property(nonatomic,strong)UILabel *prouctExplain;
@property(nonatomic,strong)UIImageView*itemImage;
@property(nonatomic,strong)UILabel *freightPrice;
@property(nonatomic,strong)UILabel *originalPrice;
@property(nonatomic,strong)UILabel *productTip;


@end
@implementation YHSuperGroupTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UILabel *prouctExplain = [[UILabel alloc] init];
//        prouctExplain.backgroundColor = ColorWithHexString(@"333333");
        prouctExplain.text = @"SCB15硅钢干式变压器 阻抗：4%；质量标准：国标；材质：全铜；温升：国标100K ";
        prouctExplain.font = [UIFont systemFontOfSize:AdaptFont(14)];
        prouctExplain.numberOfLines = 0;
        [self addSubview:prouctExplain];
        [prouctExplain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(5));
            make.right.mas_equalTo(WidthRate(-5));
            make.top.mas_equalTo(HeightRate(10) );
            
        }];
        self.prouctExplain = prouctExplain;
        
        UILabel *prouctExplainLine = [[UILabel alloc] init];
        prouctExplainLine.backgroundColor = SepratorLineColor;
        [self addSubview:prouctExplainLine];
        [prouctExplainLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(prouctExplain.mas_bottom).offset(HeightRate(10));
            make.height.mas_equalTo(HeightRate(1));
        }];
        
       
      
        UIImageView*itemImage = [[UIImageView alloc]init];
        itemImage.contentMode = UIViewContentModeScaleAspectFit;
        itemImage.translatesAutoresizingMaskIntoConstraints = false;
        itemImage.image = [UIImage imageNamed:@"placehold"];
        itemImage.layer.borderColor = SepratorLineColor.CGColor;
        itemImage.layer.borderWidth =1;
        itemImage.layer.cornerRadius = 6;
        itemImage.clipsToBounds = YES;
        [self addSubview:itemImage];
        [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(WidthRate(134));
            make.height.mas_equalTo(HeightRate(134));
            make.top.mas_equalTo(prouctExplainLine.mas_bottom).offset(HeightRate(10));
            
        }];
        
        self.itemImage = itemImage;

        UILabel *freightPrice = [[UILabel alloc]init];
        freightPrice.text =@"¥30000 ";
        freightPrice.textColor = ColorWithHexString(@"F8695D");
        freightPrice.font = [UIFont systemFontOfSize:AdaptFont(20)];
        [self addSubview:freightPrice];
        [freightPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(prouctExplainLine.mas_bottom).offset(HeightRate(20));
        }];
        self.freightPrice = freightPrice;
        
        UILabel *productCap = [[UILabel alloc]init];
        productCap.text =@" 拼团价";
        productCap.textColor = ColorWithHexString(@"F8695D");
        productCap.font = [UIFont systemFontOfSize:AdaptFont(12)];
        [self addSubview:productCap];
        [productCap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(freightPrice.mas_right).offset(WidthRate(5));
            make.bottom.mas_equalTo(freightPrice.mas_bottom).offset(0);
        }];

        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"¥30000 普通价"];
        [attrStr addAttribute:NSStrikethroughStyleAttributeName
                        value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                        range:NSMakeRange(0, @"¥30000 原价".length)];


        UILabel *originalPrice = [[UILabel alloc]init];
        originalPrice.attributedText =attrStr;
        originalPrice.textColor = ColorWithHexString(@"999999");
        originalPrice.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:originalPrice];
        [originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(freightPrice.mas_bottom).offset(HeightRate(5));
        }];
        self.originalPrice = originalPrice;
        
        UILabel *productTip = [[UILabel alloc]init];
        productTip.text =@"含税，不含运费";
        productTip.numberOfLines = 0;
        productTip.textColor = ColorWithHexString(@"FF9900");
        productTip.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:productTip];
        [productTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(5));
            make.top.mas_equalTo(originalPrice.mas_bottom).offset(5);
            make.width.mas_equalTo(WidthRate(100));

        }];
        self.productTip = productTip;
//        UILabel *totalNumbers = [[UILabel alloc]init];
//        totalNumbers.text =@"拼团总量：30000件";
//        totalNumbers.textColor = ColorWithHexString(@"999999");
//        totalNumbers.font = [UIFont systemFontOfSize:AdaptFont(13)];
//        [self addSubview:totalNumbers];
//        [totalNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(10));
//            make.top.mas_equalTo(productTip.mas_bottom).offset(HeightRate(25));
//        }];

        UILabel *dateEnd = [[UILabel alloc]init];
        dateEnd.text =@"距离结束12天 23时12分45秒";
        dateEnd.textColor = ColorWithHexString(@"999999");
        dateEnd.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:dateEnd];
        [dateEnd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(productTip.mas_bottom).offset(HeightRate(30));
        }];
        self.dateEnd = dateEnd;
        
        UIImageView *itemImageView = [[UIImageView alloc]init];
        itemImageView.contentMode =  UIViewContentModeScaleAspectFit ;
        itemImageView.clipsToBounds = YES;
        itemImageView.image = [UIImage imageNamed:@"pintuanchenggongw"];
        itemImageView.hidden = YES;
        [self addSubview:itemImageView];
        [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WidthRate(15));
            make.width.mas_equalTo(WidthRate(90));
            make.bottom.mas_equalTo(HeightRate(-20));
            make.height.mas_equalTo(HeightRate(90));
        }];
        
        UIButton *togetherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        togetherButton.backgroundColor  = ColorWithHexString(@"F8695D");
        [togetherButton setTitle:@"去拼团" forState:UIControlStateNormal];
        [togetherButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
        togetherButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
        togetherButton.layer.cornerRadius = HeightRateCommon(24);;
        togetherButton.clipsToBounds = YES;
        [self addSubview:togetherButton];
        [togetherButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(itemImage.mas_centerY).offset(WidthRate(0));
            make.right.mas_equalTo(WidthRate(-15));
            make.width.mas_equalTo(WidthRate(94));
            make.height.mas_equalTo(HeightRateCommon(48));

        }];
        self.togetherButton = togetherButton;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(HeightRate(3));
            make.bottom.mas_equalTo(HeightRate(0));
            make.top.mas_equalTo(itemImage.mas_bottom).offset(HeightRate(10));

        }];
        
        
    }
    return self;
}

-(void)requestData:(YHSuperGroupModel *)model
{
    self.prouctExplain.text = model.GroupName;
    NSArray *imageArr = [Tools stringToJSON:model.GoodsSeriesPhotos];
    if (imageArr.count>0) {
        [self.itemImage sd_setImageWithURL:[NSURL URLWithString:imageArr.firstObject]];
    }
    self.freightPrice.text =[NSString stringWithFormat:@"¥%@ 起",[Tools getHaveNum:model.infoModel.GroupPrice.doubleValue]] ;
    
    NSString *origianPrice =[NSString stringWithFormat:@"%@ 原价",[Tools getHaveNum:model.OldPrice.doubleValue]];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:origianPrice];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName
                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                    range:NSMakeRange(0, origianPrice.length)];
    self.originalPrice.attributedText = attrStr;
    
    self.productTip.text = model.GoodsAddValue;
 
    NSString *str;
//    self.dateEnd.text = [NSString stringWithFormat:@"距离结束%@天 %@时%@分%@秒",model.Day,model.Hour,@"0",@"0"];
    if (model.GroupState.integerValue==0) {
        self.togetherButton.backgroundColor = ColorWithHexString(StandardBlueColor);
        [self.togetherButton setTitle:@"即将开始" forState:UIControlStateNormal];
        str = @"距离开始";
    }else if(model.GroupState.integerValue==1)
    {
        self.togetherButton.backgroundColor = ColorWithHexString(@"F8695D");
        [self.togetherButton setTitle:@"去拼团" forState:UIControlStateNormal];
        str = @"距离结束";

    }else
    {
        self.togetherButton.backgroundColor = ColorWithHexString(@"C9C9C9");
        [self.togetherButton setTitle:@"拼团结束" forState:UIControlStateNormal];
        str = @"距离结束";

    }

   NSAttributedString *att = [Tools getFrontStr:str day:model.Day time:model.Hour isShowSecond:false ];

    self.dateEnd.attributedText = att;
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
