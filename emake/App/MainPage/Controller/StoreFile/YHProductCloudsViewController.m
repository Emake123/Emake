//
//  YHProductCloudsViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/10.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHProductCloudsViewController.h"
#import "YHTitleView.h"
#import "ProductCollectionViewCell.h"
#import "YHProductDetailsViewController.h"
#import "YhSearchModel.h"
#import "ChatNewViewController.h"
#import "YHStoreModel.h"
#import "UIButton+WebCache.h"
#import "YHProductStoreIntrocdutctionViewController.h"
@interface YHProductCloudsViewController ()<YHTitleViewViewDelegete,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIButton *storeCollect;
@property (nonatomic,strong)UITableView *leftTableView;
@property (nonatomic,strong)UICollectionView *rightCollectionView;
@property (nonatomic,strong)NSMutableArray *leftClassArray;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)NSMutableArray *CategoryList;
@property (nonatomic,strong)NSArray *StoreBusinessCategory;
@property (nonatomic,assign)NSInteger leftSelectIndex;

@property (nonatomic,strong)UIButton *CatagoryStoreNameButton;
@property (nonatomic,strong)NSArray *catagoryIds;

@property (nonatomic,strong)UIImageView *storeImage;
@property (nonatomic,strong)UILabel *storeNameLable;
@property (nonatomic,strong)YHStoreDetailModel *model;



@end

@implementation YHProductCloudsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"云工厂";
    
    [self addRigthDetailButtonIsShowCart:false];
    [self configSubViews];
}
- (void)configSubViews{

    NSMutableArray *titleArr = [NSMutableArray array];
    self.catagoryIds  = Userdefault(CatagoryIDs);
    for (NSDictionary *cataDic in self.catagoryIds) {
        NSString *catagoryname =  cataDic[@"CategoryBName"];
        if ([catagoryname containsString:@"休闲"]) {
            [titleArr addObject:@"休闲食品"];
        }else
        {
            [titleArr addObject:@"输配电"];

        }
        if (titleArr.count==2) {
            break;
        }
    }
    NSDictionary *selectCatagoryDic = self.catagoryIds[self.recordIndex];
    
   
  
    YHTitleView * titleView = [[YHTitleView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(39)) titleFont:AdaptFont(14) delegate:self andTitleArray:titleArr];
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(36));
    }];
 
    [titleView selectItemWithIndex:self.recordIndex];
    
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = ColorWithHexString(@"4EBFCD");
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(titleView.mas_bottom).offset(0);
        make.height.mas_equalTo(HeightRate(54));
    }];
    
    NSString *name = [NSString stringWithFormat:@"%@ >",selectCatagoryDic[@"CategoryBName"]];
    
    UIView * topHeadView = [self getTitleViewImageStr:selectCatagoryDic[@"FactoryIcon"] title:name isLeft:YES];
    [topHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goIntroductionVC)]];
    [topView addSubview:topHeadView];
    [topHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(15));
        make.width.mas_equalTo(WidthRate(135));
        make.height.mas_equalTo(HeightRate(40));
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
//    [topHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goStoreINtroduction)]];

    UIView * rightTopHeadView = [self getTitleViewImageStr:@"dingzhipinxujia" title:@"定制品询价" isLeft:false];
    [topView addSubview:rightTopHeadView];
    [rightTopHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-15));
        make.width.mas_equalTo(WidthRate(135));
        make.height.mas_equalTo(HeightRate(40));
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
    [rightTopHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goChatVC)]];

    CGFloat H =ScreenHeight-HeightRate(90)-(TOP_BAR_HEIGHT)-HeightRate(60);
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WidthRate(93), H) style:UITableViewStylePlain];
    self.leftTableView.backgroundColor = ColorWithHexString(@"F2F2F2");
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsHorizontalScrollIndicator = NO;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(93));
        make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(0));
        make.height.mas_equalTo(H);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WidthRate(93), 0, ScreenWidth-WidthRate(93), H) collectionViewLayout:layout];
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.dataSource = self;
    [self.rightCollectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [self.view addSubview:self.rightCollectionView];
    [self.rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(93));
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(topView.mas_bottom).offset(HeightRate(0));
        make.height.mas_equalTo(H);
    }];
    
   
    
    UIButton *serverStore = [UIButton buttonWithType:UIButtonTypeCustom];
    [serverStore setTitle:@"联系小二" forState:UIControlStateNormal];
    [serverStore setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    serverStore.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    serverStore.layer.cornerRadius = 6;
    serverStore.clipsToBounds = YES;
    serverStore.backgroundColor = ColorWithHexString(StandardBlueColor);
    [serverStore addTarget:self action:@selector(goChatVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serverStore];
    
    [serverStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(32));
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(45));
        make.bottom.mas_equalTo(-10);
    }];
}
- (void)getStoreDetailData:(NSDictionary *)dic{
    [self.view showWait:@"加载中" viewType:CurrentView];
    NSDictionary *paramDic = @{@"StoreId":dic[@"StoreId"]};


    [[YHJsonRequest shared] getStoreDetailWith:paramDic SuccessBlock:^(YHStoreDetailModel *model) {
        self.model =model;
        NSString *name = [NSString stringWithFormat:@"%@ >",model.StoreName];
        [self.storeImage sd_setImageWithURL:[NSURL URLWithString:model.StorePhoto]];
       
        self.storeNameLable.text = name;
        self.leftClassArray = [NSMutableArray arrayWithArray:model.SeriesArr];
        if (self.recordIndex <model.SeriesArr.count) {
            YHProductCatagoryModel *seriesModel = model.SeriesArr[self.recordItemIndex];
            seriesModel.select = YES;
            
            self.dataArray =seriesModel.GoodsArr;

        }else
        {
            YHProductCatagoryModel *seriesModel = model.SeriesArr[0];
            seriesModel.select = YES;
            
            self.dataArray =seriesModel.GoodsArr;
        }
     
        
        [self.leftTableView reloadData];
        [self.rightCollectionView reloadData];
 
   
     
        [self.view hideWait:CurrentView];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
    }];
}
-(void)goIntroductionVC
{
    YHProductStoreIntrocdutctionViewController *vc = [[YHProductStoreIntrocdutctionViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goChatVC{
    BOOL isVisit = [self isVisitorLoginByPhoneNumberExits];
    if (isVisit==false) {
        return;
    }
    
    NSDictionary *dic = self.catagoryIds[self.recordIndex];
//    NSString *storeID = dic[@"StoreId"];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:self.model.StoreId];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.listID = [NSString stringWithFormat:@"%@_%@",self.model.StoreId,userID];
    vc.storeID = self.model.StoreId;
    vc.isCatagory = !self.recordIndex;
    vc.storeName =self.model.StoreName;
    vc.storeAvata =self.model.StorePhoto;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---UITableViewDelegate & UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftClassArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
   
    YHProductCatagoryModel *model = self.leftClassArray[indexPath.row];
//    UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(7), 0, WidthRate(93), HeightRate(37))];
//    labelText.font = SYSTEM_FONT(AdaptFont(12));
//    labelText.text = model.CategoryName;
//    [cell addSubview:labelText];
    
    if (model.select==YES) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = TextColor_F5F5F5;
    }
    cell.textLabel.text = model.CategoryName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = SYSTEM_FONT(AdaptFont(12));
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHProductCatagoryModel *model = self.leftClassArray[indexPath.row];
    for (YHProductCatagoryModel *model1 in self.leftClassArray) {
        if ([model.CategoryName isEqualToString:model1.CategoryName]) {
            model.select = YES;
            self.dataArray = model.GoodsArr;
        }else
        {
            model1.select = false;

        }
    }
    
    [self.leftTableView reloadData];
    [self.rightCollectionView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRate(38);
}
#pragma mark--- UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    for(UIView * subView in item.subviews){
        if(subView){
            [subView removeFromSuperview];
        }
    }
    if (!item) {
        item = [[ProductCollectionViewCell alloc]init];
    }
    YHProductGoodsModel *model = self.dataArray[indexPath.item];
    UIImageView *ItemImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(110), WidthRate(110))];
    ItemImage.contentMode = UIViewContentModeScaleAspectFit;
    [ItemImage sd_setImageWithURL:[NSURL URLWithString:model.GoodsSeriesIcon]];
    ItemImage.layer.borderColor = SepratorLineColor.CGColor;
    ItemImage.layer.borderWidth = WidthRate(1);
    [item addSubview:ItemImage];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(115), WidthRate(120), HeightRateCommon(15))];
    labelName.text = model.GoodsSeriesName;
    labelName.font =  SYSTEM_FONT(AdaptFont(11));
    labelName.textColor = ColorWithHexString(@"1E1E1E");
    labelName.numberOfLines = 2;
    labelName.textAlignment = NSTextAlignmentCenter;
    [item addSubview:labelName];
    
    UILabel *labelPriceRange = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(130), WidthRate(120), HeightRateCommon(15))];
    labelPriceRange.text = model.PriceRange;
    labelPriceRange.font =  SYSTEM_FONT(AdaptFont(11));
    labelPriceRange.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    labelPriceRange.numberOfLines = 1;
    labelPriceRange.textAlignment = NSTextAlignmentCenter;
    [item addSubview:labelPriceRange];
    
    UILabel *labelSaleCount = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(145), WidthRate(120), HeightRateCommon(15))];
    labelSaleCount.text = [NSString stringWithFormat:@"销量：%@笔",model.GoodsSale];//@"销量：";
    labelSaleCount.font =  SYSTEM_FONT(AdaptFont(12));
    labelSaleCount.numberOfLines = 1;
    labelSaleCount.textColor = TextColor_666666;
    labelSaleCount.textAlignment = NSTextAlignmentCenter;
    [item addSubview:labelSaleCount];
    
    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthRate(120), HeightRateCommon(167));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return WidthRate(15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return HeightRateCommon(25);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(HeightRateCommon(25), WidthRate(10), HeightRate(0), HeightRateCommon(10));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.catagoryIds[self.recordIndex];
    YHProductGoodsModel *model = self.dataArray[indexPath.row];
    YHProductDetailsViewController *vc = [[YHProductDetailsViewController alloc] init];
    vc.GoodsSeriesCode = model.GoodsSeriesCode;
    vc.StoreID = dic[@"StoreId"];
    vc.CouponNumberStr = dic[@"DisCount"];
    vc.StoreName = self.model.StoreName;
    vc.storeAvata = self.model.StorePhoto;
    vc.storePhoneNumber = @"";
    //    [Tools jumpIntoOnlyVC:self.navigationController destnationViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)getTitleViewImageStr:(NSString *)imageStr title:(NSString *)title isLeft:(BOOL)isLeft
{
    UIView * topHeadView = [[UIView alloc] init];

    UIImageView *headImageView = [[UIImageView alloc] init];
    [topHeadView addSubview:headImageView];
   
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = title;
    [topHeadView addSubview:lable];
    
    if (isLeft == YES) {
        [headImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];

        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(5));
            make.width.mas_equalTo(WidthRate(30));
            make.height.mas_equalTo(HeightRate(30));
            make.centerY.mas_equalTo(topHeadView.mas_centerY);
        }];
        lable.font = [UIFont systemFontOfSize:AdaptFont(13)];

        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headImageView.mas_right).offset(WidthRate(3));
            //        make.width.mas_equalTo(WidthRate(30));
            make.height.mas_equalTo(HeightRate(30));
            make.centerY.mas_equalTo(topHeadView.mas_centerY);
        }];
        lable.textColor = ColorWithHexString(@"ffffff");

        self.storeImage = headImageView;
        self.storeNameLable = lable;
    }else
    {
        lable.font = [UIFont systemFontOfSize:AdaptFont(10)];
        lable.textColor = ColorWithHexString(@"999999");
        headImageView.image = [UIImage imageNamed:imageStr];
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.width.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(HeightRate(41));
            make.centerY.mas_equalTo(topHeadView.mas_centerY);
        }];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(headImageView.mas_right).offset(WidthRate(-3));
            //        make.width.mas_equalTo(WidthRate(30));
            make.height.mas_equalTo(HeightRate(30));
            make.centerY.mas_equalTo(topHeadView.mas_centerY).offset(HeightRate(10));
        }];
    }
    return topHeadView;
}
#pragma mark - YHTitleViewViewDelegete
- (void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index{
    if (self.catagoryIds.count>0) {
        self.recordIndex = index;
        self.leftSelectIndex = 0;
        NSDictionary *dic =  self.catagoryIds[index];
        
        [self getStoreDetailData:dic];

    }

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
