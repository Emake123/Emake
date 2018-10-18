//
//  YHMySuperGroupViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/14.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMySuperGroupViewController.h"
#import "YHMySuperGroupTableViewCell.h"
@interface YHMySuperGroupViewController ()<UITableViewDelegate,UITableViewDataSource,YHTitleViewViewDelegete>
@property(nonatomic,strong)UIView *emptyView;//leftView

@end

@implementation YHMySuperGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的超级团";
    [self superViewLIstUI];
}

- (void)configEmptySubViews{
    
    if (self.emptyView ==nil) {
        self.emptyView = [[UIView alloc] init];
        [self.view addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY).offset(-HeightRate(50));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(WidthRate(123));
            make.height.mas_equalTo(HeightRate(125));
        }];
        
        UIImageView *imageShow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shangjiazhong"]];
        imageShow.contentMode = UIViewContentModeScaleAspectFit;
        [self.emptyView addSubview:imageShow];
        
        [imageShow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(0));
            make.centerX.mas_equalTo(self.emptyView.mas_centerX);
            make.width.mas_equalTo(WidthRate(123));
            make.height.mas_equalTo(HeightRate(125));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text =@"敬请期待...";
        label.textColor =TextColor_737273;
        label.font = SYSTEM_FONT(AdaptFont(14));
        [self.emptyView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.emptyView.mas_centerX);
            make.height.mas_equalTo(HeightRate(23));
            make.top.mas_equalTo(imageShow.mas_bottom).offset(HeightRate(10));
        }];
    }else
    {
        self.emptyView.hidden = false;
    }
    
    
    
    
}
-(void)superViewLIstUI
    {
        
        UITableView *superTable = [[UITableView alloc] initWithFrame:CGRectMake(0, (TOP_BAR_HEIGHT)+HeightRate(45), ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(45)) style:UITableViewStyleGrouped];
        superTable.delegate =self;
        superTable.dataSource = self;
        superTable.backgroundColor = ColorWithHexString(StandardBlueColor);
        superTable.sectionHeaderHeight =0.1;
        superTable.sectionFooterHeight= 0.1;
        superTable.estimatedRowHeight =500;
        [self.view addSubview:superTable];
        
        NSArray *CatagorydictArray = Userdefault(CatagoryIDs);
        NSArray *array;
            NSDictionary *dict = CatagorydictArray[0];
            NSDictionary *dict1 = CatagorydictArray[1];
            array = @[dict[@"CategoryBName"],dict1[@"CategoryBName"] ];
       
        YHTitleView *title  =  [[YHTitleView alloc] initWithFrame:CGRectMake( WidthRate(68),TOP_BAR_HEIGHT, WidthRate(240), HeightRate(45)) titleFont:14 delegate:self andTitleArray:array];
        [self.view addSubview:title];
        if (@available(iOS 11.0, *)) {
            superTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
        
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 0.01;
    }
    -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    {
        return nil;
    }
    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return UITableViewAutomaticDimension;
    }
    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return 3;
    }
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        YHMySuperGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[YHMySuperGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        
        return cell;
        
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
