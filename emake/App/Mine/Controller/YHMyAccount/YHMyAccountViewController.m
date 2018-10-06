//
//  YHMyAccountViewController.m
//  emake
//
//  Created by 谷伟 on 2018/1/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMyAccountViewController.h"
#import "YHMyAccountHeaderCell.h"
#import "YHWithDrawListCell.h"
#import "YHWithDrawMoreCell.h"
#import "YHWithDrawInputCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "YHWithDrawListViewController.h"
#import "YHSelectBankViewController.h"
#import "YHBankModel.h"
#import "YHBankSelectCell.h"
#import "YHMineMemberIInterestIncomeViewController.h"
#import "YHCommonWebViewController.h"
@interface YHMyAccountViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,retain)TPKeyboardAvoidingTableView *table;
@property (nonatomic,retain)NSMutableArray *depositList;
@property (nonatomic,retain)NSNumber *totalMoney;
@property (nonatomic,retain)YHBankModel *bankModel;
@property (nonatomic,retain)NSMutableArray *bankList;
@end

@implementation YHMyAccountViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getBankList];
    [MobClick event:@"MyAccount" label:@"我的账号"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    self.title = @"我的账户";
    [self addRigthDetailButtonIsShowCart:false];
    [self configSubViews];
    [self getData];
    [self addRightNavBtn:@"提现规则" showColor:StandardBlueColor];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSelectBank:) name:NotificatonBankSelected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reSettingSelectBank:) name:NotificatonBankDelete object:nil];
}

-(void)rightBtnClick:(UIButton *)sender
{
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"提现规则";
    vc.URLString = UserWithDrawRulerURL;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showSelectBank:(NSNotification *)notice{
    if (notice.object){
        self.bankModel = (YHBankModel *)notice.object;
        [self.table reloadData];
    }
}
- (void)reSettingSelectBank:(NSNotification *)notice{
    NSArray *list = (NSArray *)notice.object;
    if (list.count<=0) {
        self.bankModel = nil;
    }else{
        for (YHBankModel *model in list) {
            if ([model.CardState isEqualToString:@"1"]){
                self.bankModel = model;
                break;
            }else{
                self.bankModel = [self.bankList objectAtIndex:0];
            }
        }
    }
    [self.table reloadData];
}
- (void)configSubViews{
    self.table = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor clearColor];
    self.table.estimatedSectionFooterHeight = 0;
    self.table.estimatedSectionHeaderHeight = 0;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.showsVerticalScrollIndicator = false;
    [self.view addSubview:self.table];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(0);
    }];
    
}
- (void)getBankList{
    
    self.bankList = [NSMutableArray arrayWithCapacity:0];
    [[YHJsonRequest shared] getUserBankCardSuccessBlock:^(NSArray *successMessage) {
        [self.view hideWait:CurrentView];
        self.bankList = [NSMutableArray arrayWithArray:successMessage];
        if (self.bankList.count<=0) {
            self.bankModel = nil;
        }else{
            if (self.bankModel) {
                return ;
            }else{
                for (YHBankModel *model in self.bankList) {
                    if ([model.CardState isEqualToString:@"1"]){
                        self.bankModel = model;
                        break;
                    }else{
                        self.bankModel = [self.bankList objectAtIndex:0];
                    }
                }
            }
        }
        [self.table reloadData];
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
    }];
}
- (void)getData{
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getUserAccountInfoSuccessBlock:^(NSDictionary *successMessage) {
        if ([successMessage objectForKey:@"TotalBonus"]) {

            self.totalMoney = [successMessage objectForKey:@"TotalBonus"];
            [self.table reloadData];
        }
        [self.view hideWait:CurrentView];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
- (void)withDraw{
    if (!self.bankModel) {
        [self.view makeToast:@"请添加要提现的银行卡" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    YHWithDrawInputCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if (!cell.inputAmount.text||cell.inputAmount.text.length<=0){
        [self.view makeToast:@"请输入提现金额" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([cell.inputAmount.text doubleValue]<=0){
        [self.view makeToast:@"提现金额不能小于等于0" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([cell.inputAmount.text doubleValue]>[self.totalMoney doubleValue]){
        [self.view makeToast:@"提现金额不能超过总额" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    [self.view showWait:@"加载中" viewType:CurrentView];
    
    NSDictionary *parameter = @{@"Money":[NSNumber numberWithDouble:[cell.inputAmount.text doubleValue]],@"CardId":self.bankModel.CardId};
    [[YHJsonRequest shared] depositMoney:parameter SuccessBlock:^(NSString *successMessage) {
        [self.view makeToast:@"提现申请已提交" duration:1.0 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];
        [self getData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
- (void)depositAll{
    
    [self.view endEditing:YES];
    YHWithDrawInputCell *cell = [self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.inputAmount.text = [NSString stringWithFormat:@"%.2f",[self.totalMoney doubleValue]];
}
- (void)goSelectBankVC{
    
    YHSelectBankViewController *vc = [[YHSelectBankViewController alloc]init];
    if (self.bankModel) {
        vc.selectModel = self.bankModel;
    }else{
        if (self.bankList.count<=0) {
            vc.selectModel = nil;
        }else{
            for (YHBankModel *model in self.bankList) {
                if ([model.CardState isEqualToString:@"1"]){
                    vc.selectModel = model;
                    break;
                }else{
                    vc.selectModel = [self.bankList objectAtIndex:0];
                }
            }
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goWithDrawVC{
    YHWithDrawListViewController *vc = [[YHWithDrawListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goWithIncomeVC{
    
    YHMineMemberIInterestIncomeViewController *vc = [[YHMineMemberIInterestIncomeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YHMyAccountHeaderCell *cell = nil;
        if (!cell) {
            cell = [[YHMyAccountHeaderCell alloc]init];
        }
        cell.totalMoney.text = [NSString stringWithFormat:@"%.2f",[self.totalMoney doubleValue]];
        [cell.selectBank addTarget:self action:@selector(goSelectBankVC) forControlEvents:UIControlEventTouchUpInside];
        [cell.withDrawDetailButton addTarget:self action:@selector(goWithDrawVC) forControlEvents:UIControlEventTouchUpInside];
        [cell.IncomeDetailButton addTarget:self action:@selector(goWithIncomeVC) forControlEvents:UIControlEventTouchUpInside];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.bankModel){
            [cell setData:self.bankModel];
            [cell.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(HeightRate(70*(indexPath.row+1)));
            }];

        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            YHWithDrawInputCell *cell  = nil;
            if (!cell) {
                cell = [[YHWithDrawInputCell alloc]init];
            }
            cell.depositAmout.text = [NSString stringWithFormat:@"可提现金额%.2f元",[self.totalMoney doubleValue]];
            [cell.depositAll addTarget:self action:@selector(depositAll) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = nil;
            if (!cell) {
                cell = [[UITableViewCell alloc]init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
            }
            UIButton *withDrawbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [withDrawbtn setTitle:@"提现" forState:UIControlStateNormal];
            withDrawbtn.layer.cornerRadius = WidthRate(3);
            withDrawbtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
            [withDrawbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            withDrawbtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(18)];
            [withDrawbtn addTarget:self action:@selector(withDraw) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:withDrawbtn];
            
            
            [withDrawbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(cell.contentView.mas_centerX);
                make.width.mas_equalTo(WidthRate(322));
                make.height.mas_equalTo(HeightRate(45));
                make.top.mas_equalTo(HeightRate(17));
            }];
            
            UILabel *labelTips = [[UILabel alloc]init];
            labelTips.textColor = TextColor_999999;
            labelTips.font = SYSTEM_FONT(AdaptFont(13));
            labelTips.text = @"友情提醒：提现T(today)+3个工作日到账（节假日顺延）";
            [cell.contentView addSubview:labelTips];
            
            [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(WidthRate(28));
                make.right.mas_equalTo(WidthRate(-10));
                make.top.mas_equalTo(withDrawbtn.mas_bottom).offset(HeightRate(17));
            }];
            
            return cell;
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        if (self.bankModel){
//            return HeightRate(215);
//        }else{
//            return HeightRate(191);
//        }
        return UITableViewAutomaticDimension;
    }else{
        if (indexPath.row == 0) {
            return HeightRate(199);
        }else{
            return HeightRate(228);
        }
        
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = TextColor_F7F7F7;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return TableViewHeaderNone;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0){
        return HeightRate(10);
    }else{
        return TableViewFooterNone;
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
