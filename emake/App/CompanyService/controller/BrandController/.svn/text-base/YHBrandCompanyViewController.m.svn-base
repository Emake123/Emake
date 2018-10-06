//
//  YHBrandCompanyViewController.m
//  emake
//
//  Created by eMake on 2017/11/6.
//  Copyright © 2017年 emake. All rights reserved.
//
#import "YHBrandCompanyViewController.h"
#import "UIView+PSAutoLayout.h"
#import "YHBrandImageCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "YHBrandSeriesDetailViewController.h"
 NSString  *collectionCell = @"cell";

@interface YHBrandCompanyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *picArr;
@end

@implementation YHBrandCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picArr = [NSMutableArray array];
    self.title = @"品牌商";
    
//    CGImageRef thumbnailImageRef = [[asset defaultRepresentation] fullScreenImage];
//UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
   
    [self addRigthDetailButtonIsNotChat:true];

    self.picArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *recordArray = [NSMutableArray arrayWithCapacity:0];
    NSInteger recordNum = 0;
    for (int i = 0; i < self.model.zizhiImageArr.count; i ++) {
        YHBrandListImageModel *ziziModel = self.model.zizhiImageArr[i];
        NSArray * resultArr = [ziziModel.PicName componentsSeparatedByString:@"-"];
        NSString *compareStr =resultArr [0];
        if (![recordArray containsObject:compareStr]) {
            [recordArray addObject:compareStr];
            recordNum++;
        }
    }
    for (int i =0; i<recordArray.count; i++) {
        NSMutableArray *reslutArr = [NSMutableArray array];
        for (int j=0; j<self.model.zizhiImageArr.count; j++) {
            YHBrandListImageModel *ziziModel = self.model.zizhiImageArr[j];
            NSArray * resultArr = [ziziModel.PicName componentsSeparatedByString:@"-"];
            NSString *compareStr =resultArr [0];
            if ([compareStr isEqualToString:recordArray[i]]) {
                [reslutArr addObject:ziziModel];
            }
        }
        [self.picArr addObject:reslutArr];
    }
    CGFloat heightSC = 640+(recordNum+1)/2*205;
    UIScrollView *scrol = [[UIScrollView alloc] init];
    scrol.contentSize = CGSizeMake(ScreenWidth, HeightRate(heightSC));
    scrol.translatesAutoresizingMaskIntoConstraints = NO;
    scrol.scrollEnabled = YES;
    [self.view addSubview:scrol];
    [scrol PSSetHeight:ScreenHeight-(TOP_BAR_HEIGHT)];
    [scrol PSSetWidth:ScreenWidth];
    [scrol PSSetLeft:0];
    [scrol PSSetTop:TOP_BAR_HEIGHT];
    
    
    UIImageView *bigPicture = [[UIImageView alloc] init];
    bigPicture.translatesAutoresizingMaskIntoConstraints = NO;
    [bigPicture sd_setImageWithURL:[NSURL URLWithString:self.model.BrandBigicon]];
    bigPicture.contentMode = UIViewContentModeScaleAspectFit;
    bigPicture.autoresizesSubviews = YES;
    bigPicture.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [scrol addSubview:bigPicture];
    [bigPicture PSSetTop:0];
    [bigPicture PSSetLeft:0];
    [bigPicture PSSetSize:ScreenWidth Height:HeightRate(230)];
    
    
    UILabel *lablename = [[UILabel alloc] init];
    lablename.translatesAutoresizingMaskIntoConstraints = NO;
    lablename.text = @"品 牌 商  ";
    lablename.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lablename.textColor = ColorWithHexString(@"000000");
    [scrol addSubview:lablename];
    [lablename PSSetLeft:WidthRate(11)];
    [lablename PSSetBottomAtItem:bigPicture Length:HeightRate(10)];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.text = self.model.CompanyName;
    lable.font = [UIFont boldSystemFontOfSize:AdaptFont(15)];
    lable.textColor = TextColor_636263;
    [scrol addSubview:lable];
    [lable PSSetRightAtItem:lablename Length:WidthRate(10)];

    UILabel *lable1 = [[UILabel alloc] init];
    lable1.translatesAutoresizingMaskIntoConstraints = NO;
    lable1.text = @"公司地址";
    lable1.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lable1.textColor = ColorWithHexString(@"000000");
    [scrol addSubview:lable1];
    [lable1 PSSetLeft:WidthRate(11)];
    [lable1 PSSetBottomAtItem:lable Length:HeightRate(10)];
    
    UILabel *lable3 = [[UILabel alloc] init];
    lable3.translatesAutoresizingMaskIntoConstraints = NO;
    lable3.text = self.model.Adress;
    lable3.font = [UIFont boldSystemFontOfSize:AdaptFont(14)];
    lable3.textColor = TextColor_636263;
    [scrol addSubview:lable3];
    [lable3 PSSetRightAtItem:lable1 Length:WidthRate(10)];
    UILabel *lableline = [[UILabel alloc] init];
    lableline.translatesAutoresizingMaskIntoConstraints = NO;
    lableline.backgroundColor = SepratorLineColor;
    [scrol addSubview:lableline];
    [lableline PSSetBottomAtItem:lable3 Length:WidthRate(10)];
    [lableline PSSetLeft:WidthRate(10)];
    [lableline PSSetWidth:WidthRate(355)];
    [lableline PSSetHeight:1];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.translatesAutoresizingMaskIntoConstraints = NO;
    collection.delegate = self;
    collection.dataSource = self;
    collection.scrollEnabled = NO;
    [scrol addSubview:collection];
    collection.backgroundColor = ColorWithHexString(@"ffffff");
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    [collection PSSetBottomAtItem:lableline Length:5];
    [collection PSSetLeft:0];
    [collection PSSetWidth:ScreenWidth];
    [collection PSSetHeight:HeightRate(heightSC)];
    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    

}


#pragma mark---collection delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section ==1) {
        return self.picArr.count;
    }
    return self.model.picArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.tag = 100 +indexPath.item;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
  

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizesSubviews = YES;
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:imageView];
    [imageView PSSetConstraint:0 Right:0 Top:0 Bottom:30];
    UILabel * lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lable];
    [lable PSSetLeft:0];
    [lable PSSetBottomAtItem:imageView Length:HeightRate(5)];
    [lable PSSetWidth:cell.bounds.size.width];
    
    UILabel * pagelable = [[UILabel alloc] init];
    pagelable.translatesAutoresizingMaskIntoConstraints = NO;
    pagelable.font = [UIFont systemFontOfSize:AdaptFont(8)];
    pagelable.layer.cornerRadius = 9;
    pagelable.layer.masksToBounds = YES;
    pagelable.backgroundColor = [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:0.31];
    pagelable.textAlignment = NSTextAlignmentCenter;
    pagelable.textColor = [UIColor whiteColor];
    [imageView addSubview:pagelable];
    [pagelable PSSetRight:WidthRate(26)];
    [pagelable PSSetBottom:HeightRate(14)];
    [pagelable PSSetSize:WidthRate(18) Height:HeightRate(18)];
    pagelable.hidden = YES;

    if (indexPath.section == 1) {
        NSArray *arr =self.picArr[indexPath.row];
        YHBrandListImageModel *imageModel =[arr firstObject];
        NSString *compareStr =imageModel.GoodsSeriesName;
        lable.text = compareStr;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.PicUrl] placeholderImage:[UIImage imageNamed:@""]];
        
        if (arr.count>1) {
            pagelable.text = [NSString stringWithFormat:@"1/%ld",(unsigned long)arr.count];
            pagelable.hidden = NO;
        }
        
    }else
    {
    NSArray *arr =self.model.picArr[indexPath.row];
    YHBrandListImageModel *imageModel =[arr firstObject];
    lable.text = imageModel.PicTypeName;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.PicUrl] placeholderImage:[UIImage imageNamed:@""]];

    if (arr.count>1) {
        pagelable.text = [NSString stringWithFormat:@"1/%ld",(unsigned long)arr.count];
                pagelable.hidden = NO;
    }
  }
    return cell;

}
#pragma mark--colooection headview
//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return CGSizeMake(ScreenWidth, 40);

    }
    return CGSizeZero;

}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"header";
    //从缓存中获取 Headercell
    UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *lable = [[UILabel alloc] initWithFrame:cell.bounds];
    lable.backgroundColor = SepratorLineColor;
    lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lable.text = @"  资质认证";
    [cell addSubview:lable];
    return cell;
}


//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WidthRate(128), HeightRate(200));
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(HeightRate(10), WidthRate(39), HeightRate(0), WidthRate(39));
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray * arr =indexPath.section==1?self.picArr[indexPath.row]:self.model.picArr[indexPath.row];
    
    
    if (indexPath.section == 1) {
        
        YHBrandSeriesDetailViewController *series = [[YHBrandSeriesDetailViewController alloc] init];
        YHBrandListImageModel *imageModel = arr[0];

        series.getArr = arr;
        series.title = imageModel.GoodsSeriesName;
        [self.navigationController pushViewController:series animated:YES];
    } else {
        
        NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
        
            int i = 0;
            if (arr.count == 0) {
                return;
        
            }else{
                for(i = 0;i < [arr count];i++)
                {
        
                    MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
                    YHBrandListImageModel *imageModel = arr[i];
                    browseItem.bigImageUrl = imageModel.PicUrl;// 加载网络图片大图地址
                    browseItem.bigImageName = imageModel.PicName;
                    [browseItemArray addObject:browseItem];
                }
                MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:0];
                bvc.isEqualRatio = YES;// 大图小图不等比时需要设置这个属性（建议等比）
                bvc.LastCollectionView = collectionView;
                [bvc showBrowseViewController];
            }
    }

}

-(UILabel *)getDetailInfomation:(NSString *)name companyName:(NSString *)companyName top:(CGFloat)top
{
    UILabel *lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.text = name;
    lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    
    [self.view addSubview:lable];
    [lable PSSetLeft:WidthRate(12)];
    [lable PSSetTop:top];
    [lable PSSetWidth:WidthRate(75)];
    
    UILabel *lablename = [[UILabel alloc] init];
    lablename.translatesAutoresizingMaskIntoConstraints = NO;
    lablename.text = companyName;
    lablename.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lablename.textColor = ColorWithHexString(@"636263");
    [self.view addSubview:lablename];
    [lablename PSSetRightAtItem:lable Length:WidthRate(50)];
    
    UILabel *lableline = [[UILabel alloc] init];
    lableline.translatesAutoresizingMaskIntoConstraints = NO;
    lableline.backgroundColor = SepratorLineColor;
    [self.view addSubview:lableline];
    [lableline PSSetBottomAtItem:lable Length:WidthRate(3)];
    [lableline PSSetLeft:WidthRate(10)];
    [lableline PSSetRight:WidthRate(28)];
    [lableline PSSetHeight:1];
    
    return lableline;
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
