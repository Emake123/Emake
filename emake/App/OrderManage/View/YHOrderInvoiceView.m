//
//  YHOrderInvoiceView.m
//  emake
//
//  Created by eMake on 2017/9/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderInvoiceView.h"
@implementation YHOrderInvoiceView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = ColorWithHexString(@"ffffff");
        

        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        [self.contentView addSubview:lable];
        
        UILabel *lable1 = [self getPagramView:self.contentView item:lable isLine:NO name:@"合同编号:" placeholdName:@"2007062300001" top:2];
        UILabel *lable2 =  [self getPagramView:self.contentView item:lable1 isLine:NO name:@"合同总金额:" placeholdName:@"54000.00" top:2];
        UILabel *lable3 =  [self getPagramView:self.contentView item:lable2 isLine:NO name:@"可开票金额:" placeholdName:@"200000000" top:2];
        UILabel *bglable = [[UILabel alloc]init];
        bglable.translatesAutoresizingMaskIntoConstraints = NO;
        bglable.backgroundColor = ColorWithHexString(@"D3D2D2");//ColorWithHexString(BASE_FAINTLY_COLOR);
        [self.contentView addSubview:bglable];

        
        [bglable PSSetSize:ScreenWidth Height:HeightRate(5)];
        [bglable PSSetBottomAtItem:lable3 Length:HeightRate(5)];
    
        UILabel *lable4 = [self getPagramView:self.contentView item:bglable isLine:YES name:@"发票类型:" placeholdName:@"增值税专用纸质发票" top:10];
        UITextField *lable5 =  [self getPagramView:self.contentView item:lable4 isLine:YES name:@"发票抬头:" placeholdName:@"南京xxxx有限公司" top:5];
        UITextField *lable6 =  [self getPagramView:self.contentView item:lable5 isLine:YES name:@"企业税号:" placeholdName:@"请填入企业纳税人识别号" top:5];
        UITextField *lable7 =  [self getPagramView:self.contentView item:lable6 isLine:YES name:@"银行开户行:" placeholdName:@"请填入企业纳税人开户行" top:5];
        UITextField *lable8 =  [self getPagramView:self.contentView item:lable7 isLine:YES name:@"联系人、联系电话:" placeholdName:@"请填入企业纳税人联系电话" top:5];
        UITextField *lable9 =  [self getPagramView:self.contentView item:lable8 isLine:YES name:@"邮寄地址:" placeholdName:@"请填入企业纳税人地址" top:5];
        UITextField *lable10 =  [self getPagramView:self.contentView item:lable9 isLine:YES name:@"联系人:" placeholdName:@"请填入联系人" top:5];
        UITextField *lable11 =  [self getPagramView:self.contentView item:lable10 isLine:YES name:@"手机:" placeholdName:@"请填入联系人手机" top:5];
        
        UILabel *bglable2 = [[UILabel alloc]init];
        bglable2.translatesAutoresizingMaskIntoConstraints = NO;
        bglable2.backgroundColor = ColorWithHexString(@"D3D2D2");//SepratorLineColor;
        [self.contentView addSubview:bglable2];
        
        
        [bglable2 PSSetSize:ScreenWidth Height:HeightRate(5)];
        [bglable2 PSSetBottomAtItem:self Length:HeightRate(-4)];
        self.lbContractNumber = lable1;
        self.lbContractAllPrice = lable2;
        self.lbGetPrice = lable3;
        self.lbKind = lable4;
        self.tfStart =lable5;
        self.tfNumber =lable6;
        self.tfBank =lable7;
        self.tfContactPhone =lable8;
        self.tfAddress =lable9;
        self.tfContact =lable10;
        self.tfPhone =lable11;
    }
    
    return self;
}

-(id)getPagramView:(UIView *)view item:(id)item isLine:(BOOL)isline name:(NSString *)name placeholdName:(NSString *)place top:(CGFloat)top
{
    
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.translatesAutoresizingMaskIntoConstraints = NO;
    lbTitle.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [lbTitle setTextColor:[UIColor colorWithHexString:@"000000"]];
    [view addSubview:lbTitle];

    [lbTitle setText:name];
    [lbTitle setTextAlignment:NSTextAlignmentLeft];
    lbTitle.adjustsFontSizeToFitWidth =YES;
    [lbTitle PSSetLeft:WidthRate(16)];
    [lbTitle PSSetBottomAtItem:item Length:HeightRate(top)];
    
    if (isline == NO) {
        
        [lbTitle PSSetSize:WidthRate(110) Height:HeightRate(32)];

    UILabel * lbCapacity =  [[UILabel alloc] init];
    lbCapacity.translatesAutoresizingMaskIntoConstraints = NO;
    lbCapacity.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [lbCapacity setTextColor:[UIColor colorWithHexString:@"000000"]];
    [lbCapacity setText:place];
    lbCapacity.userInteractionEnabled = YES;
    [view addSubview:lbCapacity];
        [lbCapacity PSSetRightAtItem:lbTitle Length:WidthRate(12)];
        [lbCapacity PSSetWidth:WidthRate(150)];
        return lbTitle;

     }
    else {
        [lbTitle PSSetSize:WidthRate(110) Height:HeightRate(35)];

        UITextField * lbCapacity =  [[UITextField alloc] init];
        lbCapacity.translatesAutoresizingMaskIntoConstraints = NO;
        lbCapacity.font = [UIFont systemFontOfSize:12];
        [lbCapacity setPlaceholder:place];
        lbCapacity.userInteractionEnabled = YES;
        [view addSubview:lbCapacity];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = ColorWithHexString(BASE_LINE_COLOR);
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [view  addSubview:line];
        
        if ([name isEqualToString:@"手机:"]) {
            
        }else
        {
            [line PSSetBottomAtItem:lbCapacity Length:HeightRate(3)];
            [line PSSetLeft:WidthRate(10)];
            [line PSSetHeight:1];
            [line PSSetWidth:WidthRate(329)];

        }
        
        [lbCapacity PSSetRightAtItem:lbTitle Length:WidthRate(12)];
        [lbCapacity PSSetWidth:WidthRate(150)];

        return lbCapacity;
    }
}

@end
