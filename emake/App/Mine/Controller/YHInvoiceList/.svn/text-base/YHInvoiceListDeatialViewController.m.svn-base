//
//  YHInvoiceListDeatialViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHInvoiceListDeatialViewController.h"

@interface YHInvoiceListDeatialViewController ()
@property (nonatomic,retain)UILabel *orderNum;
@property (nonatomic,retain)UILabel *OrderTime;
@property (nonatomic,retain)UILabel *applyCommpany;
@property (nonatomic,retain)UILabel *series;
@property (nonatomic,retain)UILabel *fee;
@property (nonatomic,retain)UILabel *fee1;

@end
@implementation YHInvoiceListDeatialViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开票记录";
    self.view.backgroundColor = ColorWithHexString(@"ffffff");
    [self configSubViews];
}
- (void)configSubViews{
    
    UILabel *headerlabel = [[UILabel alloc]init];
    headerlabel.text =@"  订单明细";
    headerlabel.font = SYSTEM_FONT(AdaptFont(13));
    headerlabel.backgroundColor =TextColor_F7F7F7;
    [self.view addSubview:headerlabel];
    
    [headerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(headerlabel.mas_bottom);
    }];
    
    self.orderNum =[[UILabel alloc]init];
    if (self.type == 0) {
        self.orderNum.text = [NSString stringWithFormat:@"合同号：%@",self.model.ContractNo];
        
    }else{
        self.orderNum.text = @"订单号：201706230001";
    }
    self.orderNum.font = SYSTEM_FONT(AdaptFont(12));
    self.orderNum.textColor = TextColor_636263;
    self.orderNum.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.orderNum];
    
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(HeightRate(10));
    }];
    
    self.OrderTime =[[UILabel alloc]init];
    if (self.model.Goods.count>0) {
        self.OrderTime.text = [NSString stringWithFormat:@"订单时间：%@",[self.model.Goods[0] objectForKey:@"InDate"]];
    }
    self.OrderTime.font = SYSTEM_FONT(AdaptFont(12));
    self.OrderTime.textColor = TextColor_636263;
    self.OrderTime.textAlignment = NSTextAlignmentLeft;
    
    [view addSubview:self.OrderTime];
    
    [self.OrderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.height.mas_equalTo(HeightRate(24));
        make.top.mas_equalTo(self.orderNum.mas_bottom).offset(HeightRate(5));
    }];
    
    self.applyCommpany =[[UILabel alloc]init];
    if (self.type == 0) {
        if (self.model.Goods.count>0) {
            for (int i =0; i<self.model.Goods.count; i++) {
                if (i== 0) {
                    self.applyCommpany.text = [NSString stringWithFormat:@"%@",[self.model.Goods[i] objectForKey:@"GoodsName"]];
                }else{
                    self.applyCommpany.text = [NSString stringWithFormat:@"%@、%@",self.applyCommpany.text,[self.model.Goods[i] objectForKey:@"GoodsName"]];
                }
                
            }
        }
        self.applyCommpany.text =[NSString stringWithFormat:@"商品名称：%@",self.applyCommpany.text];
    }else{
        self.applyCommpany.text = @"申请单位：易虎网科技南京有限公司";
    }
    self.applyCommpany.font = SYSTEM_FONT(AdaptFont(12));
    self.applyCommpany.textColor = TextColor_636263;
    self.applyCommpany.textAlignment = NSTextAlignmentLeft;
    self.applyCommpany.numberOfLines = 0;
    [view addSubview:self.applyCommpany];
    
    [self.applyCommpany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(-WidthRate(10));
        make.top.mas_equalTo(self.OrderTime.mas_bottom).offset(HeightRate(5));
    }];
    
    self.series =[[UILabel alloc]init];
    if (self.type == 0) {
        if (self.model.Goods.count>0) {
            for (int i =0; i<self.model.Goods.count; i++) {
                if (i== 0) {
                    self.series.text = [NSString stringWithFormat:@"%@X%@",[self.model.Goods[i] objectForKey:@"GoodsName"] ,[self.model.Goods[i] objectForKey:@"GoodsNumber"]];
                }else{
                    self.series.text = [NSString stringWithFormat:@"%@、%@X%@",self.series.text ,[self.model.Goods[i] objectForKey:@"GoodsName"],[self.model.Goods[i] objectForKey:@"GoodsNumber"]];
                }
            }
            self.series.text =[NSString stringWithFormat:@"数量：%@",self.series.text];
    }
    }else{
        self.series.text = @"体系认证：环境管理体系认证证书";
    }
    self.series.font = SYSTEM_FONT(AdaptFont(12));
    self.series.textColor = TextColor_636263;
    self.series.textAlignment = NSTextAlignmentLeft;
    self.series.numberOfLines = 0;
    [view addSubview:self.series];
    
    [self.series mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(-WidthRate(10));
        make.top.mas_equalTo(self.applyCommpany.mas_bottom).offset(HeightRate(5));
    }];
    
    self.fee =[[UILabel alloc]init];
    if (self.type == 0) {
        self.fee.text = [NSString stringWithFormat:@"开票金额：%@元",[Tools getHaveNum:self.model.InvoiceAmount.doubleValue]];
    }else{
        self.fee.text = @"咨询费：100000元";
    }
    self.fee.font = SYSTEM_FONT(AdaptFont(12));
    self.fee.textColor = TextColor_636263;
    self.fee.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.fee];
    
    [self.fee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(self.series.mas_bottom).offset(HeightRate(5));
    }];

    self.fee1 =[[UILabel alloc]init];
    if (self.type == 0) {
        self.fee1.text = [NSString stringWithFormat:@"合同总金额：%@元",[Tools getHaveNum:self.model.TotalTaxPrice.doubleValue]];
    }else{
        self.fee1.text = @"咨询费：100000元";
    }
    self.fee1.font = SYSTEM_FONT(AdaptFont(12));
    self.fee1.textColor = TextColor_636263;
    self.fee1.textAlignment = NSTextAlignmentLeft;
    [view addSubview:self.fee1];
    
    [self.fee1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(self.fee.mas_bottom).offset(HeightRate(5));
        make.bottom.mas_equalTo(HeightRate(-10));
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
