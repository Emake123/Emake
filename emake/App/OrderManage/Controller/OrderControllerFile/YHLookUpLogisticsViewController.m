//
//  YHLookUpLogisticsViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/19.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHLookUpLogisticsViewController.h"
#import "YHLogisticsDetailsCell.h"
#import "YHLogistics.h"
#import "YHOrderLogisticsCell.h"
@interface YHLookUpLogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)NSDictionary *logsticsInfo;
@property (nonatomic,retain)NSArray *logsticsArray;
@property (nonatomic,retain)UITableView *table;
@end

@implementation YHLookUpLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"物流详情";
    [self addRigthDetailButtonIsShowCart:false];
    self.view.backgroundColor  = TextColor_F5F5F5;
    self.logsticsArray = [NSMutableArray array];
    [self getLogisticsData];
    
    [self configSubviews];
}
- (void)getLogisticsData{
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getLogisticsInfomation:self.logsticsNumber Sucess:^(NSArray *successMessage) {
        [self.view hideWait:CurrentView];

        if (successMessage.count>0) {
           
            self.logsticsArray = successMessage;
            
            [self.table reloadData];
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
     
}
- (void)configSubviews{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)) style:UITableViewStyleGrouped];
//    self.table.backgroundColor = TextColor_F5F5F5;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHLogistics *model = self.logsticsArray[indexPath.section];

    if (indexPath.row==0) {
        
        YHOrderLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell =[[YHOrderLogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.logisticsIdLabel.text = [NSString stringWithFormat:@"运单号:%@",model.LogisticsBillNo]; ;
        cell.dateLabel.text =[NSString stringWithFormat:@"车牌号码:%@",model.ShippingPlate];
        cell.numberIdLabel.text =[NSString stringWithFormat:@"联系电话:%@",model.ShippingPhone];
        cell.logisticsButton.hidden = YES;
//        [cell.logisticsButton addTarget:self action:@selector(logisticsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else
    {
        
        YHLogisticsDetailsCell *cell = nil;
        if (!cell) {
            cell = [[YHLogisticsDetailsCell alloc]init];
            
            NSInteger rowCount =indexPath.row-1;
            
            NSDictionary *detail = model.Goods[rowCount];
            NSString *GoodsReName = [detail objectForKey:@"GoodsReName"];
            NSString *ShippingNumber = [NSString stringWithFormat:@"%@件",[detail objectForKey:@"ShippingNumber"]];
            [cell setLeftText:GoodsReName andRigthText:ShippingNumber];
            
            
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YHLogistics *model = self.logsticsArray[section];
    return model.Goods.count+1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.logsticsArray.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return HeightRate(70);
    }
    return HeightRate(45);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YHLogistics *model = self.logsticsArray[section];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, HeightRate(66))];
    view.backgroundColor = ColorWithHexString(@"F2F2F2");
    UILabel *lableName = [[UILabel alloc]init];
    if (model.ShippingDate.length>10) {
        lableName.text =[ model.ShippingDate substringToIndex:10];
    }else
    {
        lableName.text = model.ShippingDate ;

    }
   
    lableName.font = [UIFont systemFontOfSize:AdaptFont(15)];
    lableName.textColor = ColorWithHexString(@"999999");
    lableName.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:lableName];
    [lableName PSSetCenterHorizontalAtItem:view ];
    [lableName PSSetLeft:WidthRate(15)];
    
    UILabel *lablePrice = [[UILabel alloc]init];
    lablePrice.text =[NSString stringWithFormat:@"已发数量：%ld件",model.ShippingTotalNumber]; ;
    lablePrice.font = [UIFont systemFontOfSize:AdaptFont(15)];
    lablePrice.textColor = ColorWithHexString(@"666666");
    lablePrice.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:lablePrice];
    [lablePrice PSSetCenterHorizontalAtItem:view ];

    [lablePrice PSSetRight: WidthRate(10)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightRate(42);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
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
