//
//  YHAdressViewController.m
//  emake
//
//  Created by eMake on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHAdressViewController.h"
#import "YHNewAdresssViewController.h"
#import "adressModel.h"
#import "adressTableViewCell.h"
@interface YHAdressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *imageview;

}
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)adressModel *adressModel;
@property(nonatomic,strong)NSMutableArray* adressModelArr;
@property(nonatomic,strong)UIView* EmptyView;


@property(nonatomic,strong)UITableView *tableview;

@end

@implementation YHAdressViewController


-(UITableView *)tableview
{
    if (_tableview == nil) {
        
        _tableview= [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, (ScreenHeight)-(TOP_BAR_HEIGHT)-HeightRate(80))];
        
    }

    return _tableview;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

//    __block YHAdressViewController *weakSelf = self;
    [[YHJsonRequest shared] getUserAdressType:@"0" SuccessBlock:^(NSArray *successMessage) {

        self.adressModelArr = [NSMutableArray arrayWithArray:successMessage];
        [self ConfigTableViewAndBottomButton];

        if (successMessage.count>0) {
            
           
            [self.tableview reloadData];
            [self.EmptyView removeFromSuperview];
            
        }else
        {
            
            [self configEmptyView];
            [self.tableview removeFromSuperview];
            
        }

        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =_IsBackAdress==YES?@"选择收获地址":@"管理收货地址";
    if (self.IsBackAdress == YES) {
        
        [self setRightBtnTitle:@"管理"];
    }else
    {
        [self addRigthDetailButtonIsShowCart:false];
    }
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    
    
}

-(void)address:(UIButton *)button
{
    YHNewAdresssViewController *addres = [[YHNewAdresssViewController alloc] init];
//    addres.adressTitle = button.currentTitle;
    addres.title = @"新增新地址";
    
    [self.navigationController pushViewController:addres animated:YES];

}
-(void)ConfigTableViewAndBottomButton
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.rowHeight = 90;
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableview];
    
    UIButton * addButton  = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitleColor:ColorWithHexString(@"FFFFFF") forState:UIControlStateNormal];
    addButton.backgroundColor = ColorWithHexString(StandardBlueColor);
    addButton.layer.cornerRadius = 6;
    addButton.clipsToBounds = YES;
    [addButton setTitle:@"新增地址" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(address:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(HeightRate(-20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(40));
        
        
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adressModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cell";
    // 从重用队列里查找可重用的cell
    adressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    // 判断如果没有可以重用的cell，创建
    if (!cell) {
        cell = [[adressTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    adressModel *adressModel = self.adressModelArr[indexPath.row];
    
    cell.nameLable.text = adressModel.UserName;
    cell.phoneLable.text = adressModel.MobileNumber;
    cell.detailAddresLable.text = [NSString stringWithFormat:@"%@%@%@%@%@",adressModel.Province,adressModel.City,adressModel.County,adressModel.District,adressModel.Address];;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.IsBackAdress ==false) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    adressModel *model = self.adressModelArr[indexPath.row];
    if (self.IsBackAdress==YES) {
        self.block(model);
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        YHNewAdresssViewController *newva = [[YHNewAdresssViewController alloc]init];
        newva.model = model;
        newva.title = @"编辑地址";
        [self.navigationController pushViewController:newva animated:YES];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController*alert = [UIAlertController
                                   alertControllerWithTitle:nil
                                   message: @"确认删除该地址吗？"
                                   preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction
                          actionWithTitle:@"取消"
                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              
                              
                          }]];
        [alert addAction:[UIAlertAction
                          actionWithTitle:@"确定"
                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                          {
                              adressModel *adressModel = self.adressModelArr[indexPath.row];
                              [[YHJsonRequest shared] deleteUserAdressParams:@{@"RefNo":adressModel.RefNo,@"AddressType":@"0"} SuccessBlock:^(NSString *successMessage) {
                                  [self.adressModelArr removeObjectAtIndex:indexPath.row];
                                  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

                                  if (self.adressModelArr.count>0) {
                                      
                                  }else
                                  {
                                      [_tableview removeFromSuperview];
                                      [self configEmptyView];
                                  }
                                  //弹出提示框
                                  [self.view makeToast:successMessage duration:1 position:CSToastPositionCenter];
                                  
                              } fialureBlock:^(NSString *errorMessages) {
                                  
                                  [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
                                  
                                  
                              }];
                              
                          }]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}


- (void)configEmptyView{
    self.EmptyView = [[UIView alloc]init];
    self.EmptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.EmptyView];
    
    [self.EmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(-80);
    }];
    
    
    UIImageView *emptyImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"queyimianpeitu"]];
    emptyImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.EmptyView addSubview:emptyImage];
    
    [emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.EmptyView.mas_centerX);
        make.top.mas_equalTo(HeightRate(121));
        make.width.mas_equalTo(WidthRate(120));
        make.height.mas_equalTo(HeightRate(120));
    }];
    
    UILabel *labelText = [[UILabel alloc]init];
    labelText.text = @"亲，对不起，暂无数据";
    labelText.font = SYSTEM_FONT(AdaptFont(14));
    labelText.textColor = ColorWithHexString(@"999999");
    [self.EmptyView addSubview:labelText];
    
    
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.EmptyView.mas_centerX);
        make.top.mas_equalTo(emptyImage.mas_bottom).offset(HeightRate(10));
    }];
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
