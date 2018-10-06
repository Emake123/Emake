//
//  YHChatConfirmOrderViewController.m
//  emake
//
//  Created by zhangshichao on 2018/8/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHChatConfirmOrderViewController.h"
#import "YHOrderTableViewCell.h"
#import "adressModel.h"
#import "YHLabel.h"
#import "YHInsuranceSeviceViewController.h"
@interface YHChatConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mytable;
@property(nonatomic,assign)BOOL isShowInsuranceView;
@property(nonatomic,assign)BOOL isIndustry;
@property(nonatomic,assign)BOOL isShowAdress;
@property(nonatomic,strong)YHOrderContract *contract ;

@property(nonatomic,assign)CGFloat bottomHeight;
@end

@implementation YHChatConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"订单详情";
    self.isIndustry = [[NSUserDefaults standardUserDefaults] boolForKey:IsIndustryCatagory];

    self.view.backgroundColor = SepratorLineColor;
    

    
    CGFloat tableHeight = (ScreenHeight)-(TOP_BAR_HEIGHT)-(HeightRate(self.bottomHeight));
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0,TOP_BAR_HEIGHT, ScreenWidth, tableHeight) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.estimatedRowHeight = HeightRate(40);
    table.estimatedSectionHeaderHeight = 60.0;
    table.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:table];
    _mytable = table;
    [self getContractData];
}
-(void)getContractData{
    [self.view showWait:@"加载中" viewType:CurrentView];
   NSDictionary * paramDic =@{@"RequestType":@"1",@"OrderNo":self.contractNo};
    
    [[YHJsonRequest shared] userUseOrderManageParams:paramDic SucceededBlock:^(NSArray *orderArray) {
        
        if (orderArray.count ==1) {
            self.contract = orderArray.firstObject;
            self.isShowInsuranceView =   self.isIndustry == YES && self.contract.InsurdAmount.floatValue > @"2000".floatValue;
            self.isShowAdress = self.contract.Address.length>0?YES:(self.contract.ShippingInfo.count>0?YES:false);

            [self.mytable reloadData];
        }else
        {
            [self.view makeToast:@"合同号异常" duration:1.5f position:CSToastPositionCenter];

        }
      
        
        [self.view hideWait:CurrentView];
        
        
    } failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];

        [self.view makeToast:errorMessage duration:1.5f position:CSToastPositionCenter];
    }];
}

#pragma mark-- uitabledelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isShowAdress ==false) {
        return HeightRate(35);
    }
    return HeightRate(101);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    CGFloat hight =  self.isShowInsuranceView?(110):64;
    return HeightRate(hight);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contract.goodsModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHOrder *order = self.contract.goodsModelArr[indexPath.row];
    
    YHOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[YHOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [cell setRequestData:order withIsStore:YES isHidenFreight:YES];
    return cell;
    
}




-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(67))];
    backView.backgroundColor = ColorWithHexString(@"99CCFF");
    
    adressModel *Model;
    if (self.contract.Address.length>0) {
        Model = [adressModel mj_objectWithKeyValues:self.contract.Address];
    }else if(self.contract.shipingModelArr.count>0)
    {
        NSDictionary *shipFirstDict = self.contract.ShippingInfo.firstObject;
        Model = [adressModel initWithName:shipFirstDict[@"Receiver"] MobileNumber:shipFirstDict[@"ReceiverPhone"] Adress:shipFirstDict[@"ReceiverAddress"]];
        
    }
    UIView *adressView = [self getCustomTopAdressView:Model];
    [backView addSubview:adressView];
    
    [self TitleHeadView:backView item:adressView];
        
   
    
    
    
    return backView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGFloat hight =  self.isShowInsuranceView?(148):84;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(hight))];
    footView.backgroundColor =ColorWithHexString(@"ffffff");
    
    UILabel *line;
    if (self.isShowInsuranceView==YES) {
        UIButton *leftTipImage = [[UIButton alloc] init];
        [leftTipImage setImage:[UIImage imageNamed:@"bangzhu1"] forState:UIControlStateNormal];
        [leftTipImage addTarget:self action:@selector(helpButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:leftTipImage];
        [leftTipImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(40));
            make.width.mas_equalTo(WidthRate(34));
            make.top.mas_equalTo(HeightRate(0));
        }];
        
        
        //helpButtonClick
        
        UIImageView *imageright = [[UIImageView alloc] init];
        imageright.image = [UIImage imageNamed:@"right01"];
        imageright.contentMode = UIViewContentModeScaleAspectFit;
        [footView addSubview:imageright];
        [imageright mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(20));
            make.width.mas_equalTo(WidthRate(15));
            make.top.mas_equalTo(HeightRate(10));
            
        }];
        imageright.hidden =YES;
        
//        UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
////        [rightbtn addTarget:self action:@selector(rightBtnAddInsuranceClick:) forControlEvents:UIControlEventTouchUpInside];
//        [footView addSubview:rightbtn];
//        [rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(WidthRate(-5));
//            make.height.mas_equalTo(HeightRate(35));
//            make.width.mas_equalTo(WidthRate(130));
//            make.top.mas_equalTo(HeightRate(5));
//        }];
        
        UILabel *insureFee = [[UILabel alloc] init];
        insureFee.textColor = ColorWithHexString(@"5792F0") ;
        insureFee.text = [NSString stringWithFormat:@"人保保费0.5%%：¥%@",[Tools getHaveNum:(floorNumber(self.contract.InsurdAmount.doubleValue*0.005))]];
        insureFee.font = [UIFont systemFontOfSize:AdaptFont(12)];
        insureFee.textAlignment = NSTextAlignmentRight;
        [footView addSubview:insureFee];
        [insureFee mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(imageright.mas_left).offset(WidthRate(-5));
            make.right.mas_equalTo(WidthRate(-10));

            make.height.mas_equalTo(HeightRate(20));
            make.top.mas_equalTo(HeightRate(10));
        }];
        
        line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [footView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(1));
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(insureFee.mas_bottom).offset(HeightRate(10));
            
        }];
        
    }
    
    UILabel *tipsRightLableTop = [[UILabel alloc] init];
    tipsRightLableTop.textColor = ColorWithHexString(SymbolTopColor) ;
    tipsRightLableTop.font = [UIFont systemFontOfSize:AdaptFont(13)];
    tipsRightLableTop.textAlignment = NSTextAlignmentRight;
    [footView addSubview:tipsRightLableTop];
    [tipsRightLableTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(0.01));
        if (self.isShowInsuranceView==YES) {
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(5));
        }else
        {
            make.top.mas_equalTo(HeightRate(5));
        }
    }];
    
    UILabel *priceLable = [[UILabel alloc] init];
    priceLable.textColor = ColorWithHexString(StandardBlueColor) ;
    priceLable.text = [NSString stringWithFormat:@"¥%@", [Tools getHaveNum:self.contract.ContractAmount.doubleValue]];
    priceLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    priceLable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(tipsRightLableTop.mas_bottom).offset(HeightRate(5));
        
    }];
    
    UILabel *fixlable = [[UILabel alloc] init];
    fixlable.textColor = ColorWithHexString(@"000000") ;
    fixlable.text = [NSString stringWithFormat:@"共%@件商品  合计：",self.contract.ContractQuantity];
    fixlable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    fixlable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:fixlable];
    [fixlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(priceLable.mas_left).offset(0);
        make.height.mas_equalTo(HeightRate(20));
        make.centerY.mas_equalTo(priceLable.mas_centerY).offset(HeightRate(0));
    }];
    
    UILabel *tipsRightLable = [[UILabel alloc] init];
    tipsRightLable.textColor = ColorWithHexString(SymbolTopColor) ;
    //    tipsRightLable.text = [NSString stringWithFormat:@"%@",self.contract.GoodsAddValue];
    tipsRightLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    tipsRightLable.textAlignment = NSTextAlignmentRight;
    [footView addSubview:tipsRightLable];
    [tipsRightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(priceLable.mas_bottom).offset(HeightRate(5));
        
    }];
    
    //    if (self.contract.TaxPrice.doubleValue>0) {
    //        tipsRightLable.textColor = [UIColor blackColor];
    //        NSString *str = @"增值税";
    //
    //        NSString *priceStr =   [NSString stringWithFormat:@"%@:¥%@",str,[Tools getHaveNum:self.contract.TaxPrice.doubleValue]];//orders.GoodsAddValue
    //
    //        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:priceStr];
    //        [att addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(SymbolTopColor) range:NSMakeRange(str.length+1, priceStr.length-str.length-1)];
    //
    //
    //        tipsRightLableTop.attributedText = att;
    //        [tipsRightLableTop mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(HeightRate(20));
    //        }];
    //        [tipsRightLable mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(0);
    //        }];
    //        tipsRightLable.hidden = YES;
    //        tipsRightLableTop.hidden = false;
    //
    //    } else {
    tipsRightLableTop.hidden = YES;
    tipsRightLable.hidden = false;
    
    [tipsRightLableTop mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HeightRate(0.01));
    }];
    [tipsRightLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HeightRate(30));
    }];
    tipsRightLable.text =self.contract.GoodsAddValue;
    
    //    }
    
    UILabel *lineT = [[UILabel alloc] init];
    lineT.backgroundColor = SepratorLineColor;
    [footView addSubview:lineT];
    lineT.translatesAutoresizingMaskIntoConstraints = NO;
    [lineT PSSetLeft:0];
    [lineT PSSetSize:ScreenWidth Height:1];
    [lineT PSSetBottomAtItem:tipsRightLable Length:HeightRate(8)];
    
 
        lineT.hidden = YES;
    
    
    
    return footView;
}

#pragma mark--buttonclick
//调zhuan到保险服务页面
-(void)helpButtonClick
{
    YHInsuranceSeviceViewController *insurance = [[YHInsuranceSeviceViewController alloc] init];
    insurance.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:insurance animated:YES];
}

-(UIView *)getCustomTopAdressView:(adressModel *)adressModel
{
    
    
    UIView * adressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(78))];
    
    if (self.isShowAdress ==false) {
        adressView.hidden = YES;
        adressView.frame = CGRectMake(0, 0, ScreenWidth, HeightRate(0.01));
        
    }else{
        adressView.backgroundColor = ColorWithHexString(@"99CCFF");
        
        UIImageView *adressImageView = [[UIImageView alloc] init];
        adressImageView.contentMode = UIViewContentModeScaleAspectFit;
        adressImageView.image = [UIImage imageNamed:@"dizhi_icons"];
        [ adressView addSubview:adressImageView];
        
        [adressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(WidthRate(16));
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(WidthRate(20));
            make.centerY.mas_equalTo(adressView.mas_centerY);
            
        }];
        
        UILabel *nameInfoLable  =[[UILabel alloc] init];
        nameInfoLable.text  = [NSString stringWithFormat:@"%@    %@",adressModel.UserName,adressModel.MobileNumber];
        nameInfoLable.textColor = ColorWithHexString(@"ffffff");
        nameInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:nameInfoLable];
        [nameInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(HeightRate(15));
        }];
        
        UILabel *adressInfoLable  =[[UILabel alloc] init];
        adressInfoLable.text  = [NSString stringWithFormat:@"%@%@%@%@%@",adressModel.Province,adressModel.City,adressModel.County,adressModel.District,adressModel.Address];;
        adressInfoLable.numberOfLines = 0;
        //        adressInfoLable.lineBreakMode = NSLineBreakByWordWrapping;
        adressInfoLable.textColor = ColorWithHexString(@"ffffff");
        adressInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:adressInfoLable];
        [adressInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(35));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(nameInfoLable.mas_bottom).offset(5);
        }];
        
        
    }
    
    return  adressView;
}
-(void)TitleHeadView:(UIView *)customHeadView item:(UIView *)addressView
{
    UIView *companyView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
    companyView.backgroundColor = ColorWithHexString(@"FAFAFA");
    [customHeadView addSubview:companyView];
    companyView.translatesAutoresizingMaskIntoConstraints = NO;
    [companyView PSSetBottomAtItem:addressView Length:0];
    [companyView PSSetLeft:0];
    [companyView PSSetSize:ScreenWidth Height:HeightRate(35)];
    
    
    UIImageView * shopHeadImageView = [[UIImageView alloc] init];
    //        shopHeadImageView.image = [UIImage imageNamed:@"placehold"];
    [shopHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.contract.StorePhoto]];
    shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
    shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [companyView addSubview:shopHeadImageView ];
    [shopHeadImageView PSSetLeft:WidthRate(10)];
    [shopHeadImageView PSSetSize:WidthRate(20) Height:HeightRate(20)];
    [shopHeadImageView PSSetCenterHorizontalAtItem:companyView];
    
    UILabel *companyLabelName = [[UILabel alloc] init];
    companyLabelName.text = self.contract.StoreName;
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
    shopGoodsInvoiceLable.hidden = boolUserdefault(IsIndustryCatagory)==YES?YES:[self.contract.IsIncludeTax isEqualToString:@"0"];
    
    //订单状态
    YHLabel *orderStatusLabel = [[YHLabel alloc] initWithTextColor:@"FA0C37"];
    orderStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    orderStatusLabel.font =[UIFont systemFontOfSize:AdaptFont(12)];
    [companyView addSubview:orderStatusLabel];
    orderStatusLabel.textAlignment = NSTextAlignmentRight;
    //        [orderStatusLabel PSSetRightAtItem:orderDateLabel Length:WidthRate(18)];
    [orderStatusLabel PSSetRight:WidthRate(10)];
    [orderStatusLabel PSSetCenterHorizontalAtItem:companyView];
    [orderStatusLabel PSSetWidth:WidthRate(55)];
    orderStatusLabel.hidden = YES;
    orderStatusLabel.text = self.contract.OrderStateName;
        
    
    
    
    
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
