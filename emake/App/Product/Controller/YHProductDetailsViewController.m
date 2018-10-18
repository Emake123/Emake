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
#import "YHGoodsModel.h"
#import "YHCommonWebViewController.h"
#import "YHLoginViewController.h"
#import "YHShareView.h"
#import "PSButtonBase.h"
#import "YHStoreDetailViewController.h"
#import "YHMineMemberInterestViewController.h"
#import "YHProductCloudsViewController.h"
@interface YHProductDetailsViewController ()<YHTitleViewViewDelegete,UIScrollViewDelegate,YBPopupMenuDelegate>
{
    UIView *bottomView;
    BOOL isCollection;
    NSString * CollectionRefNo;

}
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
@property(nonatomic, retain)UIWebView *paramImageWebview;

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
@property(nonatomic, retain)PSButtonTextDonw *shareButton;
@property(nonatomic, retain)PSButtonTextDonw *collectionButton;

@property(nonatomic, retain)UIImageView *collectImageview;
@property(nonatomic, retain)UIView *seviceView;
@property(nonatomic, retain)UILabel *memberShipLable;
@property(nonatomic, retain)UIScrollView *imageScrollView;
@property(nonatomic, retain)UIView *VipView;

//@property(nonatomic, assign)BOOL isStore;

@end

@implementation YHProductDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = [NSArray array];
    self.listNameArray = [NSArray array];
    // Do any additional setup after loading the view.
    [self configTopView];
    [self configSubViews];
    [self configBottomView];
    [self getProductDeatailsData];
    if (self.CategoryBId.length>0) {
        [[NSUserDefaults standardUserDefaults] setObject:self.CategoryBId forKey:USERSELECCATEGORY];

    }


}
#pragma mark--- 获取数据 并刷新UI
- (void)getProductDeatailsData{
    [self.view showWait:@"loading..." viewType:CurrentView];
    
    
    [[YHJsonRequest shared] getProductDetailsInfoWith:self.GoodsSeriesCode seriesCode:nil successBlock:^(NSDictionary *ProductDetailsDict) {
        [self.view hideWait:CurrentView];
        
        self.product_data = ProductDetailsDict ;
        [self share];
        
        [self updateData];
        
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        
    }];
    [self getparamData];
    
}
//GoodsInsurance
-(void)getparamData
{
    [[YHJsonRequest shared] getProductAllPropertyListGoodcode:self.GoodsSeriesCode  seriesCode:self.productSerialCode SuccessBlock:^(NSDictionary *successMessage) {
        if (successMessage.count>0) {
            
            self.listArray = successMessage[@"product_dict"];
            self.listNameArray = successMessage[@"menu_list"];
            
        }else
        {
            [self.view makeToast:@"该商品已经售完" duration:1.5 position:CSToastPositionCenter];
            
        }
        [self.view hideWait:CurrentView];
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];
        
    }];
    
    //    [[YHJsonRequest shared] getProductAllPropertyListNameGoodcode:self.productCode seriesCode:self.productSerialCode SuccessBlock:^(NSArray *successMessage) {
    //
    //        self.listNameArray = successMessage;
    //
    //    } fialureBlock:^(NSString *errorMessages) {
    //        [self.view makeToast:errorMessages];
    //
    //    }];
}

///／关键字tipsbutton
-(void)tipsButtonsUpdata:(NSArray *)tipsArray
{
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
        [button setBackgroundColor:[UIColor clearColor]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_imageTipsView addSubview:button];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        //根据字体得到nsstring的尺寸
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:AdaptFont(13)],NSFontAttributeName, nil]];
        width =image.size.width+size.width+6;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftspace);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(30));
        }];
        
    }
}

- (void)updateData{
    
    NSString *IsPriceTax = self.product_data[@"IsPriceTax"];//1 bian 0休闲食品
    NSNumber *catagoryState = Userdefault(CatagoryVipState);
//    NSInteger vipStatess = catagoryState.integerValue;
  
   NSInteger vipStatess =  [Tools SaveLocalVipstateWithCatagory:nil];
    
    NSString *HidenVip = Userdefault(HidenCatagoryVip);
    if (vipStatess !=0 || HidenVip.integerValue==0) {
        [self.VipView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(0.01));
            
        }];
        self.VipView.hidden =  YES;
    }
    
    
    NSArray *imageArr = [Tools stringToJSON:self.product_data[@"GoodsSeriesPhotos"]];
     self.imageScrollView.contentSize = CGSizeMake(ScreenWidth*(imageArr.count>0?imageArr.count:1),0);
    UIImageView *itemImageView1;
    for (int i=0;i<imageArr.count;i++) {
        NSString *imageStr = imageArr[i];
        UIImageView *itemImageView = [[UIImageView alloc]init];
        itemImageView.contentMode =  UIViewContentModeScaleAspectFit ;
        itemImageView.clipsToBounds = YES;
        //        itemImageView.image = [UIImage imageNamed:@"placehold"];
        [itemImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        
        [ self.imageScrollView addSubview:itemImageView];
        [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ScreenWidth*(i));
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(215));
        }];
        itemImageView1 = itemImageView;
    }
    //    product关键字
    NSString *tipsStr = [self.product_data objectForKey:@"GoodsSeriesKeywords"];
    if (tipsStr.length > 0) {
        NSArray * tipsArr = [tipsStr componentsSeparatedByString:@"|"];
        [self tipsButtonsUpdata:tipsArr];
    }else
    {        [self tipsButtonsUpdata:@[]];
        
        [self.imageTipsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.001);
        }];
    }
    
    self.labelName.text =  [self.product_data objectForKey:@"GoodsSeriesName"];
    
    self.labelTax.text =IsPriceTax.integerValue==1? [self.product_data objectForKey:@"GoodsAddValue"]:[self.product_data objectForKey:@"GoodsAddValue2"];
    
    
    if (IsPriceTax.boolValue == YES) {
    
        NSString *GoodsQualityArrayStr =[self.product_data objectForKey:@"GoodsQuality"];
        CGFloat seviceItemHeight =    [self getSeviceView:GoodsQualityArrayStr ServersName:@"质量保障" imageName:@"zhiliangbaozhang-icon"  TopSpace:0];
        NSString *GoodsAfterSaleArrayStr =[self.product_data objectForKey:@"GoodsAfterSale"];
        CGFloat seviceItemHeight1 =    [self getSeviceView:GoodsAfterSaleArrayStr ServersName:@"售后服务" imageName:@"shouhoufuwu-icon" TopSpace:seviceItemHeight];
        
        [self.seviceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate((seviceItemHeight + seviceItemHeight1)));
        }];
        
    }else
    {
        [self.seviceView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate((0.01)));
        }];
        
    }
    
    
    
    //    根据数据展示是否收藏
    NSString *isCollect = self.product_data[@"IsCollected"];
    isCollection =  [isCollect isEqualToString:@"1"];
    NSString *imageStr = isCollection?@"shoucang-s":@"shangpinxiangqing_shoucang";
    self.collectImageview.image = [UIImage imageNamed:imageStr];
    [self.collectionButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    CollectionRefNo = self.product_data[@"CollectionRefNo"];
    
    
    NSString *paramsStr = [self.product_data objectForKey:@"GoodsSeriesParams"];
    NSArray *paramsArr = [Tools stringToJSON:paramsStr];
    if (paramsArr.count>0) {
        for (int i = 0;i < paramsArr.count;i++) {
            if (i==0) {
                NSDictionary *dict = paramsArr[i];
                self.labelParameter.text = [NSString stringWithFormat:@"%@:%@",dict[@"ParamName"],dict[@"ParamValue"]];
            }else
            {
                NSDictionary *dict = paramsArr[i];
                self.lableCapcity.text = [NSString stringWithFormat:@"%@:%@",dict[@"ParamName"],dict[@"ParamValue"]];
            }
            
        }
        
    }else
    {
        self.labelParameter.hidden = YES;
        self.lableCapcity.hidden = YES;
        [self.lineThree mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.memberShipLable.mas_bottom).offset(HeightRate(0));
        }];
        
    }
    
    
    
    self.labelPrice.text = [self.product_data objectForKey:@"PriceRange"];
    
    self.labelNumber.text = [NSString stringWithFormat:@"销量：%@笔",[self.product_data objectForKey:@"GoodsSale"]];
    
    
    [self getWebViewHeight];
    
}

-(void)getWebViewHeight
{
    
  
    NSString *paramUrlStr =[self.product_data objectForKey:@"GoodsStandardIcon"];
    NSString *detailUrlStr =[self.product_data objectForKey:@"GoodsSeriesDetail"];
    if ([paramUrlStr hasPrefix:@"http"]) {
        [self.paramImageWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:paramUrlStr]] ];
        [self.imageDetails loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:detailUrlStr]] ];

    }else
    {
        [self.paramImageWebview loadHTMLString:paramUrlStr baseURL:nil];
        [self.imageDetails loadHTMLString:detailUrlStr baseURL:nil];
    }
    
    self.paramImageWebview.scalesPageToFit = YES;
    self.paramImageWebview.userInteractionEnabled = false;
  
    
    //   通过webview获得的高度更改scroview 的contentsize尺寸，
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGRect frame1 = self.paramImageWebview.frame;
        CGSize fittingSize1 = [self.paramImageWebview sizeThatFits:CGSizeZero];
        CGFloat h1 =fittingSize1.height*ScreenWidth/fittingSize1.width+frame1.origin.y;
        
        CGFloat startH = frame1.origin.y+self.paramImageWebview.scrollView.contentSize.height;
        frame1.size.height = self.paramImageWebview.scrollView.contentSize.height;
        [self.paramImageWebview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(frame1.size.height);
            make.width.mas_equalTo(ScreenWidth);
        }];
        
        UIView *touchview1 = [[UIView alloc] initWithFrame:frame1];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwoTimesClick:)];
        touchview1.tag = 2;
        [touchview1 addGestureRecognizer:tap1];
        
        [self.scrollView addSubview:touchview1];
        [touchview1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(frame1.size.height);
            make.width.mas_equalTo(ScreenWidth);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.paramImageWebview.mas_top).offset(0);
        }];
        CGRect frame = self.imageDetails.frame;
        CGSize fittingSize = [self.imageDetails sizeThatFits:CGSizeZero];
        frame.size.height = self.imageDetails.scrollView.contentSize.height;
        [self.imageDetails mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(frame.size.height);
            make.width.mas_equalTo(ScreenWidth);
        }];
        self.sepratorBottomView.frame = CGRectMake(0, frame.origin.y+frame.size.height, ScreenWidth, HeightRate(46));
        self.scrollView.contentSize = CGSizeMake(0,startH+frame.size.height+HeightRate(45));
        
        UIView *touchview = [[UIView alloc] initWithFrame:frame];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwoTimesClick:)];
        touchview.tag = 1;
        [touchview addGestureRecognizer:tap];
        
        [self.scrollView addSubview:touchview];
        [touchview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(frame.size.height);
            make.width.mas_equalTo(ScreenWidth);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.imageDetails.mas_top).offset(0);
        }];
        
        
    });
    
    
    
}
#pragma mark---- 点击事件和方法

-(void)nextVipVC
{
    bool isVisitor =[self  isVisitorLoginByPhoneNumberExits];
    if (isVisitor ==false) {
        return;
    }
    
    
    YHMineMemberInterestViewController *vc = [[YHMineMemberInterestViewController alloc] init];
    vc.hidesBottomBarWhenPushed =YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)share
{
    if (self.product_data.count == 0) {

        return;
    }
    NSString *name = [self.product_data objectForKey:@"GoodsSeriesName"];
    __weak YHProductDetailsViewController *weakself = self;
    self.shareblock = ^() {
        if ([weakself.productCode isEqualToString:@"001-001"]) {
            [MobClick event:@"ProductDetailShareA" label:@"商品详情页面分享-输配电"];
        }else
        {
            [MobClick event:@"ProductDetailShareB" label:@"商品详情页面分享-休闲食品"];
            
        }
        YHShareView *share = [[YHShareView alloc] initShareWithContentTitle:@"易智造" theOtherTitle:[NSString stringWithFormat:@"%@商品详情",name] image:nil url:[NSString stringWithFormat:@"%@/%@",ShareProductDetaiURL,weakself.GoodsSeriesCode] withCancleTitle:@"取消"];
        [share showAnimated];
    };
}

-(void)tapTwoTimesClick:(UITapGestureRecognizer *)tap
{
    
    //    String:[self.product_data objectForKey:@"GoodsStandardIcon"] baseURL:nil];
    
//    [self.imageDetails loadHTMLString:[self.product_data objectForKey:@"GoodsSeriesDetail"]
    NSLog(@"sss==================");
    UIView *view = tap.view;
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    NSString *detailStr =  [self.product_data objectForKey:@"GoodsSeriesDetail"];
    vc.isLoadHTMLStr = ![detailStr hasPrefix:@"http"];//YES;
//    vc.time = WebTypeUserInstructions;
    if (view.tag == 1) {
        vc.URLString = [self.product_data objectForKey:@"GoodsSeriesDetail"];
        vc.titleName = @"详情图";
    }else if (view.tag == 2)//参数详情图
    {
        vc.titleName = @"参数图";
        vc.URLString = [self.product_data objectForKey:@"GoodsStandardIcon"];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)showSelectView{

    NSArray *imageArr = [Tools stringToJSON:self.product_data[@"GoodsSeriesPhotos"]];

    NSString *url= imageArr.count>0?imageArr.firstObject:@"";
    NSString *Price =[self.product_data objectForKey:@"PriceRange"];
    
    if (self.listArray.count>0 && self.listNameArray.count>0) {
        NSDictionary *dic = @{@"ItemImage":url,@"PriceValue":Price,@"TaxRate":[self.product_data objectForKey:@"TaxRate"],@"GoodsAddValue":[self.product_data objectForKey:@"GoodsAddValue"],@"GoodsAddValue2":[self.product_data objectForKey:@"GoodsAddValue2"],@"couponStr":self.CouponNumberStr,@"IsPriceTax":[self.product_data objectForKey:@"IsPriceTax"]};
        self.ParametersView = [[ProductParametersView alloc]initWithParamDic:dic largeArray:self.listArray andTitleArray:self.listNameArray];
        self.ParametersView.navagation = self.navigationController;
        self.ParametersView.GoodsInsuranceId =self.product_data[@"GoodsInsuranceId"];
        self.ParametersView.GoodsInsuranceRate = 0 ;
//        self.ParametersView.GoodsAddInvoiceValue = self.product_data[@"GoodsAddValue"];
//        self.ParametersView.GoodsNoneInvoiceValue = self.product_data[@"GoodsAddValue2"];
        self.ParametersView.couponStr = self.CouponNumberStr;
        __weak typeof(self) weakSelf = self;
        self.ParametersView.confirmBlock = ^(NSArray *productIds, NSInteger numberOfItem,NSString *isInvoice) {
            
            [weakSelf addGoodsToShoppingCart:numberOfItem productIds:productIds isInvoice:isInvoice];
        };
        [self.ParametersView showAnimated];
    }else{
        [self.view showWait:@"loading..." viewType:CurrentView];
        [self getparamData];
        
    }
}
- (void)addGoodsToShoppingCart:(NSInteger)number productIds:(NSArray *)productIds isInvoice:(NSString *)isInvoice{
    [self.ParametersView removeView];

    //判断是否是游客登录
    bool isVisist = [self isVisitorLoginByPhoneNumberExits];
    if (isVisist ==false) {
        return;
    }
    NSString *myStoreID = Userdefault(LOGIN_UserStoreID);
    if ([myStoreID isEqualToString:self.StoreID]) {
        [self.view makeToast:@"不能在自己的店铺购买商品" duration:1.5 position:CSToastPositionCenter];
        return ;
    }
    if (productIds.count ==0) {

        [self.view makeToast:@"该型号的产品参数出现异常，不能加入购物车"];

        return;
    }
 
        
       NSDictionary *  dic = @{@"GoodsSeriesCode":self.GoodsSeriesCode,@"ProductIds":productIds,@"GoodsNumber":@(number),@"IsInvoice": isInvoice,@"StoreId":self.StoreID,@"SuperGroupDetailId":self.SuperGroupDetailId.length>0?self.SuperGroupDetailId:@""};

   

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
            //判断是否是游客登录
            bool isVisist = [self isVisitorLoginByPhoneNumberExits];
            if (isVisist ==false) {
                return;
            }
            NSString *myStoreID = Userdefault(LOGIN_UserStoreID);
            if ([myStoreID isEqualToString:self.StoreID]) {
                [self.view makeToast:@"不能对自己的店铺发起聊天" duration:1.5 position:CSToastPositionCenter];
                return ;
            }
          
            
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
            [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:self.StoreID];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
            ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
            vc.hidesBottomBarWhenPushed = YES;
            vc.listID = [NSString stringWithFormat:@"%@_%@",self.StoreID,userID];
            vc.storeID = self.StoreID;
            vc.storeName =self.StoreName;
            vc.storeAvata =self.storeAvata;
            vc.isCatagory = [self.product_data[@"IsPriceTax"] boolValue];
            
         
            
            self.labelName.text = [self.product_data objectForKey:@"GoodsSeriesName"];
            vc.isPostOrderDetail = true;
            YHGoodsModel * model = [[YHGoodsModel alloc] init];
            model.GoodsPriceValue = [self.product_data objectForKey:@"PriceRange"];
            model.GoodsImageUrl = [self.product_data objectForKey:@"GoodsSeriesIcon"];
            model.GoodsSeriesName = [self.product_data objectForKey:@"GoodsSeriesName"];
            model.GoodsDetailUrl = [NSString stringWithFormat:@"%@/%@",ShareProductDetaiURL,self.GoodsSeriesCode];

            NSString *msg = [model mj_JSONString];
            vc.jsonStr = msg;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
            break;
        case 101:{
            //判断是否是游客登录
            bool isVisist = [self isVisitorLoginByPhoneNumberExits];
            if (isVisist ==false) {
                return;
            }
            self.tabBarController.selectedIndex = 2;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
            break;
        case 102:{//收藏

            
            [self getMyCollection:nil];
        }
            break;
        case 103:{//
           
            YHProductCloudsViewController *vc = [[YHProductCloudsViewController alloc] init];
            vc.storeId = self.StoreID;
            vc.catagory = self.GoodsSeriesCode;
            [Tools jumpIntoOnlyVC:self.navigationController destnationViewController:vc];
        }
            break;

        default:
            break;
    }
}
-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark---YHTitleView topview delegate
- (void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index{
    NSLog(@"indek====%ld",(long)index);
    switch (index) {
        case 0:
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
        {
            CGFloat h = self.paramImageWebview.frame.origin.y;
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
    CGFloat paramH = _paramImageWebview.frame.origin.y;
    if(scrollView.contentOffset.y >=(int) h ) {
            [self.selectView ChageItemWithIndex:2];

      CGFloat  h1 = _imageDetails.frame.size.height-150;

//     判断  显示回到顶部的按钮
        if (scrollView.contentOffset.y >= h1-150 && h1>ScreenHeight ) {
            topbutton.hidden = NO;

        }else
        {
            topbutton.hidden =YES;
        }


    }else if(scrollView.contentOffset.y >= (int)paramH)
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

-(void)getMyCollection:(UIButton *)button
{
    //判断是否是游客登录
    bool isVisist = [self isVisitorLoginByPhoneNumberExits];
    if (isVisist ==false) {
        return;
    }
    //    根据数据展示是否收藏
    [MobClick event:@"Collections" label:@"收藏"];
    if (isCollection == YES) {
        
        
        CollectionRefNo  =  CollectionRefNo.length>0?CollectionRefNo:@"";
        [[YHJsonRequest shared] userCancelCollectionProductWithParameter:CollectionRefNo SuccessBlock:^(NSString *Success) {
            if (button) {
                [button setImage:[UIImage imageNamed:@"shangpinxiangqing_shoucang"] forState:UIControlStateNormal];
            }
            [self.view makeToast:@"取消收藏" duration:1.5 position:CSToastPositionCenter];
            isCollection = false;
            self.collectImageview.image = [UIImage imageNamed:@"shangpinxiangqing_shoucang"];
            
            
        } fialureBlock:^(NSString *errorMessages) {
            [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
            
        }];
        
    }else
    {
        NSLog(@"productCode== %@ productSerialCode=%@-",self.GoodsSeriesCode,self.StoreID);
        [[YHJsonRequest shared] userCollectionProductWithParameter:@{@"GoodsSeriesCode":self.GoodsSeriesCode,@"StoreId":self.StoreID} SuccessBlock:^(NSString *Success) {
            
            if (button) {
                [button setImage:[UIImage imageNamed:@"shoucang-s"] forState:UIControlStateNormal];
            }
            self.collectImageview.image = [UIImage imageNamed:@"shoucang-s"];
            isCollection = YES;
            CollectionRefNo = Success;
            [self.view makeToast:@"收藏成功" duration:1.5 position:CSToastPositionCenter];
            
        } fialureBlock:^(NSString *errorMessages) {
            
            [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
            
        }];
    }
}

#pragma mark----自定义view
- (void)configTopView{
    
 
    [self addRigthDetailButtonIsShowShare:YES];
        
    
    NSArray *titles =[NSArray arrayWithObjects:@"商品",@"参数",@"详情",nil];
    self.selectView = [[YHTitleView alloc]initWithFrame:CGRectMake(0, 20, WidthRate(180), 39) titleFont:16 delegate:self andTitleArray:titles];
    self.selectView.backgroundColor = ColorWithHexString(StatusAndTopBarBackgroundColor);
    self.navigationItem.titleView = self.selectView;
}
- (void)configBottomView{
    
    bottomView = [[UIView alloc]init];
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
    NSString *seviceStr = @"小二";
    UIView *viewOne = [self bottomBtnView:[UIImage imageNamed:@"shouyekefu"] andTitle:seviceStr withTag:100];
    [bottomView addSubview:viewOne];
    
    [viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(71));
    }];
    
    
    
    UIView *viewTwo = [self bottomBtnView:[UIImage imageNamed:@"gouwuche-bs"] andTitle:@"购物车" withTag:101];
    [bottomView addSubview:viewTwo];
    
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WidthRate(74));
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(addItemBtn.mas_left);
    }];
    
        UIView*viewOne1 = [self bottomBtnView:[UIImage imageNamed:@"yungongchang"] andTitle:@"云工厂" withTag:103];
        
    
    [bottomView addSubview:viewOne1];
    [viewOne1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(viewOne.mas_right);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(viewTwo.mas_left);
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
    imageIcon.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageIcon];
    
    [imageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.height.mas_equalTo(WidthRate(25));
        make.width.mas_equalTo(WidthRate(25));
        make.top.mas_equalTo(HeightRate(6));
    }];
    if (tag == 102) {
        self.collectImageview = imageIcon;
    }
    
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
//    scrollImageView.contentSize =CGSizeMake(ScreenWidth*1,0);
    scrollImageView.alwaysBounceVertical = YES;
//    scrollImageView.scrollEnabled = NO;
    scrollImageView.showsVerticalScrollIndicator = false;
    scrollImageView.showsHorizontalScrollIndicator = true;
    scrollImageView.alwaysBounceHorizontal = false;
    scrollImageView.pagingEnabled = YES;
    scrollImageView.delegate = self;
    scrollImageView.tag = 110;
    [leftView addSubview:scrollImageView];
    self.imageScrollView = scrollImageView;
    
//    self.itemImageView = [[UIImageView alloc]init];
//    self.itemImageView.contentMode =  UIViewContentModeScaleAspectFit ;
//    self.itemImageView.clipsToBounds = YES;
//
//    [scrollImageView addSubview:self.itemImageView];
//    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(ScreenWidth);
//        make.top.mas_equalTo(0);
//        make.height.mas_equalTo(HeightRate(215));
//    }];
    
    UIView *imageTipsView = [[UIView alloc] init];
    imageTipsView.backgroundColor = ColorWithHexString(@"F3F3F3");
    [scrollImageView addSubview:imageTipsView];
    [imageTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(HeightRate(215));
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
    self.labelName.numberOfLines = 2;
    [self.leftView addSubview:self.labelName];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.width.mas_equalTo(WidthRate(245));
        make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(12));
//        make.height.mas_equalTo(HeightRate(24));
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
    
    
        PSButtonTextDonw *colletionButton  = [[PSButtonTextDonw alloc] init];
        //        colletionButton.backgroundColor = [UIColor yellowColor];
        
        [colletionButton setTitle:@"收藏" forState:UIControlStateNormal];
        colletionButton.titleLabel.font =[UIFont systemFontOfSize:AdaptFont(13)] ;
        [colletionButton setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
        [colletionButton setImage:[UIImage imageNamed:@"shangpinxiangqing_shoucang"] forState:UIControlStateNormal];
        //                [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [colletionButton addTarget:self action:@selector(getMyCollection:) forControlEvents:UIControlEventTouchUpInside];
        [self.leftView addSubview:colletionButton];
        [colletionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.labelName.mas_centerY).offset(HeightRate(5));
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(50));
            make.width.mas_equalTo(WidthRate(50));
            
        }];
        self.collectionButton = colletionButton;
        
       
    self.labelNumber = [[UILabel alloc]init];
    self.labelNumber.textColor = TextColor_BBBBBB;
    self.labelNumber.font = SYSTEM_FONT(AdaptFont(14));
    [self.leftView addSubview:self.labelNumber];
    
    [self.labelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-16));
        make.height.mas_equalTo(HeightRate(23));
        make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(25));
    }];
    
    self.labelPrice = [[UILabel alloc]init];
    self.labelPrice.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    self.labelPrice.font = SYSTEM_FONT(AdaptFont(20));
    [self.leftView addSubview:self.labelPrice];
    [self.labelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(3));
        make.height.mas_equalTo(HeightRate(29));
    }];
    
    self.labelTax = [[UILabel alloc]init];
    //    self.labelTax.text =[NSString stringWithFormat:@"含17%%增值税、不含运费"];
    self.labelTax.font = [UIFont systemFontOfSize:AdaptFont(13)];
    self.labelTax.textColor = ColorWithHexString(SymbolTopColor);
    [self.leftView addSubview:self.labelTax];
    
    [self.labelTax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labelPrice.mas_bottom).offset(HeightRate(5));
        make.height.mas_equalTo(HeightRate(19));
        make.left.mas_equalTo(WidthRate(20));
        
    }];
    
    
    UIView *membershipView = [self getTheMemberShipView];
    
    [self.leftView addSubview:membershipView];
    [membershipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(36));
        make.top.mas_equalTo(self.labelTax.mas_bottom).offset(HeightRate(0));
    }];
    [membershipView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextVipVC)]];
    self.VipView = membershipView;
    
   
    self.labelParameter =[[UILabel alloc]init];
    self.labelParameter.textColor = TextColor_636263;
    self.labelParameter.font = SYSTEM_FONT(AdaptFont(13));
    self.labelParameter.numberOfLines = 0;
    [self.leftView addSubview:self.labelParameter];
    
    [self.labelParameter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(membershipView.mas_bottom).offset(HeightRate(0));
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
        make.top.mas_equalTo(self.memberShipLable.mas_bottom).offset(HeightRate(5));
    }];
    
    
    UIView *seviceView = [[UIView alloc] init];
    seviceView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.leftView addSubview:seviceView];
    [seviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(self.lineThree.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRate(50));
        make.width.mas_equalTo(ScreenWidth);
        
    }];
    self.seviceView = seviceView;
    

    
    UIView *sepratorTopView = [[UIView alloc]init];
    [self.leftView addSubview:sepratorTopView];
    
    [sepratorTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(seviceView.mas_bottom).offset(HeightRate(5));
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
    
    
    self.paramImageWebview = [[UIWebView alloc] init];
    self.paramImageWebview.scalesPageToFit = YES;
    self.paramImageWebview.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.paramImageWebview];
    [self.paramImageWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(WidthRate(100));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(labelTips.mas_bottom);
        make.left.mas_equalTo(0);
        
    }];
//    self.paramImageWebview = paramIamgeview;
    
    
    self.imageDetails = [[UIWebView alloc]init];
    self.imageDetails.scalesPageToFit = YES;
//    self.imageDetails.backgroundColor = [UIColor redColor];
    [self.leftView addSubview:self.imageDetails];
    self.imageDetails.userInteractionEnabled = YES;
    
    
    [self.imageDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.paramImageWebview.mas_bottom).offset(HeightRate(0));
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(250));
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
-(CGFloat)getSeviceView:(NSString *)jsonArrString ServersName:(NSString *)ServersName imageName:(NSString *)imageName TopSpace:(CGFloat )topSpace
{
    CGFloat ItemTopSpace = topSpace+10;
    CGFloat ItemHeight = 30;

    UIView *viewTitle = [self serverViewWithServersName:ServersName imageName:imageName imageSize:CGSizeMake(16, 16) titleColor:ColorWithHexString(@"000000") titleFont:14 isAdjust:false isWithPicc:false];
    [self.seviceView addSubview:viewTitle];
    
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(21));
        make.top.mas_equalTo(HeightRate(ItemTopSpace));
        make.height.mas_equalTo(HeightRate(ItemHeight));
    }];
    
    CGFloat seviceItemHeight = 10+ItemHeight;
    CGFloat ItemTopHeight =0;
    NSArray *StringArrayAnother = [Tools stringToJSON:jsonArrString];
    for (int i = 0; i < StringArrayAnother.count; i++) {
         ItemTopHeight=5*(i+1)+ItemHeight*(i);
        NSString *stringSub =StringArrayAnother[i]; //[StringArrayAnother[0] substringFromIndex:0];
        
        UIView *viewOne1 = [self serverViewWithServersName:stringSub imageName:@"yuandian6x6" imageSize:CGSizeMake(8, 8) titleColor:ColorWithHexString(@"000000") titleFont:13 isAdjust:YES isWithPicc:[stringSub containsString:@"PICC"]];
        [self.seviceView addSubview:viewOne1];
        [viewOne1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(21));
            make.top.mas_equalTo(viewTitle.mas_bottom).offset(HeightRate(ItemTopHeight));
            make.height.mas_equalTo(HeightRate(30));
            make.right.mas_equalTo(-WidthRate(30));
        }];
        
    }
    seviceItemHeight += ItemTopHeight+ ItemHeight+10;

    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    [self.seviceView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(viewTitle.mas_bottom).offset(HeightRate(ItemTopHeight+38));
        make.height.mas_equalTo(HeightRate(1));
        make.width.mas_equalTo(ScreenWidth);
    }];
    if (StringArrayAnother.count == 0) {
        viewTitle.hidden = YES;
        line.hidden  = YES;
        return 0;
    }
    return seviceItemHeight+ItemTopHeight;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    self.imageDetails.delegate = nil;
    [self cleanCacheAndCookie];
}


-(UIView *)getTheMemberShipView
{
    UIView *membershipView = [[UIView alloc] init];
    membershipView.backgroundColor = ColorWithHexString(@"FFF1F4");
    
    
    UIImageView *membershipImageView = [[UIImageView alloc] init];
    membershipImageView.image = [UIImage imageNamed:@"huiyuans"];
    [membershipView addSubview:membershipImageView];
    [membershipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.width.mas_equalTo(WidthRate(26));
        make.height.mas_equalTo(HeightRate(20));
        make.centerY.mas_equalTo(membershipView.mas_centerY).offset(HeightRate(0));
    }];
    NSArray *cataGorys = Userdefault(CatagoryIDs);
    for (int i=0;i<cataGorys.count;i++) {
        NSDictionary *dic = cataGorys[i];
//        NSString *CategoryBName = dic[@"CategoryBName"];//CategoryBId
        NSString *CategoryBid = dic[@"CategoryBId"];
   
        if ([CategoryBid isEqualToString:self.CategoryBId]) {
            self.CouponNumberStr =   dic[@"DisCount"];
            
        }
        
    }
    
    NSString *coupon = [Tools getHaveNum:self.CouponNumberStr.doubleValue*10];
    UILabel *membershipLable = [[UILabel alloc] init];
    membershipLable.text =  [NSString stringWithFormat:@"开通会员，下单最高享%@折优惠",coupon];
    membershipLable.font = [UIFont systemFontOfSize:AdaptFont(10)];
    [membershipView addSubview:membershipLable];
    [membershipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(membershipImageView.mas_right).offset(WidthRate(10));
        make.height.mas_equalTo(HeightRate(36));
        make.centerY.mas_equalTo(membershipView.mas_centerY).offset(HeightRate(0));
    }];
    self.memberShipLable = membershipLable;
    UIImageView *membershipRightImageView = [[UIImageView alloc] init];
    membershipRightImageView.image = [UIImage imageNamed:@"right01"];
    [membershipView addSubview:membershipRightImageView];
    [membershipRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.width.mas_equalTo(WidthRate(26));
        make.height.mas_equalTo(HeightRate(20));
        make.centerY.mas_equalTo(membershipView.mas_centerY).offset(HeightRate(0));
    }];
    
    return membershipView;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
