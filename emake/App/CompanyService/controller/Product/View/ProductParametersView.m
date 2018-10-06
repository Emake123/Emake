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
#import "productFootView.h"

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
    NSString *recordAddseviceStr;
    UIView *bgFootView;
    UIScrollView *scrolview;
    CGFloat productPrice;
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
@property (nonatomic,strong)UILabel *insurancePrice;
@property (nonatomic,strong)UILabel *addSevicePrice;

@property (nonatomic,retain)TPKeyboardAvoidingCollectionView *collection;
@property (nonatomic,retain)TPKeyboardAvoidingCollectionView *otherCollection;

@property (nonatomic,copy)NSString *salePrice;
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


@property (nonatomic,retain)NSArray *ProductFilterArr;

@property (nonatomic,retain)NSMutableArray *recordFilterNameArr;

@end
@implementation ProductParametersView
- (instancetype)initWithItemImage:(NSString *)itemImageUrl PriceValue:(NSString *)priceValue taxDecription:(NSString *)taxDetail largeArray:(NSArray *)largeArray andTitleArray:(NSArray *)titleArray{
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

       self.recordFilterNameArr = [NSMutableArray array];
        for (int i = 0; i<titleArray.count; i++) {
            [self.selectIndexArray addObject:@"-1"];
            [recordParamsName addObject:@" "];
            [recordParamId addObject:@" "];

        }
        self.salePrice = priceValue;
        self.saleOriginPrice = priceValue;
        self.largeArray = largeArray;
        self.titleArray = titleArray;
        self.backgroundColor = [UIColor clearColor];
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        UIColor *color = [UIColor blackColor];
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-HeightRate(185));
        
        UIImageView *itemImage = [[UIImageView alloc]init];
        [itemImage sd_setImageWithURL:[NSURL URLWithString:itemImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
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
        productImage = itemImage;
        self.labelPrice = [[UILabel alloc]init];
        self.labelPrice.text = priceValue;
        self.labelPrice.font = SYSTEM_FONT(AdaptFont(16));
        self.labelPrice.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.labelPrice.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.labelPrice];
        
        [self.labelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(itemImage.mas_right).offset(WidthRate(7));
            make.top.mas_equalTo(HeightRate(37));
            make.height.mas_equalTo(HeightRate(26));
        }];
        
        UILabel *labelTax = [[UILabel alloc]init];
        labelTax.text = taxDetail;
        labelTax.font = [UIFont systemFontOfSize:AdaptFont(13)];
        labelTax.textColor = ColorWithHexString(SymbolTopColor);

        [self addSubview:labelTax];
        
        [labelTax mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.labelPrice.mas_bottom);
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
        scrolview.backgroundColor = [UIColor lightGrayColor];
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
        for (int i = 0; i<2; i++) {
        
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        TPKeyboardAvoidingCollectionView *collection = [[TPKeyboardAvoidingCollectionView alloc]initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, HeightRate(350)) collectionViewLayout:layout];
    
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

            }else
            {

                [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item1"];
                [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];
                self.otherCollection = collection;

            }
            
        }
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.confirmBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
        [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        self.confirmBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.confirmBtn];
//        self.confirmBtn.tag = 80;//当tag为80为self.otherCollection页面的确定，tag为81，collection页面的确定
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(45));
        }];
    self.unSelectArr  = [self.largeArray mutableCopy];
    self.filterArr  = [ self.largeArray  mutableCopy];

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
#pragma mark -----UICollectionViewDelegate & UICollectionViewDataSources
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView.tag ==collectionTag) {
        
    productIndex *indexmodel = self.titleArray[section];
    NSArray *arr  ;

    arr  = [self getdiferentArr:self.largeArray contion:indexmodel.SpecId];

    

    return arr.count;
        
    }
    else
    {
        NSArray *keys = [self.addSeviceDic allKeys];
        NSString *key = keys[section];
        NSArray *arr = self.addSeviceDic[key];
        return arr.count;
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag ==collectionTag) {
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
        
    NSArray *arr  ;
    productIndex *indexmodel = self.titleArray[indexPath.section];
    arr  = [self getdiferentArr:self.largeArray contion:indexmodel.SpecId];
    NSDictionary *dic = arr[indexPath.row][0];
    productParamModel *model2 = dic[indexmodel.SpecId];
    [btn setTitle:model2.ParamName forState:UIControlStateNormal];


    
    btn.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
    btn.layer.borderWidth = 1;
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 3;
    [btn addTarget:self action:@selector(changeBtutonClick:) forControlEvents:UIControlEventTouchUpInside];
    
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

    
    
    
    [item addSubview:btn];
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
        [btn1 setTitle:seviceModel.ProductName forState:UIControlStateNormal];
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

    productIndex *indexmodel = self.titleArray[indexPath.section];
    NSArray *arr  = [self getdiferentArr:self.largeArray contion:indexmodel.SpecId];
    
   NSDictionary *dic  = arr[indexPath.row][0];
    productParamModel *model2 = dic[indexmodel.SpecId];
    NSString *text = model2.ParamName;
    CGSize size = [Tools calcTextSize:text Size:AdaptFont(12)];
    return CGSizeMake(WidthRate(size.width+20), HeightRate(31));
    }else
    {
        NSArray *keys = [self.addSeviceDic allKeys];
        NSString *key = keys[indexPath.section];
        NSArray *arr = self.addSeviceDic[key];
        YHProductAddSeviceModel *seviceModel = arr[indexPath.row];
        CGSize size = [Tools calcTextSize:seviceModel.ProductName Size:AdaptFont(12)];
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
    if (collectionTag == collectionView.tag) {
        
    
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
        productIndex *indexmodel = self.titleArray[indexPath.section];
        label.text = indexmodel.SpecName;
        [view addSubview:label];
        return view;
    }else{
        if (indexPath.section == (self.titleArray.count-1)){
            
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
            if (self.selectSpecIdDic.count == self.titleArray.count && self.addSeviceDic.count>0) {//有数据才进来
                
                [NextView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(15);

                    make.height.mas_equalTo(HeightRate(48));
                }];
                UILabel *nextLable1 = [[UILabel alloc] init];
                nextLable1.backgroundColor = TextColor_F7F7F7;
                nextLable1.font = [UIFont systemFontOfSize:AdaptFont(12)];
                nextLable1.numberOfLines = 2;
                nextLable1.text = recordAddseviceStr;
               nextLable1.textColor = ColorWithHexString(StandardBlueColor);

                [NextView addSubview:nextLable1];
                [nextLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(WidthRate(26));
                    make.right.mas_equalTo(WidthRate(-41));
                    make.height.mas_equalTo(HeightRate(40));
                    make.centerY.mas_equalTo(NextView.mas_centerY);
                    
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
                    make.right.mas_equalTo(WidthRate(-11));
                    make.height.mas_equalTo(HeightRate(18));
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
    }else
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
            label.text = key;
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
        
      if (section == (self.titleArray.count-1))
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
    
    static BOOL isFirst = NO;
    NSInteger section = button.tag/100;
    NSInteger row = button.tag%100;
    
    NSArray * array ;
    NSString *specId = self.selectSpecIdDic[@(section)];
    productIndex *indexmodel = self.titleArray[section];
    [recordParamsName replaceObjectAtIndex:section withObject:button.currentTitle];
//    if (specId.length>0) {
//
//        NSArray *filterarray =self.RecordFilterdic[indexmodel.SpecId];
//        array  = [self getdiferentArr:self.largeArray contion:indexmodel.SpecId];
//    }
//    else
//    {
        array  = [self getdiferentArr:self.filterArr contion:indexmodel.SpecId];
        [self.RecordFilterdic setValue:[self.filterArr copy]  forKey:indexmodel.SpecId];
        [self.selectSpecIdDic setObject:indexmodel.SpecId forKey:@(section)];
        [self.selectSpecIdDict setObject:indexmodel.SpecId forKey:@(section)];

//    }
    [recordParamsName replaceObjectAtIndex:section withObject:button.currentTitle];

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
        recordAddseviceStr = self.salePrice;
        self.labelPrice.text =self.salePrice;
        [self.recordFilterNameArr removeObjectsAtIndexes:set];
    } else {
        [self.recordFilterNameArr addObject:@(section)];
        
    }
    
    
    self.ProductFilterArr =[self getdiferentArr22222222:self.largeArray namArr:recordParamsName contion:self.selectSpecIdDic.allValues];

    
    selectSpecId = indexmodel.SpecId;
    
    
    [self.selectIndexArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%ld",row]];
    button.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
    [button setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
    

    [self getselectArr];

    [self getResultProduct:section row:0];

    [self.collection reloadData];
    
}
-(void)getselectArr
{
    for ( NSInteger section1 = 0 ;section1 < self.titleArray.count ; section1 ++  ) {
        productIndex *indexmodel2 = self.titleArray[section1];
        
        NSArray * Arr  = [self getdiferentArr:self.largeArray contion:indexmodel2.SpecId];
        NSArray * Arr1;
        if ([self.selectSpecIdDict.allValues containsObject:indexmodel2.SpecId]) {
            
            
        }else
        {
            Arr1 = [self getdiferentArr:self.ProductFilterArr.count>0?self.ProductFilterArr:self.largeArray contion:indexmodel2.SpecId];
            NSMutableArray  *unselectArray = [NSMutableArray array];
            for (int i = 0; i<[Arr count]; i++) {
                [unselectArray addObject:@"-1"];
                NSArray *array3 =Arr[i];
                NSDictionary *dic = array3[0];//[obj objectAtIndex:idx];
                productParamModel *model = dic[indexmodel2.SpecId];
                
                for (NSArray *sArr in Arr1) {
                    NSDictionary *dic2 = sArr[0];
                    productParamModel *model2 = dic2[indexmodel2.SpecId];
                    if ([model.ParamName isEqual:model2.ParamName]) {
                        
                        if (Arr1.count ==1) {
                            
                            [self.selectIndexArray replaceObjectAtIndex:section1 withObject:[NSString stringWithFormat:@"%d",i]];
                            [recordParamsName replaceObjectAtIndex:section1 withObject:model.ParamName];
                            [self.selectSpecIdDic setObject:indexmodel2.SpecId forKey:@(section1)];
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
            

            if ([seviceModel.arithType isEqualToString:@"1"] ) {
                result = ( seviceModel.ProductPrice.doubleValue)*100;
                
            }else
            {
                if ([seviceModel.ProductName isEqualToString:@"无"]) {
                result1 = 0;
                }else{
                result1 = price*seviceModel.ProductPrice.doubleValue*100;
                }
            }

        }
            
    
      
        CGFloat insuranceFee= (self.GoodsInsuranceRate.doubleValue*productPrice*self.insuranceText.text.intValue*100);
        self.insurancePrice.text = [NSString stringWithFormat:@"¥%.2f",round(insuranceFee)/100.0];
        self.labelPrice.text = [NSString stringWithFormat:@"¥%.2f",(round(result)/100.0+round(result1)/100.0+round(insuranceFee)/100.0+round(productPrice*100)/100)];

    }
}
//增值服务
-(void)changeOtherBtutonClick:(UIButton *)button
{
    NSInteger section = button.tag/100;
    NSInteger row = button.tag%100;
    NSArray *keys = [self.addSeviceDic allKeys];
    NSString *key = keys[section];
    YHProductAddSeviceModel *seviceModel = self.addSeviceDic[key][row];
    [self.selectAddSevicedic setValue:seviceModel forKey:key];

    NSArray *arr = self.addSeviceDic[key];
    for (int i = 0; i < arr.count; i++) {
        YHProductAddSeviceModel *seviceModel = arr[i];

        if (row ==i) {
            seviceModel.isSelected = true;
        }else{
            seviceModel.isSelected = false;

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
   
     if (self.selectSpecIdDic.count != self.titleArray.count)
    {
        [self makeToast:@"参数选择未完成" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.confirmBlock) {
        if (self.selectAddSevicedic.count == self.addSeviceDic.count &&self.selectAddSevicedic.count>0 ) {
            
            for (NSString *key in self.selectAddSevicedic.allKeys) {
                YHProductAddSeviceModel *seviceModel = self.selectAddSevicedic[key];
                
                if (![seviceModel.ProductName isEqualToString:@"无"]) {
                    if (seviceModel.ProductId.length>0) {
                        
                    
                    NSDictionary *dic = @{@"ProductId":seviceModel.ProductId,@"ProductNumber":@"1"};
                    [self.ProductIdArr addObject:dic];
                    }
                }
            }
            NSString *isStr = [NSString stringWithFormat:@"%@",self.GoodsInsuranceRate];
            if (![isStr isEqualToString:@"0"] ) {
                NSDictionary *dicId = @{@"ProductId":self.GoodsInsuranceId,@"ProductNumber":self.insuranceText.text};
                [self.ProductIdArr addObject:dicId];

            }

        }
        button.userInteractionEnabled = NO;
        NSInteger num = [self.Number.text integerValue];
        num = num==0?1:num;

        self.confirmBlock(self.ProductIdArr,num);
    }
    }
    if (button.selected == YES) {
        
        if (self.addSeviceDic.count== self.selectAddSevicedic.count && self.addSeviceDic.count > 0) {
            [UIView animateWithDuration:.5 animations:^{
                scrolview.contentOffset  = CGPointMake(0, 0);
                
            } completion:^(BOOL finished) {
                CGFloat result = 0.0;
                CGFloat result1 = 0.0;
            NSString * resultstr ;
            NSString * resultstr1 ;
       
                for (NSString *key in self.selectAddSevicedic.allKeys) {
                    YHProductAddSeviceModel *seviceModel = self.selectAddSevicedic[key];
                    CGFloat price = productPrice;
                    if ([seviceModel.arithType isEqualToString:@"1"] ) {
                        result = ( seviceModel.ProductPrice.doubleValue)*100;
                        resultstr = [NSString stringWithFormat:@"%@:%@ ¥%.2f",key,seviceModel.ProductName,round(seviceModel.ProductPrice.doubleValue*100)/100.0];

                        
                    }else
                    {
                     if ([seviceModel.ProductName isEqualToString:@"无"]) {
                        result1 = 0;
                      }else
                       {
                        result1 = price*seviceModel.ProductPrice.doubleValue*100;
                        
                       }
                      resultstr1 = [NSString stringWithFormat:@"%@:%@ ¥%.2f",key,seviceModel.ProductName,round(result1)/100];
                    }
                    
                }
                if (resultstr.length>0 && resultstr1.length>0) {
                    recordAddseviceStr = [NSString stringWithFormat:@"%@\n%@",resultstr,resultstr1];

                } else if(resultstr.length>0||resultstr1.length>0) {
                    recordAddseviceStr = [NSString stringWithFormat:@"%@",resultstr.length>0?resultstr:resultstr1];

                }
                self.addSevicePrice.text  =recordAddseviceStr;
                self.labelPrice.text = [NSString stringWithFormat:@"¥%.2f",(round(result)/100.0+round(result1)/100+round(productPrice*100)/100)];
                collectionFooterHeight = 145;
                self.confirmBtn.hidden = false;
                [self.collection reloadData];
                self.confirmBtn.selected = NO;
            }];
        }else
        {
                [self makeToast:@"参数选择未完成，请先选择参数" duration:1.0 position:CSToastPositionCenter];
                return;
        }
        
    }
}

//通过namArr（选中所有参数的参数名数组 ）筛选array商品中的产品 返回唯一的一个产品的dic
-(NSArray  *)getproductId:(NSArray *)array selectParamS:(NSArray *)nameArr
{
    NSMutableArray *dicArr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        int record =0;

        for (int i= 0; i<self.titleArray.count; i++) {
            productIndex *indexMModel = self.titleArray[i];
            productParamModel *model = dic[indexMModel.SpecId];
            NSString *resultModelNameStr = nameArr[i];
            //            if ([nameArr containsObject:model.ParamName]) {
            if ([resultModelNameStr isEqualToString:model.ParamName]) {
                NSLog(@"resultModelNameStr= %@---ParamName-%@",resultModelNameStr,model.ParamName);
                record++;
            }
            
            if (record == self.titleArray.count) {

                [dicArr addObject:dic];
            }
        }
        
    }
    
    return dicArr;
}
//通过namArr（选中所有参数的参数名数组 ）筛选array商品中的产品 返回唯一的一个产品的dic
-(NSArray *)get111productId:(NSArray *)array selectParamS:(NSArray *)nameArr selectParamS:(NSArray *)titleArr
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        int record =0;
        
        for (int i= 0; i<titleArr.count; i++) {
            productIndex *indexMModel = self.titleArray[i];
            productParamModel *model = dic[indexMModel.SpecId];
            if ([nameArr containsObject:model.ParamName]) {
                record++;
            }
            
            if (record == self.titleArray.count) {
                
                [arr addObject:dic];
                NSLog(@"筛选array商品中的产品 返回唯一的一个产品的dic====%@",model.ParamName);
            }
        }
        
    }
    
    return arr;
}
//通过specId条件筛选array1数组中的商品
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
            
            if([model.ParamName isEqualToString:model2.ParamName]){
                [tempArray addObject:dic2];
                [indexset addIndex:j];

            }
            
        }
        [array removeObjectsAtIndexes:indexset];
        [dateMutablearray addObject:tempArray];
        NSString *key = [NSString stringWithFormat:@"%@",model.ParamName];//OrderTag
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
//根据选好的参数，直接在数据确定唯一产品（当产品出现参数异常时是该产品通过选中的参数得到的productid不少于2个）
-(void)getResultProduct:(NSInteger)section row:(NSInteger)row
{
    //选好参数，返回的productId
    if (self.selectSpecIdDic.count == self.titleArray.count) {
        
        self.selectAddSevicedic = [NSMutableDictionary dictionary];
        

        NSArray *dicArr=    [self getproductId:self.largeArray selectParamS:recordParamsName];
        if (dicArr.count==1) {
            
            self.ProductIdArr = [NSMutableArray array];
            
            NSDictionary *dic = [dicArr firstObject];
            
            productParamModel *modelImage = dic[@"00030"];;//产品图片
            
            [productImage sd_setImageWithURL:[NSURL URLWithString:modelImage.ParamValue]];
            productParamModel *modelprice = dic[@"00017"];;//产品价格
            self.labelPrice.text = [NSString stringWithFormat:@"¥%@",modelprice.ParamValue];
            productPrice = modelprice.ParamValue.doubleValue;
            
            collectionFooterHeight = 130;
            
            productId = modelImage.ProductId;
            NSDictionary *dicId = @{@"ProductId":modelImage.ProductId,@"ProductNumber":@"1"};
            
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

//通过specId条件筛选array1数组中的商品
-(NSArray *)getdiferentArr22222222:(NSArray *)array1 namArr:(NSArray *)nameArr contion:(NSArray *)specIds
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    NSMutableArray *recordArr = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i ++) {
        int record =0;
        NSDictionary *dic =  array[i];
        for (NSString *key in specIds) {
            productParamModel *model = dic[key];
            if ([nameArr containsObject:model.ParamName]) {
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
        
        NSString *isStr = [NSString stringWithFormat:@"%@",self.GoodsInsuranceRate];
        if ([isStr isEqualToString:@"0"] ) {
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


@end
