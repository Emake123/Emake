//
//  StoreSeriesViewController.m
//  emake
//
//  Created by 张士超 on 2018/7/25.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "StoreSeriesViewController.h"
#import "YHStoreModel.h"
#import "YHStoreCloudTableViewCell.h"
#import "ChatNewViewController.h"
#import "PSButtonBase.h"
#import "YHStoreDetailViewController.h"
@interface StoreSeriesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *leftTableView;
    UITableView *rightTableView;
    UIScrollView *GoodsListScrolView;
    NSString *selectCatagoryId;

    UIView *emptyBgView;
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSArray *dataStoreArr;

@end

@implementation StoreSeriesViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getLeftListData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云 工 厂";
    [self addRigthDetailButtonIsShowCart:false];
    self.view.backgroundColor =ColorWithHexString(@"ffffff");

    
    for (int i=0;i<2 ;i++) {
        
        CGFloat tableViewWidth = i?(ScreenWidth-110):110;
        CGFloat tableViewX = 110*i;
        CGFloat tableViewY = i==0?TOP_BAR_HEIGHT:((TOP_BAR_HEIGHT) + 78);

        UITableView *brandTableView  = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewWidth, ScreenHeight-(TOP_BAR_HEIGHT)-77) style:UITableViewStylePlain];
        brandTableView.delegate = self;
        brandTableView.dataSource = self;
        brandTableView.tag = i+50;//tag=50左边tableview，否则为右边
        brandTableView.sectionFooterHeight = 0;
        brandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:brandTableView];
        if (i==0) {
            leftTableView = brandTableView;
            brandTableView.backgroundColor =ColorWithHexString(@"F7F7F7");

        } else {
            if (@available(iOS 11.0, *)){
                brandTableView.estimatedSectionFooterHeight = TableViewFooterNone;
               brandTableView.estimatedSectionHeaderHeight = TableViewHeaderNone;
            }
            brandTableView.estimatedRowHeight  = 100;
            rightTableView = brandTableView;
            brandTableView.backgroundColor =ColorWithHexString(@"ffffff");

//            if () {
//                
//            }
        }
        
    }
    
    GoodsListScrolView = [[UIScrollView alloc] init];
    GoodsListScrolView.frame =  CGRectMake(110, TOP_BAR_HEIGHT, ScreenWidth-110, HeightRate(77));
    GoodsListScrolView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:GoodsListScrolView ];
    GoodsListScrolView.backgroundColor = [UIColor whiteColor];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(110, (TOP_BAR_HEIGHT) + HeightRate(77), ScreenWidth-110, 1)];
    
    line.backgroundColor = SepratorLineColor;
    [self.view addSubview:line];
   
    
}

-(void)getLeftListData{
    
    [self.view showWait:@"加载中" viewType:CurrentView];
    self.dataArr = [NSMutableArray array];
    [[YHJsonRequest shared] getShoppingGoodCategoriesSeriesId:self.CategoryId  SuccessBlock:^(NSDictionary *successMessage) {
        [self.view hideWait:CurrentView];
        NSArray *listArr     = [NSArray arrayWithArray:successMessage[@"消费品"]];
        if (listArr.count ==0) {
            [self emptyViewWithNoneData];
        }else{
            BOOL isInlistArr = false;
            for (NSDictionary *dict in listArr) {
                YHStoreListModel *model = [YHStoreListModel mj_objectWithKeyValues:dict];
                model.StoresArr = [NSMutableArray array];
                
                for (NSDictionary *storeDict in model.Stores) {
                    YHStoreModel *storeModel = [YHStoreModel mj_objectWithKeyValues:storeDict];
                    [model.StoresArr addObject:storeModel];
                }
                if([model.CategoryName isEqualToString:self.goodsName])
                {
                    
                    [self ConfigGoodsListView:model];
                    model.isSelect = YES;
                    isInlistArr = YES;
                    self.dataStoreArr = [NSArray arrayWithArray:model.StoresArr];
                    if (self.dataStoreArr.count==0) {
                        rightTableView.hidden = YES;
                        [emptyBgView removeFromSuperview];
                        [self emptyViewWithNoneData];
                    }else
                    {
                        [emptyBgView removeFromSuperview];
                        rightTableView.hidden = NO;
                        [rightTableView reloadData];
                        
                    }
                    
                }
                [self.dataArr addObject:model];
            }
            if(isInlistArr == false)
            {
                YHStoreListModel *model = self.dataArr.firstObject;
                model.isSelect = YES;
                [self ConfigGoodsListView:model];
                
                self.dataStoreArr = [NSArray arrayWithArray:model.StoresArr];
                if (self.dataStoreArr.count==0) {
                    rightTableView.hidden = YES;
                    [emptyBgView removeFromSuperview];
                    [self emptyViewWithNoneData];
                }else
                {
                    [emptyBgView removeFromSuperview];
                    rightTableView.hidden = NO;
                    [rightTableView reloadData];
                    
                }
                
            }
            
        }
        [leftTableView reloadData];
        [rightTableView reloadData];

    } fialureBlock:^(NSString *errorMessages) {

        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 50) {
        return self.dataArr.count;
    }else{
        return self.dataStoreArr.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==50) {
        return HeightRate(44);
    } else {
        return UITableViewAutomaticDimension;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==50) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        YHStoreListModel *listModel = self.dataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (listModel.isSelect==YES) {
            
           selectCatagoryId = listModel.CategoryId;

            cell.backgroundColor = ColorWithHexString(@"ffffff");

        } else {
            cell.backgroundColor = ColorWithHexString(@"f7f7f7");

        }
        cell.textLabel.font = [UIFont systemFontOfSize:AdaptFont(12)];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = listModel.CategoryName ;
        return cell;
        
    } else {

        YHStoreModel *model = self.dataStoreArr [indexPath.row];
        YHStoreCloudTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cloudCell"];
        if (cell == nil) {
            cell = [[YHStoreCloudTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cloudCell"];
        }
        [cell.storeImageView sd_setImageWithURL:[NSURL URLWithString:model.StorePhoto]];

        cell.companyLable.text =model.StoreName;
        cell.orderNumberLable.text = [NSString stringWithFormat:@"订单数:%@单",model.StoreOrders];
        cell.orderMoneyLable.text = [NSString stringWithFormat:@"订单额:¥%@",[Tools getHaveNum: model.StoreSales.doubleValue]];
        cell.tipsImage.hidden  = !model.IsCollect.integerValue;
        cell.customSeviceButton.tag = indexPath.row;
        [cell.customSeviceButton addTarget:self action:@selector(customSeviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 50) {
        YHStoreListModel *listmodel = self.dataArr[indexPath.row];
        [self ConfigGoodsListView:listmodel];

        self.dataStoreArr = listmodel.StoresArr;
        if (self.dataStoreArr.count==0) {
            rightTableView.hidden = YES;
            [emptyBgView removeFromSuperview];
            [self emptyViewWithNoneData];
        }else
        {
            [emptyBgView removeFromSuperview];
            rightTableView.hidden = NO;
            [rightTableView reloadData];
            
        }
        for (int i=0; i<self.dataArr.count; i++) {
            YHStoreListModel *listmodel111 = self.dataArr[i];
            
            if (i==indexPath.row) {
                
                listmodel111.isSelect = YES;
                
                [rightTableView reloadData];
            }else
            {
                listmodel111.isSelect = NO;
            }
        }
        
        [leftTableView reloadData];
        
    } else {
        YHStoreDetailViewController *storeVC = [[YHStoreDetailViewController alloc]init];
        YHStoreModel *model = self.dataStoreArr[indexPath.row];
        storeVC.storeId = model.StoreId;
        storeVC.storeName = model.StoreName;
        storeVC.catagory = selectCatagoryId;
        [self.navigationController pushViewController:storeVC animated:YES];
    }
}
-(void)emptyViewWithNoneData
{
    UIView *emptyView = [[UIView alloc] init];
    emptyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:emptyView];
    
    [emptyView PSSetCenterXPercent:0.6];
    [emptyView PSSetCenterHorizontalAtItem:self.view];
    
    [emptyView PSSetSize:WidthRate(200) Height:HeightRate(230)];
    emptyBgView = emptyView;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizesSubviews = YES;
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;    imageView.image = [UIImage imageNamed:@"zanwupinpai"];
    [emptyView addSubview:imageView];
    [imageView PSSetConstraint:0 Right:0 Top:0 Bottom:HeightRate(20)];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.text = @"加紧上架中";
    lable.textAlignment = NSTextAlignmentCenter;
    [emptyView addSubview:lable];
    [lable PSSetBottomAtItem:imageView Length:0];
    [lable PSSetLeft:0];
    [lable PSSetRight:0];
    [lable PSSetHeight:HeightRate(20)];
    
    
}

-(void)ConfigGoodsListView:(YHStoreListModel *)model
{
    [[GoodsListScrolView subviews] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIView class]])
        {
            [obj removeFromSuperview];
        }
    }];
    GoodsListScrolView.contentSize = CGSizeMake(HeightRate(75)*model.CategorySeries.count, HeightRate(77));
    for (int i = 0; i < model.CategorySeries.count; i++) {
        CGFloat width = 70;
        NSDictionary *dict = model.CategorySeries[i];
        CGFloat leftSpace = 5*(i+1)+width*i;
        NSString *urlStr =dict[@"GoodsSeriesIcon"];

        UIView *itemView = [[UIView alloc] init];
        itemView.translatesAutoresizingMaskIntoConstraints = NO;
        [GoodsListScrolView addSubview:itemView];
        [itemView PSSetLeft:HeightRate(leftSpace)];
        [itemView PSSetCenterHorizontalAtItem:GoodsListScrolView];
        [itemView PSSetSize:WidthRate(width) Height:HeightRate(60)];
        
        UIImageView *goodsImage = [[UIImageView alloc] init];
        [goodsImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        goodsImage.contentMode = UIViewContentModeScaleAspectFit;
        goodsImage.autoresizesSubviews = YES;
        goodsImage.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [itemView addSubview:goodsImage];
        goodsImage.translatesAutoresizingMaskIntoConstraints = NO;
        [goodsImage PSSetTop:HeightRate(5)];
        [goodsImage PSSetLeft:WidthRate(10)];
        [goodsImage PSSetSize:WidthRate(40) Height:HeightRate(40)];
        
        UILabel *goodsName = [[UILabel alloc] init];
        goodsName.translatesAutoresizingMaskIntoConstraints = NO;
        goodsName.text = dict[@"GoodsSeriesName"];
        goodsName.textAlignment = NSTextAlignmentCenter;
        goodsName.font = [UIFont systemFontOfSize:AdaptFont(10)];
        goodsName.textColor = ColorWithHexString(@"333333");
        [itemView addSubview:goodsName];
        [goodsName PSSetBottomAtItem:goodsImage Length:0];
        [goodsName PSSetSize:WidthRate(70) Height:HeightRate(15)];
        [goodsName PSSetLeft:0];
    }
    
    
}

#pragma mark==button click
-(void)customSeviceButtonClick:(UIButton *)button{
    bool isVisist = [self isVisitorLoginByPhoneNumberExits];
    if (isVisist ==false) {
        return;
    }
    YHStoreModel *model = self.dataStoreArr [button.tag];
    NSString *myStoreID = Userdefault(LOGIN_UserStoreID);
    if ([myStoreID isEqualToString:model.StoreId]) {
        [self.view makeToast:@"不能对自己的店铺发起聊天" duration:1.5 position:CSToastPositionCenter];
        return ;
    }
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
//    NSString *userID = Userdefault(LOGIN_USERID);
//    vc.storeName = model.StoreName;
//    vc.storeAvata = model.StorePhoto;
//    vc.listID = [NSString stringWithFormat:@"%@_%@",model.StoreId,userID];
//    vc.storeID = model.StoreId;
//    [self.navigationController pushViewController:vc animated:YES];
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