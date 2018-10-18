//
//  YHMainViewController.m
//  emake
//
//  Created by 谷伟 on 2018/3/16.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainViewController.h"
#import "SDCycleScrollView.h"
#import "YHMainPageCategoryCell.h"
#import "MainPageLastWeekCell.h"
#import "YHMainShoppingModel.h"
#import "YHProductClassifyViewController.h"
#import "YHMainMessageCenterViewController.h"
#import "ChatNewViewController.h"
#import "YHBrandQulificationViewController.h"
#import "YHInsuranceSeviceViewController.h"
#import "YHAfterServersViewController.h"
#import "YHLoginViewController.h"
#import "YHTodayPriceViewController.h"
#import "HRAdView.h"
#import "YHScanViewController.h"
#import "YHMainChooseCatagoryViewController.h"
#import "YHCommonWebViewController.h"
#import "YHDiscoverViewController.h"
#import "YHMainSearchViewController.h"
#import "YHNewAuditViewController.h"
#import "YHStoreCollectionViewCell.h"
#import "YHStoreViewController.h"
#import "YHStoreDetailViewController.h"
#import "StoreSeriesViewController.h"
#import "YHSendMessageToStoreListViewController.h"
#import "YHProductCloudsViewController.h"
#import "YHMainSuperTogetherCollectionViewCell.h"
#import "YHSuperGroupViewController.h"
#import "YHMainSeviceCollectionViewCell.h"
#import "YHSuperGroupModel.h"
#import "FMDBManager.h"
#import "YHMainLastWeekCollectionViewCell.h"
@interface YHMainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate,YHAlertViewDelegete,YHTitleViewViewDelegete>{
    NSString *phone;
    HRAdView *adView;
    YHTitleView *title;
}
//@property (nonatomic,strong)NSMutableDictionary *dataArrayDic;
@property (nonatomic,strong)NSMutableArray *CatagoryDataArray;

@property (nonatomic,strong)UIScrollView *CatagoryScrolView;

@property (nonatomic,copy)NSString *all_Prices;
@property(nonatomic,strong)NSMutableArray *lastOrderArray;
@property(nonatomic,retain)NSArray *ScrolCategoryData;
@property(nonatomic,assign)NSString *isInstore;//1.店铺购买2.普通购买
@property(nonatomic,strong)UIView *categoryView;
@property(nonatomic,strong)UIView *viewLastWeek;
@property(nonatomic,strong)NSDictionary *category;
@property(nonatomic,strong)NSMutableArray *bannerImageGroup;
@property(nonatomic,strong)NSMutableArray *bannerInstuition;
@property(nonatomic,strong)NSMutableArray *commpanyServersArray;
@property(nonatomic,strong)SDCycleScrollView *cycleview;
@property(nonatomic,strong)UIButton *brandButton;
@property(nonatomic,strong)UIButton *qualityButton;
@property(nonatomic,strong)UIButton *afterSaleButton;
@property(nonatomic,strong)UIView *commpanyServersView;
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)UIScrollView *cloudTitleScrollView;

@property(nonatomic,strong)UICollectionView *storeCollectionView;
@property(nonatomic,strong)UICollectionView *CatagoryCollectionView;

@property(nonatomic,strong)NSMutableArray *storeData;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,copy)NSString *storeID;
@property(nonatomic,strong)NSArray *CatagorydictArray;
@property(nonatomic,strong)NSArray *superGroupList;

@property(nonatomic,strong)NSDictionary *lastweekDic;


@end

@implementation YHMainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;

    self.recordIndex = [Userdefault(TitleIndex) integerValue];
    if (title) {
        [title selectItemWithIndex:self.recordIndex];
    }
    phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self RefreshMesssageCount];

    [self getMainPageAdd];
    [self getLastWeekData];
    [self getStoreData];//餐
    if (self.CatagorydictArray.count>1) {
        NSDictionary *dic = self.CatagorydictArray[self.recordIndex];
        [self getCateGoryData: dic];
        [self getCommpanyServerData: dic];
        [self getSuperGroupList:dic];

    }else
    {
        [self getcatagoryID];

    }

    [adView.timer setFireDate:[NSDate distantPast]];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [adView.timer setFireDate:[NSDate distantPast]];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    self.bannerImageGroup = [[NSMutableArray alloc]initWithCapacity:0];
    self.bannerInstuition = [[NSMutableArray alloc]initWithCapacity:0];
    [self configSubViews];


}

-(void)RefreshMesssageCount
{
    NSDictionary *messageCountDic = [YHMQTTClient sharedClient].messageCountDic;
   NSInteger eventCount =[ messageCountDic[@"messageCount"] integerValue];
//   NSInteger eventCount = [[FMDBManager sharedManager] getUserMessageCount:@""];
//    NSLog(@"获取总消息个数= %ld=%ld",eventCount1,eventCount);
    UIImageView *infomationImage = (UIImageView *)[self.infomationView viewWithTag:1100];
    
    if (eventCount>0) {
        if (eventCount>99){
            eventCount = 99;
        }
        [infomationImage showBadgeWithStyle:WBadgeStyleNumber value:eventCount animationType:WBadgeAnimTypeNone];
        infomationImage.badgeCenterOffset = CGPointMake(WidthRate(-8), HeightRate(5));
        
    }else{
        [infomationImage clearBadge];
    }
    
}


- (UIView *)getPictureWithTextViewWithTag:(NSInteger)tag andText:(NSString *)text imageString:(NSString *)imageString{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(33), WidthRate(45))];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(goSelectVC:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageString]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.tag = 1100;
    [view addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WidthRate(0));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = SYSTEM_FONT(AdaptFont(9));
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(image.mas_bottom).offset(WidthRate(-4));
    }];
    return view;
}
- (void)configSubViews{
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (-StatusBarHEIGHT), ScreenWidth, ScreenHeight-(TAB_BAR_HEIGHT))];
    self.mainScrollView.showsVerticalScrollIndicator = false;
    self.mainScrollView.alwaysBounceVertical = true;
    self.mainScrollView.alwaysBounceHorizontal = false;
  
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight+120);
    //banner
    self.cycleview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRateCommon(250)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    [self.mainScrollView addSubview:self.cycleview];

    
    //扫一扫
    self.categoryView = [self getPictureWithTextViewWithTag:1 andText:@"扫一扫" imageString:@"saomiao"];
    self.categoryView.frame = CGRectMake(WidthRate(9), HeightRate(5), WidthRate(35), HeightRateCommon(30));
    [self.mainScrollView addSubview:self.categoryView];


    //消息
    self.infomationView = [self getPictureWithTextViewWithTag:2 andText:@"消息" imageString:@"xiaoxi1"];
    self.infomationView.frame = CGRectMake(ScreenWidth-WidthRate(32), HeightRate(5), WidthRate(23), HeightRateCommon(30));
    [self.mainScrollView addSubview:self.infomationView];

    
//    //客服
//    self.serverView = [self getPictureWithTextViewWithTag:3 andText:@"客服" imageString:@"shouyekefu"];
//    if ([self.isInstore isEqualToString:@"1"]) {
//        self.serverView.hidden = true;
//    }else{
//        self.serverView.hidden = false;
//    }
//    self.serverView.frame = CGRectMake(ScreenWidth-WidthRate(73), HeightRate(5), WidthRate(23), HeightRateCommon(30));
//    [self.mainScrollView addSubview:self.serverView];


    //搜索
    self.searchBtn = [[UIButton alloc] init];
    [self.searchBtn setTitleColor:ColorWithHexString(@"999999") forState:UIControlStateNormal];
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"shouyesousuokuang"] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(12)];
//    self.searchBtn.frame = CGRectMake(WidthRate(59), (StatusBarHEIGHT)+3, ScreenWidth-WidthRate(111), HeightRateCommon(30));
    [self.searchBtn setTitle:@"请输入搜索内容" forState:UIControlStateNormal];
    self.searchBtn.adjustsImageWhenHighlighted = NO;
    self.searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    self.searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, WidthRate(45), 0, 0);
    [self.searchBtn addTarget:self action:@selector(seachButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.searchBtn];
   
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(8));
        make.left.mas_equalTo(self.categoryView.mas_right).offset(WidthRate(15));
        make.right.mas_equalTo(self.infomationView.mas_left).offset(WidthRate(-15));
        make.height.mas_equalTo(HeightRateCommon(30));
    }];
    
   
    
    
//    //品类
//    UIScrollView *CatagoryScrolView = [[UIScrollView alloc] init];
//    CatagoryScrolView.pagingEnabled = YES;
//    CatagoryScrolView.contentSize =  CGSizeMake(ScreenWidth, 0);
//    //    CatagoryScrolView.frame = CGRectMake(0, HeightRate(250), ScreenWidth, HeightRate(165));
//    [self.mainScrollView addSubview:CatagoryScrolView];
//    [CatagoryScrolView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(titleLine.mas_bottom).offset(-1);
//        make.width.mas_equalTo(ScreenWidth);
//        make.height.mas_equalTo(HeightRate(165));
//        make.left.mas_equalTo(0);
//
//    }];
//    self.CatagoryScrolView = CatagoryScrolView;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView * CatogoryCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    CatogoryCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    CatogoryCollectionView.backgroundColor = [UIColor whiteColor];
    CatogoryCollectionView.scrollEnabled = NO;
    CatogoryCollectionView.delegate = self;
    CatogoryCollectionView.dataSource = self;
    [self.mainScrollView addSubview:CatogoryCollectionView];
    [CatogoryCollectionView registerClass:[YHMainPageCategoryCell class] forCellWithReuseIdentifier:@"MainPageCategoryCell"];
    [CatogoryCollectionView registerClass:[YHMainSuperTogetherCollectionViewCell class] forCellWithReuseIdentifier:@"YHMainSuperTogetherCollectionViewCell"];
    [CatogoryCollectionView registerClass:[YHMainLastWeekCollectionViewCell class] forCellWithReuseIdentifier:@"YHMainLastWeekCollectionViewCell"];
    [CatogoryCollectionView registerClass:[YHMainSeviceCollectionViewCell class] forCellWithReuseIdentifier:@"YHMainSeviceCollectionViewCell"];

    [CatogoryCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LsatCategoryCell"];
    [CatogoryCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header11"];//Header11YHMainLastWeekCollectionViewCell
    
    
    CatogoryCollectionView.alwaysBounceHorizontal = YES;
    CatogoryCollectionView.showsHorizontalScrollIndicator = NO;
    self.CatagoryCollectionView = CatogoryCollectionView;
    CGFloat collectionwidth =HeightRateCommon(165)+HeightRateCommon(120)+HeightRateCommon(50) ;
    [CatogoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleview.mas_bottom).offset(-1);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(collectionwidth);
        make.left.mas_equalTo(0);
    }];
    





    
}

- (void)configLastWeekScroll{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [array addObject:self.lastOrderArray[0]];
    [array addObject:self.lastOrderArray[1]];
    [array addObject:self.lastOrderArray[2]];
    [adView removeFromSuperview];
    adView = [[HRAdView alloc]initWithTitles:self.lastOrderArray];
    adView.frame = CGRectMake(0, HeightRate(36), ScreenWidth-WidthRate(15), HeightRate(72));
    adView.time = 2.0f;
    [self.viewLastWeek addSubview:adView];
    if (array.count >1) {
        [adView beginScroll];
    }
    
}
//搜索
-(void)seachButtonClick{

    YHMainSearchViewController *search = [[YHMainSearchViewController alloc] init];
    search.hidesBottomBarWhenPushed =  YES;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)goSelectVC:(UIButton *)sender{
    bool isVisist = [self isVisitorLoginByPhoneNumberExits];
    if (isVisist ==false) {
        return;
    }
    switch (sender.tag) {
        case 1:{
            YHScanViewController *scan = [[YHScanViewController alloc] init];
            scan.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scan animated:YES];
        }
            break;
        case 2:{
            YHMainMessageCenterViewController *vc = [[YHMainMessageCenterViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            
        }
            break;
        default:
            break;
    }
}
- (void)goCommmpanyServersVC:(NSInteger )index{
    switch (index) {
        case 1:{
            
            NSDictionary *dic=  self.CatagorydictArray[self.recordIndex];
            
            YHBrandQulificationViewController *vc = [[YHBrandQulificationViewController alloc]init];
            
            vc.categoryID =  dic[@"CategoryBId"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            
            YHInsuranceSeviceViewController *vc = [[YHInsuranceSeviceViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            
            YHAfterServersViewController *vc = [[YHAfterServersViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{//订购流程
            
            YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            vc.titleName = @"订购流程";
            vc.time = WebTypeUserInstructions;
            vc.URLString = UserOrderingproURL;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{//订购须知
            
            YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.titleName = @"订购须知";
            vc.time = WebTypeUserInstructions;
            vc.URLString =UserOrderinginfoURL ;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)getLastWeekData{
    
    [[YHJsonRequest shared] getuserLastweekOrder:^(NSDictionary *shoppingCartDict) {
        self.lastweekDic = [NSDictionary dictionaryWithDictionary:shoppingCartDict];
        [self.CatagoryCollectionView reloadData];
        [self.CatagoryCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(900);
            
        }];
        self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, HeightRateCommon(250)+self.CatagoryCollectionView.contentSize.height);
        
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
}
- (void)getMainPageAdd{
    NSArray *catagor = Userdefault(CatagoryIDs);
    
    [[YHJsonRequest shared] getMainPageAddSuccessBlock:^(NSArray *mianImageAddArray) {
        [self.bannerImageGroup removeAllObjects];
        [self.bannerInstuition removeAllObjects];
        for (NSDictionary *dict in mianImageAddArray) {
            if (![dict objectForKey:@"ADUrl"]) {
                return;
            }
            [self.bannerImageGroup addObject:[dict objectForKey:@"ADUrl"]];
            [self.bannerInstuition addObject:[dict objectForKey:@"ADSkipLinkIos"]];
        }
        self.cycleview.imageURLStringsGroup = self.bannerImageGroup;
        if (self.bannerImageGroup.count>1) {
            self.cycleview.autoScroll = YES;
        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
-(void)getSuperGroupList:(NSDictionary *)dic
{
    [[YHJsonRequest shared] getAppSuperGroup:@{@"CategoryBId":dic[@"CategoryBId"]} SuccessBlock:^(NSArray *success) {
        self.superGroupList = [NSArray arrayWithArray:success];
    
        [self.CatagoryCollectionView reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];

    }];
}
- (void)getCateGoryData:(NSDictionary *)dic{
    [self.view showWait:@"加载中" viewType:CurrentView];
    
    [[NSUserDefaults standardUserDefaults] setObject:dic[@"CategoryBId"] forKey:USERSELECCATEGORY];

    [[YHJsonRequest shared] getMainPageCategory:@{@"CategoryBId":dic[@"CategoryBId"]} SuccessBlock:^(NSArray *categoryDict) {
        [self.view hideWait:CurrentView];
        self.CatagoryDataArray = [NSMutableArray arrayWithArray:categoryDict];
        [self.CatagoryDataArray addObject:dic];
        [self.CatagoryCollectionView reloadData];
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];

        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
        

    
    
}
- (void)getCommpanyServerData:(NSDictionary *)dic{
//    BusinessCategory @{@"CategoryBId":dic[@"CategoryBId"]
    self.commpanyServersArray = [NSMutableArray arrayWithCapacity:0];
    [[YHJsonRequest shared] getBusinessService:@{@"CategoryBId":dic[@"CategoryBId"]} SuccessBlock:^(NSArray *listArray){
        self.commpanyServersArray = [NSMutableArray arrayWithArray:listArray];
        [self.CatagoryCollectionView reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}

- (void)getStoreData{
    self.storeData = [NSMutableArray arrayWithCapacity:0];
//    [[YHJsonRequest shared] getFindStoreListSuccessBlock:^(NSArray *Success) {
//        self.storeData = [NSMutableArray arrayWithArray:Success];
//        [self.storeCollectionView reloadData];
//    } fialureBlock:^(NSString *errorMessages) {
//        [self.storeCollectionView reloadData];
//        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
//    }];
}

- (void)goTodayPriceVC{
    
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    self.tabBarController.selectedIndex = 1;
}

- (void)goSepacialPriceVC{

    bool isVisist = [self isVisitorLoginByPhoneNumberExits];
    if (isVisist ==false) {
        return;
    }
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
//    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
//    vc.title = @"易智造";
//    vc.listID = userID;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

//发现
- (void)goDiscoverNewsVC{
    
    YHDiscoverViewController *discover = [[YHDiscoverViewController alloc] init];
    discover.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:discover animated:YES];
}
- (void)goStoreVC{
    [MobClick event:@"dianpugengduo" label:@"店铺更多"];

    YHStoreViewController *vc = [[YHStoreViewController alloc] init];\
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goSuperGroupVC
{
    YHSuperGroupViewController *vc = [[YHSuperGroupViewController alloc] init];
    vc.groupList = self.superGroupList;
    vc.index = self.recordIndex;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark---UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

   
    NSInteger sectionNum = self.superGroupList.count>0?section:(section>=1?section+1:section);
    if (sectionNum == 3) {
//        return 1;
        return self.lastweekDic.count>0?1:0;
    }else if( sectionNum == 0)
    {
        if (self.CatagoryDataArray.count<=10) {
            return self.CatagoryDataArray.count;
        }else
        {
            return 10;
        }
    }else if(sectionNum == 2)
    {
        return   self.commpanyServersArray.count;
    }else
    {
        return 1;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.superGroupList.count>0) {
        return 4;
    }
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger sectionNum = self.superGroupList.count>0?indexPath.section:(indexPath.section>=1?indexPath.section+1:indexPath.section);
    if (sectionNum == 3) {
        
        YHMainLastWeekCollectionViewCell *cell =(YHMainLastWeekCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YHMainLastWeekCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YHMainLastWeekCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,  HeightRateCommon(160))];
        }
       
        [cell setDataDict:self.lastweekDic];
        
        return cell;
    }else if (sectionNum == 2) {
        
        YHMainSeviceCollectionViewCell *cell =(YHMainSeviceCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YHMainSeviceCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YHMainSeviceCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3.0,  HeightRate(54))];
        }
        [cell SeviceViewData:self.commpanyServersArray[indexPath.row]];
        return cell;
        
    }else if (sectionNum == 1) {
        YHMainSuperTogetherCollectionViewCell *cell =(YHMainSuperTogetherCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"YHMainSuperTogetherCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YHMainSuperTogetherCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,  HeightRate(120))];
        }
        if (self.superGroupList.count>0) {
            YHSuperGroupModel *model = self.superGroupList.firstObject;
            [cell.togetherBtn addTarget:self action:@selector(goSuperGroupVC) forControlEvents:UIControlEventTouchUpInside];
            [cell superGroupData:model];
        }
        return cell;
    }else
    {
        YHMainPageCategoryCell *cell =(YHMainPageCategoryCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MainPageCategoryCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[YHMainPageCategoryCell alloc]initWithFrame:CGRectMake(0, 0, WidthRate(47),  HeightRate(60))];
        }
    
        if (self.CatagoryDataArray.count <= 10) {
            [cell setData:self.CatagoryDataArray[indexPath.row] isLastObjict:self.CatagoryDataArray.count-1 <= indexPath.row?YES:false];
        }else
        {
            [cell setData:indexPath.row<9? self.CatagoryDataArray[indexPath.row]:self.CatagoryDataArray.lastObject isLastObjict:indexPath.row<9?false:YES];
            
        }
        
        
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger sectionNum = self.superGroupList.count>0?indexPath.section:(indexPath.section>=1?indexPath.section+1:indexPath.section);
    if (sectionNum==3) {
        return CGSizeMake(ScreenWidth, HeightRateCommon(160));
    }else if (sectionNum ==2) {
        return CGSizeMake(ScreenWidth/3.0, HeightRateCommon(54));
        
    }else if (sectionNum ==1) {
        return CGSizeMake(ScreenWidth, HeightRateCommon(130));
    }else
    {
        return CGSizeMake(WidthRate(47), HeightRateCommon(60));

    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section ==1 || section == 2 || section ==3) {
        return 0;
    }else
    {
        return WidthRate(15);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
 
    if (section ==1 || section == 2) {
        return HeightRateCommon(5);
    }else
    {
        return HeightRateCommon(5);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section ==1 || section == 2 || section==3) {
        return UIEdgeInsetsMake(HeightRate(5), WidthRate(0), HeightRate(-5), WidthRate(0));;
    }else
    {
        return UIEdgeInsetsMake(HeightRateCommon(5), WidthRate(10), HeightRate(5), WidthRate(20));
    }
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if (indexPath.section==0) {

             UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header11" forIndexPath:indexPath];
//            for(id subView in view.subviews){
//                if(subView){
//                    [subView removeFromSuperview];
//                }
//            }
            
 
            NSMutableArray *arr = [NSMutableArray array];;
            for (NSDictionary *dict in self.CatagorydictArray) {
                [arr addObject: dict[@"CategoryBName"]];
            }
            
//            UIImageView*itemTopImage = [[UIImageView alloc]init];
////            itemTopImage.contentMode = UIViewContentModeScaleAspectFill;
//            itemTopImage.backgroundColor = ColorWithHexString(@"f2f2f2");
//            itemTopImage.image = [UIImage imageNamed:@"chaojituantitle"];
//            [view addSubview:itemTopImage];
//            [itemTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(0);
//                make.width.mas_equalTo(ScreenWidth);
//                make.height.mas_equalTo(HeightRateCommon(30));
//                make.top.mas_equalTo(0);
//            }];
//
//            UILabel *cloudLabel = [[UILabel alloc]init];
//            cloudLabel.text =@"云工厂";
//            cloudLabel.textColor = ColorWithHexString(@"ffffff");
//            cloudLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
//            [view addSubview:cloudLabel];
//            [cloudLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(WidthRate(10));
//                make.width.mas_equalTo(70);
//                make.height.mas_equalTo(HeightRateCommon(30));
//                make.top.mas_equalTo(0);
//            }];
            

            view.backgroundColor = ColorWithHexString(@"ffffff");
            if (arr.count>0) {
                if (title==nil) {
                
                    title  =  [[YHTitleView alloc] initWithTitleFont:AdaptFont(14) delegate:self andTitleArray:arr andTitleHeight:HeightRateCommon(45) andScrolweight:ScreenWidth];
                    title.backgroundColor = [UIColor clearColor];
                    [view addSubview:title];
                    [title mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(0);
                        make.width.mas_equalTo(title.titleViewWidth);
                        make.height.mas_equalTo(HeightRateCommon(45));
                        make.left.mas_equalTo(WidthRate(0));
                        
                    }];
                    UILabel *line = [[UILabel alloc] init];
                    line.backgroundColor =SepratorLineColor;
                    [view addSubview:line];
                    [line mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(title.mas_bottom).offset(HeightRate(0));
                        make.width.mas_equalTo(ScreenWidth);
                        make.height.mas_equalTo(HeightRateCommon(1));
                        make.left.mas_equalTo(WidthRate(0));
                        
                    }];
                }else
                {
//            if (arr.count>0) {
            
                    [title ChageItemWithIndex:self.recordIndex<arr.count?self.recordIndex:0];

              }
            
                }
        
//            }
            
            
//            [title hidenBottonline];
            
//            cloudTitleScrollView.contentSize = CGSizeMake(title.titleViewWidth,HeightRateCommon(30));

           
            
            
            return view;

        }
        
        return nil;
        
    }else
    {
        return nil;
    }
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0)
    {
        return CGSizeMake(ScreenWidth, HeightRateCommon(45));
    }
    else
    {
        return CGSizeZero;
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger sectionNum = self.superGroupList.count>0?indexPath.section:(indexPath.section>=1?indexPath.section+1:indexPath.section);

    if (sectionNum==3) {
        
        
    }else if (sectionNum == 2) {
        
        YHCommpanyServersModel *model = self.commpanyServersArray[indexPath.row];
        [self goCommmpanyServersVC:model.ServiceType];
        
    }else  if (sectionNum ==1) {
        
        [self goSuperGroupVC];
        
    }else
    {
        [MobClick event:@"quanbushangping" label:@"全部商品"];

        YHProductCloudsViewController *vc = [[YHProductCloudsViewController alloc] init];

    NSDictionary *dict;
    if (self.CatagoryDataArray.count <= 9 ) {
        dict = indexPath.row ==self.CatagoryDataArray.count-1?self.CatagoryDataArray.firstObject: self.CatagoryDataArray[indexPath.row];
    }else
    {
        dict =indexPath.row ==9?self.CatagoryDataArray.firstObject:self.CatagoryDataArray[indexPath.row] ;
        
    }
        
        vc.hidesBottomBarWhenPushed = YES;
        vc.storeId =  dict[@"StoreId"];
        vc.catagory = dict[@"CategoryCId"];
        vc.catagoryDic = dict;
        vc.recordIndex = self.recordIndex;
        vc.recordItemIndex =self.CatagoryDataArray.count<9?( indexPath.row==self.CatagoryDataArray.count-1?0:indexPath.row):( indexPath.row==9?0:indexPath.row);
        [self.navigationController pushViewController:vc animated:YES];

    }
}


#pragma makk ---- YHAlertViewDelegate
- (void)alertViewRightBtnClick:(id)alertView{
    YHNewAuditViewController *vc = [[YHNewAuditViewController alloc] init];
    vc.isfail = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark -----YHTitleDelegate
-(void)YHSeviceView:(id)SeviceView selectItemWithIndex:(NSInteger)index
{
    
}
#pragma  mark -----YHTitleDelegate
-(void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index
{
    if (index <self.CatagorydictArray.count) {
        
        [self getCateGoryData:self.CatagorydictArray[index]];
        [self getCommpanyServerData:self.CatagorydictArray[index]];
        [self getSuperGroupList:self.CatagorydictArray[index]];
        self.recordIndex = index;

    }else
    {
        self.recordIndex = 0;

        
    }
    [[NSUserDefaults standardUserDefaults] setObject:@(self.recordIndex) forKey:TitleIndex];
}

#pragma  mark -----SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.bannerInstuition.count<=0) {
        return;
    }
//    [MobClick event:@"ShufflingFigure" label:@"轮播图"];
    if (index==0) {
        [MobClick event:@"Xiazai" label:@"我要开店"];

    }
    NSString *JsonString = [self.bannerInstuition objectAtIndex:index];
    NSData *jsonData = [JsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                           error:&err];
    if ([dict[@"className"] isEqualToString:@"YHTodayPriceViewController"]){
        self.tabBarController.selectedIndex = 1;
        return;
    }
    Class class = NSClassFromString(dict[@"className"]);
    UIViewController *vc = [[class alloc] init];
    // 获取参数列表，使用枚举的方式，对控制器属性进行KVC赋值
    NSDictionary *parameter = dict[@"propertys"];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 在属性赋值时，做容错处理，防止因为后台数据导致的异常
        if ([vc respondsToSelector:NSSelectorFromString(key)]) {
            [vc setValue:obj forKey:key];
        }
    }];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    // 从字典中获取方法名，并调用对应的方法
    if (dict[@"method"]) {
        SEL selector = NSSelectorFromString(dict[@"method"]);
        [vc performSelector:selector];
    }
}
-(void)specilView:(UIView *)specilView tiltle:(NSString *)title othertiltle:(NSString *)othertiltle imageName:(NSString *)imageName isRight:(BOOL)isRight{
    UIView *sepacialBgView = [[UIView alloc]init];
    sepacialBgView.backgroundColor = [UIColor whiteColor];
    sepacialBgView.layer.cornerRadius = HeightRate(17);
    sepacialBgView.layer.masksToBounds = YES;
    if (isRight==NO) {
         UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goSepacialPriceVC)];
        [sepacialBgView addGestureRecognizer:gesture];
    }else{
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goDiscoverNewsVC)];
        [sepacialBgView addGestureRecognizer:gesture];
    }
    [self.view addSubview:sepacialBgView];
    [sepacialBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isRight==YES) {
            make.right.mas_equalTo(-10);
        }else{
            make.left.mas_equalTo(10);
        }
        make.width.mas_equalTo(WidthRate(175));
        make.centerY.mas_equalTo(specilView.mas_centerY);
        make.height.mas_equalTo(HeightRate(34));
    }];
    
    UIImageView *sepacialImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    sepacialImage.contentMode = UIViewContentModeScaleAspectFit;
    [sepacialBgView addSubview:sepacialImage];
    
    [sepacialImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(specilView.mas_centerY);
        make.width.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(HeightRate(20));
    }];
    
    
    UILabel *textLabelSepcail = [[UILabel alloc]init];
    textLabelSepcail.text = title;
    textLabelSepcail.font = [UIFont boldSystemFontOfSize:AdaptFont(12)];
    [sepacialBgView addSubview:textLabelSepcail];
    
    [textLabelSepcail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sepacialImage.mas_right).offset(WidthRate(5));
        make.centerY.mas_equalTo(specilView.mas_centerY);
    }];
    
    UILabel *textLabelSepcailDe = [[UILabel alloc]init];
    textLabelSepcailDe.text = othertiltle;
    textLabelSepcailDe.textColor = TextColor_666666;
    textLabelSepcailDe.font = [UIFont systemFontOfSize:AdaptFont(11)];
    [sepacialBgView addSubview:textLabelSepcailDe];
    
    [textLabelSepcailDe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textLabelSepcail.mas_right).offset(WidthRate(3));
        make.centerY.mas_equalTo(specilView.mas_centerY);
    }];
}



-(void)getStoreID:(NSString *)catagory
{
    NSString *catagoryId = Userdefault(USERSELECCATEGORY);
    [[YHJsonRequest shared] getStoreIDWithCatagoryIds:@{@"BusinessCategory":catagoryId.length>0?catagoryId:@""} SuccessBlock:^(NSDictionary *success) {
        self.storeID = success[@"StoreId"];
//        YHStoreDetailViewController *vc = [[YHStoreDetailViewController alloc] init];
        YHProductCloudsViewController *vc = [[YHProductCloudsViewController alloc] init];

        vc.hidesBottomBarWhenPushed = YES;
        vc.storeId = self.storeID;
        vc.catagory = catagory;
        [self.navigationController pushViewController:vc animated:YES];
    } fialureBlock:^(NSString *errorMessages) {
        //        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
    
}
-(void)getcatagoryID
{
    [[YHJsonRequest shared] getCatagoryIDsSuccessBlock:^(NSArray *success) {
        
        if (success.count>0) {
            [[NSUserDefaults standardUserDefaults] setObject:success forKey:CatagoryIDs];
            
            self.CatagorydictArray = [NSArray arrayWithArray:success];
            [self getCateGoryData:success.firstObject];
            [self getCommpanyServerData:self.CatagorydictArray.firstObject];
            [self getSuperGroupList:self.CatagorydictArray.firstObject];
            

        }else
        {
            [self.view makeToast:@"数据异常" duration:1.5 position:CSToastPositionCenter];
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        
    }];
    
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
