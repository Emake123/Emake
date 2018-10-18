//
//  YHSuperGroupConfirmOrderViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupConfirmOrderViewController.h"
#import "YHSuperGroupConfigOrderTableViewCell.h"
#import "YHAdressViewController.h"
#import "YHSuperGroupConfirmOrderInfoTableViewCell.h"
#import "YHPayViewController.h"
#import "YHSuperGroupCollageViewController.h"
#import "YHAlertView.h"
#import "YHSuperGroupDetailViewController.h"
@interface YHSuperGroupConfirmOrderViewController ()<UITableViewDelegate ,UITableViewDataSource,YHAlertViewDelegete>
{
    
        dispatch_source_t _timer;
    
}
@property (nonatomic,retain)UITableView *myTableView;
@property (nonatomic,strong)adressModel * adressModel;
@property (nonatomic,assign)CGFloat TableviewAdressOfHeadHeight;
@property (nonatomic,strong)NSString * orderNo;
@property (nonatomic,assign)NSInteger joinIndexSuperGroup;
@property (nonatomic,strong)NSIndexPath* recordPath;


@end

@implementation YHSuperGroupConfirmOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认商品";
    [self congfigUI];
    [self bottomview];

  
    [self activeCountDownAction];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotify:) name:NsuserDefaultsPayFailState object:nil];
}
-(void)payNotify:(NSNotification *)notify
{
    YHAlertView *alert =  [[YHAlertView alloc] initWithDelegete:self Title:@"支付失败" bottomTitle:@"客服热线：400-867-0211" ButtonTitle:@"重新支付"];
    [alert showAnimated];
}
-(void)alertViewRightBtnClick:(id )alertView  currentTitle:(NSString *)currentTitle
{
    if ([currentTitle isEqualToString:@"支付失败"]) {
        YHAlertView *alertViewS = (YHAlertView *)alertView;
        [alertViewS closeAnimated];
    } else {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[YHSuperGroupDetailViewController class]]) {
                YHSuperGroupDetailViewController *vc11 = (YHSuperGroupDetailViewController *)vc;
                [self.navigationController popToViewController:vc11 animated:YES];
            }
        }
    }

}

-(void)congfigUI
{
   self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.estimatedSectionHeaderHeight =0;
    self.myTableView.estimatedSectionFooterHeight = 0;
    self.myTableView.sectionHeaderHeight= TableViewHeaderNone;
    self.myTableView.estimatedRowHeight = 200;
    
    self.myTableView.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight-HeightRate(50)-(TOP_BAR_HEIGHT));
        make.left.mas_equalTo(0);
    }];
    
    _TableviewAdressOfHeadHeight = 41;

}

-(void)bottomview{
    
    
      UIView*  bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = ColorWithHexString(@"ffffff");
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(50));
        }];
        
    
 
        UIButton *discussContractButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [bottomView addSubview:discussContractButton];
        discussContractButton.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
        discussContractButton.titleLabel.font = SYSTEM_FONT(AdaptFont(BASE_FONT_SIZE));
        [discussContractButton setTitle:@"提交" forState:UIControlStateNormal];
        [discussContractButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [discussContractButton addTarget:self action:@selector(discussContractButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [discussContractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView);
            make.right.mas_equalTo(bottomView);
            make.width.mas_equalTo(WidthRate(117));
            make.height.mas_equalTo(HeightRate(50));
        }];
    
        UILabel *allPriceLabel = [[UILabel alloc] init];
        allPriceLabel.textColor =ColorWithHexString(StandardBlueColor);
        allPriceLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        allPriceLabel.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:self.supermodel.FrontMoney.doubleValue]];
        [bottomView addSubview:allPriceLabel];
        [allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(discussContractButton.mas_left).offset(WidthRate(-10));
            make.centerY.mas_equalTo(bottomView.mas_centerY);
//            make.height.mas_equalTo(BottomViewItemLabelHeight);
        }];
        
        UILabel *allPriceItemLabel = [[UILabel alloc] init];
        allPriceItemLabel.text =@"定金：";
        allPriceItemLabel.font = [UIFont systemFontOfSize:AdaptFont(12)];
        allPriceItemLabel.textColor = ColorWithHexString(@"676767");
        
        allPriceItemLabel.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:allPriceItemLabel];
        [allPriceItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(allPriceLabel.mas_left).offset(WidthRate(0));
            make.centerY.mas_equalTo(bottomView.mas_centerY);
//            make.height.mas_equalTo(BottomViewItemLabelHeight);
        }];
    
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
        [bottomView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView);
            make.left.mas_equalTo(bottomView);
            make.right.mas_equalTo(discussContractButton);
            make.height.mas_equalTo(1);
        }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        return HeightRate(230);
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==1) {
        YHSuperGroupConfirmOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[YHSuperGroupConfirmOrderInfoTableViewCell alloc]init];
        }
        cell.peopleGroupNumberLable.text = [NSString stringWithFormat:@"%@人团",self.infomodel.PeopleNumber];
        cell.freightPrice.text = [NSString stringWithFormat:@"¥%@ 拼团价",[Tools getHaveNum:self.infomodel.GroupPrice.doubleValue]];
        cell.dateComit.text= [NSString stringWithFormat:@"交货期：%@",self.infomodel.DeliveryDate];
        cell.orderNum.text = [NSString stringWithFormat:@"订购量：%@件",self.infomodel.SetNum];
        cell.orderMoney.text = [NSString stringWithFormat:@"定金：¥%@",[Tools getHaveNum:self.supermodel.FrontMoney.doubleValue]];
        cell.endDate.text = [NSString stringWithFormat:@"   还剩%@ 结束  ",self.infomodel.Hour];
        return cell;
    }else
    {
        YHSuperGroupConfigOrderTableViewCell *cell = nil;
        if (!cell) {
            cell = [[YHSuperGroupConfigOrderTableViewCell alloc]init];
        }
        NSArray *imageArr = [Tools stringToJSON:self.supermodel.GoodsSeriesPhotos];
        if (imageArr.count>0) {
            [cell.productImage sd_setImageWithURL:[NSURL URLWithString:imageArr.firstObject]];
        }
        cell.productNameLable.text = self.supermodel.GroupName;
//        cell.lbOrderDetail.text = self.supermodel.GoodsExplain;
        cell.productPriceLable.text =[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:self.infomodel.GroupPrice.doubleValue]] ;
        cell.productNumberLable.text = [NSString stringWithFormat:@"x%@",self.infomodel.SetNum];
        cell.smallPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:self.infomodel.GroupPrice.doubleValue*self.infomodel.SetNum.integerValue]];
        cell.TotalNumberName.text = [NSString stringWithFormat:@"共%@件商品 合计：",self.infomodel.SetNum];
        cell.lbtax.text = self.supermodel.GoodsAddValue;
        
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        if (section == 0) {
            return HeightRate(30)+_TableviewAdressOfHeadHeight;
        }
        return HeightRate(30);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat Height  = HeightRate(30)+_TableviewAdressOfHeadHeight;
    UIView *customHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(Height))];
    customHeadView.backgroundColor = ColorWithHexString(@"FAFAFA");
    
    UIView *  addressView = [self getCustomTopAdressView];
    [customHeadView addSubview:addressView];
    
    
    UIView *companyView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
    companyView.backgroundColor = ColorWithHexString(@"FAFAFA");
    [customHeadView addSubview:companyView];
    companyView.translatesAutoresizingMaskIntoConstraints = NO;
    [companyView PSSetBottomAtItem:addressView Length:3];
    
    [companyView PSSetLeft:0];
    [companyView PSSetSize:ScreenWidth Height:HeightRate(30)];
    
    UIImageView * shopHeadImageView = [[UIImageView alloc] init];
    //        shopHeadImageView.image = [UIImage imageNamed:@"placehold"];
    [shopHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.supermodel.StorePhoto]];
    shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
    shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [companyView addSubview:shopHeadImageView ];
    [shopHeadImageView PSSetLeft:WidthRate(10)];
    [shopHeadImageView PSSetSize:WidthRate(20) Height:HeightRate(20)];
    [shopHeadImageView PSSetCenterHorizontalAtItem:companyView];
    
    UILabel *companyLabelName = [[UILabel alloc] init];
    companyLabelName.text = self.supermodel.StoreName;
    companyLabelName.font = [UIFont systemFontOfSize:AdaptFont(14)];
    companyLabelName.textColor = ColorWithHexString(@"333333");
    [companyView addSubview:companyLabelName];
    companyLabelName.translatesAutoresizingMaskIntoConstraints= NO;
    [companyLabelName PSSetRightAtItem:shopHeadImageView Length:WidthRate(5)];
    
    UILabel *shopGoodsInvoiceLable = [[UILabel alloc] init];
    shopGoodsInvoiceLable.text = self.supermodel.TaxDesc;
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
    shopGoodsInvoiceLable.hidden = [self.supermodel.TaxDesc containsString:@"不"]?YES:false;
    
    return customHeadView;
    
}

-(UIView *)getCustomTopAdressView
{
    
    
    UIView * adressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(_TableviewAdressOfHeadHeight))];
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

-(void)getAdressButtonClick
{
    YHAdressViewController *adress = [[YHAdressViewController alloc] init];
    adress.IsBackAdress = YES;
    __block YHSuperGroupConfirmOrderViewController *weakSelf = self;
    adress.block = ^(id param) {
        weakSelf.adressModel = (adressModel *)param;
        _TableviewAdressOfHeadHeight = 78;
        [_myTableView reloadData];
    };
    [self.navigationController pushViewController:adress animated:YES];
    
}


-(void)discussContractButtonClicked
{
    NSString *HidenVip = Userdefault(HidenCatagoryVip);
    if (HidenVip.integerValue==0) {
        
        return;
    }

    //
    NSArray *array = @[@{@"ProductId":self.supermodel.ProductId,@"ProductNumber":@"1"}];
    
    NSDictionary * dic = @{@"GoodsSeriesCode":self.supermodel.GoodsSeriesCode,
                           @"ProductIds":array,
                           @"GoodsNumber":self.infomodel.SetNum,
                           @"IsInvoice":self.supermodel.IsInvoice,
                           @"StoreId":self.supermodel.StoreId,
                           @"SuperGroupDetailId":self.infomodel.SuperGroupDetailId};


    NSString *adressStr = self.adressModel?[self.adressModel mj_JSONString]:@"";

    [[YHJsonRequest shared] getAppSuperGroupSubmitWithparams:@{@"SuperGroupDetailId":self.infomodel.SuperGroupDetailId} SuccessBlock:^(NSString *success) {
        [[YHJsonRequest shared] addShoppinCartWithParams:dic SuccessBlock:^(NSString *successMessage){
            NSMutableArray *paramsdicArr = [NSMutableArray array];
            NSDictionary * paramsDic=@{@"OrderNos":@[successMessage],@"IsInvoice":self.supermodel.IsInvoice,@"InsurdAmount":@"0",@"StoreId":self.supermodel.StoreId,@"Address":adressStr,@"SuperGroupDetailId":self.infomodel.SuperGroupDetailId,@"CategoryBId":self.supermodel.CategoryBId};
            [paramsdicArr addObject:paramsDic];
            NSDictionary * dic =@{@"MakeOrders":paramsdicArr};
            
            [[YHJsonRequest shared] makeShoppingCartOderParams:dic SuccessBlock:^(NSArray *successMessage) {
                
                //        YHSuperGroupConfirmOrderViewController *weakSelf = self;
                YHPayViewController *vc = [[YHPayViewController alloc] init];
                vc.isHidenTopTitle = false;
                vc.payOrderMoney = self.supermodel.FrontMoney;
                vc.payParams = @{@"PayClass":@"2",@"Params":@{@"OrderNo":successMessage.firstObject[@"OrderNo"]}};//"TotalAmount":@"0.01",
                vc.OrderNo = successMessage.firstObject[@"OrderNo"];
                vc.recordIndex = self.recordIdex;
                [self.navigationController pushViewController:vc animated:YES];
                
            } fialureBlock:^(NSString *errorMessages) {
                
                [self.view hideWait:CurrentView];
                [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
                
            }];
            
        } fialureBlock:^(NSString *errorMessages){
            [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
        }];
        
    } fialureBlock:^(NSString *errorMessages) {
        if ([errorMessages containsString:@"-1"]) {
     NSString *tips =  [errorMessages stringByReplacingOccurrencesOfString:@"-1" withString:@""];
            YHAlertView *alert =  [[YHAlertView alloc] initWithDelegete:self  bottomTitle:tips ButtonTitle:@"确定"];
            [alert showAnimated];
            
        } else {
            [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        }
    }];

    
    
    
}



#pragma mark - 倒计时计数

- (void)activeCountDownAction {
    
    //    [Tools getHaveNum:11];
    // 1.计算截止时间与当前时间差值
    NSArray *timeArr= [self.infomodel.Hour componentsSeparatedByString:@":"];
    NSString *timeH = timeArr[0];
    NSString *timeM = timeArr[1];
    NSString *timeS = timeArr[2];
    // 计算时间差值
    NSInteger secondsCountDown =self.infomodel.Day.integerValue*24*3600+timeH.integerValue*3600+timeM.integerValue*60+timeS.integerValue;
    
    // 2.使用GCD来实现倒计时 用GCD这个写有一个好处，跳页不会清零 跳页清零会出现倒计时错误的
    __weak __typeof(self) weakSelf = self;
    
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"还剩 00:00:00 结束"];
                        [att addAttribute:NSForegroundColorAttributeName
                                    value:ColorWithHexString(@"F8695D")
                                    range:NSMakeRange(3, 8)];//                        NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:@"0" time:@"00:00:00" isShowSecond:YES];
                        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                        YHSuperGroupConfirmOrderInfoTableViewCell *cell =(YHSuperGroupConfirmOrderInfoTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                        
                        cell.endDate.attributedText = att;
//                        weakSelf.lableDateEnd.attributedText = att;
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        if (days == 0) {
                            NSString *str =[NSString stringWithFormat:@"还剩 %02ld : %02ld : %02ld 结束",hours, minute, second];
                            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
                            [att addAttribute:NSForegroundColorAttributeName
                                        value:ColorWithHexString(@"F8695D")
                                        range:NSMakeRange(3, 13)];
                            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                            YHSuperGroupConfirmOrderInfoTableViewCell *cell =(YHSuperGroupConfirmOrderInfoTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                            cell.endDate.attributedText = att;
                        } else {
                            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                            YHSuperGroupConfirmOrderInfoTableViewCell *cell =(YHSuperGroupConfirmOrderInfoTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                            NSString *str =[NSString stringWithFormat:@"还剩 %02ld天 %02ld : %02ld : %02ld 结束",days,hours, minute, second];
                            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
                            [att addAttribute:NSForegroundColorAttributeName
                                        value:ColorWithHexString(@"F8695D")
                                        range:NSMakeRange(3, 17)];
                            cell.endDate.attributedText = att;
                        }
                        
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
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
