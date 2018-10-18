//
//  YHProductStoreIntrocdutctionViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/30.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHProductStoreIntrocdutctionViewController.h"
#import "ChatNewViewController.h"
@interface YHProductStoreIntrocdutctionViewController ()

@end

@implementation YHProductStoreIntrocdutctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRigthDetailButtonIsShowCart:false];
    self.title = self.model.StoreName;
    UILabel* storechargeName = [[UILabel alloc] init];
    storechargeName.textColor = TextColor_333333;
   storechargeName.text = @"云工厂简介";
    storechargeName.font = SYSTEM_FONT(AdaptFont(13));
    [self.view addSubview:storechargeName];
    
    [storechargeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(13));
        make.right.mas_equalTo(WidthRate(-13));
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(30));

    }];
    
    UILabel *lineV = [[UILabel alloc] init];
    lineV.backgroundColor = SepratorLineColor;
    [self.view addSubview:lineV];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(storechargeName.mas_bottom).offset(HeightRate(10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(1));
    }];
    UILabel *storeIntroduction = [[UILabel alloc] init];
    storeIntroduction.textColor = TextColor_333333;
    storeIntroduction.numberOfLines = 0;
    storeIntroduction.font = SYSTEM_FONT(AdaptFont(12));
    [self.view addSubview:storeIntroduction];
    storeIntroduction.text = self.model.StoreSummary;
    
    [storeIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(WidthRate(-10));
        make.top.mas_equalTo(lineV.mas_bottom).offset(HeightRate(10));
    }];

    
    UIButton *serverStore = [UIButton buttonWithType:UIButtonTypeCustom];
    [serverStore setTitle:@"联系小二" forState:UIControlStateNormal];
    [serverStore setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    serverStore.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
    serverStore.layer.cornerRadius = 6;
    serverStore.clipsToBounds = YES;
    serverStore.backgroundColor = ColorWithHexString(StandardBlueColor);
    [serverStore addTarget:self action:@selector(goChatVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serverStore];
    
    [serverStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(32));
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(45));
        make.bottom.mas_equalTo(-10);
    }];
   
}
- (void)goChatVC{
    BOOL isVisit = [self isVisitorLoginByPhoneNumberExits];
    if (isVisit==false) {
        return;
    }
    
    //    NSString *storeID = dic[@"StoreId"];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:self.model.StoreId];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.listID = [NSString stringWithFormat:@"%@_%@",self.model.StoreId,userID];
    vc.storeID = self.model.StoreId;
    vc.isCatagory = !self.recordIndex;
    vc.storeName =self.model.StoreName;
    vc.storeAvata =self.model.StorePhoto;
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
