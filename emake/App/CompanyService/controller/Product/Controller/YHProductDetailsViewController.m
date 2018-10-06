//
//  YHProductDetailsViewController.m
//  emake
//
//  Created by 谷伟 on 2017/11/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHProductDetailsViewController.h"
#import "ProductParametersView.h"
#import "ChatNewViewController.h"
#import "YHShoppingCartNewViewController.h"
#import "YBPopupMenu.h"
#import "Tools.h"

@interface YHProductDetailsViewController ()<YHTitleViewViewDelegete,UIScrollViewDelegate,YBPopupMenuDelegate>
@property (nonatomic,retain)YHTitleView *selectView;
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)NSArray *auxiliary_list;
@property (nonatomic,retain)NSArray *brand_list;
@property (nonatomic,retain)NSDictionary *product_data;
@property (nonatomic,retain)UILabel *labelParameter;
@property (nonatomic,retain)UILabel *labelName;
@property (nonatomic,retain)UILabel *labelPrice;
@property (nonatomic,retain)UILabel *lableCapcity;
@property (nonatomic,retain)UILabel *lableQuality;
@property (nonatomic,retain)UILabel *lineHide;

@property (nonatomic,retain)UIImageView *itemImageView;
@property (nonatomic,retain)UIView *imageTipsView;

@property (nonatomic,retain)UIWebView *imageDetails;
@property (nonatomic,retain)UILabel *labelNumber;
@property (nonatomic,retain)UILabel *labelVolt;
@property (nonatomic,retain)NSMutableArray *brandTitles;
@property (nonatomic,retain)NSMutableArray *accssoryTitles;
@property (nonatomic,retain)NSMutableArray *brandCodes;
@property (nonatomic,retain)NSMutableArray *accssoryCodes;
@property (nonatomic,retain)NSMutableArray *SelectTitles;
@property (nonatomic,retain)NSMutableArray *accssoryPrice;
@property (nonatomic,retain)NSMutableArray *brandRate;
@property (nonatomic,retain)UILabel *labelTax;
@property (nonatomic,retain)ProductParametersView *ParametersView;

@property(nonatomic, strong)NSArray *listArray;
@property(nonatomic, strong)NSArray *listNameArray;

@property(nonatomic, strong)UIButton *tipSButton;
@property(nonatomic, retain)UIView *sepratorBottomView;
@property(nonatomic, retain)UIView *leftView;
@property(nonatomic, retain)UILabel *lineThree;
@property(nonatomic, retain)UILabel *lineFour;
@property(nonatomic, retain)UILabel *lineFive;
@property(nonatomic, retain)UIImageView *paramImageview;

@end

@implementation YHProductDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configTopView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];


    [self.selectView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [NSArray array];
    
    self.listNameArray = [NSArray array];
    // Do any additional setup after loading the view.
    [self configSubViews];
    [self configBottomView];
    [self getProductDeatailsData];
}

- (void)getProductDeatailsData{
    
    [[YHJsonRequest shared] getProductDetailsInfoWith:self.productCode seriesCode:self.productSerialCode successBlock:^(NSDictionary *ProductDetailsDict) {
        self.product_data = ProductDetailsDict ;
        [self updateData];
    } fialureBlock:^(NSString *errorMessages) {
        
    }];
    [self.view showWait:@"loading..." viewType:CurrentView];
    [self getparamData];
}
//GoodsInsurance
-(void)getparamData
{
    [[YHJsonRequest shared] getProductAllPropertyListGoodcode:self.productCode  seriesCode:self.productSerialCode SuccessBlock:^(NSDictionary *successMessage) {
        if (successMessage.count>0) {
            
            self.listArray = [successMessage allValues][0];
            [self.view hideWait:CurrentView];
            
        }
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages];
        [self.view hideWait:CurrentView];
        
    }];
    
    [[YHJsonRequest shared] getProductAllPropertyListNameGoodcode:self.productCode seriesCode:self.productSerialCode SuccessBlock:^(NSArray *successMessage) {
        
        self.listNameArray = successMessage;

    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages];
        
    }];
}

///／关键字tipsbutton
-(void)tipsButtonsUpdata:(NSArray *)tipsArray
{
//    NSArray *arr = @[@"数据数据",@"数句",@"数据数数数据数数数据数数数",@"数数据"];
    CGFloat leftspace = 0;
    CGFloat width = 0;

    for (int i = 0; i <tipsArray.count ; i++) {
        
        
        UIImage *image = [UIImage imageNamed:@"tezhengstar"];
        NSString *title =  tipsArray[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat space1 = 8;
        CGFloat space = i==0?12:3;
        leftspace =leftspace+width+space;

        button.imageEdgeInsets = UIEdgeInsetsMake(space1, 0, space1, 0);
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:ColorWithHexString(@"666666") forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        //    button.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
        [button setBackgroundColor:[UIColor clearColor]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_imageTipsView addSubview:button];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        //根据字体得到nsstring的尺寸
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:AdaptFont(13)],NSFontAttributeName, nil]];
         width =image.size.width+size.width+6;
        if (width>ScreenWidth/4.0) {
            width = ScreenWidth/4.0;
        }
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftspace);
            make.width.mas_equalTo(WidthRate(width));
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(30));
        }];
        
    }
}

- (void)updateData{

//    product关键字
    NSArray *tipsArr = [self.product_data objectForKey:@"GoodsInsurance"];
    [self tipsButtonsUpdata:tipsArr];
    
    self.labelName.text = [self.product_data objectForKey:@"GoodsSeriesName"];
    self.lableQuality.text = [self.product_data objectForKey:@"GoodsQuality"];
    self.labelTax.text = [self.product_data objectForKey:@"GoodsAddValue"];
    NSString *GoodsVoltage =[self.product_data objectForKey:@"GoodsVoltage"];

    
    UIView *one = [self.leftView viewWithTag:1001];
    UILabel *label = [one viewWithTag:200];
    
    UIView *two = [self.leftView viewWithTag:1002];
    UILabel *labelTwo = [two viewWithTag:200];
    UIView *three = [self.leftView viewWithTag:1003];
    UILabel *labelThree = [three viewWithTag:200];
    UIView *four = [self.leftView viewWithTag:1004];
    UIView *five = [self.leftView viewWithTag:1000];
    NSArray *StringArrayAnother = [self.product_data objectForKey:@"GoodsInsurance"];
    if (StringArrayAnother.count>0) {
        NSString *stringSub = [StringArrayAnother[1] substringFromIndex:4];
        labelTwo.text = stringSub;
        label.text = StringArrayAnother[0];
    }else{
        five.hidden = YES;
        one.hidden = YES;
        two.hidden = YES;
        [self.lineFour mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineThree.mas_top);
        }];
    }
    NSArray *StringArray = [self.product_data objectForKey:@"GoodsAfterSale"];
    if (StringArray.count>0) {
        labelThree.text = StringArray[0];
    }else{
        four.hidden = YES;
        three.hidden = true;
        [self.lineFive mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.lineFour.mas_top);
        }];
    }
    
    NSString *GoodsCapacity =[NSString stringWithFormat:@"%@%@",[self.product_data objectForKey:@"GoodsCapacityMin"],[self.product_data objectForKey:@"GoodsCapacityMax"]];
    if (GoodsVoltage.length ==0 && GoodsCapacity.length ==0) {
        [self.lineThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(15));

        }];
        self.lableCapcity.hidden = YES;
        self.labelParameter.hidden = YES;
    }else
    {
        self.labelParameter.text = [self.product_data objectForKey:@"GoodsVoltage"];
        if (  GoodsCapacity.length > 0) {
        self.lableCapcity.text = [NSString stringWithFormat:@"容量：%@-%@kVA",[self.product_data objectForKey:@"GoodsCapacityMin"],[self.product_data objectForKey:@"GoodsCapacityMax"]];;
        }
    }
 
   NSString *GoodsPriceMin = [Tools stringWithDecimalNumber:[[self.product_data objectForKey:@"GoodsPriceMin"] doubleValue]];
       NSString *GoodsPriceMax = [Tools stringWithDecimalNumber:[[self.product_data objectForKey:@"GoodsPriceMax"] doubleValue]];
    
    self.labelPrice.text =[GoodsPriceMin isEqualToString:GoodsPriceMax]?[NSString stringWithFormat:@"¥%@",GoodsPriceMin]:[NSString stringWithFormat:@"¥%@-%@",GoodsPriceMin,GoodsPriceMax];
    self.labelNumber.text = [NSString stringWithFormat:@"月销量：%@笔",[self.product_data objectForKey:@"GoodsSales"]];
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:[self.product_data objectForKey:@"GoodsSeriesIcon"]] placeholderImage:nil];
    [self.imageDetails loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.product_data objectForKey:@"GoodsDetailIcon"]]]];
    
    NSString *paramIamgeStr = self.product_data[@"GoodsStandardIcon"];
    if (paramIamgeStr.length >0) {
        UIImage *paramIamge = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:paramIamgeStr]]];
        
        self.paramImageview.image = paramIamge;
        CGFloat paramIamgeH = paramIamge.size.height*ScreenWidth/paramIamge.size.width;
        [self.paramImageview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(paramIamgeH);
            
        }];
    } else {
        [self.paramImageview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            
        }];
    }
   
    
    
//   通过webview获得的高度更改scroview 的contentsize尺寸，
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect frame = self.imageDetails.frame;
        CGSize fittingSize = [self.imageDetails sizeThatFits:CGSizeZero];
        CGFloat h =fittingSize.height*ScreenWidth/fittingSize.width+frame.origin.y;
        frame.size.height = self.imageDetails.scrollView.contentSize.height;
        self.imageDetails.frame = frame;
        self.sepratorBottomView.frame = CGRectMake(0, frame.origin.y+frame.size.height, ScreenWidth, HeightRate(46));
        self.scrollView.contentSize = CGSizeMake(0, h+HeightRate(45));
//        self.scrollView.backgroundColor = [UIColor redColor];
//        [self.imageDetails sizeToFit];
        
    });
    
    self.SelectTitles = [NSMutableArray arrayWithCapacity:0];
    self.brandTitles = [NSMutableArray arrayWithCapacity:0];
    self.accssoryTitles = [NSMutableArray arrayWithCapacity:0];
    self.brandTitles = [NSMutableArray arrayWithCapacity:0];
    self.brandRate = [NSMutableArray arrayWithCapacity:0];
    self.accssoryPrice = [NSMutableArray arrayWithCapacity:0];
    self.accssoryCodes = [NSMutableArray arrayWithCapacity:0];
    self.brandCodes = [NSMutableArray arrayWithCapacity:0];
    if (self.brand_list.count > 0) {
        for (NSDictionary *object in self.brand_list) {
            if (object){
                [self.brandTitles addObject:[object valueForKey:@"ProductName"]];
                [self.brandCodes addObject:[object valueForKey:@"ProductId"]];
                [self.brandRate addObject:[object valueForKey:@"ProductRate"]];
            }
        }
    }
    if (self.auxiliary_list.count > 0) {
        for (NSDictionary *object in self.auxiliary_list) {
            if (object){
                [self.accssoryTitles addObject:[object valueForKey:@"ProductName"]];
                [self.accssoryCodes addObject:[object valueForKey:@"ProductId"]];
                [self.accssoryPrice addObject:[object valueForKey:@"ProductPrice"]];
            }
        }
    }
  
    
}
- (void)configBottomView{
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(50));
    }];
    
    UIButton *addItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addItemBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [addItemBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addItemBtn addTarget:self action:@selector(showSelectView) forControlEvents:UIControlEventTouchUpInside];
    addItemBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [bottomView addSubview:addItemBtn];
    
    [addItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(159));
    }];
    
    UIView *viewOne = [self bottomBtnView:[UIImage imageNamed:@"tab_service"] andTitle:@"客服" withTag:100];
    [bottomView addSubview:viewOne];
    
    [viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(108));
    }];
    
    UIView *viewTwo = [self bottomBtnView:[UIImage imageNamed:@"gouwuche-bs"] andTitle:@"购物车" withTag:101];
    [bottomView addSubview:viewTwo];
    
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(viewOne.mas_right);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(addItemBtn.mas_left);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = SepratorLineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}
- (void)configSubViews{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight-60-HeightRate(50))];
    self.scrollView.contentSize =CGSizeMake(0, ScreenHeight*6+486);
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.alwaysBounceHorizontal = false;
    self.scrollView.delegate = self;
    self.scrollView.tag = 100;
    [self.view addSubview:self.scrollView];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66-HeightRate(50))];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:leftView];
    self.leftView = leftView;

   
    UIScrollView * scrollImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(245))];
    scrollImageView.contentSize =CGSizeMake(ScreenWidth*1,0);
    scrollImageView.alwaysBounceVertical = YES;
    scrollImageView.scrollEnabled = NO;
    scrollImageView.showsVerticalScrollIndicator = false;
    scrollImageView.showsHorizontalScrollIndicator = true;
    scrollImageView.alwaysBounceHorizontal = false;
    scrollImageView.pagingEnabled = YES;
    scrollImageView.delegate = self;
    scrollImageView.tag = 110;
    [leftView addSubview:scrollImageView];
    
    self.itemImageView = [[UIImageView alloc]init];
    self.itemImageView.contentMode =  UIViewContentModeScaleAspectFit ;
    self.itemImageView.clipsToBounds = YES;

    [scrollImageView addSubview:self.itemImageView];
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(245-30));
    }];
    
    UIView *imageTipsView = [[UIView alloc] init];
    imageTipsView.backgroundColor = ColorWithHexString(@"F3F3F3");
    [scrollImageView addSubview:imageTipsView];
    [imageTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(self.itemImageView.mas_bottom);
        make.height.mas_equalTo(HeightRate(30));
        
    }];
    
    self.imageTipsView = imageTipsView;
    
  
    UILabel *lineOne = [[UILabel alloc]init];
    lineOne.backgroundColor = SepratorLineColor;
    [self.leftView addSubview:lineOne];
    
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imageTipsView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    

    self.labelName = [[UILabel alloc]init];
    self.labelName.font = [UIFont systemFontOfSize:AdaptFont(16)];
    [self.leftView addSubview:self.labelName];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(12));
        make.height.mas_equalTo(HeightRate(24));
    }];
    UILabel *labelQuilty = [[UILabel alloc] init];
    labelQuilty.text = @"";
    labelQuilty.font = [UIFont systemFontOfSize:AdaptFont(13)];
    labelQuilty.textColor = TextColor_636263;
    labelQuilty.hidden = true;
    labelQuilty.textAlignment = NSTextAlignmentLeft;
    [self.leftView addSubview:labelQuilty];
    [labelQuilty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labelName.mas_centerY);
        make.left.mas_equalTo(self.labelName.mas_right).offset(10);
        make.height.mas_equalTo(HeightRate(24));
    }];
    self.lableQuality = labelQuilty;
    
    self.labelNumber = [[UILabel alloc]init];
    self.labelNumber.textColor = TextColor_BBBBBB;
    self.labelNumber.font = SYSTEM_FONT(AdaptFont(14));
    [self.leftView addSubview:self.labelNumber];
    
    [self.labelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(HeightRate(23));
        make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(10));
    }];
    
    self.labelPrice = [[UILabel alloc]init];
    self.labelPrice.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    self.labelPrice.font = SYSTEM_FONT(AdaptFont(20));
    [self.leftView addSubview:self.labelPrice];
    
    [self.labelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-16));
        make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(3));
        make.height.mas_equalTo(HeightRate(29));
    }];
    
    self.labelTax = [[UILabel alloc]init];
    self.labelTax.text =[NSString stringWithFormat:@"含17%%增值税、不含运费"];
    self.labelTax.font = [UIFont systemFontOfSize:AdaptFont(13)];
    self.labelTax.textColor = ColorWithHexString(SymbolTopColor);
    [self.leftView addSubview:self.labelTax];
    
    [self.labelTax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labelPrice.mas_bottom).offset(HeightRate(5));
        make.height.mas_equalTo(HeightRate(19));
        make.right.mas_equalTo(WidthRate(-16));
    }];
    
    UILabel *lineTwo = [[UILabel alloc]init];
    lineTwo.backgroundColor = SepratorLineColor;
    [self.leftView addSubview:lineTwo];
    
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.labelTax.mas_bottom).offset(HeightRate(5));
    }];

    self.labelParameter =[[UILabel alloc]init];
    self.labelParameter.textColor = TextColor_636263;
    self.labelParameter.font = SYSTEM_FONT(AdaptFont(13));
    self.labelParameter.numberOfLines = 0;
    [self.leftView addSubview:self.labelParameter];
    
    [self.labelParameter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(lineTwo.mas_bottom).offset(HeightRate(3));
        make.height.mas_equalTo(HeightRate(25));
        make.width.mas_equalTo(WidthRate(135));
    }];
    
    self.lableCapcity=[[UILabel alloc]init];
    self.lableCapcity.textColor = TextColor_636263;
    self.lableCapcity.font = SYSTEM_FONT(AdaptFont(13));
    [self.leftView addSubview:self.lableCapcity];
    
    [self.lableCapcity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labelParameter.mas_right).offset(WidthRate(48));
        make.centerY.mas_equalTo(self.labelParameter.mas_centerY);
        make.height.mas_equalTo(HeightRate(25));
    }];
    self.lineThree = [[UILabel alloc]init];
    self.lineThree.backgroundColor = SepratorLineColor;
    [self.leftView addSubview:self.lineThree];
    [self.lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.labelParameter.mas_bottom).offset(HeightRate(5));
    }];
    self.lineHide = self.lineThree;

    UIView *viewOne = [self serverViewWithServersName:@"质量保障" imageName:@"zhiliangbaozhang-icon" imageSize:CGSizeMake(16, 16) titleColor:ColorWithHexString(@"000000") titleFont:14 isAdjust:false isWithPicc:false];
    viewOne.tag = 1000;
    [self.leftView addSubview:viewOne];
    
    [viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(self.lineThree.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRate(25));
    }];
    
    UIView *viewFirst = [self serverViewWithServersName:@"平台质保一年" imageName:@"yuandian6x6" imageSize:CGSizeMake(8, 8) titleColor:ColorWithHexString(@"000000") titleFont:13 isAdjust:YES isWithPicc:false];
    viewFirst.tag = 1001;
    [self.leftView addSubview:viewFirst];
    
    [viewFirst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(viewOne.mas_bottom).offset(HeightRate(3));
        make.height.mas_equalTo(HeightRate(25));
        make.right.mas_equalTo(5);
    }];
    
    UIView *viewOne1 = [self serverViewWithServersName:@"人保提供1年期产品质量保险，产品1年内出现质量问题，人保按保额赔付90% " imageName:@"yuandian6x6" imageSize:CGSizeMake(8, 8) titleColor:ColorWithHexString(@"000000") titleFont:13 isAdjust:YES isWithPicc:true];
    viewOne1.tag = 1002;
    [self.leftView addSubview:viewOne1];
    
    [viewOne1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(viewFirst.mas_bottom).offset(HeightRate(3));
        make.height.mas_equalTo(HeightRate(25));
        make.right.mas_equalTo(-WidthRate(30));
    }];

    
    self.lineFour = [[UILabel alloc]init];
    self.lineFour.backgroundColor = SepratorLineColor;
    [self.leftView addSubview:self.lineFour];
    [self.lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(viewOne1.mas_bottom).offset(HeightRate(10));
    }];
    
    UIView *viewTwo = [self serverViewWithServersName:@"售后服务" imageName:@"shouhoufuwu-icon" imageSize:CGSizeMake(16, 16) titleColor:ColorWithHexString(@"000000") titleFont:14 isAdjust:false isWithPicc:false];
    viewTwo.tag = 1004;
    [self.leftView addSubview:viewTwo];
    
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(self.lineFour.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRate(25));
    }];
    UIView *viewTwo1 = [self serverViewWithServersName:@"专业机构提供全国范围售后服务，10分钟响应，8小时到达现场。" imageName:@"yuandian6x6" imageSize:CGSizeMake(8, 8) titleColor:ColorWithHexString(@"000000") titleFont:13 isAdjust:YES isWithPicc:false];
    viewTwo1.tag = 1003;
    [self.leftView addSubview:viewTwo1];
    
    [viewTwo1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(viewTwo.mas_bottom).offset(HeightRate(3));
        make.height.mas_equalTo(HeightRate(25));
        make.right.mas_equalTo(-WidthRate(30));
    }];

    self.lineFive = [[UILabel alloc]init];
    self.lineFive.backgroundColor = SepratorLineColor;
    [self.leftView addSubview:self.lineFive];
    
    [self.lineFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(viewTwo1.mas_bottom).offset(HeightRate(8));
    }];
    
    UIView *sepratorTopView = [[UIView alloc]init];
    [self.leftView addSubview:sepratorTopView];
    
    [sepratorTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.lineFive.mas_bottom).offset(HeightRate(0));
        make.height.mas_equalTo(HeightRate(41));
    }];
    
    UIImageView *imageDown = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_down"]];
    [sepratorTopView addSubview:imageDown];
    
    [imageDown mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(WidthRate(118));
        make.width.mas_equalTo(WidthRate(14));
        make.height.mas_equalTo(WidthRate(14));
        make.centerY.mas_equalTo(sepratorTopView.mas_centerY);
    }];
    
    UILabel *labelTips =[[UILabel alloc]init];
    labelTips.textColor = TextColor_636263;
    labelTips.font = SYSTEM_FONT(AdaptFont(13));
    labelTips.text = @"上拉查看图文详情";
    [sepratorTopView addSubview:labelTips];
    
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(imageDown.mas_right).offset(WidthRate(12));
        make.height.mas_equalTo(WidthRate(19));
        make.centerY.mas_equalTo(sepratorTopView.mas_centerY);
    }];
    

    UIImageView *paramIamgeview = [[UIImageView alloc] init];
    [self.scrollView addSubview:paramIamgeview];
    [paramIamgeview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WidthRate(100));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(labelTips.mas_bottom);
        make.left.mas_equalTo(0);
        
    }];
    self.paramImageview = paramIamgeview;
    
    self.imageDetails = [[UIWebView alloc]init];
    self.imageDetails.scalesPageToFit = YES;
     self.imageDetails.opaque = NO;
    self.imageDetails.backgroundColor = [UIColor clearColor];
    [self.leftView addSubview:self.imageDetails];
    self.imageDetails.scrollView.bounces = NO;
    self.imageDetails.scrollView.showsHorizontalScrollIndicator = NO;
    self.imageDetails.scrollView.scrollEnabled = NO;

    
    [self.imageDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(paramIamgeview.mas_bottom).offset(HeightRate(0));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(50));
    }];
    
    self.sepratorBottomView = [[UIView alloc]init];
    [self.leftView addSubview:self.sepratorBottomView];
    
    [self.sepratorBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.imageDetails.mas_bottom).offset(0);
        make.height.mas_equalTo(HeightRate(44));
    }];
    
    UIImageView *imageEnd = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"end"]];
    [self.sepratorBottomView addSubview:imageEnd];
    
    [imageEnd mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(WidthRate(11));
        make.centerY.mas_equalTo(self.sepratorBottomView.mas_centerY);
    }];
    
}
- (void)configTopView{
    

    [self addRigthDetailButtonIsShowCart:YES];
    NSArray *titles =[NSArray arrayWithObjects:@"商品",@"参数",@"详情",nil];
    self.selectView = [[YHTitleView alloc]initWithFrame:CGRectMake(0, 20, WidthRate(120), 39) titleFont:16 delegate:self andTitleArray:titles];
    self.selectView.backgroundColor = ColorWithHexString(StatusAndTopBarBackgroundColor);
    [self.navigationController.view addSubview:self.selectView];
    
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.navigationController.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(120));
        make.height.mas_equalTo(TOP_BAR_HEIGHT-20);
        make.top.mas_equalTo(20);
    }];
    
    

}
- (UIView *)serverViewWithServersName:(NSString*)serversName imageName:(NSString *)imageName imageSize:(CGSize)size titleColor:(UIColor *)color titleFont:(NSInteger)font isAdjust:(BOOL)adjust isWithPicc:(BOOL)isPicc{
    
    UIView *serverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(80), HeightRate(25))];
    UIImageView *selectImage = [[UIImageView alloc]init];
    selectImage.image = [UIImage imageNamed:imageName];
    [serverView addSubview:selectImage];
    selectImage.contentMode = UIViewContentModeScaleAspectFit;
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(size.width));
        make.height.mas_equalTo(WidthRate(size.height));
        make.top.mas_equalTo(0);
    }];
    UIImageView *piccImage = [[UIImageView alloc]init];
    piccImage.image = [UIImage imageNamed:@"logo-rencai-picc"];
    if (isPicc){
        [serverView addSubview:piccImage];
        piccImage.contentMode = UIViewContentModeScaleAspectFit;
        [piccImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(selectImage.mas_right).offset(WidthRate(5));
            make.width.mas_equalTo(WidthRate(26));
            make.height.mas_equalTo(HeightRate(10));
            make.top.mas_equalTo(0);
        }];
    }

    UILabel *labelServers = [[UILabel alloc]init];
    labelServers.text = serversName;
    labelServers.font = SYSTEM_FONT(AdaptFont(font));
    labelServers.textColor = color;
    labelServers.tag = 200;
    [serverView addSubview:labelServers];
    labelServers.numberOfLines = 0;
    
    [labelServers mas_makeConstraints:^(MASConstraintMaker *make) {\
        if (isPicc) {
            make.left.mas_equalTo(piccImage.mas_right).offset(WidthRate(5));
        }else{
            make.left.mas_equalTo(selectImage.mas_right).offset(WidthRate(10));
        }
        
        make.right.mas_equalTo(-6);
        if (adjust) {
            make.top.mas_equalTo(-HeightRate(2));
        }else{
            make.top.mas_equalTo(0);
        }
    }];
    return serverView;
}
- (UIView *)bottomBtnView:(UIImage *)image andTitle:(NSString *)title withTag:(NSInteger)tag{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIImageView *imageIcon = [[UIImageView alloc]init];
    imageIcon.image = image;
    [view addSubview:imageIcon];
    
    [imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.height.mas_equalTo(WidthRate(20));
        make.width.mas_equalTo(WidthRate(20));
        make.top.mas_equalTo(HeightRate(6));
    }];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.width.mas_equalTo(WidthRate(27));
        make.height.mas_equalTo(HeightRate(27));
        make.top.mas_equalTo(0);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = title;
    titleLabel.font = SYSTEM_FONT(AdaptFont(12));
    [view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(23));
    }];
    return view;
}
- (void)showSelectView{

    NSString *url= self.product_data[@"GoodsSeriesIcon"];
    NSString *GoodsPriceMin = [Tools stringWithDecimalNumber:[[self.product_data objectForKey:@"GoodsPriceMin"] doubleValue]];
    NSString *GoodsPriceMax = [Tools stringWithDecimalNumber:[[self.product_data objectForKey:@"GoodsPriceMax"] doubleValue]];
    NSString *Price =[GoodsPriceMin isEqualToString:GoodsPriceMax]?[NSString stringWithFormat:@"¥%@",GoodsPriceMin]:[NSString stringWithFormat:@"¥%@-%@",GoodsPriceMin,GoodsPriceMax];

    if (self.listArray.count>0 && self.listNameArray.count>0) {
      self.ParametersView = [[ProductParametersView alloc]initWithItemImage:url PriceValue:Price taxDecription: [self.product_data objectForKey:@"GoodsAddValue"] largeArray:self.listArray andTitleArray:self.listNameArray];
    
   self.ParametersView.GoodsInsuranceId =self.product_data[@"GoodsInsuranceId"];
    self.ParametersView.GoodsInsuranceRate =self.product_data[@"GoodsInsuranceRate"];

    __weak typeof(self) weakSelf = self;
    self.ParametersView.confirmBlock = ^(NSArray *productIds, NSInteger numberOfItem) {
 
        [weakSelf addGoodsToShoppingCart:numberOfItem productIds:productIds];
    };
    [self.ParametersView showAnimated];
    }else{
        [self.view showWait:@"loading..." viewType:CurrentView];
        [self getparamData];
        
    }
}
- (void)addGoodsToShoppingCart:(NSInteger)number productIds:(NSArray *)productIds{
    
    if (productIds.count ==0) {
        [self.ParametersView removeView];

        [self.view makeToast:@"该型号的产品参数出现异常，不能加入购物车"];

        return;
    }
    NSDictionary *dic = @{@"GoodsSeriesCode":self.productSerialCode,@"ProductIds":productIds,@"GoodsNumber":@(number)};
    [[YHJsonRequest shared] addShoppinCartWithParams:dic SuccessBlock:^(NSString *successMessage){
        [self.ParametersView removeView];
        UIView *showView = [self.view customShowAlert:@"添加购物车成功，在购物车等亲" image:@"pop_success"];
        [self.view showToast:showView duration:1 position:CSToastPositionCenter completion:^(BOOL didTap) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonRefreshCartData object:nil];
        }];
    } fialureBlock:^(NSString *errorMessages){
        [self.ParametersView removeView];
        [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
    }];
}

- (void)buttonClick:(UIButton *)sender{
    switch (sender.tag) {
        case 100:{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
            ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 101:{
            YHShoppingCartNewViewController *vc = [[YHShoppingCartNewViewController alloc]init];
            vc.number = self.cartNumber;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---YHTitleView
- (void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index{
    NSLog(@"indek====%ld",(long)index);
    switch (index) {
        case 0:
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
        {
            CGFloat h = self.paramImageview.frame.origin.y;
            [self.scrollView setContentOffset:CGPointMake(0, h) animated:YES];
            NSLog(@"paramImageview%lf",h);
            ;
        }
            break;
        case 2:
        {
            CGFloat h = _imageDetails.frame.origin.y;
            [self.scrollView setContentOffset:CGPointMake(0, h) animated:YES];
            NSLog(@"_imageDetails%lf",h);

        }
            break;
        default:
            break;
    }
}
#pragma mark----UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    UIButton *topbutton = [self TopButton:self.view];
    [topbutton addTarget:self action:@selector(top) forControlEvents:UIControlEventTouchUpInside];
    CGFloat h = _imageDetails.frame.origin.y;
    CGFloat paramH = _paramImageview.frame.origin.y;
    NSLog(@".contentOffset.y==%lf",scrollView.contentOffset.y);
    if(scrollView.contentOffset.y >= h ) {
            [self.selectView ChageItemWithIndex:2];

      CGFloat  h1 = _imageDetails.frame.size.height-150;

//     判断  显示回到顶部的按钮
        if (scrollView.contentOffset.y >= h1-150 && h1>ScreenHeight ) {
            topbutton.hidden = NO;

        }else
        {
                    topbutton.hidden =YES;

        }


    }else if(scrollView.contentOffset.y >= paramH)
    {

        [self.selectView ChageItemWithIndex:1];

        topbutton.hidden =YES;

    }else
    {
        [self.selectView ChageItemWithIndex:0];
        topbutton.hidden =YES;

    }

    
}
-(void)top
{
     CGFloat h = _imageDetails.frame.origin.y;
    [UIView animateWithDuration:.1 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, h);
        [self.selectView ChageItemWithIndex:1];
    }];
}
-(void)dealloc
{
    self.imageDetails.delegate = nil;
    [self cleanCacheAndCookie];
    
}

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
