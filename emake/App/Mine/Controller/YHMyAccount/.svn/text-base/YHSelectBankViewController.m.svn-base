//
//  YHSelectBankViewController.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSelectBankViewController.h"
#import "YHBankSelectCell.h"
#import "YHBankAddCell.h"
#import "YHAddBankCardViewController.h"
#import "YHBankModel.h"
@interface YHSelectBankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView *table;
@end

@implementation YHSelectBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    self.title = @"选择银行卡";
    [self addRigthDetailButtonIsShowCart:false];
    [self configSubViews];
    [self refreshBankList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBankList) name:NotificatonBankAddSuccess object:nil];
}
- (void)refreshBankList{
    self.bankList = [NSMutableArray arrayWithCapacity:0];
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getUserBankCardSuccessBlock:^(NSArray *successMessage){
        [self.view hideWait:CurrentView];
        self.bankList = [NSMutableArray arrayWithArray:successMessage];
        BOOL flag = false;
        if (self.bankList.count>0){
            if (self.selectModel){
                for (YHBankModel *model in self.bankList) {
                    if ([model.CardId isEqualToString:self.selectModel.CardId]) {
                        model.CardState = @"1";
                    }else{
                        model.CardState = @"0";
                    }
                }
            }else{
                for (YHBankModel *model in self.bankList) {
                    if ([model.CardState isEqualToString:@"1"]){
                        flag = true;
                        break;
                    }
                }
                if (flag == false) {
                    YHBankModel *model = self.bankList[0];
                    model.CardState = @"1";
                }
            }
        }
        [self.table reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
    }];
}
- (void)configSubViews{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.estimatedSectionFooterHeight = 0;
    self.table.estimatedSectionHeaderHeight = 0;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.showsVerticalScrollIndicator = false;
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.table];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(ScreenHeight-(TOP_BAR_HEIGHT));
    }];
}

#pragma mark --UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.bankList.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.bankList.count) {
        YHBankAddCell *cell = nil;
        if (!cell) {
            cell = [[YHBankAddCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        YHBankSelectCell *cell = nil;
        if (!cell) {
            cell = [[YHBankSelectCell alloc]init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YHBankModel *model = [self.bankList objectAtIndex:indexPath.row];
        [cell setData:model];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRate(75);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.bankList.count) {
        YHAddBankCardViewController *vc = [[YHAddBankCardViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        for (YHBankModel *model in self.bankList) {
            if ([self.bankList indexOfObject:model] == indexPath.row){
                model.CardState = @"1";
            }else{
                model.CardState = @"0";
            }
        }
        [self.table reloadData];
        [self.navigationController popViewControllerAnimated:YES];
        YHBankModel *model = [self.bankList objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonBankSelected object:model];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.bankList.count) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view showWait:@"请等待" viewType:CurrentView];
    YHBankModel *model = self.bankList[indexPath.row];
    [[YHJsonRequest shared] DeleteUserBankCard:model.CardId SuccessBlock:^(NSString *successMessage) {
        [self.view makeToast:successMessage duration:1.0 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];
        [self.bankList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonBankDelete object:self.bankList];
        [self refreshBankList];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];
    }];
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
