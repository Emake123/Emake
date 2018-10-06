//
//  MessageEventCollectionViewCell.m
//  sampleObjectC
//
//  Created by oshumini on 2017/6/16.
//  Copyright © 2017年 HXHG. All rights reserved.
//

#import "MessageEventCollectionViewCell.h"
#import "YHShoppingCartModel.h"
#import "YHOrder.h"
@interface MessageEventCollectionViewCell ()
@property(strong, nonatomic)UILabel *evenText;
@property(strong, nonatomic)UIImageView *itemImage;
@property(strong, nonatomic)UILabel *itemName;
@property(strong, nonatomic)UILabel *itemParameter;
@property(strong, nonatomic)UILabel *PriceLabel;
@property(strong, nonatomic)UIImageView *downImage;

@end

@implementation MessageEventCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
      
      self.backView = [[UIView alloc]init];
      self.backView.backgroundColor = [UIColor whiteColor];
      self.backView.layer.borderWidth = WidthRate(2);
      self.backView.layer.borderColor = SepratorLineColor.CGColor;
      self.backView.layer.cornerRadius = WidthRate(5);
      
      UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBubble)];
      [self.backView addGestureRecognizer:gesture];
      [self.contentView addSubview:self.backView];
      [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.mas_equalTo(self.contentView.mas_centerX);
          make.top.mas_equalTo(HeightRate(30));
          make.bottom.mas_equalTo(0);
          make.width.mas_equalTo(WidthRate(370));
      }];
      
      UILabel *title = [[UILabel alloc]init];
      title.text = @"订单信息";
      title.font = SYSTEM_FONT(AdaptFont(15));
      title.textColor = TextColor_636263;
      [self.backView addSubview:title];
      
      [title mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(WidthRate(15));
          make.height.mas_equalTo(HeightRate(18));
          make.top.mas_equalTo(HeightRate(10));
      }];
      
      self.itemImage = [[UIImageView alloc]init];
      self.itemImage.layer.borderColor = SepratorLineColor.CGColor;
      self.itemImage.layer.borderWidth = WidthRate(1);
      self.itemImage.contentMode =UIViewContentModeScaleAspectFit;
      [self.backView addSubview:self.itemImage];
      
      [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(WidthRate(15));
          make.height.mas_equalTo(HeightRate(70));
          make.width.mas_equalTo(WidthRate(75));
          make.top.mas_equalTo(title.mas_bottom).offset(HeightRate(15));
      }];
      
      self.itemName = [[UILabel alloc]init];
      self.itemName.text = @"200KVA-国标45#油";
      self.itemName.numberOfLines = 3;
      self.itemName.font = SYSTEM_FONT(AdaptFont(15));
      self.itemName.textColor = [UIColor blackColor];
      [self.backView addSubview:self.itemName];
      
      [self.itemName mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.itemImage.mas_right).offset(WidthRate(10));
          make.right.mas_equalTo(WidthRate(-20));
          make.top.mas_equalTo(title.mas_bottom).offset(HeightRate(15));
      }];
      
      self.itemParameter = [[UILabel alloc]init];
      self.itemParameter.text = @"原厂质保三年；全铜；";
      self.itemParameter.font = SYSTEM_FONT(AdaptFont(14));
      self.itemParameter.textColor = TextColor_636263;
      self.itemParameter.numberOfLines = 0;
      [self.backView addSubview:self.itemParameter];
      
      [self.itemParameter mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.itemImage.mas_right).offset(WidthRate(10));
          make.right.mas_equalTo(WidthRate(-10));
          make.top.mas_equalTo(self.itemName.mas_bottom).offset(HeightRate(5));
      }];
      
      self.PriceLabel = [[UILabel alloc]init];
      self.PriceLabel.text = @"共%ld件商品     小计：";
      self.PriceLabel.font = SYSTEM_FONT(AdaptFont(14));
      self.PriceLabel.textColor = TextColor_636263;
      self.PriceLabel.numberOfLines = 0;
      [self.backView addSubview:self.PriceLabel];
      
      [self.PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(WidthRate(-20));
          make.height.mas_equalTo(HeightRate(15));
//           make.bottom.mas_equalTo(self.itemParameter.mas_bottom).offset(5);
          make.bottom.mas_equalTo(HeightRate(-19));
      }];
      
      self.downImage = [[UIImageView alloc]init];
      self.downImage.image = [UIImage imageNamed:@"direction_down"];
      [self.backView addSubview:self.downImage];
      
      [self.downImage mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.mas_equalTo(self.backView.mas_centerX);
          make.height.mas_equalTo(WidthRate(14));
          make.width.mas_equalTo(WidthRate(14));
          make.bottom.mas_equalTo(HeightRate(-5));
      }];
      
  }
  return self;
}
- (void)tapBubble{
    if ([self.delegate respondsToSelector:@selector(didTapMessageBubbleWithModel:)]) {
        [self.delegate didTapMessageBubbleWithModel:self.model];
    }
}
- (void)presentCell:(NSString *)eventText {
    
    
  _evenText.text = eventText;
  _evenText.frame = CGRectMake(0, 0, 300, 20);
  
  _evenText.center = CGPointMake(self.contentView.frame.size.width/2,
                                 self.contentView.frame.size.height/2);
  
}
- (void)setData:(YHChatOrderContract *)contract
{
    
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:contract.GoodsSeriesIcon]];
    self.itemName.text = contract.GoodsTitle;
    self.itemParameter.text = contract.GoodsExplain;
    NSString *price = [Tools getHaveNum:contract.ContractAmount.doubleValue];
    NSString  *priceStr  =  [NSString stringWithFormat:@"共%@件商品     合计：¥%@",contract.ContractQuantity, price];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(priceStr.length-price.length-1,price.length+1)];
    
    self.PriceLabel.attributedText = attrStr;
    if (contract.ContractQuantity.integerValue == 1) {
        self.downImage.hidden = YES;
    }else
    {
        self.downImage.hidden = NO;

    }
}
@end
