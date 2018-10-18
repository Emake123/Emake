    //
//  OrderManage.m
//  emake
//
//  Created by chenyi on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderManageNewViewController.h"
#import "YHOrder.h"
#import "YHOrderLogisticsCell.h"
#import "ChatNewViewController.h"
#import "YHOrderUploadPaymentVoucherViewController.h"
#import "YHLabel.h"
#import "YHOrderTableViewCell.h"
#import "YHOrderFootTableViewCell.h"
#import "accountInformationView.h"
#import "YHOrderContract.h"
#import "YHTitleView.h"
#import "UIImageView+WebCache.h"
#import "YHLookUpLogisticsViewController.h"
#import "YHQualificationApplyViewController.h"
#import "YHOrderContractViewController.h"
#import "YHAlertView.h"
#import "YHOrderInvoiceInfoViewController.h"
#import "YHOrderDetailViewController.h"
#import "YHOrderNewFootTableViewCell.h"
#import "YHInsuranceSeviceViewController.h"
#import "YHOrderInsuranceViewController.h"
#import "YHStoreOrderNewTableViewCell.h"
NSString *Cell = @"cell";
NSString * LogisticsCell =@"LogisticsCell";
NSString * FootCell = @"footCell";
@interface YHOrderManageNewViewController ()<UITableViewDataSource, UITableViewDelegate,YHTitleViewViewDelegete,YHListViewDelegate>{
    NSMutableArray *arrayState;//判断状态
    NSMutableArray *arrayData;//数据
    YHTitleView *titleView;
    UIView *slectView;
    UIView *emptyView;
    NSInteger lastSelectIndex;
    NSMutableArray *testArr;
    accountInformationView *account;
    NSInteger page;
    UIScrollView *TopScroView;

}
@property (nonatomic, weak) UITableView *orderManageTableView;
@property (nonatomic, strong) UILabel *tinLabel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *totalArray;
//titleView的title
@property(nonatomic,strong)NSArray *titleArray;

//titleView的title
@property(nonatomic,strong)NSArray *titleSelectArray;

//保险和pay的银行账户信息
@property(nonatomic,strong)NSMutableArray *payArray;
@property(nonatomic,strong)NSMutableArray *insuranceArray;
@property (assign, nonatomic) NSInteger expandSectionIndex;
@property (assign, nonatomic) BOOL isExpandSection;
@property (assign, nonatomic) NSInteger recordSectionIndex;
//@property (assign, nonatomic) BOOL isStore;
@end

@implementation YHOrderManageNewViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addRigthDetailButtonIsShowCart:false];
    self.view.backgroundColor = TextColor_F5F5F5;
    self.navigationItem.title = @"全部订单";
 
    _dataArray = [NSMutableArray array];
    _totalArray = [NSMutableArray array];
    [self configUI];

    self.expandSectionIndex = NSNotFound;
    if (self.isShowLeftButton == YES) {
        self.navigationItem.leftBarButtonItem = nil;
    }else
    {
        [self addRigthDetailButtonIsShowCart:false];

    }
    page = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [MobClick event:@"Order" label:@"我的订单-输配电"];

   


    [self configTopView];
    [titleView selectItemWithIndex:self.OrderState];

    if (_orderManageTableView) {
        [_orderManageTableView.mj_header beginRefreshing];
    }
}
//空订单图
-(void)getEmptyOrderCart:(NSString *)title
{
    emptyView = [[UIView alloc]init];
    emptyView.bounds =CGRectMake(WidthRate(0), HeightRate(0), WidthRate(200), HeightRate(120));
    emptyView.center = self.view.center;
    [self.view addSubview:emptyView];
    UIImageView  *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"orderEmpty"]];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.frame = CGRectMake(WidthRate(55), HeightRate(0), WidthRate(70), HeightRate(70));
    [emptyView addSubview:imageview];
    UILabel  *lable  = [[UILabel alloc] init];
    lable.bounds = CGRectMake(WidthRate(0), HeightRate(0), WidthRate(240), HeightRate(20));
    lable.center = CGPointMake(imageview.centerX, imageview.centerY+imageview.height/1.5+HeightRate(10));
    lable.textAlignment = NSTextAlignmentCenter;;
    lable.text = @"您还没有相关订单";
    lable .textColor = ColorWithHexString(@"909090");
    lable.font = SYSTEM_FONT(13);
    [emptyView addSubview:lable];
}

- (void)getOrderData{
//    PageIndex

    NSString *orderStateNumStr =self.titleSelectArray[lastSelectIndex] ;
    NSDictionary* paramDic = lastSelectIndex==0?@{@"RequestType":@"1",@"PageIndex":@"1",@"PageSize":[NSString stringWithFormat:@"%ld",page]} :@{@"RequestType":@"1",@"OrderState":[NSString stringWithFormat:@"%@",orderStateNumStr],@"PageIndex":@"1",@"PageSize":[NSString stringWithFormat:@"%ld",page]};
    [[YHJsonRequest shared] userUseOrderManageParams:paramDic SucceededBlock:^(NSArray *orderArray) {
        BOOL isCanOut =lastSelectIndex==2?YES:(lastSelectIndex==1?YES:false);

        if (isCanOut == YES) {//未付款的才有已失效
            NSMutableArray * selectArray= [NSMutableArray array];
            for (YHOrderContract *contract in orderArray) {
                if (![contract.IsOut isEqualToString:@"0"]) {
                    
                    [selectArray addObject:contract];
                }
              }
            
            _dataArray = [NSMutableArray arrayWithArray:selectArray];

        }else{
            _dataArray = [NSMutableArray arrayWithArray:orderArray];

        }
       
        _totalArray = [NSMutableArray arrayWithArray:orderArray];
        [self.orderManageTableView.mj_header endRefreshing];
        [self.orderManageTableView.mj_footer endRefreshing];
        if (self.dataArray.count < page) {//本次接口获得的数据列表数<10
            self.orderManageTableView.mj_footer.automaticallyHidden = YES;//隐藏上拉刷新控件
            [self.orderManageTableView.mj_footer endRefreshingWithNoMoreData];
        }

        [self.view hideWait:CurrentView];
        [_orderManageTableView reloadData];
        [_orderManageTableView.tableHeaderView reloadInputViews];
        if(_dataArray.count==0)
        {
            [emptyView removeFromSuperview];
            [self getEmptyOrderCart:nil];
        }else
        {
            [emptyView removeFromSuperview];
        }
        
    } failedBlock:^(NSString *errorMessage) {
        [self.orderManageTableView.mj_header endRefreshing];
        [self.orderManageTableView.mj_footer endRefreshing];
        [self.view makeToast:errorMessage duration:1.5f position:CSToastPositionCenter];
    }];
}
-(void)configTopView
{
    [titleView removeFromSuperview];
    if (TopScroView == nil) {
        TopScroView = [[UIScrollView alloc] init];
        TopScroView.frame = CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(35));
        TopScroView.showsHorizontalScrollIndicator = false;
        TopScroView.backgroundColor = ColorWithHexString(@"ffffff");
        [self.view addSubview:TopScroView];
    }
    self.titleSelectArray = [NSArray arrayWithObjects:@"0",@"-2",@"012",@"3", nil];
    self.titleArray = [NSArray arrayWithObjects:@"全  部",@"待签订",@"待付款",@"已发货", nil];
    titleView = [[YHTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(35)) titleFont:14 delegate:self andTitleArray:self.titleArray];
    [TopScroView addSubview:titleView];

}
- (void)configUI {
    
    UITableView *orderManageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    orderManageTableView.dataSource = self;
    orderManageTableView.delegate = self;
    orderManageTableView.backgroundColor = [UIColor clearColor];
    orderManageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    orderManageTableView.estimatedRowHeight = HeightRate(88);
    [self.view addSubview:orderManageTableView];
    [orderManageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((TOP_BAR_HEIGHT)+HeightRate(36));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    orderManageTableView.estimatedSectionFooterHeight =50;
    orderManageTableView.estimatedRowHeight = 150;
    orderManageTableView.estimatedSectionFooterHeight=0.0;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
   MJRefreshAutoNormalFooter *foot =  [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(UpLoadNewData)];
    foot.automaticallyHidden = false;
//    / 设置文字
    [foot setTitle:@"加载更多" forState:MJRefreshStateIdle];
    [foot setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [foot setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    foot.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    foot.stateLabel.textColor = ColorWithHexString(StandardBlueColor);
    
  
    [foot endRefreshingWithNoMoreData];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    foot.automaticallyChangeAlpha = YES;

    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    orderManageTableView.mj_header = header;
    orderManageTableView.mj_footer = foot;
    [orderManageTableView.mj_header beginRefreshing];
    
    _orderManageTableView = orderManageTableView;
}
#pragma mark--mj-refresh
- (void)loadNewData {
    
   [self getOrderData];
}
- (void)UpLoadNewData {
    page += 3;
    [self getOrderData];
}

#pragma  mark - titleView delegate
-(void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index
{
    page = 3;
    self.OrderState = index;
    lastSelectIndex =  index;
    [[NSUserDefaults standardUserDefaults] setObject:@(index) forKey:TitleIndex];

//    CGFloat indext =(index-2)>0?(index>3?1.25:(NSInteger)(index-2)):0;
//    [TopScroView setContentOffset:CGPointMake(80*indext, 0) animated:YES];
    [self getOrderData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YHOrderContract *contract = self.dataArray[section];
    if ([contract.OrderState isEqual:@(3)] && contract.isExpandSection ==YES && contract.sectionRecord == section ) {
        return (contract.goodsModelArr.count+contract.shipingModelArr.count+1);
    }else{
        return (contract.goodsModelArr.count+1);
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHOrderContract *contract = self.dataArray[indexPath.section];
    if (indexPath.row<contract.goodsModelArr.count) {
        YHOrder *order = contract.goodsModelArr[indexPath.row];
        YHStoreOrderNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
        cell = [[YHStoreOrderNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        
        [cell setRequestData:order ];
        return cell;
       
        
    }else if (indexPath.row ==contract.goodsModelArr.count)
    {

        YHOrderNewFootTableViewCell *cell = [[YHOrderNewFootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newcell"];
        cell.logisticsDetailButton.selected = contract.isExpandSection;
        contract.sectionRecord = indexPath.section;
          [cell.helpBtn addTarget:self action:@selector(helpButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.customerServiceButton addTarget:self action:@selector(customerServiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.commBtn addTarget:self action:@selector(rcommBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.logisticsDetailButton addTarget:self action:@selector(orderIsSlectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.commBtn.tag = indexPath.section+100;
        cell.rightBtn.tag = indexPath.section+100;
        cell.customerServiceButton.tag = indexPath.section+100;
        cell.logisticsDetailButton.tag = indexPath.section+100;
        [cell setData:contract withIsStore:0];
        return cell;
    }
    else
    {
        NSInteger rowCount =indexPath.row- contract.goodsModelArr.count-1;
        
        YHOrderLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:LogisticsCell];
        YHOrderShippingInfo *ship = contract.shipingModelArr[rowCount];
        if (!cell) {
            cell =[[YHOrderLogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LogisticsCell];
        }
        cell.logisticsIdLabel.text = [NSString stringWithFormat:@"运单号:%@",ship.ShippingNo]; ;
        cell.dateLabel.text =[NSString stringWithFormat:@"日期:%@",ship.ShippingDate];
        cell.numberIdLabel.text =[NSString stringWithFormat:@"已发数量:%@件",ship.ShippingNumber];
        cell.logisticsButton.tag = 100 + 10*indexPath.section + rowCount;
        [cell.logisticsButton addTarget:self action:@selector(logisticsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"iiiiiiiiiiii-----%ld===%ld",indexPath.row,indexPath.section);
    
    YHOrderContract *contract = self.dataArray[indexPath.section];

    YHOrderDetailViewController *vc = [[YHOrderDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.contract = contract;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightRate(62);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return TableViewFooterNone;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YHOrderContract *contract = self.dataArray[section];
    return [self getheadView:tableView order:contract section:section];;
}

#pragma mark - YHOrderHeaderViewDelegate 和button的点击事件
-(void)orderIsSlectButtonClick:(YHLogisticsDetailButton *)button
{

    NSInteger index = button.tag - 100;
    
    YHOrderContract *contract = self.dataArray[index];
    contract.sectionRecord = index;
    _recordSectionIndex = index;
    button.selected = contract.isExpandSection;
    NSMutableArray *indexArr = [NSMutableArray array];
    for (int i =0; i <contract.shipingModelArr.count; i++) {
        NSIndexPath *indexpath1 =[NSIndexPath indexPathForRow:(contract.goodsModelArr.count+1+i) inSection:index];
        [indexArr addObject:indexpath1];
    }
    
    if (contract.isExpandSection==NO) {
        button.selected = YES;
        contract.isExpandSection = YES;
        [self.orderManageTableView insertRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationFade];
    }else{
        contract.isExpandSection = NO;
        button.selected = NO;
        
        [self.orderManageTableView deleteRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationFade];
    }
}
//调zhuan到保险服务页面
-(void)helpButtonClick
{
    YHInsuranceSeviceViewController *insurance = [[YHInsuranceSeviceViewController alloc] init];
    insurance.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:insurance animated:YES];
}
//调zhuan到保单页面
-(void)rightBtnAddInsuranceClick:(UIButton *)button
{
    
    YHOrderContract *contract = self.dataArray[button.tag-100];

    YHOrderInsuranceViewController *vc = [[YHOrderInsuranceViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
//    vc.contract = contract.or;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)payButtonClickedWithOrder:( YHOrderContract *)orderContract {
    
    YHOrderUploadPaymentVoucherViewController *vc = [[YHOrderUploadPaymentVoucherViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//物流
-(void)logisticsButtonClick:(YHButton *)sender
{
    NSInteger section = (sender.tag - 100)/10;
    NSInteger row = sender.tag - 100 - section*10 ;
    YHOrderContract *contract = self.dataArray[section];
    YHOrderShippingInfo *ship = contract.shipingModelArr[row];
    YHLookUpLogisticsViewController *vc = [[YHLookUpLogisticsViewController alloc]init];
    vc.logsticsNumber = ship.ShippingNo;
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:YES];
    
}
//订单恢复
-(void)renewOrderButtonClickedWithOrder:(YHOrderContract *)orderContract
{

    YHAlertView *alert = [[YHAlertView alloc] initWithTitle:@"确定恢复订单" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    alert.model = orderContract;

    alert.rightBlock = ^(NSString *str){   // 1
        
        [[YHJsonRequest shared] putOrderManageContratNo:@{@"OrderNo":orderContract.ContractNo,@"OrderState":@"0"} SucceededBlock:^(NSString *successMessage) {
            
                                          [self.view makeToast:successMessage];
                                          [self getOrderData];
                                          [_orderManageTableView reloadData];
                                      } failedBlock:^(NSString *errorMessage) {
            
                                          [self.view makeToast:errorMessage];
            
                                      }];
       
        
        
    };
    [alert showAnimated];
}

//订单删除
- (void)deleteOrderButtonClickedWithOrder:( YHOrderContract *)orderContract {
    //初始化警告框
    
    YHAlertView *alert = [[YHAlertView alloc] initWithTitle:@"确定删除订单" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    alert.model = orderContract;
    
    alert.rightBlock = ^(NSString *str){   // 1
        
        for ( int i=0;i<self.dataArray.count;i++ ) {
                        YHOrderContract *object = self.dataArray[i];
                        if([object isEqual:orderContract])
                        {
                            [_orderManageTableView beginUpdates];
                            [self.view showWait:@"删除中" viewType:CurrentView];
                            [[YHJsonRequest shared] deleteOrderManageContratNo:orderContract.ContractNo SucceededBlock:^(NSString *successMessage) {
            
                                [self.view hideWait:CurrentView];
                                [_dataArray removeObject:orderContract];
                                [_orderManageTableView deleteSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationNone];
                                [self.view makeToast:successMessage duration:2 position:CSToastPositionCenter];
                            } failedBlock:^(NSString *errorMessage) {
                                [self.view hideWait:CurrentView];

                            }];
                            [_orderManageTableView endUpdates];
            
            
                        }
            
                    }
        
        
        
    };
    [alert showAnimated];

    
    
}
//客服
- (void)customerServiceButtonClick:(UIButton *)button {
    YHOrderContract *contract = self.dataArray[button.tag-100];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:contract.StoreId];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    vc.isCatagory = contract.IsIncludeTax;
    vc.storeName = contract.StoreName;
    vc.storeAvata = contract.StorePhoto;
    vc.listID = [NSString stringWithFormat:@"%@_%@",contract.StoreId,userID];
    vc.storeID = contract.StoreId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//合同查看
- (void)contractButtonClickedWithOrder:( YHOrderContract *)orderContract {

    YHOrderContractViewController *contractViewController = [[YHOrderContractViewController alloc] init];
    contractViewController.contractID = orderContract.ContractNo;
    contractViewController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:contractViewController animated:YES];
}


//服务打款
-(void)payAccountOrderButtonClickedWithOrder:( YHOrderContract *)orderContract{
    
    account = [[accountInformationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    account.listViewDelegate = self;
    account.lableTexTAliment = NSTextAlignmentCenter;
    account.section = orderContract.sectionRecord;
    account.flag = 11;
    account.NumberOfLines = 3;
    [[UIApplication sharedApplication].keyWindow addSubview:account];
    [account.closeButton addTarget:self action:@selector(dimissview) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//保险服务打款 = 删除订单
-(void)rcommBtnClick:(YHButton *)button{
    YHOrderContract *contract = self.dataArray[button.tag-100];

    if([button.currentTitle isEqualToString:@"付预付款"]){
        [MobClick event:@"PaymentAccount" label:@"付款账号"];
        account = [[accountInformationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        account.listViewDelegate = self;
        account.section = button.tag-100;
        account.flag = 10;
        account.lableTexTAliment = NSTextAlignmentCenter;
        account.NumberOfLines = 3;
        [[UIApplication sharedApplication].keyWindow addSubview:account];
        [account.closeButton addTarget:self action:@selector(dimissview) forControlEvents:UIControlEventTouchUpInside];
    }else if([button.currentTitle isEqualToString:@"删除订单"]){
//        YHOrderContract *contract = self.dataArray[button.tag-100];
        [self deleteOrderButtonClickedWithOrder:contract];
    }else if([button.currentTitle isEqualToString:@"合同洽谈"]){
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:contract.StoreId];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
        ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
        vc.isCatagory =![contract.CategoryBName containsString:@"输配电"];
        YHOrder *order = contract.goodsModelArr.firstObject;
        vc.isFromCartConfirm = YES;
        YHChatOrderContract *chatOrder = [YHChatOrderContract initWithContractNo:contract.ContractNo GoodsTitle:order.GoodsTitle ContractAmount:contract.ContractAmount ContractQuantity:contract.ContractQuantity GoodsSeriesIcon:order.GoodsSeriesIcon GoodsExplain:order.GoodsExplain IsStore:[NSString stringWithFormat:@"%d",(![contract.CategoryBName containsString:@"输配电"])]];
        NSString *jsonstr = [chatOrder mj_JSONString];
        vc.storeName = contract.StoreName;
        vc.storeID =contract.StoreId;
        vc.storeAvata = contract.StorePhoto;
        vc.isPostOrder = true;
        vc.jsonStr = jsonstr;
        vc.isPostOrder = YES;
        vc.listID = [NSString stringWithFormat:@"%@_%@",contract.StoreId,userID];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([button.currentTitle isEqualToString:@"物流详情"])
    {
        YHLookUpLogisticsViewController *vc = [[YHLookUpLogisticsViewController alloc] init];
        vc.logsticsNumber = contract.ContractNo;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark---accountInformationView 打款界面 delegate
-(NSString *)ListView:(UIView *)listView withIndex:(NSInteger)index flag:(NSInteger)flag section:(NSInteger)section
{
    //因为contract的所有的
    YHOrderContract *contract = self.dataArray[section];
    NSString *insuranceSting;
    NSString *paySting;
    
    switch (index) {
        case 0:
        {
            paySting  = [NSString stringWithFormat:@"收款方:%@",contract.NameOfPartyA];
            insuranceSting = [NSString stringWithFormat:@"收款方:%@",contract.BankOfPartyA];
            
        }
            break;
        case 1:
        {
            paySting  = [NSString stringWithFormat:@"开户行:%@",contract.BankOfPartyA];
            insuranceSting = [NSString stringWithFormat:@"开户行:%@",contract.NameOfPartyA];
            
        }
            break;
        case 2:
        {
            paySting  = [NSString stringWithFormat:@"银行卡账号:%@",contract.AccountOfPartyA];
            insuranceSting   = [NSString stringWithFormat:@"银行卡账号:%@",contract.AccountOfPartyA];
        }
            break;
        default:
            break;
    }
    return paySting;
}
 -(void)dimissview
 {
     [UIView animateWithDuration:.5 animations:^{
         
         account.center = self.view.center;
         account.bounds = CGRectZero;
         [account removeFromSuperview];
         
     } completion:^(BOOL finished) {
         
     }];
         
 }



-(UIView *)getheadView:(UITableView *)tableView order:(YHOrderContract *)order section:(NSInteger )section
{
    UIView *orderTopView;
    if (orderTopView==nil) {
        orderTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, tableView.sectionHeaderHeight)];
        
        orderTopView.backgroundColor = ColorWithHexString(@"F7F7F7");
        orderTopView.clipsToBounds = NO;
        
        UIView *lineBottomView = [[UIView alloc] init];
        lineBottomView.translatesAutoresizingMaskIntoConstraints = NO;
        lineBottomView.backgroundColor = ColorWithHexString(@"EBEBEB");
        [orderTopView addSubview:lineBottomView];
        [lineBottomView PSSetLeft:0];
        [lineBottomView PSSetWidth:ScreenWidth];
        if (section==0) {
            [lineBottomView PSSetTop:-1];
            [lineBottomView PSSetHeight:0.01];
        }else
        {
            [lineBottomView PSSetTop:HeightRate(0)];
            [lineBottomView PSSetHeight:HeightRate(5)];
            
        }
        
            UIView *companyView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
            companyView.backgroundColor = ColorWithHexString(@"FAFAFA");
            [orderTopView addSubview:companyView];
            companyView.translatesAutoresizingMaskIntoConstraints = NO;
            [companyView PSSetBottomAtItem:lineBottomView Length:3];
            
            [companyView PSSetLeft:0];
            [companyView PSSetSize:ScreenWidth Height:HeightRate(60)];
            
            UIImageView * shopHeadImageView = [[UIImageView alloc] init];
            //        shopHeadImageView.image = [UIImage imageNamed:@"placehold"];
            [shopHeadImageView sd_setImageWithURL:[NSURL URLWithString:order.StorePhoto]];
            shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
            shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
            [companyView addSubview:shopHeadImageView ];
            [shopHeadImageView PSSetLeft:WidthRate(10)];
            [shopHeadImageView PSSetSize:WidthRate(20) Height:HeightRate(30)];
            [shopHeadImageView PSSetTop:0];
            
            UILabel *companyLabelName = [[UILabel alloc] init];
            companyLabelName.text = order.StoreName;
            companyLabelName.font = [UIFont systemFontOfSize:AdaptFont(14)];
            companyLabelName.textColor = ColorWithHexString(@"333333");
            [companyView addSubview:companyLabelName];
            companyLabelName.translatesAutoresizingMaskIntoConstraints= NO;
            [companyLabelName PSSetRightAtItem:shopHeadImageView Length:WidthRate(5)];
            
           
            
            
            UILabel *shopGoodsInvoiceLable = [[UILabel alloc] init];
            shopGoodsInvoiceLable.text = @"含税";
            shopGoodsInvoiceLable.textAlignment = NSTextAlignmentCenter;
            shopGoodsInvoiceLable.font = [UIFont systemFontOfSize:AdaptFont(9)];
            shopGoodsInvoiceLable.textColor = ColorWithHexString(@"ffffff");
            shopGoodsInvoiceLable.layer.cornerRadius = 6;
            shopGoodsInvoiceLable.clipsToBounds = YES;
            shopGoodsInvoiceLable.backgroundColor = ColorWithHexString(@"FFCC00");
            [companyView addSubview:shopGoodsInvoiceLable];
            shopGoodsInvoiceLable.translatesAutoresizingMaskIntoConstraints= NO;
            [shopGoodsInvoiceLable PSSetRightAtItem:companyLabelName Length:WidthRate(5)];
            [shopGoodsInvoiceLable PSSetSize:WidthRate(33) Height:HeightRate(17)];
            shopGoodsInvoiceLable.hidden =!order.IsIncludeTax.boolValue;

            if (shopGoodsInvoiceLable.hidden==false ) {
                [shopGoodsInvoiceLable PSSetSize:WidthRate(33) Height:HeightRate(17)];

            }else
            {
                [shopGoodsInvoiceLable PSSetSize:WidthRate(0.01) Height:HeightRate(17)];

            }
            UILabel *superGroupLable = [[UILabel alloc] init];
            superGroupLable.text = @"团";
            superGroupLable.textAlignment = NSTextAlignmentCenter;
            superGroupLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
            superGroupLable.textColor = ColorWithHexString(@"ffffff");
            superGroupLable.layer.cornerRadius = 3;
            superGroupLable.clipsToBounds = YES;
            superGroupLable.backgroundColor = ColorWithHexString(@"F8695D");
            [companyView addSubview:superGroupLable];
            superGroupLable.translatesAutoresizingMaskIntoConstraints= NO;
            superGroupLable.hidden =order.SuperGroupDetailId.length>0?false:YES;
            [superGroupLable PSSetRightAtItem:shopGoodsInvoiceLable Length:WidthRate(5)];
            [superGroupLable PSSetSize:WidthRate(14) Height:HeightRate(17)];

            
            
            UILabel *superOrder = [[UILabel alloc] init];
            superOrder.text = @"已付定金";
            superOrder.textAlignment = NSTextAlignmentCenter;
            superOrder.font = [UIFont systemFontOfSize:AdaptFont(9)];
            superOrder.textColor = ColorWithHexString(@"F8695D");
            superOrder.layer.borderColor =  ColorWithHexString(@"F8695D").CGColor;
            superOrder.layer.borderWidth = 1;
            superOrder.layer.cornerRadius = 6;
            superOrder.clipsToBounds = YES;
//            superOrder.backgroundColor = ColorWithHexString(@"FFCC00");
            [companyView addSubview:superOrder];
            superOrder.translatesAutoresizingMaskIntoConstraints= NO;
            [superOrder PSSetRightAtItem:superGroupLable Length:WidthRate(5)];
            [superOrder PSSetSize:WidthRate(55) Height:HeightRate(17)];
            superOrder.hidden =order.SuperGroupDetailId.length>0?false:YES;;
            //订单状态
            YHLabel *orderStatusLabel = [[YHLabel alloc] initWithTextColor:@"FA0C37"];
            orderStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
            
            orderStatusLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
            [orderTopView addSubview:orderStatusLabel];
            orderStatusLabel.textAlignment = NSTextAlignmentRight;
            [orderStatusLabel PSSetRight:WidthRate(10)];
            [orderStatusLabel PSSetCenterHorizontalAtItem:shopGoodsInvoiceLable];
            [orderStatusLabel PSSetWidth:WidthRate(55)];
            orderStatusLabel.text = order.OrderStateName;
            
            UILabel *line = [[UILabel alloc] init];
            line.backgroundColor = SepratorLineColor;
            line.translatesAutoresizingMaskIntoConstraints = false;
            [orderTopView addSubview:line];
            [line PSSetLeft:WidthRate(10)];
            [line PSSetSize:ScreenWidth-WidthRate(20) Height:HeightRate(1)];
            [line PSSetBottomAtItem:shopHeadImageView Length:0];

            //订单号
            YHLabel *orderIdLabel = [[YHLabel alloc] initWithTextColor:BASE_FAINTLY_COLOR];
            orderIdLabel.translatesAutoresizingMaskIntoConstraints = NO;
            orderIdLabel.text = [NSString stringWithFormat:@"订单号：%@",order.ContractNo] ;
            orderIdLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
            [orderTopView addSubview:orderIdLabel];
            [orderIdLabel PSSetLeft:WidthRate(10)];
            [orderIdLabel PSSetSize:ScreenWidth-WidthRate(20) Height:HeightRate(30)];
            [orderIdLabel PSSetBottomAtItem:shopHeadImageView Length:0];

      
    }
    
    return orderTopView;
    
}
@end

