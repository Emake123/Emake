//
//  YHBrandQulificationViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/25.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHBrandQulificationViewController.h"
#import "YHBrandCompanyViewController.h"
#import "CommonConfig.h"
#import "UIColor+Common.h"
#import "YHBrandTableViewCell.h"
#import "YHJsonRequest.h"
#import "YHBrandModel.h"
#import "UIImageView+WebCache.h"
@interface YHBrandQulificationViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *leftTableView;
    UITableView *rightTableView;
    UIView *emptyBgView;
}
@property(nonatomic,strong)NSArray *brandArray;
@property(nonatomic,strong)NSArray *brandlistArray;

@end

@implementation YHBrandQulificationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"已合作品牌";
    self.view.backgroundColor =ColorWithHexString(@"ffffff");
    self.brandlistArray = [NSArray array];
    for (int i=0;i<2 ;i++) {
        
        CGFloat tableViewWidth = i?(ScreenWidth-110):110;
        CGFloat tableViewX = 110*i;

    UITableView *brandTableView  = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, TOP_BAR_HEIGHT, tableViewWidth, ScreenHeight-(TOP_BAR_HEIGHT)) style:UITableViewStylePlain];
    brandTableView.delegate = self;
    brandTableView.dataSource = self;
    brandTableView.tag = i+50;//tag=50左边tableview，否则为右边
    brandTableView.sectionFooterHeight = 0;
    brandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    brandTableView.backgroundColor =ColorWithHexString(@"F7F7F7");
        
    [self.view addSubview:brandTableView];
        if (i==0) {
            leftTableView = brandTableView;
        } else {
            rightTableView = brandTableView;

        }
    
    }
    
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getuserBrand:^(NSArray *shoppingCartArray) {
        _brandArray  = [NSArray arrayWithArray:shoppingCartArray];
        [self.view hideWait:CurrentView];

        if (shoppingCartArray.count == 0) {
            [self emptyViewWithNoneData:0.5];

        } else {
            [emptyBgView removeFromSuperview];
            YHBrandListModel *model = self.brandArray[0];
            model.isSelect = YES;
            self.brandlistArray = model.BrandArr;
            [self.view hideWait:CurrentView];
            [leftTableView reloadData];
            [rightTableView reloadData];
            if (model.BrandArr.count == 0) {
                
                [self emptyViewWithNoneData:0.6];
                rightTableView.backgroundColor = [UIColor whiteColor];
            }
            
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages];
        [self.view hideWait:CurrentView];
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 50) {
        return self.brandArray.count;
    }else{
        return self.brandlistArray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==50) {
        return HeightRate(44);
    } else {
        return HeightRate(100);
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==50) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"brandlist"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"brandlist"];
        }
        YHBrandListModel *listmodel = self.brandArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (listmodel.isSelect==YES) {
        
            cell.backgroundColor = ColorWithHexString(@"ffffff");
            
        } else {
            cell.backgroundColor = ColorWithHexString(@"f7f7f7");

        }
        cell.textLabel.font = [UIFont systemFontOfSize:AdaptFont(12)];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text =listmodel.CategoryName ;
        return cell;
        
    } else {
        
        YHBrandModel *model = self.brandlistArray[indexPath.row];
        YHBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"brandCell"];
        if (cell == nil) {
            cell = [[YHBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"brandCell"];
        }
        [cell.companyImageview sd_setImageWithURL:[NSURL URLWithString:model.BrandIcon]];
        
        cell.companyName.text =model.CompanyName;
        cell.brandKind.text = [NSString stringWithFormat:@"授权品类:%@",model.CategoryName];
        float rate= model.Rate.floatValue*100;
        cell.brandFee.text = [NSString stringWithFormat:@"品牌授权费:%.1f%%",rate];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 50) {
        YHBrandListModel *listmodel = self.brandArray[indexPath.row];
        self.brandlistArray = listmodel.BrandArr;
        if (self.brandlistArray.count==0) {
            rightTableView.hidden = YES;
            [emptyBgView removeFromSuperview];
            [self emptyViewWithNoneData:0.6];
        }else
        {
            [emptyBgView removeFromSuperview];
            rightTableView.hidden = NO;
            [rightTableView reloadData];
            
        }
        for (int i=0; i<self.brandArray.count; i++) {
            YHBrandListModel *listmodel111 = self.brandArray[i];

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
        YHBrandCompanyViewController *brand = [[YHBrandCompanyViewController alloc]init];
        brand.model = self.brandlistArray[indexPath.row];
        [self.navigationController pushViewController:brand animated:YES];
    }
}
-(void)emptyViewWithNoneData:(CGFloat)showHpercentPosition
{
    UIView *emptyView = [[UIView alloc] init];
    emptyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:emptyView];

    [emptyView PSSetCenterXPercent:showHpercentPosition];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache]setValue:nil forKey:@"memCache"];
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
