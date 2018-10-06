 //
//  Mine.m
//  emake
//
//  Created by chenyi on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHMineViewController.h"
#import "YHSettingViewController.h"
#import "YHLoginViewController.h"
#import "YHPersonalFileViewController.h"
#import "YHOrderManageNewViewController.h"
#import "YHInvoiceListViewController.h"
#import "YHCertificationStateOriginalViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHMainMessageCenterViewController.h"
#import "YHCommonWebViewController.h"
#import "YHSixTeamViewController.h"
#import "YHMyAccountViewController.h"
#import "YHOrderInvoiceInfoViewController.h"
#import "YHAdressViewController.h"
#import "YHLoginViewController.h"
#import "YHMineFirstRowTableViewCell.h"
#import "YHMinwCollectionViewController.h"
#import "YHShareView.h"
#import "YHNewAuditViewController.h"
#import "YHNoneTeamViewController.h"
#import "YHMineSecondTableViewCell.h"
#import "YHMineThirdTableViewCell.h"
#import "YHMineCommonCell.h"
#import "ChatNewViewController.h"
#import "YHMineMemberAndCityDelegateTableViewCell.h"
#import "YHMineAccountAndMembersTableViewCell.h"
#import "YHMineMemberInterestViewController.h"
#import "YHMineCityDelegateViewController.h"
#import "YHSuperGroupViewController.h"
#import "YHMineCityDelegateSuccessViewController.h"
#import "YHMemberExperienceViewController.h"

@interface YHMineViewController () <UITableViewDataSource,UITableViewDelegate,YHFirsrRowDelegate,YHSecondRowDelegate>{
    
    UIView *headView;
    UIImageView *backImage;
    NSString *userType;
    NSDictionary *orderCountDic;
    UITapGestureRecognizer *gestureOrder;
    NSInteger recordeUsingText;
    NSInteger recordeAppShare;

    NSString *isCheck;
    NSString *auditFailReason;
    NSString *successsDate;
    UserInfoModel *model;
    BOOL isStore;
    UIImageView *MessageImageView;
    NSInteger messageCounts;

}
@end

@implementation YHMineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"我的";
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = TextColor_F5F5F5;
    orderCountDic = [NSDictionary dictionary];
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString *isStoreString = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
    isStore = [isStoreString isEqualToString:@"1"];
    userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    NSString *tocken = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_Access_Token];
    [self refreshMesssageCount];
    if (tocken.length>0) {
        [self getUserInfo];

    }else
    {
        model = nil;
        [self.myTableView reloadData];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)configUI{
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-(TOP_BAR_HEIGHT)) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.estimatedRowHeight = HeightRate(50);
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(-(StatusBarHEIGHT));
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)refreshMesssageCount
{
    NSDictionary *messageCountDic = [YHMQTTClient sharedClient].messageCountDic;
    messageCounts =[ messageCountDic[@"messageCount"] integerValue];
    [self.myTableView reloadData];
}
- (UIView *)getHeadView{
    
//    if (headView ==nil) {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, HeightRate(238))];
        headView.backgroundColor = [UIColor whiteColor];
        backImage = [[UIImageView alloc]initWithFrame:headView.frame];
        backImage.image = [UIImage imageNamed:@"wopeitu"];
        [headView addSubview:backImage];
        
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(238));
        }];
//    }
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectZero];
    image.layer.cornerRadius = WidthRate(32);
    image.layer.borderColor = TextColor_8AA1F2.CGColor;
    image.layer.borderWidth  =  WidthRate(5);
    image.alpha = 0.4;
    image.clipsToBounds = YES;
    [headView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        if (iOS11_Former) {
            make.top.mas_equalTo(HeightRate(31)+(StatusBarHEIGHT));
        }else{
           make.top.mas_equalTo(HeightRate(18)+(StatusBarHEIGHT));
        }
        make.width.mas_equalTo(WidthRate(64));
        make.height.mas_equalTo(WidthRate(64));
    }];
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    NSString *fileName = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_HeadImageURLString];
    [headImage sd_setImageWithURL:[NSURL URLWithString:fileName] placeholderImage:[UIImage imageNamed:@"login_logo"]];
    headImage.contentMode = UIViewContentModeScaleAspectFill;
    headImage.layer.cornerRadius = WidthRate(27.5);
    headImage.clipsToBounds = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goFilePersonalVC)];
    gesture.numberOfTapsRequired = 1;
    [headImage addGestureRecognizer:gesture];
    headImage.userInteractionEnabled=YES;
    [headView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(image.mas_centerX);
        make.centerY.mas_equalTo(image.mas_centerY);
        make.width.mas_equalTo(WidthRate(55));
        make.height.mas_equalTo(WidthRate(55));
    }];

    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectZero];
    labelName.font = [UIFont systemFontOfSize:18];
    NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];

    if (nickName.length>0) {
        labelName.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];
    }else{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
            labelName.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        }else{
            labelName.text = @"未登录";
        }
    }
    
    [headView addSubview:labelName];
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImage.mas_right).offset(10);
        if ([userType isEqualToString:@"1"]) {
            make.centerY.mas_equalTo(headImage.mas_centerY).offset(-HeightRate(13));
        }else{
            make.centerY.mas_equalTo(headImage.mas_centerY).offset(0);
        }
        make.height.mas_equalTo(HeightRate(25));
    }];
  
    UIButton *cityDelegateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cityDelegateButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(11)];
    [cityDelegateButton setTitle:@"城市代理商" forState:UIControlStateNormal];
    [cityDelegateButton setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
    cityDelegateButton.layer.borderWidth = 1;
    cityDelegateButton.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
    cityDelegateButton.clipsToBounds = YES;
    cityDelegateButton.layer.cornerRadius = HeightRate(10);
    [cityDelegateButton setImage:[UIImage imageNamed:@"dailishangbiaozhi"] forState:UIControlStateNormal];
    [headView addSubview:cityDelegateButton];
    [cityDelegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelName.mas_left).offset(WidthRate(0));
        make.width.mas_equalTo(WidthRate(80));
        make.height.mas_equalTo(HeightRate(20));
        make.top.mas_equalTo(labelName.mas_bottom).offset(HeightRate(5));
    }];
    
        UIButton *vipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        vipButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(11)];
        [vipButton setTitle:@"  会员" forState:UIControlStateNormal];
        [vipButton setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
        vipButton.layer.borderWidth = 1;
        vipButton.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
        vipButton.clipsToBounds = YES;
        vipButton.layer.cornerRadius = HeightRate(10);
        [vipButton setImage:[UIImage imageNamed:@"huiyuanbiaozhi"] forState:UIControlStateNormal];
        [headView addSubview:vipButton];
        [vipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cityDelegateButton.mas_right).offset(WidthRate(5));
            make.width.mas_equalTo(WidthRate(65));
            make.height.mas_equalTo(HeightRate(20));
            make.top.mas_equalTo(labelName.mas_bottom).offset(HeightRate(5));
        }];
    vipButton.hidden = model.UserIdentity.integerValue==0?YES:false;

    if (model.AgentState.integerValue != 1) {
        cityDelegateButton.hidden = YES;
        [cityDelegateButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(0.01));
            
        }];

    }
    

    
    
    UIImageView *settingImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    settingImageView.image = [UIImage imageNamed:@"wo-shezhi"];
    UITapGestureRecognizer *gestureAnother = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goSettingVC)];
    gesture.numberOfTapsRequired = 1;
    settingImageView.contentMode = UIViewContentModeScaleToFill;
    [settingImageView addGestureRecognizer:gestureAnother];
    settingImageView.userInteractionEnabled=YES;
    [headView addSubview:settingImageView];
    [settingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-18));
        make.height.mas_equalTo(WidthRate(35));
        make.width.mas_equalTo(WidthRate(35));
        make.centerY.mas_equalTo(headImage.mas_centerY);
    }];
    
//    if (MessageImageView==nil) {
        MessageImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        MessageImageView.image = [UIImage imageNamed:@"wo-xinxi"];
        UITapGestureRecognizer *gestureMessage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goMessgaeVC)];
        gestureMessage.numberOfTapsRequired = 1;
        [MessageImageView addGestureRecognizer:gestureMessage];
        MessageImageView.userInteractionEnabled=YES;
        [headView addSubview:MessageImageView];
        [MessageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(settingImageView.mas_left).offset(WidthRate(-8));
            make.height.mas_equalTo(WidthRate(35));
            make.width.mas_equalTo(WidthRate(35));
            make.centerY.mas_equalTo(headImage.mas_centerY);
        }];
    if (messageCounts>0) {
        if (messageCounts>99){
            messageCounts = 99;
        }
        [MessageImageView showBadgeWithStyle:WBadgeStyleNumber value:messageCounts animationType:WBadgeAnimTypeNone];
        MessageImageView.badgeCenterOffset = CGPointMake(WidthRate(30), HeightRate(5));
        
    }else{
        [MessageImageView clearBadge];
    }
//    }
   

    return  headView;
}
- (void)getUserInfo {
    [[YHJsonRequest shared] getUserInfoSuccessBlock:^(UserInfoModel *userInfo) {
        model = userInfo;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userInfo.HeadImageUrl forKey:LOGIN_HeadImageURLString];

        if ((!userInfo.NickName)||(userInfo.NickName.length<=0) ){
            [userDefaults setObject:nil forKey:LOGIN_USERNICKNAME];
        }else{
            [userDefaults setObject:userInfo.NickName forKey:LOGIN_USERNICKNAME];
        }
        [userDefaults synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:userInfo.RealName forKey:USERSCardName];
        [userDefaults setObject:userInfo.AuditRemark forKey:USERSTATEFailReason];
        [userDefaults setObject:userInfo.ApplyTime forKey:USERSTATECommitDate];
        [userDefaults setObject:userInfo.UserIdentity forKey:VipState];
        [userDefaults setObject:userInfo.AgentState forKey:LOGIN_USERCARDSTATE];
        [userDefaults setObject:userInfo.UserAccount[@"TotalCashIn"] forKey:DelegateMyMoney];
        [Tools SaveLocalVipstateWithCatagory:userInfo.IdentityCategorys];

        [[NSUserDefaults standardUserDefaults] setObject:userInfo.AuditRemark forKey:USERSTATEFailReason];
        [[NSUserDefaults standardUserDefaults] setObject:userInfo.EditWhen forKey:USERSTATECommitDate];
        [[NSUserDefaults standardUserDefaults] setObject:userInfo.IsCheck forKey:USERSISCHECK];

        isCheck = userInfo.IsCheck;
        auditFailReason = userInfo.AuditRemark;
        successsDate = userInfo.EditWhen;
//        [_myTableView setTableHeaderView:[self getHeadView]];
        [self.myTableView reloadData];
    } fialureBlock:^(NSString *errorMessages) {
//        [_myTableView setTableHeaderView:[self getHeadView]];
        
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        [self.myTableView reloadData];
    }];
}
#pragma mark -- UITableViewDelagte  &  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
        if (model.AgentState.integerValue ==1) {
            
            return 5;
        }else
        {
            return 4;
            
        }
    
  
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger rowCount = model.AgentState.integerValue==1?3:2;
    if (indexPath.row == 0) {
        YHMineMemberAndCityDelegateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMineMemberAndCityDelegateTableViewCell"];
        if (cell== nil) {
            cell = [[YHMineMemberAndCityDelegateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHMineMemberAndCityDelegateTableViewCell"];
        }
        NSString *Title = model.AgentState.integerValue==1?@"城市代理商权益":@"城市代理商申请";
        [cell.CityDelegateButton setTitle:Title forState:UIControlStateNormal];
        [cell.CityDelegateButton addTarget:self action:@selector(cityDelegateButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.MyMemberInterestButton addTarget:self action:@selector(MyMemberInterestButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }else  if (indexPath.row <= rowCount) {
        
        NSInteger index = model.AgentState.integerValue==1? indexPath.row:indexPath.row+1;
        if (index ==1) {
            YHMineAccountAndMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMineAccountAndMembersTableViewCell"];
            if (cell== nil) {
                cell = [[YHMineAccountAndMembersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHMineAccountAndMembersTableViewCell"];
            }
            cell.MyAccountMoneyLable.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum: model.TotalBonus.doubleValue]];
            cell.MemberNumbersLable.text = [NSString stringWithFormat:@"%@个",model.VipNum];
            [cell.myAccountButton addTarget:self action:@selector(GoMyAccount) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            YHMineFirstRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHMineFirstRowTableViewCell"];
            if (cell== nil) {
                cell = [[YHMineFirstRowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHMineFirstRowTableViewCell"];
            }
            cell.delegate = self;
            [cell setChangeNameAndImage:index-2];
            return cell;
        }
    }else{
        YHMineThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        if (cell==nil) {
            cell = [[YHMineThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }

        return cell;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
   
    return UITableViewAutomaticDimension;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [self getHeadView];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeightRate(238);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = model.AgentState.integerValue ==1?4:3;
    if (indexPath.row==index) {
        bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
        if(isvisitor == false)
        {
            return;
        }
        YHSuperGroupViewController *vc = [[YHSuperGroupViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isFromMine = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
        
}
#pragma mark - 滚动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = ScreenWidth; // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y; // 偏移的y值，还要考虑导航栏的64哦
    if (yOffset < 0) {//向下拉是负值，向上是正
        CGFloat totalOffset = HeightRate(238) + HeightRate(ABS(yOffset));
        CGFloat heigth = HeightRate(238);
        CGFloat f = totalOffset/heigth ;//缩放比例
        //拉伸后的图片的frame应该是同比例缩放。
        backImage.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);
    }
}
#pragma mark======Method
-(void)cityDelegateButtonClick
{
    [self getcertification];
}

-(void)MyMemberInterestButtonClick
{
    bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
    if(isvisitor == false)
    {
        return;
    }
    if (model.UserIdentity.integerValue ==3 ) {
        NSString *date ;
        if (model.IdentityCategorys.count>0) {
           date = model.IdentityCategorys.firstObject[@"EndAt"];
        }
        
        YHMemberExperienceViewController *vc = [[YHMemberExperienceViewController alloc] init];
        vc.hidesBottomBarWhenPushed =YES;
        vc.VipCount = model.VipCount;
        vc.VipDate = date;
        [self.navigationController pushViewController:vc animated:YES];

    }else
    {
        YHMineMemberInterestViewController *vc = [[YHMineMemberInterestViewController alloc] init];
        vc.hidesBottomBarWhenPushed =YES;
        vc.isExperienceVip = model.UserIdentity.integerValue ==0?false:YES;
        [self.navigationController pushViewController:vc animated:YES];
       
    }
 
}
-(void)nexttPageTeam{
    [MobClick event:@"MyTeam" label:@"我的团队"];
    if ([userType isEqualToString:@"0"]||[userType isEqualToString:@"3"]||[userType isEqualToString:@"4"]) {
        YHNoneTeamViewController *vc = [[YHNoneTeamViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        YHSixTeamViewController *vc = [[YHSixTeamViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)loginVC{
    YHLoginViewController *loginVC = [[YHLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:^{
            
    }];
}

-(void)goSettingVC{
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];

    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    YHSettingViewController *vc = [[YHSettingViewController alloc] init];
    vc.titleStr = @"设置";
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)goMessgaeVC {
    
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    YHMainMessageCenterViewController *vc = [[YHMainMessageCenterViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (void)goFilePersonalVC{
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:Is_Login]) {
        [MobClick event:@"Personal" label:@"个人中心"];
        YHPersonalFileViewController *vc = [[YHPersonalFileViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        [self loginVC];
    }
}
//　实名认证
-(void)getcertification{
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    NSString *state =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERCARDSTATE];
    if ([state isEqualToString:@"0"]) {//审核zhong
        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
//        vc.failReason = auditFailReason;
        vc.successDate = model.ApplyTime;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([state isEqualToString:@"2"]) {//审核失败
        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
        vc.failReason = auditFailReason;
//        vc.successDate = successsDate;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([state isEqualToString:@"1"]) {
        if (![model.IsCheck isEqualToString:@"1"] ) {
            YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            YHMineCityDelegateSuccessViewController *vc =[[YHMineCityDelegateSuccessViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }else if ([state isEqualToString:@"-1"]) {
        YHMineCityDelegateViewController *vc = [[YHMineCityDelegateViewController alloc] init];
        vc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)goInvoiceVC
{
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    YHOrderInvoiceInfoViewController *vc = [[YHOrderInvoiceInfoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)goShareApp
{
    [MobClick event:@"AppShare" label:@"分享"];
    
    YHShareView *share = [[YHShareView alloc] initShareWithContentTitle:@"易智造" theOtherTitle:@"为帮助行业用户提高制造效率、降低制造成本，易虎网科技南京有限公司推出官方移动APP——易智造，致力于以“AI+大数据”为核心打造制造业智能生态。采用用户订货，易智造补贴工厂利润的方式，开启类似滴滴补贴的商业模式，为生产和经销环节创造更多利润。" image:nil url:ShareDownloURL withCancleTitle:@"取消"];
    [share showAnimated];

}
-(void)goUserIntroductionVC
{
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"使用说明";
    vc.time = WebTypeUserInstructions;
    vc.URLString = UserInstructionURL;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void )goUserAddressVC
{
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    [MobClick event:@"MyAddress" label:@"我的地址"];
    YHAdressViewController *adress = [[YHAdressViewController alloc] init];
    adress.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adress animated:YES];
}
-(void)goUserCollection
{
    [MobClick event:@"MyCollections" label:@"我的收藏"];
    YHMinwCollectionViewController *vc=[[YHMinwCollectionViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)GoMyAccount
{
    bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
    if(isvisitor == false)
    {
        return;
    }
    YHMyAccountViewController *vc=[[YHMyAccountViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark--yhFirstRow delegate
-(void)YHFirsrRowView:(UIView *)item index:(NSInteger)index{//index=1,2,3
  
    switch (index) {
        case 1:{
            bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
            if(isvisitor == false)
            {
                return;
            }
            [self goUserCollection];

            
            
        }
            break;
        case 2:{
            
            bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
            if(isvisitor == false)
            {
                return;
            }
            [self goUserAddressVC];
        }
            break;
        case 3:{
            
            bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
            if(isvisitor == false)
            {
                return;
            }
            [self goInvoiceVC];
        }
            break;
        case 4:{
            
            bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
            if(isvisitor == false)
             {
                return;
            }
            [self goShareApp];
        }
            break;
        case 5:{
            
            bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
            if(isvisitor == false)
            {
                return;
            }
            [self goUserIntroductionVC];
        }
            break;
        case 6:{
            bool isvisitor = [self isVisitorLoginByPhoneNumberExits];
            if(isvisitor == false)
            {
                return;
            }
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
            ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
            vc.listID = userID;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark--YHSecondRowView delegate
-(void)YHSecondRowView:(UIView *)item index:(NSInteger)index{
    switch (index) {
        case 1:{
            
            [self goUserAddressVC];
        }
            break;
        case 2:{
            [self goInvoiceVC];
            
        }
            break;
        case 3:{
            [self goShareApp];
        }
            break;
        case 4:{
            [self goUserIntroductionVC];
        }
            break;
        default:
            break;
    }
}


@end