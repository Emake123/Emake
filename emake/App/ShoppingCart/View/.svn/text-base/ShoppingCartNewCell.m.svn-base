//
//  ShoppingCartNewCell.m
//  emake
//
//  Created by 谷伟 on 2017/9/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "ShoppingCartNewCell.h"
#import "YHShoppingCartAccessoryModel.h"
static CGFloat const itemFont = 14.0f;

@interface ShoppingCartNewCell()

@property (nonatomic,strong)UIImageView *itemImage;
@property (nonatomic,strong)UILabel *itemNameLabel;
@property (nonatomic,strong)UILabel *itemRawPrice;
@property (nonatomic,strong)UILabel *itemProduceFee;
@property (nonatomic,strong)UILabel *salePrice;
@property (nonatomic,strong)UILabel *itemWeight;
@property (nonatomic,strong)UILabel *itemSize;
@property (nonatomic,strong)UILabel *itemNumber;
@property (nonatomic,strong)UILabel *parameter;
@property (nonatomic,strong)UILabel *sizeAndWeight;
@property (nonatomic,strong)UILabel *WeightStandard;
@property (nonatomic,strong)UILabel *Brand;
@property (nonatomic,strong)UILabel *totalPrice;
@property (nonatomic,strong)UILabel *taxTipsLable;

@property (nonatomic,strong)UIView *addSeviceView;
@end
@implementation ShoppingCartNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initCell{
    
    self = [super init];
    if (self) {
        
        self.selectItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectItemBtn setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        [self.selectItemBtn setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];
        [self.contentView addSubview:self.selectItemBtn];
        
        [self.selectItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(WidthRate(25));
            make.height.mas_greaterThanOrEqualTo(HeightRate(36));
            make.top.mas_equalTo(HeightRate(36));

        }];

        self.itemImage = [[UIImageView alloc]init];
        self.itemImage.image = [UIImage imageNamed:@"S11"];
        self.itemImage.layer.borderColor = SepratorLineColor.CGColor;
        self.itemImage.layer.borderWidth = 1;
        self.itemImage.contentMode = UIViewContentModeScaleAspectFit;
        self.itemImage.autoresizesSubviews = YES;
        [self.contentView addSubview:self.itemImage];
        
        [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(HeightRate(6));
            make.width.mas_equalTo(WidthRate(70));
            make.height.mas_equalTo(WidthRate(80));
            make.left.mas_equalTo(WidthRate(36));
            
        }];
        
        
        self.itemNameLabel = [[UILabel alloc]init];
        self.itemNameLabel.text =@"200kVA-国标45#油200kVA";
        self.itemNameLabel.font = [UIFont systemFontOfSize:AdaptFont(itemFont)];
        self.itemNameLabel.numberOfLines = 2;
        self.itemNameLabel.textColor = TextColor_0A0A0A;
        [self.contentView addSubview:self.itemNameLabel];
        
        [self.itemNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(6));
            make.left.mas_equalTo(self.itemImage.mas_right).offset(WidthRate(13));
            make.width.mas_equalTo(WidthRate(255));
        }];
        
        self.parameter = [[UILabel alloc]init];
        self.parameter.text =[NSString stringWithFormat:@"s11,ww"];
        self.parameter.font = [UIFont systemFontOfSize:AdaptFont(itemFont)];
        self.parameter.textColor = TextColor_7D7C7C;
        self.parameter.numberOfLines = 0;
        [self.contentView addSubview:self.parameter];
        
        [self.parameter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.itemNameLabel.mas_bottom);
            make.left.mas_equalTo(self.itemImage.mas_right).offset(WidthRate(13));
//            make.height.mas_equalTo(HeightRate(51));
            make.right.mas_equalTo(WidthRate(0));
        }];
        

        self.salePrice = [[UILabel alloc]init];
        self.salePrice.text =[NSString stringWithFormat:@"¥888"];
        self.salePrice.font = [UIFont systemFontOfSize:AdaptFont(itemFont+2)];
        self.salePrice.textColor = TextColor_666666;
        [self.contentView addSubview:self.salePrice];
        
        [self.salePrice mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(HeightRate(74));
            make.top.mas_equalTo(self.parameter.mas_bottom);
            make.height.mas_equalTo(HeightRate(24));
            make.right.mas_equalTo(WidthRate(-7));
        }];
        
        self.addSeviceView = [[UIView alloc]init];
        self.addSeviceView.backgroundColor = ColorWithHexString(@"ffffff");
        [self.contentView addSubview:self.addSeviceView];
        
        [self.addSeviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.salePrice.mas_bottom).offset(HeightRate(7));
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(56));
        }];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;//ColorWithHexString(@"333333");
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(1));
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(self.addSeviceView.mas_bottom).offset(HeightRate(4));
        }];
        UIImageView *addOrDecreaseImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addOrDecrease"]];
        [self.contentView addSubview:addOrDecreaseImage];
        
        [addOrDecreaseImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.height.mas_equalTo(HeightRate(30));
            make.width.mas_equalTo(WidthRate(160));
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(4));
        }];
        
        self.decreseItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.decreseItemBtn setTitleColor:ColorWithHexString(@"bbbbbb") forState:UIControlStateNormal];
        self.decreseItemBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(28)];
        [self.contentView addSubview:self.decreseItemBtn];
        
        [self.decreseItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(addOrDecreaseImage.mas_centerY);
            make.left.mas_equalTo(WidthRate(12));
            make.height.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(WidthRate(45));
        }];
        
        self.Number = [[UITextField alloc]init];
        self.Number.text =[NSString stringWithFormat:@"4"];
        self.Number.textAlignment =NSTextAlignmentCenter;
        self.Number.keyboardType = UIKeyboardTypeNumberPad;
        self.Number.font = [UIFont systemFontOfSize:AdaptFont(15)];
        self.Number.textColor = TextColor_383838;
        [self.contentView addSubview:self.Number];
        
        [self.Number mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.decreseItemBtn.mas_right).offset(WidthRate(9.5));
            make.width.mas_equalTo(WidthRate(55));
            make.centerY.mas_equalTo(addOrDecreaseImage.mas_centerY);
            make.height.mas_equalTo(HeightRate(24));
        }];
        
        
        self.addItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addItemBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(28)];
        [self.addItemBtn setTitleColor:ColorWithHexString(@"bbbbbb") forState:UIControlStateNormal];
        [self.contentView addSubview:self.addItemBtn];

        [self.addItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(addOrDecreaseImage.mas_centerY);
            make.left.mas_equalTo(self.Number.mas_right);
            make.height.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(WidthRate(45));
        }];
        
        self.totalPrice = [[UILabel alloc]init];
        self.totalPrice.text =[NSString stringWithFormat:@"￥2201000.00"];
        self.totalPrice.font = [UIFont systemFontOfSize:AdaptFont(itemFont+4)];
        self.totalPrice.textColor = TextColor_666666;
        [self.contentView addSubview:self.totalPrice];
        
        [self.totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(addOrDecreaseImage.mas_centerY);
            make.height.mas_equalTo(HeightRate(24));
            make.right.mas_equalTo(WidthRate(-7));
        }];
        
        UILabel *labelTax = [[UILabel alloc]init];
        labelTax.text =[NSString stringWithFormat:@"含增值税、不含运费"];
        labelTax.font = [UIFont systemFontOfSize:AdaptFont(itemFont-1)];
        labelTax.textColor = ColorWithHexString(SymbolTopColor);

        [self.contentView addSubview:labelTax];
        
        [labelTax mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.totalPrice.mas_bottom);
            make.height.mas_equalTo(HeightRate(19));
            make.right.mas_equalTo(WidthRate(-7));
        }];
        self.taxTipsLable = labelTax;
        

        UILabel *lineLabel =[[UILabel alloc]init];
        lineLabel.backgroundColor = SepratorLineColor;

        [self.contentView addSubview:lineLabel];

        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.top.mas_equalTo(labelTax.mas_bottom);

            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);

        }];
    }
    return self;
}
- (void)setData:(YHShoppingCartModel *)model{
    self.taxTipsLable.text = [NSString stringWithFormat:@"(%@)",model.GoodsAddValue];
    self.itemNameLabel.text =  [NSString stringWithFormat:@"%@",model.GoodsTitle] ;
//    self.itemSize.text =  model.GoodsSize;
//    self.itemWeight.text =[NSString stringWithFormat:@"重量:%dkg",[model.GoodsWeight intValue]];
    self.parameter.text = model.GoodsExplain;
//    self.WeightStandard.text = [NSString stringWithFormat:@"%@%@",model.AddSeriesName,model.AuxiliaryName];

//    self.sizeAndWeight.text = [NSString stringWithFormat:@"%@   重量:%dkg",model.GoodsSize,[model.GoodsWeight intValue]];
    self.salePrice.text = [NSString stringWithFormat:@"￥%@", [Tools getHaveNum:model.MainProductPrice.doubleValue]];;
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:model.GoodsSeriesIcon] ];
    self.itemNumber.text = [NSString stringWithFormat:@"X%@",model.GoodsNumber];
    self.Number.text = [NSString stringWithFormat:@"%@",model.GoodsNumber];

    self.selectItemBtn.selected = model.isSelect;
    float total = [model.ProductGroupPrice doubleValue] * [model.GoodsNumber intValue];
    NSString *RateText = [NSString stringWithFormat:@"小计 ¥%@", [Tools getHaveNum:total]];
    NSMutableAttributedString *RateTextAttributedSting = [[NSMutableAttributedString alloc]initWithString:RateText];
    [RateTextAttributedSting addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(APP_THEME_MAIN_COLOR) range:NSMakeRange(3, RateText.length-3)];
    [RateTextAttributedSting addAttribute:NSFontAttributeName value:SYSTEM_FONT(AdaptFont(12)) range:NSMakeRange(0, 3)];
    self.totalPrice.attributedText = RateTextAttributedSting;
    CGFloat height = (HeightRate(25))*model.AddServiceArr.count;

//   NSArray * AddServiceArr = [YHShoppingCartAccessoryModel mj_keyValuesArrayWithObjectArray:model.AddServiceInfo];

    if (model.AddServiceArr.count ==0)
    {
        self.addSeviceView.hidden = YES;
        [self.addSeviceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.01);
        }];
        
    }else
    {
        CGFloat height = model.AddServiceArr.count*HeightRate(25);
        [self.addSeviceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        self.addSeviceView.hidden = NO;
    }
    for ( int i = 0;i < model.AddServiceArr.count;i++) {
        YHOrderAddSevice *sevice = model.AddServiceArr[i];
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
        CGFloat viewY =HeightRate(25)*i;
        view.frame = CGRectMake(0, viewY, ScreenWidth, HeightRate(25));
        [self.addSeviceView addSubview:view];
        
        
    }
    
    
//    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
//        if (model.AddServiceInfo.count <=0) {
//            
//            make.height.mas_equalTo(0);
//            
//        }else{
//            make.height.mas_equalTo(HeightRate(height));
//        }
//        
//    }];
//    for (int i = 0; i<model.AddServiceInfo.count; i++) {
//        NSDictionary *dict = model.AddServiceInfo[i];
//        YHOrderAddSevice *model = [YHOrderAddSevice mj_objectWithKeyValues:dict];
//        if ((model.ProductName.length>0 && model.ProductName) && (model.ProductPrice.length>0 && model.ProductPrice)){
//            NSString *leftText;
//            if ([model.arithType isEqualToString:@"1"]) {
//                if(i==0){
//                    leftText = [NSString stringWithFormat:@"%@%@",model.AddSeriesName,model.ProductName];
//                }else{
//                    leftText = [NSString stringWithFormat:@"           %@",model.ProductName];
//                }
//            }else{
//                leftText = [NSString stringWithFormat:@"%@%@",model.AddSeriesName,model.ProductName];
//            }
//            NSString *rigthText = [NSString stringWithFormat:@"¥%.2f",[model.ProductPrice doubleValue]];
//            UIView *view = [self itemView:leftText rightText:rigthText];
//            view.frame = CGRectMake(0,HeightRate(25*i), ScreenWidth, HeightRate(25));
//            [self.bgView addSubview:view];
//        }else{
//            UIView *view = [self itemView:@"" rightText:[dict objectForKey:@""]];
//            view.frame = CGRectMake(0,HeightRate(25*i), ScreenWidth, HeightRate(25));
//            [self.bgView addSubview:view];
//        }
//    }
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
