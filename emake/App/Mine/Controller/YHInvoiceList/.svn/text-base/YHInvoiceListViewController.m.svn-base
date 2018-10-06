//
//  YHInvoiceListViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHInvoiceListViewController.h"
#import "YHInvoiceListCell.h"
#import "YHInvoiceListDeatialViewController.h"
#import "YHInvoiceListModel.h"
@interface YHInvoiceListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIView *emptyView;
    UITableView *table;

}
@property (nonatomic,retain)NSMutableArray *listArr;
@end

@implementation YHInvoiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"开票记录";
    [self addRigthDetailButtonIsShowCart:false];
    self.view.backgroundColor = TextColor_F5F5F5;
//    [self configTopView];
    [self congfigSubViews];
    [self getInvoiceList];
}
- (void)getInvoiceList{
  

    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared]applyInvoiceListsucess:^(NSArray<YHInvoiceListModel *> *shoppingCartArray) {
        
            [self.view hideWait:CurrentView];
            if ([self.view.subviews containsObject:emptyView]) {
                [emptyView removeFromSuperview];
            }
            self.listArr = [NSMutableArray arrayWithArray:shoppingCartArray];
            if (self.listArr.count == 0) {
                [table removeFromSuperview];
                [self addEmptyView];
            }else
            {
                [table reloadData];

            }
       
    } fialureBlock:^(NSString *errorMessages) {
            [self.view hideWait:CurrentView];
            [table removeFromSuperview];
            [self addEmptyView];
            [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
- (void)configTopView{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(99))];
    backView.backgroundColor = TextColor_242324;
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(99));
    }];
    
    UIImageView *headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
    NSString *headURL = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_HeadImageURLString];
    [headImage sd_setImageWithURL:[NSURL URLWithString:headURL] placeholderImage:[UIImage imageNamed:@"login_logo"]];
    headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    headImage.layer.borderWidth = 2;
    headImage.layer.cornerRadius = WidthRate(28);
    headImage.contentMode = UIViewContentModeScaleAspectFill;
    headImage.clipsToBounds = YES;
    [backView addSubview:headImage];
    
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(30));
        make.width.mas_equalTo(WidthRate(56));
        make.height.mas_equalTo(WidthRate(56));
        make.centerY.mas_equalTo(backView.mas_centerY);
    }];
    
    
    UILabel *name = [[UILabel alloc]init];
    name.textColor = [UIColor whiteColor];
    name.font = SYSTEM_FONT(AdaptFont(16));
    NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];
    if (nickName.length>0) {
        name.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];
    }else{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
            name.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        }else{
            name.text = @"未登录";
        }
    }
    [backView addSubview:name];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImage.mas_right).offset(WidthRate(13));
        make.height.mas_equalTo(HeightRate(40));
        make.centerY.mas_equalTo(backView.mas_centerY);

    }];
}
- (void)congfigSubViews{
    
    table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.backgroundColor =[UIColor clearColor];
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.estimatedSectionFooterHeight=0;
    table.estimatedSectionHeaderHeight=0;
    [self.view addSubview:table];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(HeightRate(0)+(TOP_BAR_HEIGHT));
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)addEmptyView{
    
    emptyView = [[UIView alloc]init];
    emptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:emptyView];
    
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(HeightRate(0)+(TOP_BAR_HEIGHT));
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *emptyImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fapiaoxinxi_wu"]];
    [emptyView addSubview:emptyImage];
    
    [emptyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(125));
        make.width.mas_equalTo(WidthRate(102));
        make.height.mas_equalTo(WidthRate(102));
        make.centerX.mas_equalTo(emptyView.mas_centerX);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.text =@"亲，您还没有开票信息哦～";
    lab.font = SYSTEM_FONT(AdaptFont(14));
    [emptyView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(emptyImage.mas_bottom).offset(HeightRate(31));
        make.height.mas_equalTo(WidthRate(25));
        make.centerX.mas_equalTo(emptyView.mas_centerX);
    }];
}
- (void)goDetailVC:(UIButton *)sender{
    
    YHInvoiceListDeatialViewController *vc = [[YHInvoiceListDeatialViewController alloc]init];
    vc.type = 0;
    vc.model = self.listArr[sender.tag - 100];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ----UITableViewDelegate&UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHInvoiceListCell *cell = nil;
    if (!cell) {
        cell = [[YHInvoiceListCell alloc]init];
        [cell.detailBtn addTarget:self action:@selector(goDetailVC:) forControlEvents:UIControlEventTouchUpInside];
        cell.detailBtn.tag = 100 +indexPath.section;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        YHInvoiceListModel *model = self.listArr[indexPath.section];
        [cell setData:model];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return TableViewHeaderNone;
    }else{
        return HeightRate(7);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHInvoiceListModel *model = self.listArr[indexPath.section];
    if ([model.InvoiceState isEqualToString:@"1"] ||[model.InvoiceState isEqualToString:@"2"] ) {
        return HeightRate(204);
    }else{
        return HeightRate(160);
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
