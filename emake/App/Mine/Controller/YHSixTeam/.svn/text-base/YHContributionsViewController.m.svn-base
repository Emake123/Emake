//
//  YHContributionsViewController.m
//  emake
//
//  Created by 张士超 on 2018/1/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHContributionsViewController.h"
#import "YHTeamTableViewCell.h"
#import "YHPersonContributionTableViewCell.h"
#import "teamModel.h"
#import "Tools.h"
@interface YHContributionsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    UIView *emptybgView;
}
@property(nonatomic,strong)NSArray *detailArr;
@end

@implementation YHContributionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"订单金额明细";
    [self getLeaderContributionData];
}

-(void)getLeaderContributionData
{
    [self.view showWait:@"加载中" viewType:CurrentView];

    [[YHJsonRequest shared] getUserTeamLeaderDetailContribution:self.isTeam SuccessBlock:^(NSArray *successMessage) {
        [self.view hideWait:CurrentView];
        if (successMessage.count==0) {
            [self emptyViewWithNoneData];
            
        }else{
            
            [emptybgView removeFromSuperview];
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, HeightRate(0), ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        table.delegate = self;
            table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.dataSource = self;
            table.estimatedSectionHeaderHeight = 0;
            table.estimatedSectionFooterHeight = 0;
            table.estimatedRowHeight = 160;
            table.rowHeight  = UITableViewAutomaticDimension;
            
        [self.view addSubview:table];
        self.detailArr =successMessage;
        [table reloadData];
        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];

    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        YHPersonContributionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"person"];
        
        if (!cell) {
            cell = [[YHPersonContributionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"person"];
        }
        YHTeamDetailModel *model = self.detailArr[indexPath.row];
        
       NSString *price = [Tools getNsstringFromDouble:model.ContractAmount.doubleValue isShowUNIT:NO];
        cell.Pricelable.text = [NSString stringWithFormat:@"+%@元",price];
        cell.Datelable.text = model.AddWhen;
        cell.orderLable.text = [NSString stringWithFormat:@"订单：%@",model.ContractNo];
        cell.commitTipsLable.text = [NSString stringWithFormat:@"提成%@%%：",[Tools getHaveNum:(model.Rate.doubleValue*100)]];
        cell.nameLable.text = model.RealName;
        
        NSString *price1 = [Tools getNsstringFromDouble:model.BonusAmount.doubleValue isShowUNIT:NO];

        cell.commitMoneyLable.text =[NSString stringWithFormat:@"%@元",price1]; ;
        if ([model.UserType isEqualToString:@"3"] || [model.UserType isEqualToString:@"4"]) {
            NSString *str =model.BelongUsername.length>0? [NSString  stringWithFormat:@"(%@)",model.BelongUsername]:@"";
            cell.detailLable.text = [NSString stringWithFormat:@"%@ B端用户",str];
         
        }else
        {
            NSString *str =model.BelongUsername.length>0? [NSString  stringWithFormat:@"(%@)",model.BelongUsername]:@"";
            cell.detailLable.text = [NSString stringWithFormat:@"%@ 分销商",str];
           
        }
        if (self.isTeam == NO) {
            cell.nameLable.hidden = YES;
            cell.detailLable.hidden = YES;
            [cell.nameLable PSUpdateConstraintsHeight:0.01];
            [cell.detailLable PSUpdateConstraintsHeight:0.01];

        }
        return cell;
        
    } else {
        YHTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (!cell) {
            cell = [[YHTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
    }
}
-(void)emptyViewWithNoneData
{
    [emptybgView removeFromSuperview];
    UIView *emptyView = [[UIView alloc] init];
    [self.view addSubview:emptyView];
    emptyView.center = self.view.center;
    emptyView.bounds =CGRectMake(0, 0, WidthRate(200), HeightRate(230));
    
    emptybgView = emptyView;
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
    lable.text = @"还没有贡献金额吆，亲";
    lable.textAlignment = NSTextAlignmentCenter;
    [emptyView addSubview:lable];
    [lable PSSetBottomAtItem:imageView Length:0];
    [lable PSSetLeft:0];
    [lable PSSetRight:0];
    [lable PSSetHeight:HeightRate(20)];
    
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
