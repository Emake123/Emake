//
//  YHBrandSeriesDetailViewController.m
//  emake
//
//  Created by 张士超 on 2018/3/26.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHBrandSeriesDetailViewController.h"
#import "YHBrandModel.h"
#import "UIImageView+WebCache.h"
@interface YHBrandSeriesDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger record;
    NSIndexPath *recordIndexPath;

}
@property(nonatomic,strong)NSMutableArray *picArr;
@end

@implementation YHBrandSeriesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRigthDetailButtonIsShowCart:false];

    NSMutableArray *recordArray = [NSMutableArray arrayWithCapacity:0];
    self.picArr = [NSMutableArray array];
    for (int i = 0; i < self.getArr.count; i ++) {
        YHBrandListImageModel *ziziModel = self.getArr[i];

        if (![recordArray containsObject:ziziModel.GoodsParamName]) {
            [recordArray addObject:ziziModel.GoodsParamName];
        
        }
    }
    for (int i =0; i<recordArray.count; i++) {
        NSMutableArray *reslutArr = [NSMutableArray array];
        for (int j=0; j<self.getArr.count; j++) {
            YHBrandListImageModel *ziziModel = self.getArr[j];
        
            if ([ziziModel.GoodsParamName isEqualToString:recordArray[i]]) {
                [reslutArr addObject:ziziModel];
            }
        }
        [self.picArr addObject:reslutArr];
    }
    

    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    collect.delegate = self;
    collect.dataSource = self;
    collect.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:collect];
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    record = 20;
    recordIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [collect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.picArr.count;
    }else
    {
        NSArray *resultArr = self.picArr[recordIndexPath.row];

        return resultArr.count;

    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (indexPath.section == 0) {
       
        UILabel *lable = [[UILabel alloc] init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        lable.text = @"3000kVA";
        lable.textAlignment = NSTextAlignmentCenter;
        lable.layer.borderWidth = 1;
        lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [cell.contentView addSubview:lable];
        [lable PSSetConstraint:0 Right:0 Top:0 Bottom:0];
        if (recordIndexPath.row ==  indexPath.row) {
            
            lable.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;

        }else
        {
            lable.layer.borderColor = SepratorLineColor.CGColor;

        }
        
        NSArray *nameArr = self.picArr[indexPath.row];
        if (nameArr.count>0) {
            YHBrandListImageModel *model = nameArr[0];
            lable.text = model.GoodsParamName;
            
        }
    } else {
        NSArray *resultArr = self.picArr[recordIndexPath.row];
        YHBrandListImageModel *brand = resultArr[indexPath.row];
        
        UIImageView *imageView  = [[UIImageView alloc] init];
        imageView.tag = 100 +indexPath.item;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizesSubviews = YES;
        imageView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:imageView];
        [imageView PSSetConstraint:0 Right:0 Top:0 Bottom:0];
        [imageView sd_setImageWithURL:[NSURL URLWithString:brand.PicUrl] placeholderImage:[UIImage imageNamed:@""]];

    }
    
    
    return cell;
}


#pragma mark--colooection headview
//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(ScreenWidth, 1);
        
    }
    return CGSizeZero;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        
        NSArray *nameArr =  self.picArr[indexPath.row];
        YHBrandListImageModel *model = nameArr[0];
        NSString *text = model.GoodsParamName;
        CGSize size = [Tools calcTextSize:text Size:AdaptFont(12)];
        return CGSizeMake(WidthRate(size.width+20), HeightRate(31));
    } else {
        
        
        return CGSizeMake(WidthRate(105), HeightRate(150));
        
    }
}
///设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        
            return UIEdgeInsetsMake(HeightRate(10), WidthRate(10), HeightRate(10), WidthRate(10));

    }else
    {
    return UIEdgeInsetsMake(HeightRate(10), WidthRate(15), HeightRate(10), WidthRate(15));

    }
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"header";
    //从缓存中获取 Headercell
    UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *lable = [[UILabel alloc] initWithFrame:cell.bounds];
    lable.backgroundColor = SepratorLineColor;
    [cell addSubview:lable];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {

        record = indexPath.row;
        recordIndexPath = indexPath;

        [collectionView reloadData];

    } else
    {
        
        NSArray *arr = self.picArr[recordIndexPath.row];

        NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];

        if (arr.count == 0) {
            return;
            
        }else
        {
          for(int i = 0;i < [arr count];i++)
          {
            
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            YHBrandListImageModel *imageModel = arr[i];
            browseItem.bigImageUrl = imageModel.PicUrl;// 加载网络图片大图地址
            browseItem.bigImageName = imageModel.PicName;
            [browseItemArray addObject:browseItem];
           }
           MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
           bvc.isEqualRatio = YES;// 大图小图不等比时需要设置这个属性（建议等比）
           bvc.LastCollectionView = collectionView;
          [bvc showBrowseViewController];
      }
    
    }
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
