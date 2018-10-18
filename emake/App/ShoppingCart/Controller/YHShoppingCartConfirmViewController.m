//
//  YHShoppingCartConfirmViewController.m
//  emake
//
//  Created by 谷伟 on 2017/11/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHShoppingCartConfirmViewController.h"
#import "YHShoppingCartConfirmCell.h"
#import "YHContractCreatViewController.h"
#import "ChatNewViewController.h"
#import "YHShoppingTeamOrderTableViewCell.h"
#import "teamModel.h"
#import "Tools.h"
#import "YHShopAlertView.h"
#import "YHOrderManageNewViewController.h"
#import "YHShoppingInsranceViewController.h"
#import "YHInsuranceSeviceViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "YHAdressViewController.h"
#import "YHMainMessageCenterViewController.h"
#import "YHOrderManageNewViewController.h"
@interface YHShoppingCartConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    TPKeyboardAvoidingTableView * myTableView;
    BOOL isLeader;
    NSString *groupID;
    UIView *alertShow;
    YHShopAlertView *alertshop;
    BOOL isInvoice;
    BOOL isRecordSelectInsurance;

    CGFloat TableviewFootHeight;
    CGFloat TableviewAdressOfHeadHeight;

    UIView *bottomView;
    
}
@property (nonatomic,retain)UIButton *dicussBtn;
@property (nonatomic,retain)UILabel *totalLabel;
@property (nonatomic,retain)UILabel *priceFeeLabel;
@property (nonatomic,retain)UILabel *insuranceFeeLabel;
@property (nonatomic,retain)UILabel *insuranceMoneyLabel;
@property (nonatomic,retain)UITextField *insuranceMoneyTextField;

@property (nonatomic,retain)UIButton *addInsuranceMoneyButton;

@property(nonatomic,strong)NSArray *groupArr;
@property(nonatomic,copy)NSString *recordTotalprice;
@property(nonatomic,copy)NSString *recordFeeprice;
@property(nonatomic,copy)NSString *recordTotalFeeprice;
@property(nonatomic,copy)NSString *recordInsuranceMoney;
@property(nonatomic,copy)NSString *recordTheNewChangeTotalInsurancePrice;
@property(nonatomic,copy)NSString *recordOriginalTotalInsurancePrice;

@property(nonatomic,assign)NSInteger recordNum;

@property(nonatomic,assign)BOOL isStore;
@property(nonatomic,assign)BOOL isIndustry;


@end

@implementation YHShoppingCartConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isNeedHideBottomView) {
        self.title =@"订单详情";
    }else{
        self.title =@"确认订单";
    }
//    [self addRightNavBtnWithImage:@"shouyekefu"];
    [self addRigthDetailButtonIsShowCart:false];
//    NSString *isStore = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
//    self.isStore = [isStore isEqualToString:@"1"];
    
//    self.isIndustry = [[NSUserDefaults standardUserDefaults] boolForKey:IsIndustryCatagory];
    

    [self getConculateResultTotalPriceWithIsSelectInsurance:false isChange:false];


    
   
    NSLog(@"IsIndustryCatagory==%d",self.isIndustry);
    self.recordInsuranceMoney = @"0";
    [self configBottomView];
    [self configUI];

}
-(void)getConculateResultTotalPriceWithIsSelectInsurance:(BOOL)IsSelectInsurance isChange:(BOOL)isChangeValue
{
        double TotalPrice = 0 ;

        for (NSArray *class in self.selectArray) {
            double TotalInsurancePrice = 0 ;
            
            double priceALL = 0 ;
            NSInteger recordNum = 0 ;
            
            for (YHShoppingCartModel *item in class) {
                
             
                //保额=原产品价格+所有附件的价格
                TotalInsurancePrice += (item.MainProductPrice.doubleValue+[self totalAddSevice:item.AddServiceArr])*item.GoodsNumber.integerValue;
                
                priceALL += item.ProductGroupPrice.doubleValue*item.GoodsNumber.integerValue;
                recordNum += item.GoodsNumber.integerValue;
            }
            YHShoppingCartModel *model = class.firstObject;
            model.storeTotalPrice = [Tools getHaveNum:priceALL];

            if (isChangeValue==false) {
                model.isSelectInsurance = false;
                model.InsuranceMoney = [Tools getHaveNum:TotalInsurancePrice];

                model.InsuranceNewMoney = [Tools getHaveNum:TotalInsurancePrice];
            }
            model.storeTotalNumber = recordNum;
            model.isShowInsranceView =self.isIndustry ==YES?(TotalInsurancePrice>2000):false;
            if (model.isSelectInsurance ==YES) {
                TotalPrice +=floorNumber(model.InsuranceNewMoney.doubleValue*0.005) +model.storeTotalPrice.doubleValue;
            }else
            {
                TotalPrice +=  model.storeTotalPrice.doubleValue;

            }
            
        }
//    self.totalPrice =[NSString stringWithFormat:@"%@",[Tools getHaveNum:(self.recordTotalprice.doubleValue+floorNumber(_recordInsuranceMoney.doubleValue*0.005))]]   ;
    _totalLabel.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:TotalPrice]];
   
    [myTableView reloadData];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSInteger messageCount = 0;
    if (messageCount>0) {
        if (messageCount>99){
            messageCount = 99;
        }
        [self.navigationItem.rightBarButtonItem showBadgeWithStyle:WBadgeStyleNumber value:messageCount animationType:WBadgeAnimTypeNone];
        self.navigationItem.rightBarButtonItem.badgeCenterOffset = CGPointMake(WidthRate(-8), HeightRate(5));
    }else{
        [self.navigationItem.rightBarButtonItem clearBadge];
    }
}
-(double)totalAddSevice:(NSArray *)addsevice
{
    double TotalPrice = 0;
    for (int i = 0; i < addsevice.count; i++) {
        YHOrderAddSevice *seviceModel = addsevice[i];
        if ([seviceModel.GoodsType isEqualToString:@"2"]) {//附件 价格相加
            TotalPrice += seviceModel.GoodsPrice.doubleValue;
        }

    }
    return TotalPrice;
}

- (void)configUI{

    TableviewAdressOfHeadHeight = 41;
    
    myTableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.estimatedSectionHeaderHeight =0;
    myTableView.estimatedSectionFooterHeight = 0;
    myTableView.sectionHeaderHeight= TableViewHeaderNone;
    myTableView.estimatedRowHeight = 200;
    
    myTableView.backgroundColor = TextColor_F5F5F5;
    [self.view addSubview:myTableView];
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.mas_equalTo(bottomView.mas_top).offset(0);
        make.left.mas_equalTo(0);
    }];
}

- (void)configBottomView{

    bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(0));
        make.bottom.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(50));
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(1));
    }];
    
    
    self.dicussBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dicussBtn addTarget:self action:@selector(dicussBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.dicussBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [self.dicussBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [self.dicussBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dicussBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [bottomView addSubview:self.dicussBtn];
    
    [self.dicussBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(115));
        make.height.mas_equalTo(HeightRate(50));
    }];
    
    self.totalLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    self.totalLabel.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    self.totalLabel.font = SYSTEM_FONT(AdaptFont(16));
    [bottomView addSubview:self.totalLabel];
    self.totalLabel.text = [NSString stringWithFormat:@"¥ %@",self.totalPrice];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.dicussBtn.mas_left).offset(-WidthRate(19));
        make.centerY.mas_equalTo(self.dicussBtn.mas_centerY).offset(HeightRate(0));
        make.height.mas_equalTo(HeightRate(25));
    }];
    
    UILabel *   label =[[UILabel alloc]initWithFrame:CGRectZero];
    label.font = SYSTEM_FONT(AdaptFont(14));
    label.text = @"合计：";
    [bottomView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.totalLabel.mas_left).offset(0);
        make.centerY.mas_equalTo(self.dicussBtn.mas_centerY).offset(HeightRate(0));
        make.height.mas_equalTo(HeightRate(25));
    }];
    
    
    if (_isNeedHideBottomView ==  YES) {
        
        self.dicussBtn.hidden = YES ;
        [self.dicussBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.01);
        }];
        
        
    }
    

}
#pragma mark === UITableViewDelegate & UITableViewDataSources
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *class = self.selectArray[section];
    
    return class.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.selectArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHShoppingCartConfirmCell *cell = nil;
    if (!cell) {
        cell = [[YHShoppingCartConfirmCell alloc]init];
    }
    NSArray *shopArr = self.selectArray[indexPath.section];
    YHShoppingCartModel *model = shopArr[indexPath.row];
  
    [cell setData:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSArray *array = self.selectArray[section];
    YHShoppingCartModel *model = array.firstObject;
    if (model.isShowInsranceView==YES) {
        return HeightRate(167);
    }
    return HeightRate(78);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

        if (section == 0) {
            return HeightRate(30)+TableviewAdressOfHeadHeight;
        }
        return HeightRate(30);
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat Height  =section==0?(HeightRate(30)+TableviewAdressOfHeadHeight):HeightRate(30);
    UIView *customHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(Height))];
    customHeadView.backgroundColor = ColorWithHexString(@"FAFAFA");
    
    UIView *addressView ;
    if (section == 0) {
        addressView = [self getCustomTopAdressView];
        [customHeadView addSubview:addressView];
    }


        NSArray *shopArr = self.selectArray[section];
        YHShoppingCartModel *model = shopArr.firstObject;
        UIView *companyView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
        companyView.backgroundColor = ColorWithHexString(@"FAFAFA");
        [customHeadView addSubview:companyView];
        companyView.translatesAutoresizingMaskIntoConstraints = NO;
        if (section==0) {
            [companyView PSSetBottomAtItem:addressView Length:3];
//            companyView.frame = CGRectMake(0, TableviewAdressOfHeadHeight, ScreenWidth, HeightRate(30));
        }else
        {
//            companyView.frame = CGRectMake(0, 0, ScreenWidth, HeightRate(30));

            [companyView PSSetTop:0];
        }
        [companyView PSSetLeft:0];
        [companyView PSSetSize:ScreenWidth Height:HeightRate(30)];
        
        UIImageView * shopHeadImageView = [[UIImageView alloc] init];
//        shopHeadImageView.image = [UIImage imageNamed:@"placehold"];
        [shopHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.StorePhoto]];
        shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
        shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [companyView addSubview:shopHeadImageView ];
        [shopHeadImageView PSSetLeft:WidthRate(10)];
        [shopHeadImageView PSSetSize:WidthRate(20) Height:HeightRate(20)];
        [shopHeadImageView PSSetCenterHorizontalAtItem:companyView];
        
        UILabel *companyLabelName = [[UILabel alloc] init];
        companyLabelName.text = model.StoreName;
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
        shopGoodsInvoiceLable.hidden = self.isIndustry==YES?YES:[model.IsInvoice isEqualToString:@"0"];
   
    return customHeadView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    CGFloat bavkviewHeight = TableviewFootHeight;
    
  
    NSArray *array = self.selectArray[section];
    YHShoppingCartModel *model = array.firstObject;
    NSString *taxTips = @"";


    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(bavkviewHeight))];
    backView.backgroundColor = [UIColor whiteColor];
    
//    double insuranceShowPrice = self.isNeedHideBottomView==YES?self.insurancePrice.doubleValue:self.recordTheNewChangeTotalInsurancePrice.doubleValue;
    UILabel *insurancelineLable;
    if (model.isShowInsranceView) {
        insurancelineLable  = [self getFootView:backView byItem:nil totalPrice:model.InsuranceNewMoney.doubleValue tag:section buttonSelect:model.isSelectInsurance];
    }
  
    
    UILabel *labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(0), 0, ScreenWidth-WidthRate(5), HeightRate(48))];
    labelPrice.backgroundColor = [UIColor whiteColor];
    if (model.isSelectInsurance == YES && self.isIndustry == YES) {
        double smallPrice =  floorNumber(model.InsuranceNewMoney.doubleValue*0.005) +model.storeTotalPrice.doubleValue;
        labelPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:smallPrice]];

    }else
    {
        labelPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:model.storeTotalPrice.doubleValue]];

    }
    labelPrice.textAlignment = NSTextAlignmentRight;
    labelPrice.font = SYSTEM_FONT(AdaptFont(15));
    labelPrice.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [backView addSubview:labelPrice];
    
    [labelPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-6));
        if (insurancelineLable == nil) {
            make.top.mas_equalTo(HeightRate(5));

        }else
        {
        make.top.mas_equalTo(insurancelineLable.mas_bottom).offset(HeightRate(5));
        }
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(0), 0, ScreenWidth-WidthRate(5), HeightRate(48))];
    label.backgroundColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"共%ld件商品     合计：",model.storeTotalNumber];
    label.textAlignment = NSTextAlignmentRight;
    label.font = SYSTEM_FONT(AdaptFont(12));
    [backView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(labelPrice.mas_left);
        make.centerY.mas_equalTo(labelPrice.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *freight = [[UILabel alloc] init];
    freight.textColor = ColorWithHexString(BASE_LINE_COLOR);
    freight.translatesAutoresizingMaskIntoConstraints = NO;
    freight.text =[NSString stringWithFormat:@"(%@)",model.GoodsAddValue] ;
    freight.textColor = ColorWithHexString(SymbolTopColor);

    freight.font =[UIFont systemFontOfSize:AdaptFont(13)];
    [backView addSubview:freight];
    
    [freight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-6));
        make.top.mas_equalTo(label.mas_bottom).offset(HeightRate(5));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    [backView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(HeightRate(1));
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(freight.mas_bottom).offset(HeightRate(10));
    }];
   
    return backView;
}


#pragma mark---button click 点击事件
-(void)isCanInvoiceButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    isInvoice = button.selected;
    if (isInvoice== YES) {
        self.totalPrice = self.recordTotalFeeprice;
        
    }else{
        self.totalPrice = self.recordTotalprice;
        
    }
    self.totalLabel.text = [NSString stringWithFormat:@"¥ %@",self.totalPrice];

}
-(void)selectButtonClick:(UIButton *)button
{
    NSInteger row = button.tag-2000;
    for ( int i=0;i< self.groupArr.count;i++) {
        teamModel *model = self.groupArr[i];
        if (row==i) {
            model.isSelect = YES;
        }else
        {
            model.isSelect = NO;
        }
        
    }
    
    [myTableView reloadData];
    
    
}
- (void)dicussBtnClick{
//        [MobClick event:@"ContractNegotiation" label:@"合同洽谈-输配电"];

   
    
    
    NSString * price;
    NSString * ParamPrice;
    
  
    NSMutableArray *addModelArr = [NSMutableArray array];
    NSMutableArray *addKeysdicArr = [NSMutableArray array];
    NSMutableArray *paramsdicArr = [NSMutableArray array];
    NSString *adressStr = self.adressModel?[self.adressModel mj_JSONString]:@"";

    NSInteger num=0;
    for (NSArray *class in self.selectArray) {
        NSString *invoice = @"";
        NSString *StoreId = @"";
        
        NSMutableArray *addArr = [NSMutableArray array];

        for ( int i =0;i <class.count;i++ ) {
            YHShoppingCartModel *item = class[i];
                [addArr addObject:item.OrderNo];
                [addModelArr addObject:item];
                StoreId = item.StoreId;
                invoice = item.IsInvoice;
            
            
            num  = num + item.GoodsNumber.intValue;
        }
            YHShoppingCartModel *model = class.firstObject;

            NSDictionary * paramsDic=@{@"OrderNos":addArr,@"IsInvoice":self.isIndustry==YES?@"1":model.IsInvoice,@"InsurdAmount":model.isSelectInsurance==YES?model.InsuranceNewMoney:@"0",@"StoreId":StoreId,@"Address":adressStr,@"SuperGroupDetailId":model.SuperGroupDetailId.length?model.SuperGroupDetailId:@"",@"CategoryBId":model.CategoryBId};
            [paramsdicArr addObject:paramsDic];

    }

    for (NSArray *resultArr in self.selectArray) {
        NSMutableArray *dictttt = [NSMutableArray array];
        dictttt =  [YHShoppingCartModel mj_keyValuesArrayWithObjectArray:resultArr];
        [addKeysdicArr addObject:dictttt];
    }
    
    NSMutableArray *firstArr = addKeysdicArr[0];
     NSMutableArray *arrM3 = [NSMutableArray arrayWithArray:firstArr];
    for (int i= 1; i < addKeysdicArr.count; i ++) {
        NSArray *secondArr = addKeysdicArr[i];
      [arrM3 addObjectsFromArray:secondArr];
    }
    

    NSString *invoice  =[NSString stringWithFormat:@"%d",isInvoice];
    NSDictionary *dic;
    
    dic =@{@"MakeOrders":paramsdicArr};

    [self.view showWait:@"合同生成中..." viewType:CurrentView];
    
   
    [[YHJsonRequest shared] makeShoppingCartOderParams:dic SuccessBlock:^(NSArray *successMessage) {
        [self.view hideWait:CurrentView];
        
            YHOrderManageNewViewController *order = [[YHOrderManageNewViewController alloc] init];
            order.OrderState = 0;
            [self.navigationController pushViewController:order animated:YES];
        
    } fialureBlock:^(NSString *errorMessages) {

        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];

    }];
}
-(void)getAdressButtonClick
{
    YHAdressViewController *adress = [[YHAdressViewController alloc] init];
    adress.IsBackAdress = YES;
    __block YHShoppingCartConfirmViewController *weakSelf = self;
    adress.block = ^(id param) {
        weakSelf.adressModel = (adressModel *)param;
        TableviewAdressOfHeadHeight = 78;
        [myTableView reloadData];
    };
    [self.navigationController pushViewController:adress animated:YES];
    
}
-(void)alertIsInvoice
{

    alertshop = [[YHShopAlertView alloc] initWithShoppingCartprice:_totalPrice pirceFee:self.recordFeeprice pirceTotalFee:self.recordTotalFeeprice];
    [alertshop.sureBtn addTarget:self action:@selector(rightSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [alertshop.falseBtn addTarget:self action:@selector(rightSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [alertshop showAnimated];
}

- (void)rightBtnClick:(UIButton *)sender{
    [super rightBtnClick:sender];
    
    YHMainMessageCenterViewController *centerMesseage = [[YHMainMessageCenterViewController alloc] init];
    centerMesseage.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:centerMesseage animated:YES];
    
    
}

-(void)rightSureBtnClick:(UIButton *)button
{
    
    [alertshop closeAnimated];
    
    isInvoice =[button.currentTitle isEqualToString:@"是"];
  
    
}


-(void)nextVC
{
    YHInsuranceSeviceViewController *insurance = [[YHInsuranceSeviceViewController alloc] init];
    insurance.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:insurance animated:YES];
    
}

-(void)SelectInsuranceButtonClick:(UIButton *)button
{
    NSArray *array = self.selectArray[button.tag-100];
    YHShoppingCartModel *model = array.firstObject;
    model.isSelectInsurance = !model.isSelectInsurance;


    [self getConculateResultTotalPriceWithIsSelectInsurance:model.isSelectInsurance isChange:YES];

}

-(void)addInsuranceBtnClick
{
    //    YHShoppingInsranceViewController *vc = [[YHShoppingInsranceViewController alloc] init];
    //    vc.myInsurance = ^(NSString *myinsurancefee, NSString *myinsuranceMoney) {
    //        _recordTheNewChangeTotalInsurancePrice = myinsuranceMoney;
    //        _recordInsuranceMoney = myinsuranceMoney;
    //        _insuranceFeeLabel.text =myinsurancefee;
    //        _insuranceMoneyLabel.text = [NSString stringWithFormat:@"投保金额：¥%@",[Tools getHaveNum:(myinsuranceMoney.doubleValue)]];;
    //        _totalPrice =[NSString stringWithFormat:@"%@",[Tools getHaveNum:(self.recordTotalprice.doubleValue+floorNumber(myinsuranceMoney.doubleValue*0.005))]];
    //
    //        _totalLabel.text = [NSString stringWithFormat:@"¥%@",_totalPrice];
    //    };
    //    vc.totalPrice = self.recordTheNewChangeTotalInsurancePrice;
    //    vc.originalTotalPrice = self.recordOriginalTotalInsurancePrice;
    //
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark--- 自定义方法
-(UILabel *)getItem:(UIView *)item ByItem:(id)byitem topSpace:(CGFloat)topspace lableTitle:( NSString*)title titleColor:(NSString *)titlecolor price:(NSString *)price priceColor:(NSString *)priceColor
{
    UILabel *lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.text  =  title;
    lable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lable.textColor = ColorWithHexString(titlecolor);
    [item addSubview:lable];
    [lable PSSetSize:WidthRate(135) Height:HeightRate(35)];
    [lable PSSetLeft:WidthRate(40)];
    [lable PSSetBottomAtItem:byitem Length:HeightRate(topspace)];

    
    UILabel *lable1 = [[UILabel alloc] init];
    lable1.translatesAutoresizingMaskIntoConstraints = NO;
    lable1.text  =  price;
    lable1.textAlignment = NSTextAlignmentRight;
    lable1.font = [UIFont systemFontOfSize:AdaptFont(14)];
    lable1.textColor = ColorWithHexString(priceColor);
    [item addSubview:lable1];
    [lable1 PSSetSize:WidthRate(135) Height:HeightRate(35)];
    [lable1 PSSetCenterHorizontalAtItem:lable];
    [lable1 PSSetRight:WidthRate(40)];
    if ([title isEqualToString:@"增值税:"]) {
        UILabel *lineLable = [[UILabel alloc] init];
        lineLable.translatesAutoresizingMaskIntoConstraints = NO;
        lineLable.backgroundColor = SepratorLineColor;
        [item addSubview:lineLable];
        [lineLable PSSetLeft:WidthRate(40)];
        [lineLable PSSetRight:WidthRate(40)];
        [lineLable PSSetHeight:HeightRate(1)];
        [lineLable PSSetBottomAtItem:lable1 Length:2];
    }
    
    
    return lable;
    
}

-(UILabel *)getFootView:(UIView *)footView byItem:(UILabel *)item totalPrice:(CGFloat)price  tag:(NSInteger )tag buttonSelect:(BOOL)isSelect
{
   
    UIButton *SelectInsuranceButton = [UIButton buttonWithType:UIButtonTypeCustom];
 
    SelectInsuranceButton.tag = 100+tag;
    [SelectInsuranceButton addTarget:self action:@selector(SelectInsuranceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:SelectInsuranceButton];
    [SelectInsuranceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(40));
        make.width.mas_equalTo(WidthRate(34));
//        make.centerY.mas_equalTo(addInsuranceBtn.mas_centerY).offset(HeightRate(0));
        make.top.mas_equalTo(HeightRate(0));
    }];
    
    UILabel *insureFee = [[UILabel alloc] init];
    insureFee.textColor = ColorWithHexString(@"5792F0") ;
    insureFee.text = [NSString stringWithFormat:@"人保保费0.5%%：¥%.2lf",floorNumber(price*0.005)];
    insureFee.tag = 500 +tag;
    insureFee.font = [UIFont systemFontOfSize:AdaptFont(13)];
    insureFee.textAlignment = NSTextAlignmentRight;
    [footView addSubview:insureFee];
    [insureFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SelectInsuranceButton.mas_right).offset(WidthRate(5));
        make.height.mas_equalTo(HeightRate(40));
        make.centerY.mas_equalTo(SelectInsuranceButton.mas_centerY).offset(HeightRate(0));
    }];
    self.insuranceFeeLabel = insureFee;
    
    UIButton *InsurancHelpButton = [[UIButton alloc] init];
    [InsurancHelpButton setImage:[UIImage imageNamed:@"bangzhu1"] forState:UIControlStateNormal];
    [InsurancHelpButton addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:InsurancHelpButton];
    [InsurancHelpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(34));
        make.width.mas_equalTo(WidthRate(34));
        make.centerY.mas_equalTo(SelectInsuranceButton.mas_centerY).offset(HeightRate(0));
    }];
   
    

    UILabel *insureMoney = [[UILabel alloc] init];
    insureMoney.textColor = ColorWithHexString(@"333333") ;
    insureMoney.text = [NSString stringWithFormat:@"可加大投保金额:"];
    insureMoney.font = [UIFont systemFontOfSize:AdaptFont(13)];
//    insureMoney.backgroundColor = [UIColor redColor];
//    insureMoney.textAlignment = NSTextAlignmentRight;
    [footView addSubview:insureMoney];
    [insureMoney mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(tipLable.mas_left).offset(WidthRate(-5));
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(20));
        make.width.mas_equalTo(WidthRate(100));
        make.top.mas_equalTo(SelectInsuranceButton.mas_bottom).offset(HeightRate(0));
    }];
//    self.insuranceMoneyLabel = insureMoney;
    
    UILabel *TextBoardlable  = [[UILabel alloc] init];
    TextBoardlable.layer.borderWidth = 1;
    TextBoardlable.layer.borderColor =ColorWithHexString(@"C9C9C9").CGColor;
    TextBoardlable.clipsToBounds = YES;
    TextBoardlable.layer.cornerRadius = 6;
    [footView addSubview:TextBoardlable];
    [TextBoardlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(insureMoney.mas_right).offset(WidthRate(6));
        //        make.right.mas_equalTo(WidthRate(-10));
        make.width.mas_equalTo(WidthRate(230));
        make.height.mas_equalTo(HeightRate(34));
        make.centerY.mas_equalTo(insureMoney.mas_centerY).offset(HeightRate(0));
    }];
    
    
    UITextField *insureMoneyText = [[UITextField alloc] init];
    insureMoneyText.text = [Tools getHaveNum:(price)];
//    insureMoneyText.layer.borderWidth = 1;
    insureMoneyText.textAlignment = NSTextAlignmentRight;
    insureMoneyText.delegate = self;
    insureMoneyText.tag = 100+tag;

    insureMoneyText.keyboardType = UIKeyboardTypeDecimalPad;
    insureMoneyText.textColor = ColorWithHexString(@"999999");
    insureMoneyText.placeholder = _recordOriginalTotalInsurancePrice;
//    insureMoneyText.layer.borderColor = ColorWithHexString(@"C9C9C9").CGColor;
    [footView addSubview:insureMoneyText];
    [insureMoneyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(insureMoney.mas_right).offset(WidthRate(8));
        make.width.mas_equalTo(WidthRate(220));
        make.height.mas_equalTo(HeightRate(34));
        make.centerY.mas_equalTo(insureMoney.mas_centerY).offset(HeightRate(0));
    }];
    self.insuranceMoneyTextField = insureMoneyText;

    UILabel *textFieldTipsLable = [[UILabel alloc] init];
    textFieldTipsLable.textColor = ColorWithHexString(@"C9C9C9");
    textFieldTipsLable.text = @"请输入大于已选商品金额的投保额";
    textFieldTipsLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    [footView addSubview:textFieldTipsLable];
    [textFieldTipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(insureMoney.mas_right).offset(WidthRate(5));
        make.right.mas_equalTo(WidthRate(-10));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(insureMoney.mas_bottom).offset(HeightRate(5));
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    [footView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(0));
        make.top.mas_equalTo(textFieldTipsLable.mas_bottom).offset(HeightRate(2));
        make.height.mas_equalTo(1);
    }];
    
    if (isSelect == YES) {
        [SelectInsuranceButton setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateNormal];
        insureMoneyText.userInteractionEnabled = YES;
        
    }else
    {
        [SelectInsuranceButton setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        insureMoneyText.userInteractionEnabled = false;

    }
    if (_isNeedHideBottomView  == YES) {
        SelectInsuranceButton.hidden = YES;
        [SelectInsuranceButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.01);
        }];
        insureMoneyText.userInteractionEnabled = false;
        textFieldTipsLable.hidden = YES;
    }
    self.recordInsuranceMoney = [Tools getHaveNum:(price)];
    return line;
}


-(UIView *)getCustomTopAdressView
{

    
     UIView * adressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(TableviewAdressOfHeadHeight))];
     adressView.backgroundColor = ColorWithHexString(@"99CCFF");
    [adressView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getAdressButtonClick)]];
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
    if (self.adressModel) {
        
        UILabel *nameInfoLable  =[[UILabel alloc] init];
        nameInfoLable.text  = [NSString stringWithFormat:@"%@    %@",self.adressModel.UserName,self.adressModel.MobileNumber];
        nameInfoLable.textColor = ColorWithHexString(@"ffffff");
        nameInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:nameInfoLable];
        [nameInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(HeightRate(15));
        }];
        
        UILabel *adressInfoLable  =[[UILabel alloc] init];
        adressInfoLable.text  = [NSString stringWithFormat:@"%@%@%@%@%@",self.adressModel.Province,self.adressModel.City,self.adressModel.County,self.adressModel.District,self.adressModel.Address];;
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
        
        
    }else
    {
       
        
        UIButton *editAddaddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [editAddaddressButton setTitle:@"编辑地址" forState:UIControlStateNormal];
        editAddaddressButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [editAddaddressButton setTitleColor:ColorWithHexString(@"FFFF00") forState:UIControlStateNormal];
        [editAddaddressButton addTarget:self action:@selector(getAdressButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [ adressView addSubview:editAddaddressButton];
        [editAddaddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(80));
            make.height.mas_equalTo(HeightRate(36));
            make.right.mas_equalTo(WidthRate(-10));
            make.centerY.mas_equalTo(adressView.mas_centerY);
        }];
        UIImageView * shopHeadImageView = [[UIImageView alloc] init];
        shopHeadImageView.image = [UIImage imageNamed:@"dizhi_bianji"];
        shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
        shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [adressView addSubview:shopHeadImageView ];
        [shopHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(16));
            make.height.mas_equalTo(HeightRate(16));
            make.right.mas_equalTo(editAddaddressButton.mas_left).offset(-WidthRate(0));
            make.centerY.mas_equalTo(adressView.mas_centerY);
        }];
    }
    
    return  adressView;
}
#pragma mark-- textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    NSString* nba=@"2014.9.26";
    //    NSArray *p=[nbacomponentsSeparatedByString:@"."];
    //    if (self.insurancfeeTextfeild.text.length <= 0) {
    //        [self.view makeToast:@"当前投保额不能为空" duration:1 position:CSToastPositionCenter];
    //        return NO;
    //    }
    if ([textField.text containsString:string] &&[string isEqualToString:@"."]) {
        [self.view makeToast:@"输入数字格式不正确" duration:1 position:CSToastPositionCenter];
        return NO;
    }
    
    //判断小数点的位数
    if ([textField.text containsString:@"."]) {
        NSRange ran=[textField.text rangeOfString:@"."];
        NSInteger tt=range.location-ran.location;
        if (tt <= 2){
            return YES;
        }else{
//                    [self alertView:@"亲，您最多输入两位小数"];
            return NO;
        }
    }else
    {
        return YES;
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSArray *array = self.selectArray[textField.tag-100];
    YHShoppingCartModel *model = array.firstObject;
    if (textField.text.length <= 0) {
        textField.text = model.InsuranceMoney;
        [self.view makeToast:@"当前投保额不能为空" duration:1 position:CSToastPositionCenter];
        return ;
    }
    if(textField.text.doubleValue<model.InsuranceMoney.doubleValue) {
        textField.text = model.InsuranceMoney;

        [self.view makeToast:@"保额不能低于订单总额" duration:1.5 position:CSToastPositionCenter];
        return ;
    }
    NSString *insuranceFeeMoney =[Tools getHaveNum:floorNumber(textField.text.doubleValue*0.005)];


    model.InsuranceNewMoney  = textField.text;
    UIView *textSuperView = textField.superview;
    UILabel *insranceLable = (UILabel *)[textSuperView viewWithTag:(500+(textField.tag-100))];
    insranceLable.text = [NSString stringWithFormat:@"人保保费0.5%%：¥%@",insuranceFeeMoney];
    [self getConculateResultTotalPriceWithIsSelectInsurance:model.isSelectInsurance isChange:YES];
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
