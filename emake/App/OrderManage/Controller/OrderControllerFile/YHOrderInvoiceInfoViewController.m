//
//  YHOrderInvoiceInfoViewController.m
//  emake
//
//  Created by 张士超 on 2018/4/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHOrderInvoiceInfoViewController.h"
#import "YHOrderInvoiceInfoTableViewCell.h"
#import "YHQualificationApplyViewController.h"
#import "YHInvoiceListModel.h"
#import "YHInvoiceListViewController.h"
#import "MJRefresh.h"
@interface YHOrderInvoiceInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIView * emptyBgView;
}
@property(nonatomic,strong)UITableView *myTable;

@end

@implementation YHOrderInvoiceInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataList];
    [MobClick event:@"Invoice" label:@"开票管理"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发票管理";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self addRightNavBtn:@"开票记录"];
//    if (_myTable==nil) {
//        [self getMYTableUI];
//    }
}

-(void)refreshTableData{
    [self getDataList];
}
-(void)rightBtnClick:(UIButton *)sender{
    YHInvoiceListViewController *vc = [[YHInvoiceListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)emptyViewWithNoneData{
    UIView *emptyView = [[UIView alloc] init];
    emptyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:emptyView];
    
    [emptyView PSSetCenterXPercent:0.5];
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
    lable.text = @"亲，您还没有发票信息";
    lable.textAlignment = NSTextAlignmentCenter;
    [emptyView addSubview:lable];
    [lable PSSetBottomAtItem:imageView Length:0];
    [lable PSSetLeft:0];
    [lable PSSetRight:0];
    [lable PSSetHeight:HeightRate(20)];
    
}

-(void)getMYTableUI{
    if (_myTable==nil) {
        
        CGFloat tatolH = ScreenHeight-(TOP_BAR_HEIGHT)-80;
    
    _myTable = [[UITableView alloc] initWithFrame:CGRectMake(0,TOP_BAR_HEIGHT, ScreenWidth, HeightRate(tatolH)) style:UITableViewStylePlain];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.estimatedRowHeight = 100;
    _myTable.backgroundColor = [UIColor clearColor];
    _myTable.rowHeight = UITableViewAutomaticDimension;
    _myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTable.estimatedSectionFooterHeight = 0;
    _myTable.estimatedSectionHeaderHeight =0;
    [self.view addSubview:_myTable];
    
    
    UIButton *addInvoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addInvoiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [addInvoiceBtn setTitle:@"新增开票" forState:UIControlStateNormal];
    [addInvoiceBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    addInvoiceBtn.backgroundColor =  ColorWithHexString(StandardBlueColor)  ;
    addInvoiceBtn.layer.cornerRadius = 6;
    addInvoiceBtn.clipsToBounds = YES;
    addInvoiceBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(15)];
    [addInvoiceBtn addTarget:self action:@selector(addInvoiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addInvoiceBtn];
    [addInvoiceBtn PSSetBottom:HeightRate(20)];
    [addInvoiceBtn PSSetLeft:WidthRate(33)];
    [addInvoiceBtn PSSetRight:WidthRate(33)];
    [addInvoiceBtn PSSetHeight:HeightRate(50)];
//    [addInvoiceBtn PSSetSize:ScreenWidth Height:HeightRate(50)];
//    [addInvoiceBtn PSSetBottomAtItem:_myTable Length:HeightRate(13)];
        
    }else
    {
        
        [_myTable reloadData];
        
    }
}
#pragma mark--data
-(void)getDataList
{
    [[YHJsonRequest shared] getUserInvoiceManageSuccessBlock:^(NSArray *invoicelist) {
        [emptyBgView removeFromSuperview];

        self.myInvoiceList = invoicelist;
        [self getMYTableUI];
        if (invoicelist.count == 0) {
//            [_myTable removeFromSuperview];
            [self emptyViewWithNoneData];
        }
        
    } fialureBlock:^(NSString *errorMessages) {

        [self.view makeToast:errorMessages];

    }];
}
#pragma mark--uitableviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myInvoiceList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHInvoiceListModel *model = self.myInvoiceList[indexPath.row];
    YHOrderInvoiceInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[YHOrderInvoiceInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.companyLable.text = model.InvoiceTitle;
    cell.taxLable.text = [NSString stringWithFormat:@"企业税号：%@",model.CustomerTaxCode];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHInvoiceListModel *model = self.myInvoiceList[indexPath.row];
    YHQualificationApplyViewController *invoice = [[YHQualificationApplyViewController alloc]init];
    invoice.ContractNo = self.contractNo;
    invoice.hidesBottomBarWhenPushed = YES;
    invoice.Model = model;
    invoice.refNo = model.RefNo;
    [self.navigationController pushViewController:invoice animated:YES];
}

//delete
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        YHInvoiceListModel *model = self.myInvoiceList[indexPath.row];
        [[YHJsonRequest shared] deleteUserInvoiceManage:model.RefNo SuccessBlock:^(NSString *success) {
            [self.view makeToast:success duration:1 position:CSToastPositionCenter];
            NSMutableArray *arr = (NSMutableArray *)self.myInvoiceList;
            [arr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            if (arr.count==0) {
                [self refreshTableData];
            }
        } fialureBlock:^(NSString *errorMessages) {
            [self.view makeToast:errorMessages];
        }];
    }];
    deleteAction.backgroundColor = ColorWithHexString(@"FAAF1E");
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        editingStyle = UITableViewCellEditingStyleDelete;
}

#pragma mark--button click
-(void)addInvoiceButtonClick
{
    YHQualificationApplyViewController *invoice = [[YHQualificationApplyViewController alloc]init];
    invoice.ContractNo = self.contractNo;
    invoice.refNo = @"";
    invoice.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:invoice animated:YES];
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
