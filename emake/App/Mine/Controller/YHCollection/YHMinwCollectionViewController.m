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

@interface YHMinwCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mytable;
}
@property(nonatomic,strong)NSMutableArray *collectionArr;
@property(nonatomic,strong)UIView *EmptyView;

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

    self.extendedLayoutIncludesOpaqueBars = YES;
    

    mytable = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-tableHeight) style:UITableViewStyleGrouped];
    mytable.estimatedRowHeight = HeightRate(200);
//    mytable.estimatedSectionHeaderHeight = 0.01;
    mytable.sectionFooterHeight = 0.001;
    mytable.sectionHeaderHeight = 0.001;
    mytable.delegate = self;
    mytable.dataSource = self;
    [self.view addSubview:mytable];
    
//    if (@available(iOS 11.0, *)){
//        mytable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else{
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
//    / 设置tableView的内边距(能够显示出导航栏和tabBar下覆盖的内容)
    
//    mytable.contentInset = UIEdgeInsetsMake(-0, 0,0, 0);
//
//    // 设置内容指示器(滚动条)的内边距
//
//    mytable.scrollIndicatorInsets = mytable.contentInset;
}
- (void)configEmptyView{
    self.EmptyView = [[UIView alloc]init];
    self.EmptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.EmptyView];
    
    [self.EmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo((TOP_BAR_HEIGHT));
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
    labelText.text = @"您还没有收藏的商品";
    labelText.textAlignment = NSTextAlignmentCenter;
    labelText.font = SYSTEM_FONT(AdaptFont(16));
    [self.EmptyView addSubview:labelText];
    
    
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.EmptyView.mas_centerX);
        make.top.mas_equalTo(emptyImage.mas_bottom).offset(HeightRate(10));
        
    }];
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
        self.collectionArr = [NSMutableArray arrayWithArray:Success];
        }
        [mytable reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}


#pragma mark--tabble delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.collectionArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHMainSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell = [[YHMainSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    YhSearchModel *model = self.collectionArr[indexPath.row];
    [cell.productImage sd_setImageWithURL:[NSURL URLWithString: model.GoodsSeriesIcon]];
    
    cell.productName.text = model.GoodsSeriesName;
    cell.productPrice.text =[NSString stringWithFormat:@"¥%@-%@",[Tools getHaveNum:model.GoodsPriceMin.doubleValue],[Tools getHaveNum:model.GoodsPriceMax.doubleValue]];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        YhSearchModel *model = self.collectionArr[indexPath.row];
        YHProductDetailsViewController *detaiVC = [[YHProductDetailsViewController alloc] init];
        detaiVC.productCode = model.CategoryId;
        detaiVC.productSerialCode = model.GoodsSeriesCode;
        [self.navigationController pushViewController:detaiVC animated:YES];
   
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
                    [self.EmptyView removeFromSuperview];
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
