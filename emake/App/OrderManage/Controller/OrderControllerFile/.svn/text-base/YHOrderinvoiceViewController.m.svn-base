//
//  YHOrderinvoiceViewController.m
//  emake
//
//  Created by eMake on 2017/9/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderinvoiceViewController.h"
#import "YHOrderInvoiceView.h"
#import "YHOrderInvoiceTableViewCell.h"
#import "YHUploadPaymentSuccessViewController.h"

@interface YHOrderinvoiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign)NSInteger record;
@property (nonatomic,strong)UIButton *invoiceBtn;
@property (nonatomic,strong)UILabel *priceL;

@end

@implementation YHOrderinvoiceViewController


- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请发票";
    UITableView *tableview   = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped];
    tableview.dataSource= self;
    tableview.delegate = self;
    [self.view addSubview:tableview];
    [tableview registerClass:[YHOrderInvoiceView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    [self comfimeBottomView];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    
    return HeightRate(380);

}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 3;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return HeightRate(70);

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    YHOrderInvoiceView *headview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headview) {
        headview =[[YHOrderInvoiceView alloc] initWithReuseIdentifier:@"header"];
    }
    
    return headview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    YHOrderInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YHOrderInvoiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    [ cell.selectBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectBtn.tag = 10+indexPath.row;
    return cell;


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHOrderInvoiceTableViewCell *cell = [ tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectBtn.selected ==YES) {
        
        _record  +=cell.lbPrice.text.intValue;
    }else
    {
        _record  -=cell.lbPrice.text.intValue;

    }

}

#pragma mark-- 选中cell -buttonClick
-(void)selectButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
}

#pragma mark---bottomview
-(void)comfimeBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        bottomView.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:bottomView];
    [bottomView PSSetCenterX];
    [bottomView PSSetSize:ScreenWidth Height:HeightRate(60)];
    [bottomView PSSetBottom:HeightRate(0)];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];

    [bottomView addSubview:button];
    [button PSSetLeft:WidthRate(15)];
    [button PSSetSize:WidthRate(36) Height:HeightRate(36)];
    [button PSSetCenterHorizontalAtItem:bottomView];

    
    UILabel *lableName = [[UILabel alloc]init];
    lableName.text = @"全选";
    lableName.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lableName.backgroundColor = [UIColor greenColor];
    lableName.textColor = ColorWithHexString(@"7d7c7d");
    lableName.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:lableName];
    [lableName PSSetRightAtItem:button Length:WidthRate(8)];
    [lableName PSSetWidth:WidthRate(30)];

    
    UILabel *lablePrice = [[UILabel alloc]init];
    lablePrice.text = @"申请开票金额:";
    lablePrice.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lablePrice.textColor = ColorWithHexString(@"555555");
    lablePrice.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:lablePrice];
    [lablePrice PSSetRightAtItem:lableName Length:WidthRate(11)];
    [lablePrice PSSetWidth:WidthRate(100)];
    
    UILabel *lablestate = [[UILabel alloc]init];
    lablestate.text = @"¥";
    lablestate.font = [UIFont systemFontOfSize:AdaptFont(12)];
    lablestate.textColor = ColorWithHexString(@"F53154");
    lablestate.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:lablestate];

    [lablestate PSSetRightAtItem:lablePrice Length:WidthRate(-8)];

    UILabel *price = [[UILabel alloc]init];
    price.text = @"24000";
    price.font = [UIFont systemFontOfSize:AdaptFont(16)];
    price.textColor = ColorWithHexString(@"F53154");
    price.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:price];
    [price PSSetRightAtItem:lablestate Length:WidthRate(4)];


    _invoiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _invoiceBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:_invoiceBtn];
    _invoiceBtn.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
    _invoiceBtn.userInteractionEnabled = YES;
    _invoiceBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [_invoiceBtn setTitle:@"我要开票" forState:UIControlStateNormal];
    [_invoiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_invoiceBtn addTarget:self action:@selector(discussContractButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_invoiceBtn PSSetSize:WidthRate(102) Height:HeightRate(60)];
    [_invoiceBtn PSSetCenterHorizontalAtItem:lablePrice];
    [_invoiceBtn PSSetRight:0];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:lineView];
    [lineView PSSetSize:WidthRate(273) Height:HeightRate(1)];
    [lineView PSSetTop:0];
    [lineView PSSetLeft:0];
    
}
//开票buttonClick
-(void)discussContractButtonClicked
{

    YHUploadPaymentSuccessViewController *vc = [[YHUploadPaymentSuccessViewController alloc]init];
    vc.titlleStr = @"开票申请已提交，客服审核中";
    vc.tipStr = @"您的开票申请已提交客服审核中，请耐心等待";
    vc.navTitleStr = @"开票申请";

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
