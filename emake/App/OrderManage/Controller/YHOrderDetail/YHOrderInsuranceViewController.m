//
//  YHOrderInsuranceViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/24.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHOrderInsuranceViewController.h"
#import "Tools.h"
@interface YHOrderInsuranceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *emptyView;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)UICollectionView *mycollection;

@end

@implementation YHOrderInsuranceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保单";
    
   
    [self getmydata];
}

-(void)getmydata
{
    [[YHJsonRequest shared] getUserInsuranceOrder:self.contract.length>0?self.contract:@"" SuccessBlock:^(NSDictionary *Success) {
        
        if (Success.count>0) {
            [emptyView removeFromSuperview];

            UILabel *lable = [self getItem:nil name:@"合同号：" title:Success[@"ContractNo"] ishave:NO];
            UILabel *lable1 = [self getItem:lable name:@"保单号：" title:Success[@"InsuranceNo"] ishave:NO];
            
            UILabel *lable2 = [self getItem:lable1 name:@"创建时间：" title:Success[@"AddWhen"] ishave:YES];
            self.imageArray = [Tools stringToJSON:Success[@"InsurancePhoto"]];
            self.dataDic = Success;
            [self configView];
//            [self.mycollection reloadData];
        }else
        {
            [emptyView removeFromSuperview];
            [self getEmptyOrderInsurancCart];
        }
        
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages];
    }];
    
    
}
-(void)configView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT+100, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT+164)) collectionViewLayout:layout];
    collect.delegate = self;
    collect.dataSource = self;
    collect.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:collect];
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.mycollection =  collect;
//    collect.backgroundColor = [UIColor grayColor];
    
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.textColor = ColorWithHexString(@"666666");
    nameLable.text = @"    易智造平台会在30个工作日后将您的保单文件快递给您！快递地址将按照发货地址邮寄，如有变化，请联系易智造客服。给您带来不便，敬请谅解！";
    nameLable.numberOfLines = 0;
    nameLable.backgroundColor = ColorWithHexString(@"FFFFCC");
    nameLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [self.view addSubview:nameLable];
    nameLable.translatesAutoresizingMaskIntoConstraints = NO;
    [nameLable PSSetLeft:WidthRate(0)];
    [nameLable PSSetHeight:HeightRate(64)];
    [nameLable PSSetWidth:ScreenWidth];
    [nameLable PSSetBottom:0];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSString *imageUrlStr = self.imageArray[indexPath.row];
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.tag = 100 +indexPath.item;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@""]];

    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizesSubviews = YES;
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:imageView];
    [imageView PSSetConstraint:0 Right:0 Top:0 Bottom:30];
    return cell;
    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WidthRate(108), HeightRate(156));
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(HeightRate(10), WidthRate(52), HeightRate(0), WidthRate(52));
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    
    int i = 0;
    if (self.imageArray.count == 0) {
        return;
        
    }else{
        for(i = 0;i < [self.imageArray count];i++)
        {
            
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            NSString *imageUrlstr = self.imageArray[i];
            browseItem.bigImageUrl = imageUrlstr;// 加载网络图片大图地址
//            browseItem.bigImageName = imageModel.PicName;
            [browseItemArray addObject:browseItem];
        }
        MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
        bvc.isEqualRatio = YES;// 大图小图不等比时需要设置这个属性（建议等比）
        bvc.LastCollectionView = collectionView;
        [bvc showBrowseViewController];
    }
    
}


-(UILabel *)getItem:(id)item name:(NSString *)name title:(NSString *)title ishave:(BOOL)isHave
{
    UILabel *nameLable = [[UILabel alloc] init];
    nameLable.textColor = ColorWithHexString(@"A1A1A1");
    nameLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    nameLable.text = name;
    [self.view addSubview:nameLable];
    nameLable.translatesAutoresizingMaskIntoConstraints = NO;
    [nameLable PSSetLeft:WidthRate(15)];
    [nameLable PSSetHeight:HeightRate(30)];
    if (item) {
        [nameLable PSSetBottomAtItem:item Length:0];
    }else
    {
        [nameLable PSSetTop:HeightRate(10)+TOP_BAR_HEIGHT];
    }
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.textColor = ColorWithHexString(@"000000");
    titleLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    titleLable.text = title;
    [self.view addSubview:titleLable];
    titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [titleLable PSSetHeight:HeightRate(30)];
    [titleLable PSSetRightAtItem:nameLable Length:3];
    if (isHave == YES) {
        
        UILabel *tipLable = [[UILabel alloc] init];
        tipLable.textColor = ColorWithHexString(SymbolTopColor);
        tipLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        tipLable.text = @"(保期一年)";
        [self.view addSubview:tipLable];
        tipLable.translatesAutoresizingMaskIntoConstraints = NO;
        [tipLable PSSetHeight:HeightRate(30)];
        [tipLable PSSetRightAtItem:titleLable Length:10];
    }
    
    return nameLable;
}

//空订单图
-(void)getEmptyOrderInsurancCart
{
    emptyView = [[UIView alloc]init];
    emptyView.bounds =CGRectMake(WidthRate(0), HeightRate(0), ScreenWidth, HeightRate(500));
    emptyView.center = self.view.center;
    [self.view addSubview:emptyView];
    UIImageView  *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"tuzi02"]];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
//    imageview.frame = CGRectMake(WidthRate(55), HeightRate(0), WidthRate(70), HeightRate(70));
    [emptyView addSubview:imageview];
    imageview.translatesAutoresizingMaskIntoConstraints = NO;
    [imageview PSSetSize:WidthRate(148) Height:HeightRate(116)];
    [imageview PSSetCenterX];
    [imageview PSSetCenterVerticalAtItem:emptyView];
    
    UILabel  *lable  = [[UILabel alloc] init];
//    lable.bounds = CGRectMake(WidthRate(0), HeightRate(0), ScreenWidth, HeightRate(20));
//    lable.center = CGPointMake(imageview.centerX, imageview.centerY+imageview.height/1.5+HeightRate(10));
    lable.textAlignment = NSTextAlignmentCenter;;
    lable.text = @"保单在投保中，请7-15工作日后查看保单号";
    lable.textColor = ColorWithHexString(StandardBlueColor);
    lable.font = SYSTEM_FONT(13);
    [emptyView addSubview:lable];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [lable PSSetLeft:0];
    [lable PSSetWidth:ScreenWidth];
    [lable PSSetBottomAtItem:imageview Length:HeightRate(10)];
    
    
    UILabel  *tiplable  = [[UILabel alloc] init];
    //    lable.bounds = CGRectMake(WidthRate(0), HeightRate(0), ScreenWidth, HeightRate(20));
    //    lable.center = CGPointMake(imageview.centerX, imageview.centerY+imageview.height/1.5+HeightRate(10));
    tiplable.textAlignment = NSTextAlignmentCenter;;
    tiplable.text = @"客服热线：400-867-0211";
    tiplable.textColor = ColorWithHexString(SymbolTopColor);
    tiplable.font = SYSTEM_FONT(13);
    [emptyView addSubview:tiplable];
    tiplable.translatesAutoresizingMaskIntoConstraints = NO;
    [tiplable PSSetLeft:0];
    [tiplable PSSetWidth:ScreenWidth];
    [tiplable PSSetBottomAtItem:lable Length:HeightRate(10)];
    
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
