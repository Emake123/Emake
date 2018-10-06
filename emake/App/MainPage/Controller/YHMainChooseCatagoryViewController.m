//
//  YHMainChooseCatagoryViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/2.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainChooseCatagoryViewController.h"
#import "PSButtonBase.h"
#import "YHMainCatagoryModel.h"
@interface YHMainChooseCatagoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *bgview;
    

}
@property(nonatomic,retain)NSMutableArray *CategoryData;
@property(nonatomic,retain)NSMutableArray *CategoryCode;
@property(nonatomic,retain)NSMutableArray *CategoryImage;
@property(nonatomic,retain)NSMutableArray *storeBtnArr;
@property(nonatomic,retain)NSMutableArray *CategoryArr;

@property(nonatomic,strong)UICollectionView *collection;

@end

@implementation YHMainChooseCatagoryViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:false];

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.CategoryData = [NSMutableArray arrayWithObjects:@"输配电",@"电机",@"家具",@"灯具",@"休闲食品",nil];
    self.CategoryCode = [NSMutableArray arrayWithObjects:@"001-001",@"001-002",@"002-001",@"002-002",@"002-003",nil];
    self.CategoryImage = [NSMutableArray arrayWithObjects:@"shupeidian",@"dianji",@"shafa",@"dengju",@"shipin",nil];
    [self confingView];

    [self getdata];
}

-(void)getdata{

    [[YHJsonRequest shared] addVisitorsLoginSuccessBlock:^(NSArray *categoryDict) {
        [bgview removeFromSuperview];
        if (categoryDict.count>0) {
            self.CategoryArr = [NSMutableArray arrayWithArray:categoryDict];
            self.storeBtnArr = [NSMutableArray arrayWithCapacity:categoryDict.count];
            for ( int i=0;i<categoryDict.count;i++) {
                if (i==0) {
                    [self.storeBtnArr addObject:@(0)];

                }else
                {
                    [self.storeBtnArr addObject:@(1)];

                }
                [self.collection reloadData];
            }
        }
    } fialureBlock:^(NSString *errorMessages) {
        
        [self reloadViews];
        [self.view makeToast:errorMessages];
    }];
   
}

-(void)reloadViews
{
    if (bgview==nil) {
        
        
        bgview = [[UIView alloc] init];
        bgview.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:bgview];
        [bgview PSSetCenterX];
        [bgview PSSetSize:WidthRate(ScreenWidth) Height:HeightRate(80)];
        [bgview PSSetCenterVerticalAtItem:self.view];
   
    
    UILabel *label= [[UILabel alloc] init];
    label.text = @"当前网络或服务器不稳定";
    label.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label PSSetCenterX];
    [label PSSetSize:ScreenWidth Height:HeightRate(40)];
    [label PSSetCenterVerticalAtItem:bgview];
        
        
   UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击刷新重试" forState:UIControlStateNormal];
    [button setTitleColor:ColorWithHexString(SymbolTopColor) forState:UIControlStateNormal];
        [button setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateHighlighted];

    [button addTarget:self action:@selector(getdata) forControlEvents:UIControlEventTouchUpInside];

    button.titleLabel.lineBreakMode = 0;//这句话很重要，不加这句话加上换行符也没用
    [bgview addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button PSSetCenterX];
    [button PSSetSize:WidthRate(200) Height:HeightRate(40)];
    [button PSSetBottomAtItem:label Length:0];
        
    
        
    }
    
}
-(void)confingView
{
    UIImageView *titleimage = [[UIImageView alloc] init];
//    titleimage.bounds = CGRectMake(0, 0, WidthRate(150), HeightRate(40));
//    titleimage.center = CGPointMake(self.view.centerX, HeightRate(130));
    titleimage.image = [UIImage imageNamed:@"AppIcon"];
    [self.view addSubview:titleimage];
    titleimage.layer.cornerRadius = 6;
    titleimage.layer.masksToBounds = YES;
    titleimage.translatesAutoresizingMaskIntoConstraints = NO;
    [titleimage PSSetLeft:WidthRate(123)];
    [titleimage PSSetSize:WidthRate(36) Height:HeightRate(36)];
    [titleimage PSSetTop:HeightRate(85)];

    UILabel *lable1 = [[UILabel alloc] init];
    lable1.text = @"易智造云工厂";
    lable1.textColor = ColorWithHexString(@"617393");
    lable1.font = [UIFont boldSystemFontOfSize:AdaptFont(18)];

//    lable1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable1];
    lable1.translatesAutoresizingMaskIntoConstraints = NO;
    [lable1 PSSetRightAtItem:titleimage Length:5];
    
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"请选择一个您感兴趣的品类";
    lable.textColor = ColorWithHexString(StandardBlueColor);

    lable.font = [UIFont boldSystemFontOfSize:AdaptFont(16)];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    lable.bounds = CGRectMake(0, 0, WidthRate(250), HeightRate(40));
    lable.center = CGPointMake(self.view.centerX, HeightRate(170));

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HeightRate(200), ScreenWidth, ScreenHeight-300) collectionViewLayout:layout];
    collection.translatesAutoresizingMaskIntoConstraints = NO;
    collection.delegate = self;
    collection.dataSource = self;
    collection.scrollEnabled = NO;
    [self.view addSubview:collection];
    collection.backgroundColor = ColorWithHexString(@"ffffff");
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collection = collection;
    
    UIButton *   addButton  = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"确定" forState:UIControlStateNormal];
    [addButton setTitleColor:ColorWithHexString(@"FFFFFF") forState:UIControlStateNormal];
    addButton.backgroundColor = ColorWithHexString(StandardBlueColor);
    addButton.frame =CGRectMake(WidthRate(25), ScreenHeight-100, WidthRate(325), HeightRate(40));
    [addButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.CategoryArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YHMainCatagoryModel *model = self.CategoryArr[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.tag = 100 +indexPath.item;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizesSubviews = YES;
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.CategoryIcon] placeholderImage:[UIImage imageNamed:@"placehold"]];
    [imageView PSSetCenterX];
    [imageView PSSetTop:0];
    [imageView PSSetWidth:WidthRate(73)];
    [imageView PSSetHeight:HeightRate(73)];
    
    UILabel * lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.font = [UIFont systemFontOfSize:14];
    lable.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lable];
    lable.text = model.CategoryName;
    [lable PSSetLeft:0];
    
    [lable PSSetBottomAtItem:imageView Length:HeightRate(5)];
    [lable PSSetWidth:cell.bounds.size.width];
    
    UIImageView *imageView1  = [[UIImageView alloc] init];
    imageView1.tag = 100 +indexPath.item;
    imageView1.translatesAutoresizingMaskIntoConstraints = NO;
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.autoresizesSubviews = YES;
    imageView1.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [cell.contentView addSubview:imageView1];
    [imageView1 PSSetTop:HeightRate(5)];
    [imageView1 PSSetRight:WidthRate(5)] ;
    [imageView1 PSSetSize:WidthRate(23) Height:HeightRate(23)];
    
    NSNumber *num =self.storeBtnArr[indexPath.row];
//    imageView1.hidden  = [num isEqual:@(1)]?YES:NO;
    NSString *imageName = [num isEqual:@(1)]?@"weixuanzhongicon": @"xuanzhongicon";
    imageView1.image = [UIImage imageNamed:imageName];

    for (int i = 0; i < model.CategoryList.count; i++) {
        CGFloat top = 24*(i) +10*(i+1);
        UILabel * lable1 = [[UILabel alloc] init];
        lable1.translatesAutoresizingMaskIntoConstraints = NO;
        lable1.font = [UIFont systemFontOfSize:13];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.layer.cornerRadius = 3;
        lable1.clipsToBounds = YES;
        lable1.layer.borderWidth = 1;
        lable1.layer.borderColor = ColorWithHexString(@"E4E4E4").CGColor;
        [cell.contentView addSubview:lable1];
//        lable1.text =@"速配的"; //model.CategoryList[i];
        NSDictionary *oneKindOfCatagory = model.CategoryList[i];
        lable1.text = oneKindOfCatagory[@"CategoryName"];
        [lable1 PSSetLeft:0];
        [lable1 PSSetBottomAtItem:lable Length:HeightRate(top)];
        [lable1 PSSetHeight:HeightRate(24)];
        [lable1 PSSetWidth:cell.bounds.size.width];
    }
  
    return cell;
//
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    YHMainCatagoryModel *model = self.CategoryArr[indexPath.row];
    NSInteger count =model.CategoryList.count>2?model.CategoryList.count:3;
    CGFloat height= count*34+110+10;
        return CGSizeMake(WidthRate(105), HeightRate(height));
        
}
///设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
  
        return UIEdgeInsetsMake(HeightRate(10), WidthRate(70), HeightRate(10), WidthRate(60));
        
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    for ( int i=0;i< self.storeBtnArr.count;i++) {
//        NSNumber *num = self.storeBtnArr[indexPath.row];
        if (i == indexPath.row) {
            [self.storeBtnArr replaceObjectAtIndex:i withObject:@(0)];
        

        } else {
            [self.storeBtnArr replaceObjectAtIndex:i withObject:@(1)];
        }
    }
    
    [collectionView reloadData];
}
-(void)chooseButtonClick:(UIButton *)button
{
   
    NSInteger index = [self.storeBtnArr indexOfObject:@(0)];
    YHMainCatagoryModel *model = self.CategoryArr[index];
    if( [model.CategoryName isEqualToString:@"工业品"])
    {
        [MobClick event:@"gongyeping" label:@"工业品"];
    }else
    {
        [MobClick event:@"xiaofeiping" label:@"消费品"];
        
    }
    NSString *isStore = [model.CategoryName isEqualToString:@"工业品"]?@"1":@"1";
    [[NSUserDefaults standardUserDefaults]setObject:model.CategoryId forKey:USERSELECCATEGORY];
    [[NSUserDefaults standardUserDefaults]setBool:[model.CategoryName isEqualToString:@"工业品"] forKey:IsIndustryCatagory];

    [[NSUserDefaults standardUserDefaults]setObject:isStore forKey:LOGIN_ISSTORE];

    [self.navigationController popViewControllerAnimated:YES];
    
    
    
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
