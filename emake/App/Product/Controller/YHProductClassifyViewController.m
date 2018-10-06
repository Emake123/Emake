//
//  YHProductClassifyViewController.m
//  emake
//
//  Created by 谷伟 on 2017/12/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHProductClassifyViewController.h"
#import "ProductCollectionViewCell.h"
#import "YHProductDetailsViewController.h"
#import "YHProductSeriesModel.h"
#import "YHLoginViewController.h"
#import "ChatNewViewController.h"
#import "productModel.h"
@interface YHProductClassifyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate>
@property (nonatomic,retain)UITableView *leftTableView;
@property (nonatomic,retain)UICollectionView *rightCollectionView;
@property (nonatomic,retain)NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *leftClassArray;
@property (nonatomic,retain)NSMutableArray *ProductSeriesArray;
@property (nonatomic,retain)UIView *emptyView;
@property (nonatomic,assign)NSInteger leftSelectIndex;

@end

@implementation YHProductClassifyViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"GoodsList" label:@"商品列表"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleName;
    self.leftSelectIndex = 0;
    [self addRigthDetailButtonIsShowCart:false];
    [self configLeftClaasifyTableView];
    [self configRightCollectionView];
    [self getLeftListData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationItem.titleView endEditing:YES];
}
-(void)configTopView{
    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, WidthRate(286), HeightRate(28))];
    search.delegate = self;
    self.navigationItem.titleView = search;
}
-(void)selectFirstClaasify{
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
-(void)getLeftListData{
    
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getShoppingGoodCategoriesSeriesId:self.CategoryId  SuccessBlock:^(NSDictionary *successMessage) {
        [self.view hideWait:CurrentView];
        if (successMessage.count ==0) {
            [self configEmptyViewleftSpace:0];

        }else{
            [_emptyView removeFromSuperview];
            self.leftClassArray = [NSMutableArray arrayWithCapacity:0];
            self.ProductSeriesArray = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *dict in successMessage) {
                if (dict) {
                    YHProductSeriesModel *model = [YHProductSeriesModel mj_objectWithKeyValues:dict];
                    if (model) {
                        [self.leftClassArray addObject:model];
                        [self.ProductSeriesArray addObject:model.CategoryId];
                    }
                 
                }
            }
            [self.leftTableView reloadData];
            NSInteger selectIndex = 0;
            if (self.serriesCode) {
                selectIndex = [self.ProductSeriesArray indexOfObject:self.serriesCode];
            }
            [self tableView:self.leftTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]];
            [self.rightCollectionView reloadData];
        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.leftClassArray removeAllObjects];
        [self.dataArray removeAllObjects];
        [self.leftTableView reloadData];
        [self.rightCollectionView reloadData];
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
-(void)getData:(NSString *)serriesCode{
    
    [[YHJsonRequest shared] getGoodsseries:serriesCode SuccessBlock:^(NSArray *successMessage) {
        self.dataArray = [NSMutableArray arrayWithArray:successMessage];
        [self.rightCollectionView reloadData];
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages];
    }];
}
- (void)configLeftClaasifyTableView{
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, WidthRate(93), ScreenHeight-(TOP_BAR_HEIGHT)) style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsHorizontalScrollIndicator = NO;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(93));
    }];
}
- (void)configRightCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WidthRate(93), TOP_BAR_HEIGHT, ScreenWidth-WidthRate(93)-(TOP_BAR_HEIGHT), ScreenHeight) collectionViewLayout:layout];
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.dataSource = self;
    [self.rightCollectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [self.rightCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    [self.view addSubview:self.rightCollectionView];
    [self.rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(93));
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)configEmptyViewleftSpace:(CGFloat)leftSpace{
    
    self.emptyView = [[UIView alloc]init];
    self.emptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.emptyView];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(leftSpace));
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *imageShow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shangjiazhong"]];
    [self.emptyView addSubview:imageShow];
    
    [imageShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(195));
        make.centerX.mas_equalTo(self.emptyView.mas_centerX);
        make.width.mas_equalTo(WidthRate(125));
        make.height.mas_equalTo(HeightRate(125));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text =@"正在上架中\n敬请期待...";
    label.textColor =TextColor_737273;
    label.numberOfLines = 2;
    label.font = SYSTEM_FONT(AdaptFont(14));
    [self.emptyView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.emptyView.mas_centerX);
        make.height.mas_equalTo(HeightRate(44));
        make.width.mas_equalTo(WidthRate(80));
        make.top.mas_equalTo(imageShow.mas_bottom).offset(HeightRate(16));
    }];
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
    UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(7), 0, WidthRate(93), HeightRate(37))];
    YHProductSeriesModel *model = self.leftClassArray[indexPath.row];
    labelText.text = model.CategoryName;
    labelText.font = SYSTEM_FONT(AdaptFont(12));
    [cell addSubview:labelText];
    if (model.isSelect) {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = TextColor_F5F5F5;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRate(37),  WidthRate(93), HeightRate(1))];
    label.backgroundColor = SepratorLineColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.leftSelectIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [self.emptyView removeFromSuperview];
    [self.rightCollectionView removeFromSuperview];
    for (int i = 0;i < self.leftClassArray.count;i++) {
        YHProductSeriesModel *model = self.leftClassArray[i];
        if (i == indexPath.row) {
            model.isSelect = YES;
        }else{
            model.isSelect = false;
        }
    }
    [self.leftTableView reloadData];
    if (self.leftClassArray.count<=0) {
        return;
    }
    YHProductSeriesModel *selectModel = self.leftClassArray[indexPath.row];
    self.dataArray = [NSMutableArray arrayWithArray:selectModel.CategorySeries];
    if (self.dataArray.count<=0) {
        [self configEmptyViewleftSpace:93];
    }else{
        UIImage *SepacialImage = [UIImage imageNamed:@"shangjiazhong-1"];
        [self.dataArray addObject:SepacialImage];
        [self configRightCollectionView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRate(38);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--- UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
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
    if (indexPath.row < self.dataArray.count-1) {
        
        NSDictionary *dict = self.dataArray[indexPath.row];
        productModel *model = [productModel mj_objectWithKeyValues:dict];
        UIImageView *ItemImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(110), WidthRate(110))];
        ItemImage.contentMode = UIViewContentModeScaleAspectFit;
        [ItemImage sd_setImageWithURL:[NSURL URLWithString:model.GoodsSeriesIcon]];
        ItemImage.layer.borderColor = SepratorLineColor.CGColor;
        ItemImage.layer.borderWidth = WidthRate(1);
        [item addSubview:ItemImage];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(120), WidthRate(120), HeightRateCommon(47))];
        label.text = model.GoodsSeriesName;
        label.font =  SYSTEM_FONT(AdaptFont(12));
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        [item addSubview:label];
    }else{
        if ([self.dataArray objectAtIndex:self.dataArray.count-1]) {
            UIImageView *ItemImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(120), WidthRate(120))];
            ItemImage.contentMode = UIViewContentModeScaleAspectFit;
            ItemImage.image = self.dataArray[self.dataArray.count-1];
            ItemImage.layer.borderColor = SepratorLineColor.CGColor;
            ItemImage.layer.borderWidth = WidthRate(1);
            [item addSubview:ItemImage];
        }
    }
    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthRate(120), HeightRateCommon(157));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return WidthRate(15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return HeightRateCommon(25);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(HeightRateCommon(25), WidthRate(10), HeightRate(0), HeightRateCommon(10));

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == self.dataArray.count-1) {
        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        if (phone.length<=0) {
            YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
            loginViewController.navigationController.navigationBarHidden = YES;
            loginViewController.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
//        [MobClick event:@"SpecialProduct" label:@"特殊产品"];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//        ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
//        vc.hidesBottomBarWhenPushed = YES;
//        NSString *userID = Userdefault(LOGIN_USERID);
//        vc.listID = userID;
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSDictionary *dict = self.dataArray[indexPath.row];
        YHProductDetailsViewController *vc = [[YHProductDetailsViewController alloc]init];
        vc.GoodsSeriesCode = dict[@"GoodsSeriesCode"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ---UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.navigationItem.titleView endEditing:YES];
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
