//
//  ProductParametersView.m
//  emake
//
//  Created by 谷伟 on 2017/11/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "ProductParametersView.h"
#import "productParamModel.h"
#import "YHProductAddSeviceModel.h"
#import "YHJsonRequest.h"
#import "TPKeyboardAvoidingCollectionView.h"
#import "YHMineMemberInterestViewController.h"
#import "YHLoginViewController.h"
static CGFloat const collectionTag = 400;

enum selectStyle
{
    selectStyleSelectedEable = 0,
    selectStyleSelectedUnEable = 1,
    selectStyleDidSelect = 2
};
@interface ProductParametersView()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    NSInteger selectBrandIndex;
    NSString * selectSpecId;
    NSMutableArray *recordParamsName;
    NSInteger selectAccessoryIndex;
    BOOL isSelectBrand;
    BOOL isSelectAccessory;
    NSInteger recordTextNum;
    NSString *recordAddAuStr;//附件
    NSString *recordAddBrandStr;//品牌
    CGFloat recordAddAuStrHeight;//附件height
    CGFloat recordAddBrandStrHeight;//品牌height

    UIView *bgFootView;
    UIScrollView *scrolview;
    double productPrice;
    CGFloat collectionFooterHeight;
    UIImageView *productImage;
    NSString *productId;
    NSMutableArray *recordParamId;
    NSMutableArray *priceSS;
}

@property (nonatomic, assign)CGSize kbSize;
@property (nonatomic,strong)UIView *maskView;
@property (nonatomic,strong)UIButton *cancle;
@property (nonatomic,strong)UILabel *labelPrice;
@property (nonatomic,strong)UILabel *theBottomlabelPrice;

@property (nonatomic,strong)UILabel *insurancePrice;
@property (nonatomic,strong)UILabel *addSevicePrice;

@property (nonatomic,retain)TPKeyboardAvoidingCollectionView *collection;
@property (nonatomic,retain)TPKeyboardAvoidingCollectionView *otherCollection;

@property (nonatomic,copy)NSString *salePriceArea;
@property (nonatomic,copy)NSString *saleOriginPrice;
@property (nonatomic,retain)NSMutableArray *selectIndexArray;
@property (nonatomic,retain)NSMutableArray *unSelectArr;
@property (nonatomic,retain)NSMutableDictionary *unSelectIndexDic;
@property (nonatomic,retain)NSMutableDictionary *unSelectIndexArr;

@property (nonatomic,retain)NSMutableArray *filterArr;
@property (nonatomic,retain)NSMutableArray *RecordFilterArr;
@property (nonatomic,retain)NSMutableDictionary *selectSpecIdDic;
@property (nonatomic,retain)NSMutableDictionary *selectSpecIdDict;

@property (nonatomic,retain)NSDictionary *RecordFilterdic;

@property (nonatomic,retain)NSDictionary *addSeviceDic;

@property (nonatomic,retain)NSArray *allArray;

@property (nonatomic,retain)NSMutableDictionary *selectAddSevicedic;
@property (nonatomic,retain)NSMutableArray *ProductIdArr;

@property (nonatomic,retain)UILabel *labelTax;

@property (nonatomic,retain)NSArray *ProductFilterArr;

@property (nonatomic,retain)NSMutableArray *recordFilterNameArr;

@property (nonatomic,assign)BOOL isStore;
@property (nonatomic,assign)NSIndexPath *recordInvoiceIndexpath;
@property (nonatomic,copy)NSString *isInVoice;
@property (nonatomic,assign)CGFloat InvoiceRate;
@property (nonatomic,copy)UILabel * MyMemberShipLable;

@property (nonatomic,assign)BOOL isVip;

@end
@implementation ProductParametersView
//ItemImage:(NSString *)itemImageUrl PriceValue:(NSString *)priceValue taxDecription:(NSString *)taxDetail
- (instancetype)initWithParamDic:(NSDictionary *)dic largeArray:(NSArray *)largeArray andTitleArray:(NSArray *)titleArray{
    if (self = [super init]) {
        self.unSelectArr = [NSMutableArray array];
        self.unSelectIndexDic = [NSMutableDictionary dictionary];
        self.filterArr = [NSMutableArray array];
        self.RecordFilterArr = [NSMutableArray array];
        self.selectSpecIdDic = [NSMutableDictionary dictionary];
        recordParamsName = [NSMutableArray array];
        self.RecordFilterdic = [NSMutableDictionary dictionary];
        self.selectIndexArray = [NSMutableArray arrayWithCapacity:0];
        self.allArray = [NSArray array];
        self.addSeviceDic = [NSDictionary dictionary];
        recordParamId = [NSMutableArray array];
        self.selectSpecIdDict = [NSMutableDictionary dictionary];
        self.couponStr = dic[@"couponStr"];
       self.recordFilterNameArr = [NSMutableArray array];
        for (int i = 0; i<titleArray.count; i++) {
            [self.selectIndexArray addObject:@"-1"];
            [recordParamsName addObject:@" "];
            [recordParamId addObject:@" "];

        }
        self.salePriceArea = dic[@"PriceValue"];
        self.saleOriginPrice = dic[@"PriceValue"];;
        self.largeArray = largeArray;
        self.titleArray = titleArray;
        self.backgroundColor = [UIColor clearColor];
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        UIColor *color = [UIColor blackColor];
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-HeightRate(185));
        
        UIImageView *itemImage = [[UIImageView alloc]init];
        [itemImage sd_setImageWithURL:[NSURL URLWithString:dic[@"ItemImage"]] placeholderImage:[UIImage imageNamed:@"login_logo"]];
         itemImage.contentMode = UIViewContentModeScaleAspectFit;
        itemImage.backgroundColor = [UIColor whiteColor];
        itemImage.layer.borderColor = SepratorLineColor.CGColor;
        itemImage.layer.borderWidth = 1;
        itemImage.clipsToBounds = YES;
        itemImage.layer.cornerRadius = 3;
        [self addSubview:itemImage];
        
        [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(16));
            make.width.mas_equalTo(WidthRate(118));
            make.height.mas_equalTo(HeightRate(112));
            make.top.mas_equalTo(HeightRate(-37));
        }];
//        NSDictionary *dic = @{@"ItemImage":url,@"PriceValue":Price,@"TaxRate":[self.product_data objectForKey:@"TaxRate"],@"GoodsAddValue":[self.product_data objectForKey:@"GoodsAddValue"],@"GoodsAddValue2":[self.product_data objectForKey:@"GoodsAddValue2"]};
        self.isStore = ![dic[@"IsPriceTax"] boolValue];

        
        productImage = itemImage;
        self.labelPrice = [[UILabel alloc]init];
        self.labelPrice.text = dic[@"PriceValue"];
        self.labelPrice.font = SYSTEM_FONT(AdaptFont(16));
        self.labelPrice.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.labelPrice.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.labelPrice];
        [self.labelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(7));
            make.top.mas_equalTo(HeightRate(7));
            make.height.mas_equalTo(HeightRate(26));
        }];
        UILabel *priceNameLable = [[UILabel alloc]init];
//        MyMemberShipLable.text = [NSString stringWithFormat:@"会员价：%@",dic[@"PriceValue"]];
        priceNameLable.font = SYSTEM_FONT(AdaptFont(12));
        priceNameLable.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        priceNameLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceNameLable];
        [priceNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labelPrice.mas_right).offset(WidthRate(7));
            make.centerY.mas_equalTo(self.labelPrice.mas_centerY);
            make.height.mas_equalTo(HeightRate(26));
        }];
        
        UILabel *MyMemberShipLable = [[UILabel alloc]init];
        MyMemberShipLable.text = [NSString stringWithFormat:@"%@",dic[@"PriceValue"]];
        MyMemberShipLable.font = SYSTEM_FONT(AdaptFont(12));
        MyMemberShipLable.textColor = ColorWithHexString(@"999999");
        MyMemberShipLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:MyMemberShipLable];

        [MyMemberShipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(7));
            make.top.mas_equalTo(self.labelPrice.mas_bottom);
            make.height.mas_equalTo(HeightRate(26));
        }];
        self.theBottomlabelPrice = MyMemberShipLable;
        
        UILabel *priceNameLable1 = [[UILabel alloc]init];
        //        MyMemberShipLable.text = [NSString stringWithFormat:@"会员价：%@",dic[@"PriceValue"]];
        priceNameLable1.font = SYSTEM_FONT(AdaptFont(12));
        priceNameLable1.textColor = ColorWithHexString(@"999999");
        priceNameLable1.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceNameLable1];
        [priceNameLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(MyMemberShipLable.mas_right).offset(WidthRate(7));
            make.centerY.mas_equalTo(MyMemberShipLable.mas_centerY);
            make.height.mas_equalTo(HeightRate(26));
        }];
        self.GoodsAddInvoiceValue = dic[@"GoodsAddValue"];
        self.GoodsNoneInvoiceValue = dic[@"GoodsAddValue2"];
        
        NSString *taxDetail = self.isStore==YES?dic[@"TaxRate"]:@"0";
        self.InvoiceRate = taxDetail.doubleValue;
        
        UILabel *labelTax = [[UILabel alloc]init];
        labelTax.text = self.isStore==YES?dic[@"GoodsAddValue2"]:dic[@"GoodsAddValue"];
        labelTax.font = [UIFont systemFontOfSize:AdaptFont(13)];
        labelTax.textColor = ColorWithHexString(SymbolTopColor);
        [self addSubview:labelTax];
        self.labelTax = labelTax;
        [labelTax mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(MyMemberShipLable.mas_bottom);
            make.height.mas_equalTo(HeightRate(19));
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(7));
        }];
        
        
        self.cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancle setImage:[UIImage imageNamed:@"gouwucheshanchu"] forState:UIControlStateNormal];
        [self.cancle addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancle];
        
        [self.cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(HeightRate(0));
            make.width.mas_equalTo(WidthRate(37));
            make.height.mas_equalTo(WidthRate(37));
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(itemImage.mas_bottom).offset(HeightRate(17));
        }];
        
        
       

        scrolview = [[UIScrollView alloc]init];
        scrolview.contentSize =CGSizeMake(ScreenWidth*2, 0);
        scrolview.pagingEnabled =YES;
        scrolview.alwaysBounceHorizontal = NO;
        scrolview.clipsToBounds=NO;
        scrolview.backgroundColor = [UIColor whiteColor];
        scrolview.showsVerticalScrollIndicator = FALSE;
        scrolview.showsHorizontalScrollIndicator = FALSE;
        scrolview.scrollEnabled = NO;
        [self addSubview:scrolview];
        [scrolview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(line.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
//        NSInteger vipStatess ;

        NSNumber *catagoryState = Userdefault(CatagoryVipState);
        NSInteger vipStatess =  [Tools SaveLocalVipstateWithCatagory:nil];

//            vipStatess =catagoryState.integerValue;
       
        NSString *HidenVip = Userdefault(HidenCatagoryVip);
        if (HidenVip.integerValue==0) {
            self.isVip = 0;//0 bu 1vip
            priceNameLable1.hidden = YES;
            priceNameLable.hidden = YES;
            self.theBottomlabelPrice.hidden = YES;
        }else
        {
            self.isVip = vipStatess;//0 bu 1vip

        }

        for (int i = 0; i<2; i++) {
            CGFloat vipHeight =0;
            if (vipStatess==0 && HidenVip.integerValue==1) {
                UIView *membershipView = [self getTheMemberShipView];
                [membershipView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextVipVC)]];
                
                [scrolview addSubview:membershipView];
                [membershipView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(ScreenWidth*i);
                    make.width.mas_equalTo(ScreenWidth);
                    make.height.mas_equalTo(HeightRate(36));
                    make.top.mas_equalTo(0);
                }];
                vipHeight = HeightRate(36);
                priceNameLable.text = @"普通价";
                priceNameLable1.text = @"会员价";

            }else
            {
                priceNameLable.text = @"会员价";
                priceNameLable1.text =@"普通价" ;
            }
            
            
            UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
            TPKeyboardAvoidingCollectionView *collection = [[TPKeyboardAvoidingCollectionView alloc]initWithFrame:CGRectMake(ScreenWidth*i, vipHeight, ScreenWidth, HeightRate(335)-vipHeight) collectionViewLayout:layout];
            
            collection.delegate = self;
            collection.dataSource = self;
            [scrolview addSubview:collection];
            
            collection.backgroundColor = [UIColor whiteColor];
            
            collection.tag = collectionTag+i;
            
            if (i==0) {
                [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
                [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
                [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
                
                self.collection = collection;
                collectionFooterHeight = 80;
                
                self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.confirmBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
                [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
                self.confirmBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
                self.confirmBtn.layer.cornerRadius = 6;
                self.confirmBtn.clipsToBounds = YES;
                [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
                [scrolview addSubview:self.confirmBtn];
                [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(ScreenWidth*i+WidthRate(32));
                    make.width.mas_equalTo(WidthRate(310));
//                    make.bottom.mas_equalTo(HeightRate(-15));
                    make.top.mas_equalTo(collection.mas_bottom).offset(HeightRate(2));
                    make.height.mas_equalTo(HeightRate(40));
                }];
                
            }else
            {
                
                [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item1"];
                [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];
                self.otherCollection = collection;
                
                UIButton *backLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [backLeftBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
                [backLeftBtn setBackgroundColor:ColorWithHexString(@"ffffff")];
                backLeftBtn.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
                backLeftBtn.layer.borderWidth = 1;
                [backLeftBtn setTitle:@"上一步" forState:UIControlStateNormal];
                backLeftBtn.layer.cornerRadius = 6;
                backLeftBtn.clipsToBounds = YES;
                backLeftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
                [backLeftBtn addTarget:self action:@selector(backToMainParamsViewClick) forControlEvents:UIControlEventTouchUpInside];
                [scrolview addSubview:backLeftBtn];
                [backLeftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(ScreenWidth+WidthRate(25));
                    make.width.mas_equalTo(WidthRate(150));
                    make.top.mas_equalTo(collection.mas_bottom).offset(HeightRate(2));
                    make.height.mas_equalTo(HeightRate(40));
                }];
                
                UIButton *confirmRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [confirmRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [confirmRightBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
                [confirmRightBtn setTitle:@"确认" forState:UIControlStateNormal];
                confirmRightBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
                [confirmRightBtn addTarget:self action:@selector(confirmSeviceClick) forControlEvents:UIControlEventTouchUpInside];
                confirmRightBtn.layer.cornerRadius = 6;
                confirmRightBtn.clipsToBounds = YES;
                confirmRightBtn.tag = 100;
                [scrolview addSubview:confirmRightBtn];
                [confirmRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    //                    make.left.mas_equalTo(ScreenWidth*i);
                    make.left.mas_equalTo(backLeftBtn.mas_right).offset(WidthRate(25));
                    make.width.mas_equalTo(WidthRate(150));
                    make.top.mas_equalTo(collection.mas_bottom).offset(HeightRate(2));
                    make.height.mas_equalTo(HeightRate(40));
                }];
                
            }
            
            
            
            
            
        }
        
        
    self.unSelectArr  = [self.largeArray mutableCopy];
    self.filterArr  = [ self.largeArray  mutableCopy];

        self.recordInvoiceIndexpath = [NSIndexPath indexPathForRow:1 inSection:self.titleArray.count];
        self.isInVoice = @"0";
        productPrice =0;
//    记录numtexfield的数值，防止刷新时改变数据
        recordTextNum = 1;
        
        
    }
    return self;
}
- (void)showAnimated{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformMakeTranslation(0, -HeightRate(481));
                     }
                        completion:^(BOOL finished) {
                            
                     }];
}
- (void)removeView{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformMakeTranslation(0, ScreenHeight);
                     }
                     completion:^(BOOL finished) {

                             [self.maskView removeFromSuperview];
                     }];

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
    
    UILabel *membershipLable = [[UILabel alloc] init];
    membershipLable.text = [NSString stringWithFormat:@"开通会员，下单享会员价"] ;
    membershipLable.font = [UIFont systemFontOfSize:AdaptFont(10)];
    [membershipView addSubview:membershipLable];
    [membershipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(membershipImageView.mas_right).offset(WidthRate(10));
        make.height.mas_equalTo(HeightRate(36));
        make.centerY.mas_equalTo(membershipView.mas_centerY).offset(HeightRate(0));
    }];
//    self.memberShipLable = membershipLable;
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

-(void)nextVipVC
{
    [self removeView];
    NSString *phone =Userdefault(LOGIN_MOBILEPHONE) ;
    
    if(phone.length<=0 )
    {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.navigationController.navigationBar.hidden = YES;
        
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navagation pushViewController:loginViewController animated:NO];
        return;
    }
    YHMineMemberInterestViewController *vc = [[YHMineMemberInterestViewController alloc] init];
    vc.hidesBottomBarWhenPushed =YES;
    
    [self.navagation pushViewController:vc animated:YES];
    
}
#pragma mark -----UICollectionViewDelegate & UICollectionViewDataSources
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView.tag ==collectionTag) {
        
        if (self.isStore==YES && section == self.titleArray.count) {
            return 2;
        }
        productIndex *indexmodel = self.titleArray[section];
        NSArray *arr  ;
        arr  = [self getdiferentArr:self.largeArray contion:indexmodel.ParamId];
        return arr.count;
        
    }else
    {
        NSArray *keys = [self.addSeviceDic allKeys];
        NSString *key = keys[section];
        NSArray *arr = self.addSeviceDic[key];
        return arr.count;
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag ==collectionTag) {
        if (self.isStore== YES) {
            return self.titleArray.count+1;
        }
        return self.titleArray.count;
        
    }
    else
    {
        return self.addSeviceDic.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag ==collectionTag) {
        
        UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
        for(UIView * subView in item.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }
        if (!item) {
            if (indexPath.section == 0) {
                item = [[UICollectionViewCell alloc]init];
            }else{
                item = [[UICollectionViewCell alloc]init];
            }
        }
        
        item.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];//initWithFrame:item.bounds];
        btn.tag = indexPath.item + indexPath.section*100;
        btn.backgroundColor = [UIColor whiteColor];
        btn.frame = item.bounds;
        btn.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
        btn.layer.borderWidth = 1;
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 3;
        [btn addTarget:self action:@selector(changeBtutonClick:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:btn];
        if(_isStore == YES && indexPath.section == self.titleArray.count)
        {
            [btn setTitle:indexPath.row ==0?@"是":@"否" forState:UIControlStateNormal];
            if ([indexPath isEqual:self.recordInvoiceIndexpath]) {
                btn.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
                [btn setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
            } else {
                btn.layer.borderColor = SepratorLineColor.CGColor;
                [btn setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
            }

            return item;
        }
        NSArray *arr  ;
        productIndex *indexmodel = self.titleArray[indexPath.section];
        arr  = [self getdiferentArr:self.largeArray contion:indexmodel.ParamId];
        NSDictionary *dic = arr[indexPath.row][0];
        productParamModel *model2 = dic[indexmodel.ParamId];
        [btn setTitle:model2.ParamOptionalName forState:UIControlStateNormal];
        
        
        
        
        
        NSString *key =[NSString stringWithFormat:@"%ld",indexPath.section];
        NSArray *  unarray = _unSelectIndexDic[key];
        
        NSNumber *num = unarray[indexPath.row];
        
        if (num.intValue == -1) {
            btn.layer.borderColor = SepratorLineColor.CGColor;
            [btn setTitleColor:SepratorLineColor forState:UIControlStateNormal];
            for (NSDictionary *dictt in  arr[indexPath.row]) {
                [self.filterArr removeObject:dictt];
                
            }
            
            
        }else
        {
            btn.layer.borderColor = SepratorLineColor.CGColor;
            [btn setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
            
        }
        if (![[self.selectIndexArray objectAtIndex:indexPath.section] isEqualToString:@"-1"]) {
            if ([[self.selectIndexArray objectAtIndex:indexPath.section] isEqualToString:[NSString stringWithFormat:@"%ld",indexPath.item]]) {
                btn.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
                [btn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
            }
        }
        
        
        
        
     
        return item;
    }else
    {
        UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item1" forIndexPath:indexPath];
        for(UIView * subView in item.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }
        if (!item) {
            if (indexPath.section == 0) {
                item = [[UICollectionViewCell alloc]init];
            }else{
                item = [[UICollectionViewCell alloc]init];
            }
        }
        
        item.backgroundColor = [UIColor whiteColor];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];//initWithFrame:item.bounds];
        btn1.tag = indexPath.item + indexPath.section*100;
        btn1.backgroundColor = [UIColor whiteColor];
        btn1.frame = item.bounds;
        
        
        NSArray *keys = [self.addSeviceDic allKeys];
        NSString *key = keys[indexPath.section];
        NSArray *arr = self.addSeviceDic[key];
        YHProductAddSeviceModel *seviceModel = arr[indexPath.row];
        [btn1 setTitle:seviceModel.GoodsTitle forState:UIControlStateNormal];
        if (seviceModel.isSelected == YES) {
            [btn1 setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
            btn1.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
            
        }else
        {
            [btn1 setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
            btn1.layer.borderColor = SepratorLineColor.CGColor;
            
        }
        btn1.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
        btn1.layer.borderWidth = 1;
        btn1.clipsToBounds = YES;
        btn1.layer.cornerRadius = 3;
        [btn1 addTarget:self action:@selector(changeOtherBtutonClick:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:btn1];
        
        return item;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag ==collectionTag) {

        if (self.isStore == YES && indexPath.section == self.titleArray.count) {
            return CGSizeMake(WidthRate(45), HeightRate(31));
        }
        productIndex *indexmodel = self.titleArray[indexPath.section];
        NSArray *arr  = [self getdiferentArr:self.largeArray contion:indexmodel.ParamId];
        
        NSDictionary *dic  = arr[indexPath.row][0];
        productParamModel *model2 = dic[indexmodel.ParamId];
        NSString *text = model2.ParamOptionalName;
        CGSize size = [Tools calcTextSize:text Size:AdaptFont(12)];
        return CGSizeMake(WidthRate(size.width+20), HeightRate(31));
    }else
    {
        NSArray *keys = [self.addSeviceDic allKeys];
        NSString *key = keys[indexPath.section];
        NSArray *arr = self.addSeviceDic[key];
        YHProductAddSeviceModel *seviceModel = arr[indexPath.row];
        CGSize size = [Tools calcTextSize:seviceModel.GoodsTitle Size:AdaptFont(12)];
        return CGSizeMake(WidthRate(size.width+20), HeightRate(31));
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView.tag ==collectionTag) {
        if (section == 0) {
            return WidthRate(15);
        }else{
            return WidthRate(5);
        }
    }else
    {
        if (section == 0) {
            return WidthRate(15);
        }else{
            return WidthRate(5);
        }
        
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView.tag == collectionTag) {
        return HeightRate(10);

    }
    return HeightRate(10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView.tag == collectionTag) {
        
      if (section == 0) {
         return UIEdgeInsetsMake(HeightRate(0), WidthRate(23), HeightRate(0), WidthRate(10));
       }else{
        return UIEdgeInsetsMake(HeightRate(0), WidthRate(23), HeightRate(0), WidthRate(10));
      }
    }else
    {
        if (section == 0) {
        return UIEdgeInsetsMake(HeightRate(0), WidthRate(23), HeightRate(0), WidthRate(10));
       }else{
        return UIEdgeInsetsMake(HeightRate(0), WidthRate(23), HeightRate(0), WidthRate(10));
       }
        
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        // 头部
    if (collectionTag == collectionView.tag) {//产品参数
        
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        for(id subView in view.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(26), 0, ScreenWidth-WidthRate(26), HeightRate(38))];
        label.font = SYSTEM_FONT(AdaptFont(12));
        label.textColor = TextColor_636263;
        if (self.isStore == YES && indexPath.section == self.titleArray.count) {
            label.text = @"含税";
        }else
        {
            productIndex *indexmodel = self.titleArray[indexPath.section];
            label.text = indexmodel.ParamName;
        }
        [view addSubview:label];
        return view;
    }else{
        NSInteger arrayCount = self.isStore == YES?self.titleArray.count:self.titleArray.count-1;
        if (indexPath.section == arrayCount){
            
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
            for(id subView in view.subviews){
                if(subView){
                    [subView removeFromSuperview];
                }
            }
            
//            选择完参数再显示nextview的内容（增值服务内容）
            UIView * NextView = [[UIView alloc] init];
            NextView.backgroundColor = TextColor_F7F7F7;
            [view addSubview:NextView];
            [NextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(0));
                make.width.mas_equalTo(ScreenWidth);
                make.top.mas_equalTo(1);
                make.height.mas_equalTo(HeightRate(0.1));
                
            }];
            if (self.selectSpecIdDic.count == self.titleArray.count && self.selectAddSevicedic.count>0) {//有数据才进来
                CGFloat height = recordAddBrandStrHeight+recordAddAuStrHeight+10;
                [NextView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(15);

                    make.height.mas_equalTo(HeightRate(height));
                }];
                UILabel *nextLable1 = [[UILabel alloc] init];
                nextLable1.backgroundColor = TextColor_F7F7F7;
                nextLable1.font = [UIFont systemFontOfSize:AdaptFont(12)];
                nextLable1.numberOfLines = 0;
                nextLable1.text = recordAddAuStr;
                nextLable1.textColor = ColorWithHexString(StandardBlueColor);

                [NextView addSubview:nextLable1];
                [nextLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(WidthRate(26));
                    make.right.mas_equalTo(WidthRate(-41));
                    make.height.mas_equalTo(HeightRate(recordAddAuStrHeight));
                    make.top.mas_equalTo(HeightRate(5));
                    
                }];
                self.addSevicePrice = nextLable1;
                
                UILabel *nextLable2 = [[UILabel alloc] init];
                nextLable2.backgroundColor = TextColor_F7F7F7;
                nextLable2.font = [UIFont systemFontOfSize:AdaptFont(12)];
                nextLable2.numberOfLines = 0;
                nextLable2.text = recordAddBrandStr;
                nextLable2.textColor = ColorWithHexString(StandardBlueColor);
                
                [NextView addSubview:nextLable2];
                [nextLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(WidthRate(26));
                    make.right.mas_equalTo(WidthRate(-41));
                    make.height.mas_equalTo(HeightRate(recordAddBrandStrHeight));
                    make.top.mas_equalTo(nextLable1.mas_bottom);
                    
                }];
                self.addSevicePrice = nextLable1;

                UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
                [nextButton addTarget:self action:@selector(nextpage) forControlEvents:UIControlEventTouchUpInside];
                [NextView addSubview:nextButton];
                [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(WidthRate(0));
                    make.right.mas_equalTo(WidthRate(41));
                    make.centerY.mas_equalTo(NextView.mas_centerY);

                }];

                UIImageView *imageright = [[UIImageView alloc] init];
                imageright.image =[UIImage imageNamed:@"direction_right"];
                [NextView addSubview:imageright];
                [imageright mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(WidthRate(-14));
                    make.height.mas_equalTo(WidthRate(18));
                    make.width.mas_equalTo(WidthRate(18));
                    make.centerY.mas_equalTo(NextView.mas_centerY);
                    
                }];

            }
         UIView *footview =   [self getColloectionView:NextView];
            [view addSubview:footview];
            [footview mas_makeConstraints:^(MASConstraintMaker *make) {
            
                make.left.mas_equalTo(WidthRate(0));
                make.width.mas_equalTo(ScreenWidth);
                make.top.mas_equalTo(NextView.mas_bottom).offset(3);
                make.bottom.mas_equalTo(-1);
            }];
            
            return view;
        }else{
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
            for(id subView in view.subviews){
                if(subView){
                    [subView removeFromSuperview];
                }
            }
            return view;
        }
      }
    }else//增值服务
    {
        if([kind isEqualToString:UICollectionElementKindSectionHeader])
        {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1" forIndexPath:indexPath];
            for(id subView in view.subviews){
                if(subView){
                    [subView removeFromSuperview];
                }
            }
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(26), 0, ScreenWidth-WidthRate(26), HeightRate(38))];
            label.font = SYSTEM_FONT(AdaptFont(12));
            label.textColor = TextColor_636263;
            NSArray *keys = [self.addSeviceDic allKeys];
            NSString *key = keys[indexPath.section];
            if ([key isEqualToString:@"附件"]) {
                label.text = [NSString stringWithFormat:@"%@(可多选)",key];

            }else
            {
                label.text = key;
            }
            [view addSubview:label];
            return view;
            
        }
        else{ UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer1" forIndexPath:indexPath];
        for(id subView in view.subviews){
            if(subView){
                [subView removeFromSuperview];
            }
        }
        
            return nil;
            
        }
    }
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionTag == collectionView.tag)
    {
      return CGSizeMake(ScreenWidth, HeightRate(38));
    }
    else
    {
        return CGSizeMake(ScreenWidth, HeightRate(38));

    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (collectionView.tag ==collectionTag) {
        
        NSInteger arrayCount = self.isStore == YES?self.titleArray.count:self.titleArray.count-1;
      if (section == arrayCount)
      {
        return CGSizeMake(ScreenWidth, HeightRate(collectionFooterHeight));
      }else
      {
         return CGSizeMake(ScreenWidth, HeightRate(0.0001));
       }
        
    }else
    {
        return CGSizeZero;

    }
}

#pragma mark === UItextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([self.Number.text integerValue]<= 0) {
        [self makeToast:@"该商品最少1件" duration:1.0 position:CSToastPositionCenter];
        self.Number.text =@"1";
    }
    if ([self.Number.text integerValue] >= 1000) {
        self.Number.text =@"999";
        [self makeToast:@"该商品最多可选999件" duration:1.0 position:CSToastPositionCenter];
    }
    return YES;
}
#pragma mark-----buttonclick
-(void)changeBtutonClick:(UIButton *)button
{
    if ([Tools firstColor:button.currentTitleColor secondColor:SepratorLineColor]||[Tools firstColor:button.currentTitleColor secondColor:ColorWithHexString(StandardBlueColor)])
    {
        NSLog(@"颜色相同");
        return ;
    }
    NSInteger section = button.tag/100;
    NSInteger row = button.tag%100;
    if (self.isStore == YES && self.titleArray.count == section) {
        self.recordInvoiceIndexpath =  [NSIndexPath indexPathForRow:row inSection:section];
        self.isInVoice = row==1?@"0":@"1";
        self.labelTax.text  = [self.isInVoice isEqualToString:@"0"]?self.GoodsNoneInvoiceValue:self.GoodsAddInvoiceValue;
        [self.collection reloadData];
        if (productPrice > 0 ) {
            [self getPriceByConculateInvoiceState];
        }
        
        return;
    }
    NSArray * array ;
    productIndex *indexmodel = self.titleArray[section];
    [recordParamsName replaceObjectAtIndex:section withObject:button.currentTitle];
    array  = [self getdiferentArr:self.filterArr contion:indexmodel.ParamId];
    [self.RecordFilterdic setValue:[self.filterArr copy]  forKey:indexmodel.ParamId];
    [self.selectSpecIdDic setObject:indexmodel.ParamId forKey:@(section)];
    [self.selectSpecIdDict setObject:indexmodel.ParamId forKey:@(section)];
    [recordParamsName replaceObjectAtIndex:section withObject:button.currentTitle];
    productPrice = 0;
    if ([self.recordFilterNameArr containsObject:@(section)]) {
        
        NSInteger index = [self.recordFilterNameArr indexOfObject:@(section)];
        NSInteger count = self.recordFilterNameArr.count;
        NSMutableIndexSet *set =[[NSMutableIndexSet alloc] init];
        for (NSInteger i = index+1; i <count; i++) {
            NSNumber *recordNameIndex =self.recordFilterNameArr[i];
            [set addIndex:i];
            [recordParamsName replaceObjectAtIndex:recordNameIndex.integerValue withObject:@""] ;
            [self.selectIndexArray replaceObjectAtIndex:recordNameIndex.integerValue withObject:@"-1"];
            [self.selectSpecIdDic removeObjectForKey:recordNameIndex];
            [self.selectSpecIdDict removeObjectForKey:recordNameIndex];
        }
        if (self.selectSpecIdDic.count >self.recordFilterNameArr.count) {
            
            
            for (NSString *key in self.selectSpecIdDic.allKeys) {
                if (![self.recordFilterNameArr containsObject:key]) {
                    [self.selectIndexArray replaceObjectAtIndex:key.integerValue withObject:@"-1"];
                    [self.selectSpecIdDic removeObjectForKey:key];
                    [recordParamsName replaceObjectAtIndex:key.integerValue withObject:@""] ;

                }
                
            }
            
        }
        
        self.labelPrice.text =  self.salePriceArea;
        [self.recordFilterNameArr removeObjectsAtIndexes:set];
    } else {
        [self.recordFilterNameArr addObject:@(section)];
        
    }
    
    
    self.ProductFilterArr =[self getdiferentArr22222222:self.largeArray namArr:recordParamsName contion:self.selectSpecIdDic.allValues];

    
    selectSpecId = indexmodel.ParamId;
    
    
    [self.selectIndexArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%ld",row]];
    button.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
    [button setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
    

    [self getselectArr];
    productPrice = 0;
    [self getResultProduct:section row:0];

    [self.collection reloadData];
    
}
-(void)getselectArr
{
    for ( NSInteger section1 = 0 ;section1 < self.titleArray.count ; section1 ++  ) {
        productIndex *indexmodel2 = self.titleArray[section1];
        
        NSArray * Arr  = [self getdiferentArr:self.largeArray contion:indexmodel2.ParamId];
        NSArray * Arr1;
        if ([self.selectSpecIdDict.allValues containsObject:indexmodel2.ParamId]) {
            
            
        }else
        {
            Arr1 = [self getdiferentArr:self.ProductFilterArr.count>0?self.ProductFilterArr:self.largeArray contion:indexmodel2.ParamId];
            NSMutableArray  *unselectArray = [NSMutableArray array];
            for (int i = 0; i<[Arr count]; i++) {
                [unselectArray addObject:@"-1"];
                NSArray *array3 =Arr[i];
                NSDictionary *dic = array3[0];//[obj objectAtIndex:idx];
                productParamModel *model = dic[indexmodel2.ParamId];
                
                for (NSArray *sArr in Arr1) {
                    NSDictionary *dic2 = sArr[0];
                    productParamModel *model2 = dic2[indexmodel2.ParamId];
                    if ([model.ParamOptionalName isEqual:model2.ParamOptionalName]) {
                        
                        if (Arr1.count ==1) {
                            
                            [self.selectIndexArray replaceObjectAtIndex:section1 withObject:[NSString stringWithFormat:@"%d",i]];
                            [recordParamsName replaceObjectAtIndex:section1 withObject:model.ParamOptionalName];
                            [self.selectSpecIdDic setObject:indexmodel2.ParamId forKey:@(section1)];
                            if (![self.recordFilterNameArr containsObject:@(section1)])
                             {
                                [self.recordFilterNameArr addObject:@(section1)];
                              }

                           
                        }
                        [unselectArray replaceObjectAtIndex:i withObject:@(i)];
                        
                    }
                }
                
            }
            
            NSString *key = [NSString stringWithFormat:@"%ld",section1];
            [_unSelectIndexDic setObject:unselectArray forKey:key];
        }
    }
    
}
-(void)getinsrancePrice111
{
    if (self.selectAddSevicedic.count == self.addSeviceDic.count &&self.selectAddSevicedic.count>0 ) {
        
        CGFloat result1 = 0.0;
        CGFloat result = 0.0;

        for (NSString *key in self.selectAddSevicedic.allKeys) {
            YHProductAddSeviceModel *seviceModel = self.selectAddSevicedic[key];
            CGFloat price = productPrice;
            

            if ([seviceModel.GoodsType isEqualToString:@"2"] ) {
                result = ( seviceModel.GoodsPrice.doubleValue)*100;
                
            }else
            {
                if ([seviceModel.GoodsTitle isEqualToString:@"无"]) {
                result1 = 0;
                }else{
                result1 = price*seviceModel.GoodsPrice.doubleValue*100;
                }
            }

        }
            
    
      
        CGFloat insuranceFee= (self.GoodsInsuranceRate*productPrice*self.insuranceText.text.intValue*100);
        self.insurancePrice.text = [NSString stringWithFormat:@"¥%.2f",round(insuranceFee)/100.0];
        double price =(round(result)/100.0+round(result1)/100.0+round(insuranceFee)/100.0+round(productPrice*100)/100);
        self.labelPrice.text =self.isVip == YES? [NSString stringWithFormat:@"¥%@",[Tools getHaveNum: floorNumber(price*self.couponStr.doubleValue) ]]:[NSString stringWithFormat:@"¥%.2f",price];
        self.theBottomlabelPrice.text = self.isVip == YES?[NSString stringWithFormat:@"¥%.2f",price]:[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:floorNumber(price*self.couponStr.doubleValue)]];

    }
}
//增值服务
-(void)changeOtherBtutonClick:(UIButton *)button
{
    NSInteger section = button.tag/100;
    NSInteger row = button.tag%100;
    NSArray *keys = [self.addSeviceDic allKeys];
    NSString *key = keys[section];
    YHProductAddSeviceModel *seviceModel1 = self.addSeviceDic[key][row];
    [self.selectAddSevicedic setValue:seviceModel1 forKey:key];

    NSArray *arr = self.addSeviceDic[key];
    
    for (int i = 0; i < arr.count; i++) {
        YHProductAddSeviceModel *seviceModel = arr[i];

       
        if ([seviceModel.GoodsType isEqualToString:@"2"] ) {
            
             if ([seviceModel1.GoodsTitle isEqualToString:@"无"]){
                if ([seviceModel.GoodsTitle isEqualToString:seviceModel1.GoodsTitle])
                {
                         seviceModel.isSelected = !seviceModel.isSelected;
                }else
                {
                         seviceModel.isSelected = NO;
                }
                
            }else
            {
                if ([seviceModel.GoodsTitle isEqualToString:seviceModel1.GoodsTitle])
                {
                    seviceModel.isSelected = !seviceModel.isSelected;
                }
                
                if ([seviceModel.GoodsTitle isEqualToString:@"无"]) {
                    seviceModel.isSelected = NO;
                }
            }
          
        }else
        {
            if (row ==i) {
                seviceModel.isSelected = true;
            }else{
                seviceModel.isSelected = false;

            }
            
        }
    
    }
    [self.otherCollection reloadData];
    
}
-(void)nextpage
{
    if (self.selectAddSevicedic.count==0) {

        [self showWait:@"loading..." viewType:CurrentView];
    [[YHJsonRequest shared] getProductAddServiceGoodcode:productId SuccessBlock:^(NSDictionary *successMessage) {
       
        [self hideWait:CurrentView];
        self.addSeviceDic= successMessage;
        if (self.addSeviceDic.count>0) {
            
            [UIView animateWithDuration:.5 animations:^{
                scrolview.contentOffset  = CGPointMake(ScreenWidth, 0);
                self.confirmBtn.selected = YES;

            } completion:^(BOOL finished) {
                
            }];
            
        }else
        {
            
            NSString *price = [self.isInVoice isEqualToString:@"0"]?[Tools getHaveNum:productPrice]: [Tools getHaveNum:productPrice*(self.InvoiceRate+1)];
            
            self.labelPrice.text =self.isVip == YES? [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:floorNumber(price.doubleValue*self.couponStr.doubleValue) ]]:[NSString stringWithFormat:@"¥%@",price];
            self.theBottomlabelPrice.text = self.isVip == YES?[NSString stringWithFormat:@"¥%@",price]:[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:floorNumber(price.doubleValue*self.couponStr.doubleValue)]];
            
        }
        [self.otherCollection reloadData];
    } fialureBlock:^(NSString *errorMessages) {

        [self makeToast:errorMessages];
        [self hideWait:CurrentView];

    }];
    }else
    {
        if (self.addSeviceDic.count>0) {
            
            [UIView animateWithDuration:.5 animations:^{
                scrolview.contentOffset  = CGPointMake(ScreenWidth, 0);
                self.confirmBtn.selected = YES;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
        [self.otherCollection reloadData];
    }

}

-(void)backToMainParamsViewClick
{
    [UIView animateWithDuration:.5 animations:^{
        scrolview.contentOffset  = CGPointMake(0, 0);
        self.confirmBtn.selected = false;
    } completion:^(BOOL finished) {
        
        [self.selectAddSevicedic removeAllObjects];
       
    }];
   
}
-(void)confirmSeviceClick
{
    if (self.selectSpecIdDic.count != self.titleArray.count)
    {
        [self makeToast:@"参数选择未完成" duration:1.0 position:CSToastPositionCenter];
        return;
    }
        if (self.addSeviceDic.count== self.selectAddSevicedic.count && self.addSeviceDic.count > 0) {
            [UIView animateWithDuration:.5 animations:^{
                scrolview.contentOffset  = CGPointMake(0, 0);
                
            } completion:^(BOOL finished) {
                [self getPriceByConculateInvoiceState];
            }];
            
        }else{
            [self makeToast:@"参数选择未完成，请先选择参数" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    
}
#pragma mark ----Method
- (UIToolbar *)addToolbar{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}
- (void)textFieldDone{
    [self endEditing:YES];
    if ([self.Number.text integerValue]<= 0) {
        [self makeToast:@"该商品最少1件" duration:1.0 position:CSToastPositionCenter];
        self.Number.text =@"1";
        return;
    }
    if ([self.Number.text integerValue] >= 100000) {
        self.Number.text =@"99999";
        [self makeToast:@"该商品最多可选99999件" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.insuranceText.text.length>0) {
        if (self.addSeviceDic.count>0 &&self.selectAddSevicedic.count==0) {
            [self makeToast:@"请先选择增值服务" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        [self getinsrancePrice111];
    }
    if ([self.insuranceText.text integerValue]< 1) {
        self.insuranceText.text =@"1";
        [self makeToast:@"不能低于一份" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    recordTextNum =self.Number.text.integerValue;
    
}
- (void)addNumber{
    if ([self.Number.text integerValue] >= 99999) {
        self.Number.text =@"99999";
        [self makeToast:@"该商品最多可选99999件" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    self.Number.text = [NSString stringWithFormat:@"%ld",[self.Number.text integerValue]+1];
    recordTextNum++;
}
- (void)decreseNumber{
    if (self.addSeviceDic.count > 0 &&self.selectAddSevicedic.count==0) {
        [self makeToast:@"请先选择增值服务" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.Number.text integerValue]<= 1) {
        self.Number.text =@"1";
        [self makeToast:@"该商品已减至一件" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    self.Number.text = [NSString stringWithFormat:@"%ld",[self.Number.text integerValue]-1];
    recordTextNum--;
}
-(void)addInsranceNumber
{

    if ([self.insuranceText.text integerValue] >= 100) {
        self.insuranceText.text =@"100";
        [self makeToast:@"不能多于100份" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    self.insuranceText.text = [NSString stringWithFormat:@"%d",[self.insuranceText.text integerValue]+1];
    [self getinsrancePrice111];

}
-(void)decreseInsranceNumber
{
    if ([self.insuranceText.text integerValue]<  1) {
        self.insuranceText.text =@"1";
        [self makeToast:@"不能低于一份" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    self.insuranceText.text = [NSString stringWithFormat:@"%ld",[self.insuranceText.text integerValue]-1];
    [self getinsrancePrice111];
}
-(void)confirm:(UIButton *)button{
    if (button.selected == NO) {
        [MobClick event:@"AddCart" label:@"加入购物车"];

     if (self.selectSpecIdDic.count != self.titleArray.count)
    {
        [self makeToast:@"参数选择未完成" duration:1.0 position:CSToastPositionCenter];
        return;
    }
        if (self.addSeviceDic.count>0 && self.selectAddSevicedic.count ==0) {
            
            [self nextpage];
            return;
        }
    if (self.confirmBlock) {
        
       
        if (self.selectAddSevicedic.count == self.addSeviceDic.count &&self.selectAddSevicedic.count>0 ) {

            for (NSString *key in self.addSeviceDic.allKeys) {
                
                NSArray *keyArr = self.addSeviceDic[key];
                for (YHProductAddSeviceModel *model in keyArr) {
                    if (model.isSelected ==YES) {
                        NSLog(@"YHProductAddSeviceModel==%@-%@",model.GoodsTitle,model.ProductId);
                        if (model.ProductId.length>0) {
                            NSDictionary *dic = @{@"ProductId":model.ProductId,@"ProductNumber":@"1"};
                            [self.ProductIdArr addObject:dic];
                        }
                       
                    }
                    NSLog(@"=ProductName%@-%@ iselrct==%d",model.GoodsTitle,model.ProductId,model.isSelected);

                   
                }
                
            }

//            NSString *isStr = [NSString stringWithFormat:@"%@",self.GoodsInsuranceRate];
            if (self.GoodsInsuranceRate != 0 ) {
                NSDictionary *dicId = @{@"ProductId":self.GoodsInsuranceId,@"ProductNumber":self.insuranceText.text};
                [self.ProductIdArr addObject:dicId];

            }

        }
        button.userInteractionEnabled = NO;
        NSInteger num = [self.Number.text integerValue];
        num = num==0?1:num;

        self.confirmBlock(self.ProductIdArr,num,self.isInVoice);
    }
    }
   
}

//通过namArr（选中所有参数的参数名数组 ）筛选array商品中的产品 返回个产品的dicArray
-(NSArray  *)getproductId:(NSArray *)array selectParamS:(NSArray *)nameArr
{
    NSMutableArray *dicArr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        int record =0;

        for (int i= 0; i<self.titleArray.count; i++) {
            productIndex *indexMModel = self.titleArray[i];
            productParamModel *model = dic[indexMModel.ParamId];
            NSString *resultModelNameStr = nameArr[i];
            //            if ([nameArr containsObject:model.ParamName]) {
            if ([resultModelNameStr isEqualToString:model.ParamOptionalName]) {
                NSLog(@"resultModelNameStr= %@---ParamName-%@",resultModelNameStr,model.ParamOptionalName);
                record++;
            }

            if (record == self.titleArray.count) {

                [dicArr addObject:dic];
            }
        }

    }

    return dicArr;
}

//通过specId条件筛选array1数组中的商品 展示界面的显示
-(NSArray *)getdiferentArr:(NSArray *)array1 contion:(NSString *)specId
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    NSMutableArray *dateMutablearray = [NSMutableArray array ];
    NSMutableDictionary *compareDic = [NSMutableDictionary dictionary] ;
    
    for (int i = 0; i < array.count; i ++) {
        
        NSDictionary *dic =  array[i];
        productParamModel *model = dic[specId];
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [tempArray addObject:dic];
        NSMutableIndexSet *indexset = [[NSMutableIndexSet alloc] init];
        for (int j = i+1; j < array.count; j ++) {
            
            NSDictionary *dic2 = array[j];
            productParamModel *model2 = dic2[specId];
            
            if([model.ParamOptionalName isEqualToString:model2.ParamOptionalName]){
                [tempArray addObject:dic2];
                [indexset addIndex:j];

            }
            
        }
        [array removeObjectsAtIndexes:indexset];
        [dateMutablearray addObject:tempArray];
        NSString *key = [NSString stringWithFormat:@"%@",model.ParamOptionalName];//OrderTag
//        NSLog(@"key==%@==%@-----%@",model.ParamName,model.ParamValue,key);
        [compareDic setObject:tempArray forKey:key];
    }
    NSArray *keyArr = [compareDic allKeys];
    NSStringCompareOptions comparisonOptions = NSNumericSearch | NSCaseInsensitiveSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *keys = [keyArr sortedArrayUsingComparator:sort];

  NSMutableArray *resultArr =  [NSMutableArray array];

    for (NSString *keyStr in keys) {
        NSArray* result = compareDic[keyStr];
        [resultArr addObject:result];
        
    }
    return resultArr;
    
}
//对选择好的参数的得到Product数组进行处理，并决定跳转页面
-(void)getResultProduct:(NSInteger)section row:(NSInteger)row
{
    //选好参数，返回的productId
    if (self.selectSpecIdDic.count == self.titleArray.count) {
        
        self.selectAddSevicedic = [NSMutableDictionary dictionary];
        

        NSArray *dicArr=    [self getproductId:self.largeArray selectParamS:recordParamsName];
        if (dicArr.count==1) {
            
            self.ProductIdArr = [NSMutableArray array];
            
            NSDictionary *dic = [dicArr firstObject];
            
            productParamModel *paramsModel = dic.allValues[0];;
//
//            self.labelTax.text = paramsModel.GoodsTitle;
            productPrice =[[Tools getHaveNum:paramsModel.PruductPrice.doubleValue] doubleValue] ;
            self.saleOriginPrice = paramsModel.PruductPrice;
            if (self.isStore == YES && [self.isInVoice isEqualToString:@"1"]) {
             
                
                NSString *price = [Tools getHaveNum:floorNumber(paramsModel.PruductPrice.doubleValue*(1+self.InvoiceRate))];
                
                self.labelPrice.text =self.isVip == YES? [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:floorNumber(price.doubleValue*self.couponStr.doubleValue)]]:[NSString stringWithFormat:@"¥%@",price];
                self.theBottomlabelPrice.text = self.isVip == YES?[NSString stringWithFormat:@"¥%@",price]:[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:floorNumber(price.doubleValue*self.couponStr.doubleValue)]];
                

            }else
            {
             
                
                NSString *price = [Tools getHaveNum:paramsModel.PruductPrice.doubleValue];
                
                self.labelPrice.text =self.isVip == YES? [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:price.doubleValue*self.couponStr.doubleValue]]:[NSString stringWithFormat:@"¥%@",price];
                self.theBottomlabelPrice.text = self.isVip == YES?[NSString stringWithFormat:@"¥%@",price]:[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:price.doubleValue*self.couponStr.doubleValue]];
            }
            collectionFooterHeight = 200;
            
            productId = paramsModel.ProductId;
            NSDictionary *dicId = @{@"ProductId":paramsModel.ProductId,@"ProductNumber":@"1"};
            
            [self.ProductIdArr addObject:dicId];
            [self nextpage];
        }else{
            
            if (dicArr.count >1) {
                [self makeToast:@"参数异常，请联系客服"];
                
                return;
            }
            else
            {

                self.filterArr = [self.largeArray mutableCopy];
                self.ProductFilterArr =[self getdiferentArr22222222:self.largeArray namArr:recordParamsName contion:self.selectSpecIdDic.allValues];
                
            }
        }
    }
}

//通过specId条件筛选array1数组中的商品（逐步筛选参数）
-(NSArray *)getdiferentArr22222222:(NSArray *)array1 namArr:(NSArray *)nameArr contion:(NSArray *)specIds
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    NSMutableArray *recordArr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i ++) {
        int record =0;
        NSDictionary *dic =  array[i];
        for (NSString *key in specIds) {
            productParamModel *model = dic[key];
            if ([nameArr containsObject:model.ParamOptionalName]) {
                record++;
            }
            if (record == specIds.count) {
                [recordArr addObject:dic];
            }
        }
    }

    return recordArr;
}


-(UIView *)getColloectionView:(UIView *)item
{
    if (bgFootView==nil) {
        bgFootView = [[UIView alloc] init];
        UIView * insuranceView1 = [self getItemView:bgFootView Title:@"保险" isShowPrice:YES Num:@"1"];
        [insuranceView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(30));
            make.top.mas_equalTo(2);
            make.width.mas_equalTo(ScreenWidth);
        }];
      
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [bgFootView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-12));
            make.height.mas_equalTo(HeightRate(1));
            make.left.mas_equalTo(WidthRate(26));
            make.top.mas_equalTo(insuranceView1.mas_bottom).offset(HeightRate(10));
        }];
        
//        NSString *isStr = [NSString stringWithFormat:@"%@",self.GoodsInsuranceRate];
        if (self.GoodsInsuranceRate == 0 ) {
            [line mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(3);
                make.height.mas_equalTo(HeightRate(0.01));
                
            }];
            insuranceView1.hidden = YES;
            [insuranceView1 mas_updateConstraints:^(MASConstraintMaker *make) {
                                make.height.mas_equalTo(HeightRate(0.01));
            
                            }];
        }else
        {
            insuranceView1.hidden = NO;

            [self getinsrancePrice111];
        }
        recordTextNum = recordTextNum==0?1:recordTextNum;
        UIView * NumberView = [self getItemView:bgFootView Title:@"数量" isShowPrice:false Num:[NSString stringWithFormat:@"%ld",recordTextNum]];
        [NumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(30));
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(3));
            make.width.mas_equalTo(ScreenWidth);

        }];
        
    }
    return bgFootView;
    
}
-(UIView *)getItemView:(UIView *)bgview Title:(NSString *)Title isShowPrice:(BOOL)isShow Num:(NSString *)num
{

        UIView * insuranceView= [[UIView alloc] init];
        [bgFootView addSubview:insuranceView];
        UILabel *insuranceLable = [[UILabel alloc]init];
        insuranceLable.textColor = TextColor_636263;
        insuranceLable.text =Title; //@"保险";
        insuranceLable.font = SYSTEM_FONT(AdaptFont(14));
        [insuranceView addSubview:insuranceLable];
        [insuranceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(26));
            make.height.mas_equalTo(HeightRate(25));
            make.top.mas_equalTo(HeightRate(13));
        }];
    
        UIImageView *addOrDecreaseImage1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"addOrDecrease"]];
        [insuranceView addSubview:addOrDecreaseImage1];
        [addOrDecreaseImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-11));
            make.height.mas_equalTo(HeightRate(30));
            make.width.mas_equalTo(WidthRate(145));
            make.centerY.mas_equalTo(insuranceLable.mas_centerY);
            
        }];
        
        UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(28)];
        [addBtn setTitleColor:ColorWithHexString(@"bbbbbb") forState:UIControlStateNormal];
        [insuranceView addSubview:addBtn];
        
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(insuranceLable.mas_centerY);
            make.right.mas_equalTo(WidthRate(-12));
            make.height.mas_equalTo(HeightRate(24));
            make.width.mas_equalTo(WidthRate(40));
            
        }];
        
        UITextField * insuranceText = [[UITextField alloc]init];
        insuranceText.text =[NSString stringWithFormat:@"1"];
        insuranceText.textAlignment =NSTextAlignmentCenter;
        insuranceText.keyboardType = UIKeyboardTypeNumberPad;
        insuranceText.font = [UIFont systemFontOfSize:AdaptFont(15)];
        insuranceText.textColor = TextColor_383838;
        insuranceText.delegate = self;
        insuranceText.inputAccessoryView = [self addToolbar];
        [insuranceView addSubview:insuranceText];
        [insuranceText mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(addBtn.mas_left).offset(WidthRate(-3));
            make.width.mas_equalTo(WidthRate(50));
            make.centerY.mas_equalTo(insuranceLable.mas_centerY);
            make.height.mas_equalTo(HeightRate(26));
        }];
        
        UIButton *decreseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [decreseBtn setTitleColor:ColorWithHexString(@"bbbbbb") forState:UIControlStateNormal];
        decreseBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(28)];

        [insuranceView addSubview:decreseBtn];

        [decreseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(insuranceLable.mas_centerY);
            make.right.mas_equalTo(insuranceText.mas_left).offset(-5);
            make.height.mas_equalTo(HeightRate(24));
            make.width.mas_equalTo(WidthRate(35));
        }];
    
        if (isShow ==YES) {
            UILabel *insurancePrice = [[UILabel alloc] init];
            insurancePrice.textColor = ColorWithHexString(StandardBlueColor);
            insurancePrice.text = @"¥0";
            [insuranceView addSubview:insurancePrice];
            self.insurancePrice = insurancePrice;
            [insurancePrice mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(WidthRate(82));
                make.height.mas_equalTo(HeightRate(23));
                make.left.mas_equalTo(insuranceLable.mas_right).offset(WidthRate(15));
                make.centerY.mas_equalTo(insuranceLable.mas_centerY);
            }];
            [addBtn addTarget:self action:@selector(addInsranceNumber) forControlEvents:UIControlEventTouchUpInside];
             [decreseBtn addTarget:self action:@selector(decreseInsranceNumber) forControlEvents:UIControlEventTouchUpInside];
            self.insuranceText = insuranceText;
        }else
        {
            self.addItemBtn = addBtn;
            [self.addItemBtn addTarget:self action:@selector(addNumber) forControlEvents:UIControlEventTouchUpInside];
            self.decreseItemBtn =  decreseBtn;
            [self.decreseItemBtn addTarget:self action:@selector(decreseNumber) forControlEvents:UIControlEventTouchUpInside];
            self.Number = insuranceText;
        }
    if (isShow == YES) {
        self.insuranceText.text = num;

    } else {
        
        self.Number.text = num;

    }
    return insuranceView;
}

-(void)getPriceByConculateInvoiceState
{
    
    CGFloat result = 0.0;//附件价格
    CGFloat result0 = 0.0;//附件价格

    CGFloat result1 = 0.0;//品牌价格（普通）
    CGFloat result11 = 0.0;//品牌价格（会员）

    NSString * resultstr1 ;
    NSMutableArray *storeStr= [[NSMutableArray alloc] init];
    
    for (NSString *key in self.addSeviceDic.allKeys) {
        NSArray * arr = self.addSeviceDic[key];
        for ( int i = 0;i< arr.count;i++) {
            YHProductAddSeviceModel *seviceModel = arr[i];
            if (seviceModel.isSelected == YES) {
                double price = [[Tools getHaveNum:productPrice] doubleValue];
                if ([seviceModel.GoodsType isEqualToString:@"2"] ) {//附件的价格
                    result += [[Tools getHaveNum:seviceModel.GoodsPrice.doubleValue] doubleValue];
                    result0 += [[Tools getHaveNum:floorNumber(seviceModel.GoodsPrice.doubleValue*self.couponStr.doubleValue) ] doubleValue];
                    if (storeStr.count == 0 ) {
                        NSString * resultTitle =[NSString stringWithFormat:@"%@:  %@          ¥%@",key,seviceModel.GoodsTitle ,[Tools getHaveNum:seviceModel.GoodsPrice.doubleValue]];
                        [storeStr addObject:resultTitle];
                    }else
                    {
                        NSString *resultTitle =[NSString stringWithFormat:@"          %@          ¥%@",seviceModel.GoodsTitle ,[Tools getHaveNum:seviceModel.GoodsPrice.doubleValue]];
                        [storeStr addObject:resultTitle];
                        
                    }
                    
                    
                }else
                {
                    if ([seviceModel.GoodsTitle isEqualToString:@"无"]) {
                        result1 = 0;
                    }else
                    {

                        CGFloat sevicePrice = floorNumber(price*seviceModel.GoodsPrice.doubleValue);
                        CGFloat sevicePrice1 = floorNumber(price* seviceModel.GoodsPrice.doubleValue*self.couponStr.doubleValue)
                        ;
                        if ([self.isInVoice isEqualToString:@"1"] && self.isStore == YES) {
                            result1 =[[Tools getHaveNum:floorNumber(sevicePrice*(1+self.InvoiceRate))] doubleValue];
                            result11 = [[Tools getHaveNum:floorNumber(sevicePrice1*(1+self.InvoiceRate))] doubleValue];;

                        }else
                        {
                            
                            result1 =[[Tools getHaveNum:sevicePrice] doubleValue];
                            result11 = [[Tools getHaveNum:sevicePrice1] doubleValue];
                        }
                        
                    }
                    resultstr1 = [NSString stringWithFormat:@"%@:%@          ¥%@",key,seviceModel.GoodsTitle,[Tools getHaveNum:self.isVip==YES?result11:result1]];
                }
            }
            
        }
    }
    
    if(storeStr.count <=0)
    {
        recordAddAuStrHeight = 0.01;
        recordAddBrandStrHeight = 20;
    }else if(resultstr1.length<=0)
    {
        recordAddAuStrHeight= (storeStr.count*20);
        recordAddBrandStrHeight = 0.01;
    }else
    {
        recordAddAuStrHeight= (storeStr.count*20);
        recordAddBrandStrHeight = 20;
    }
    recordAddAuStr = [storeStr componentsJoinedByString:@"\n"];
    NSLog(@"recordAddAuStr==%@",recordAddAuStr);
    recordAddBrandStr = resultstr1;
    if (resultstr1.length<=0 && storeStr.count <=0 && self.isStore == YES) {
      
        NSString *price = [self.isInVoice isEqualToString:@"0"]?[Tools getHaveNum:productPrice]: [Tools getHaveNum:productPrice*(self.InvoiceRate+1)];
       
        
        self.labelPrice.text =self.isVip == YES? [NSString stringWithFormat:@"¥%@",[Tools getHaveNum: floorNumber(price.doubleValue*self.couponStr.doubleValue) ]]:[NSString stringWithFormat:@"¥%@",price];
        self.theBottomlabelPrice.text = self.isVip == YES?[NSString stringWithFormat:@"¥%@",price]:[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:floorNumber(price.doubleValue*self.couponStr.doubleValue)]];
        
    }else{
        
        NSString *price = [Tools getHaveNum: result+result1+productPrice];
        CGFloat vipProductPrice =floorNumber(productPrice*self.couponStr.doubleValue) ;
        CGFloat vipProductAuxiPrice = result0; //floorNumber(result*self.couponStr.doubleValue) ;

        NSString *price1 = [Tools getHaveNum:(vipProductAuxiPrice+result11 +vipProductPrice )];

        self.labelPrice.text =self.isVip == YES? [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:price1.doubleValue]]:[NSString stringWithFormat:@"¥%@",price];
        self.theBottomlabelPrice.text = self.isVip == YES?[NSString stringWithFormat:@"¥%@",price]:[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:price1.doubleValue]];
    
        collectionFooterHeight = 130+recordAddAuStrHeight+recordAddBrandStrHeight+10;

    }
    self.confirmBtn.hidden = false;
    [self.collection reloadData];
    self.confirmBtn.selected = NO;
}
@end
