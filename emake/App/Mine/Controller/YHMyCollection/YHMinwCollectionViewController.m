//
//  YHMinwCollectionViewController.m
//  emake
//
//  Created by 张士超 on 2018/6/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMinwCollectionViewController.h"
#import "YHMainSearchTableViewCell.h"
#import "YhSearchModel.h"
#import "YHProductDetailsViewController.h"
#import "YHMYStoreCollectionTableViewCell.h"
#import "YHStoreCloudTableViewCell.h"
#import "YHTitleView.h"
#import "YHStoreModel.h"
#import "YHStoreDetailViewController.h"
@interface YHMinwCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,YHTitleViewViewDelegete>
{
    UITableView *mytable;
}
@property(nonatomic,strong)NSMutableArray *collectionArr;
@property(nonatomic,strong)NSMutableArray *collectionStoreArr;

@property(nonatomic,strong)NSMutableArray *collectionGoodsArr;

@property(nonatomic,strong)UIView *EmptyView;
@property(nonatomic,assign)BOOL isShowStoreCollections;
@property(nonatomic,strong)NSMutableArray *TopTitleArray;
@property(nonatomic,strong)YHTitleView *TitleView;
@property(nonatomic,assign)NSInteger recordIndex;

@end

@implementation YHMinwCollectionViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getColletionData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    CGFloat tableHeight =TOP_BAR_HEIGHT;
    self.view.backgroundColor = ColorWithHexString(@"ffffff");
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    self.TopTitleArray = [NSMutableArray array];
    CGFloat TopHeight =0;
   
//    TopHeight =(TOP_BAR_HEIGHT);
    mytable = [[UITableView alloc] initWithFrame:CGRectMake(0, TopHeight, ScreenWidth, ScreenHeight-tableHeight) style:UITableViewStyleGrouped];
    mytable.estimatedRowHeight = HeightRate(200);
//    mytable.estimatedSectionHeaderHeight = 0.01;
    mytable.sectionFooterHeight = 0.001;
    mytable.sectionHeaderHeight = 0.001;
    mytable.delegate = self;
    mytable.dataSource = self;
    [self.view addSubview:mytable];
    

}

- (void)configEmptyView{
    if (self.EmptyView) {
        
        self.EmptyView.hidden = false;
        
    }else
    {
        CGFloat Height = TOP_BAR_HEIGHT;
        self.EmptyView = [[UIView alloc]init];
        self.EmptyView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.EmptyView];
        
        [self.EmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(Height);
            make.bottom.mas_equalTo(0);
        }];
        
        
        UIImageView *emptyImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"queyimianpeitu"]];
        self.EmptyView.contentMode = UIViewContentModeScaleAspectFit;
        [self.EmptyView addSubview:emptyImage];
        
        [emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.EmptyView.mas_centerX);
            make.top.mas_equalTo(HeightRate(160));
            make.width.mas_equalTo(WidthRate(200));
            make.height.mas_equalTo(WidthRate(200));
        }];
        
        UILabel *labelText = [[UILabel alloc]init];
        labelText.text = @"您还没有收藏";
        labelText.textAlignment = NSTextAlignmentCenter;
        labelText.font = SYSTEM_FONT(AdaptFont(16));
        [self.EmptyView addSubview:labelText];
        
        
        [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.EmptyView.mas_centerX);
            make.top.mas_equalTo(emptyImage.mas_bottom).offset(HeightRate(10));
            
        }];
    }
}
#pragma mark--data
-(void)getColletionData
{
    [[YHJsonRequest shared] getUserCollectionProductSuccessBlock:^(NSArray *Success) {
        [self.EmptyView removeFromSuperview];

        if (Success.count==0) {
            [self configEmptyView];
        }else
        {
            self.EmptyView.hidden = YES;
            self.collectionGoodsArr = [NSMutableArray arrayWithArray:Success];
            self.isShowStoreCollections = false;
        }
            [mytable reloadData];

    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}

-(void)getStoreCollectionData
{
    [[YHJsonRequest shared] getUserCollectionStoreRequestMethod:Get params:nil SuccessBlock:^(NSArray *Success) {
        
        self.collectionStoreArr = [NSMutableArray arrayWithArray:Success];

            
        [mytable reloadData];

    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];

    }];
}

-(void)getStoreCollectionCancelData
{
    
}
#pragma mark--tabble delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

        return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collectionGoodsArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

            YhSearchModel *model = self.collectionGoodsArr[indexPath.row];
            YHStoreCloudTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cloudCell"];
            if (cell == nil) {
                cell = [[YHStoreCloudTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cloudCell"];
            }
            [cell.storeImageView sd_setImageWithURL:[NSURL URLWithString:model.GoodsSeriesIcon]];

            cell.companyLable.text =model.GoodsSeriesTitle;
            cell.orderNumberLable.text =[NSString stringWithFormat:@"销量:%@笔",model.GoodsSale];
            cell.orderMoneyLable.text =[NSString stringWithFormat:@"%@",model.PriceRange];
            cell.tipsImage.hidden  = YES;
            [cell.customSeviceButton addTarget:self action:@selector(cancelCollectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.customSeviceButton setTitle:@"取消收藏" forState:UIControlStateNormal];
            cell.customSeviceButton.tag = 300+indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(35))];
        headView.backgroundColor = [UIColor whiteColor];
        if(self.TitleView ==nil){
        self.TitleView= [[YHTitleView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(180), HeightRate(35)) titleFont:14 delegate:self andTitleArray:self.TopTitleArray];
        [headView addSubview:self.TitleView];
            
        }
        
        
        return headView;
   
  
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.isShowStoreCollections == NO) {
        YhSearchModel *model = self.collectionGoodsArr[indexPath.row];
        YHProductDetailsViewController *detaiVC = [[YHProductDetailsViewController alloc] init];
        detaiVC.GoodsSeriesCode = model.GoodsSeriesCode;
        detaiVC.StoreID = model.StoreId;
        detaiVC.StoreName = model.StoreName;
        detaiVC.storeAvata = @"";//  model.StorePhoto;
        detaiVC.storePhoneNumber = model.StoreOwner[@"MobileNumber"];
        [self.navigationController pushViewController:detaiVC animated:YES];
//    }else
//    {
//        YHStoreModel *model = self.collectionArr[indexPath.row];
//        YHStoreDetailViewController *detaiVC = [[YHStoreDetailViewController alloc] init];
//        detaiVC.storeId = model.StoreId;
//
//        [self.navigationController pushViewController:detaiVC animated:YES];
//    }
   
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            YhSearchModel *model = self.collectionArr[indexPath.row];
    
        [[YHJsonRequest shared] userCancelCollectionProductWithParameter:model.RefNo SuccessBlock:^(NSString *Success) {
        
            [self.collectionArr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.view makeToast:@"删除成功" duration:1.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                if (self.collectionArr.count == 0) {
                  
                    [self configEmptyView];
                }
            }];

           
        
        } fialureBlock:^(NSString *errorMessages) {
        
          [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        }];
    }];
    
        deleteAction.backgroundColor = ColorWithHexString(@"FAAF1E");
        return @[deleteAction];
        
    }
#pragma mark--buttonclick
-(void)EnterStoreBUttonClick:(UIButton *)button
{
    NSInteger row = button.tag-200;
    YhSearchModel *model = self.collectionArr[row];
    YHStoreDetailViewController *detailVC = [[YHStoreDetailViewController alloc] init];
    detailVC.storeId = model.StoreId;
    detailVC.storeName = model.StoreName;
    [self.navigationController pushViewController:detailVC animated:YES];
    

}
-(void)cancelCollectionButtonClick:(UIButton *)button
{
    [self CancelCollection:(button.tag-300)];
}

-(void)CancelCollection:(NSInteger)index
{
    YhSearchModel *model = self.collectionArr[index];
//    @[[NSString stringWithFormat:@"商品(%ld)",self.collectionArr.count],[NSString stringWithFormat:@"店铺(%ld)",self.collectionStoreArr.count]]
    if (self.isShowStoreCollections) {
        NSDictionary *dic = @{@"RefNo":model.RefNo};
        [[YHJsonRequest shared] getUserCollectionStoreRequestMethod:Delete params:dic SuccessBlock:^(NSArray *Success) {
           
            [self.collectionArr removeObjectAtIndex:index];
            [self.collectionStoreArr removeObjectAtIndex:index];
            UIButton *button = self.TitleView.titleButtonArray[_recordIndex];
            [button setTitle:[NSString stringWithFormat:@"店铺(%ld)",self.collectionStoreArr.count] forState:UIControlStateNormal];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
            [mytable deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
            [self.view makeToast:@"取消收藏" duration:1.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                if (self.collectionArr.count == 0) {
                    
                    [self configEmptyView];
                }
            }];

            
        } fialureBlock:^(NSString *errorMessages) {
            [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];

        }];
    }else
    {
        [[YHJsonRequest shared] userCancelCollectionProductWithParameter:model.RefNo SuccessBlock:^(NSString *Success) {
            
            [self.collectionArr removeObjectAtIndex:index];
            [self.collectionGoodsArr removeObjectAtIndex:index];
            UIButton *button = self.TitleView.titleButtonArray[_recordIndex];
            [button setTitle:[NSString stringWithFormat:@"商品(%ld)",self.collectionArr.count] forState:UIControlStateNormal];
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
            [mytable deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationFade];
            [self.view makeToast:@"取消收藏" duration:1.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                if (self.collectionArr.count == 0) {
                    
                    [self configEmptyView];
                }
            }];
            
        } fialureBlock:^(NSString *errorMessages) {
            
            [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        }];
    }
}
#pragma mark---YHTitleView
- (void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index{
    NSLog(@"indek====%ld",(long)index);
    self.recordIndex = index;
    self.collectionArr = [NSMutableArray arrayWithArray:index==1?self.collectionStoreArr:self.collectionGoodsArr];
    self.isShowStoreCollections  = index;
    if(self.collectionArr.count>0)
    {
        self.EmptyView.hidden = YES;
        mytable.hidden = false;
        [mytable reloadData];
    }else
    {
        mytable.hidden = YES;
        [self configEmptyView];
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
