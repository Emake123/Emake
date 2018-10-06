//
//  YHCommpanyServersNewViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/25.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCommpanyServersNewViewController.h"
#import "YHCommpanyServersCell.h"
#import "YHBrandQulificationViewController.h"
#import "YHCertificationStateOriginalViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHInsuranceSeviceViewController.h"
#import "YHAfterServersViewController.h"
@interface YHCommpanyServersNewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)NSMutableArray *listArray;
@property (nonatomic,retain)UITableView *tableView;
@end

@implementation YHCommpanyServersNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title= @"企业服务";
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubViews];
    [self addRigthDetailButtonIsShowCart:false];
    [self getCommpanyServersList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshingData) name:NotificatonRefreshCartData object:nil];
    // Do any additional setup after loading the view.
}
- (void)configSubViews{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 180;
    self.tableView.estimatedSectionFooterHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(ScreenHeight-(TOP_BAR_HEIGHT)));

    }];
}
-(void)refreshingData
{
    [self getCommpanyServersList];
}
- (void)getCommpanyServersList{
    self.listArray = [NSMutableArray arrayWithCapacity:0];
//    [[YHJsonRequest shared] getBusinessService: SuccessBlock:^(NSArray *listArray) {
//        self.listArray = [NSMutableArray arrayWithArray:listArray];
//        [self.tableView reloadData];
//    } fialureBlock:^(NSString *errorMessages) {
//        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
//    }];
}
#pragma mark----UITableViewDelegate&UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHCommpanyServersCell *cell = nil;
    if (!cell) {
        cell = [[YHCommpanyServersCell alloc]init];
        [cell setData:self.listArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRate(75);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHCommpanyServersModel * model = self.listArray[indexPath.row];
    if ([model.BrandServiceTitle isEqualToString:@"品牌授权"]) {
        YHBrandQulificationViewController *vc = [[YHBrandQulificationViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.BrandServiceTitle isEqualToString:@"质量保险"])  {
        YHInsuranceSeviceViewController *vc = [[YHInsuranceSeviceViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YHAfterServersViewController *vc = [[YHAfterServersViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
