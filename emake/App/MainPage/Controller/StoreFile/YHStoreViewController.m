//
//  YHStoreViewController.m
//  emake
//
//  Created by 谷伟 on 2018/7/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHStoreViewController.h"
#import "YHStoreListCollectionViewCell.h"
#import "YHStoreDetailViewController.h"
#import "ChatNewViewController.h"
#import "YHStoreViewController.h"
@interface YHStoreViewController ()<YHTitleViewViewDelegete,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *storeCollectionView;
@property (nonatomic,strong)NSMutableArray *storeData;
@end

@implementation YHStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"店铺";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubViews];
    [self getStoreData];
}
- (void)configSubViews{
    NSArray *titles = @[@"全部",@"销售额",@"订单数"];
    YHTitleView *titleView = [[YHTitleView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(34)) titleFont:14 delegate:self andTitleArray:titles];
    [self.view addSubview:titleView];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(34));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.storeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HeightRate(470), ScreenWidth, HeightRate(122)) collectionViewLayout:layout];
    self.storeCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.storeCollectionView.backgroundColor = TextColor_F7F7F7;
    self.storeCollectionView.delegate = self;
    self.storeCollectionView.dataSource = self;
    [self.view addSubview:self.storeCollectionView];
    [self.storeCollectionView registerClass:[YHStoreListCollectionViewCell class] forCellWithReuseIdentifier:@"StoreCell"];
    
    [self.storeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(titleView.mas_bottom).offset(1);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)getStoreData{
    self.storeData = [NSMutableArray arrayWithCapacity:0];
    [[YHJsonRequest shared] getStoreListSuccessBlock:^(NSArray *Success) {
        self.storeData = [NSMutableArray arrayWithArray:Success];
        [self.storeCollectionView reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
#pragma mark---UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.storeData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHStoreListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YHStoreListCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/2,  HeightRate(212))];
    }
    cell.backgroundColor = [UIColor whiteColor];
    YHStoreModel *model = [self.storeData objectAtIndex:indexPath.item];
    [cell setData:model];
    
   __block YHStoreViewController *weakself = self;
    cell.connactBlock = ^(YHStoreModel *model) {
        bool isVisist = [weakself isVisitorLoginByPhoneNumberExits];
        if (isVisist ==false) {
            return;
        }
        NSString *myStoreID = Userdefault(LOGIN_UserStoreID);
        if ([myStoreID isEqualToString:model.StoreId]) {
            [self.view makeToast:@"不能对自己的店铺发起聊天" duration:1.5 position:CSToastPositionCenter];
            return ;
        }
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//        ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
//        vc.hidesBottomBarWhenPushed = YES;
//        NSString *userID = Userdefault(LOGIN_USERID) ;
//        
//        vc.storeName = model.StoreName;
//        vc.storeAvata = model.StorePhoto;
//        vc.listID = [NSString stringWithFormat:@"%@_%@",model.StoreId,userID];
//        vc.storeID = model.StoreId;
//        [self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth/2, HeightRate(212));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YHStoreModel *model = [self.storeData objectAtIndex:indexPath.item];
    YHStoreDetailViewController *vc = [[YHStoreDetailViewController alloc] init];
    vc.storeId = model.StoreId;
    vc.storeName = model.StoreName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - YHTitleViewViewDelegete
- (void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index{
    
    NSSortDescriptor *StoreOrdersDesc;
    if (index==1) {
     StoreOrdersDesc = [NSSortDescriptor sortDescriptorWithKey:@"StoreSales" ascending:false];
    }else if(index==2)
    {
        StoreOrdersDesc = [NSSortDescriptor sortDescriptorWithKey:@"StoreOrders" ascending:false];
    }else
    {
        StoreOrdersDesc = [NSSortDescriptor sortDescriptorWithKey:@"IsCollect" ascending:false];
    }

  
    NSArray *descs = [NSArray arrayWithObjects:StoreOrdersDesc, nil];
    
    NSArray *array2 = [self.storeData sortedArrayUsingDescriptors:descs];
    self.storeData = [NSMutableArray arrayWithArray:array2];
    [self.storeCollectionView reloadData];
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
