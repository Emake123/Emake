//
//  YHInsuranceSeviceViewController.m
//  emake
//
//  Created by 张士超 on 2017/12/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHInsuranceSeviceViewController.h"
#import "YHInsuranceSeviceCell.h"
#import "YHInsuranceServersInstructionViewController.h"
@interface YHInsuranceSeviceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)NSArray *dataList;
@property (nonatomic,retain)UITableView *insuranceTableView;
@end

@implementation YHInsuranceSeviceViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"Insurance" label:@"质量保险"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保险服务";
    
    self.view.backgroundColor = ColorWithHexString(@"ffffff");
    UIImageView *bgview = [[UIImageView alloc] init];
    bgview.image = [UIImage imageNamed:@"shouhoufuwujpg"];
    bgview.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(HeightRate(256));
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.mas_equalTo(HeightRate(-0));
    }];
    
    self.insuranceTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)) style:UITableViewStylePlain];
    self.insuranceTableView.delegate = self;
    self.insuranceTableView.dataSource = self;
    self.insuranceTableView.sectionFooterHeight = 0;
    self.insuranceTableView.estimatedRowHeight = 300;
    self.insuranceTableView.estimatedSectionFooterHeight = 0;
    self.insuranceTableView.estimatedSectionHeaderHeight = 0;
    self.insuranceTableView.scrollEnabled = NO;
    self.insuranceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.insuranceTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.insuranceTableView];
    
   
    
    
    [self getInsuranceListData];
}
- (void)getInsuranceListData{
    self.dataList = [NSArray array];
    [[YHJsonRequest shared] getUserInsuranceCategorySuccessBlock:^(NSArray *successMessage) {
        self.dataList = [NSArray arrayWithArray:successMessage];
        [self.insuranceTableView reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
#pragma mark---tableViewDatasoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHInsuranceSeviceCell *cell= nil;
    if (cell== nil) {
        
        cell = [[YHInsuranceSeviceCell alloc] init];
    }
    YHInsuranceModel *model = self.dataList[indexPath.row];
    [cell setData:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      cell.backgroundColor=[UIColor clearColor];
    return cell;
}
#pragma mark---tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHInsuranceModel *model = self.dataList[indexPath.row];
    YHInsuranceServersInstructionViewController *vc =[[YHInsuranceServersInstructionViewController alloc]init];
    vc.titleName = model.InsuranceCompanyName;
    vc.InsuranceID = model.InsuranceId;
    [self.navigationController pushViewController:vc animated:YES];
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
