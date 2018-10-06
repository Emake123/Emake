
//
//  YHSixTeamViewController.m
//  emake
//
//  Created by 张士超 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSixTeamViewController.h"
#import "YHTeamProgressView.h"
#import "YHTeamTableViewCell.h"
#import "teamModel.h"
#import "YHUserContribution.h"
#import "YHTeamInviteViewController.h"
#import "YBPopupMenu.h"
#import "YHMissonCreatSuccessView.h"
#import "Tools.h"
#import "YHCommonWebViewController.h"
#import "YHMyAccountViewController.h"
#import "YHContributionsViewController.h"
#import "UIButton+Common.h"
@interface YHSixTeamViewController ()<UITableViewDelegate,UITableViewDataSource,YBPopupMenuDelegate>
{
    UITableView *table;
    NSString * userType ;
    UIView *emptyBgView;
    YHTeamProgressView *progress;
}
@property(nonatomic,strong)NSArray *progressArr;
@property(nonatomic,strong)NSMutableArray *listArr;
@property(nonatomic,retain)teamModel *model;

@property (nonatomic, strong) UIButton * informationCardBtn;
@end

@implementation YHSixTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self addRigthDetailButtonTeamIsShowCart:false];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    self.title =@"我的团队" ;//[userType isEqualToString:@"2"]?@"我的经销团队":@"我的分销团队";


    [self getControbutionData];

}
-(void)progressview:(teamModel *)teamModel
{
    [progress removeFromSuperview];
   progress = [[YHTeamProgressView alloc]init];
    UIView *view = [progress progressViewWithModel:teamModel];
    
    if ([userType isEqualToString:@"1"]  ) {
        progress.progressCustonmView.hidden = YES;
        [progress.progressCustonmView PSUpdateConstraintsHeight:HeightRate(10)];
    }else
    {
        
    }
    
    [progress.getMoneyView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCurrentMoney)] ];
    
    progress.personOrder.userInteractionEnabled  = YES;
  [progress.teamView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCurrentTeamOrder)] ];
    [progress.personView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCurrentMyOrder)] ];
//    [progress.personView addTarget:self action:@selector(goMyTeamActityRulerVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:view];
    [view PSSetLeft:0];
    [view PSSetTop:TOP_BAR_HEIGHT];
    [view PSSetWidth:ScreenWidth];
    
    table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.estimatedSectionFooterHeight = 0;
    table.estimatedSectionHeaderHeight =0;
    table.estimatedRowHeight = 150;
    table.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:table];
    table.translatesAutoresizingMaskIntoConstraints = NO;
    [table PSSetBottomAtItem:view Length:0];
    [table PSSetWidth:ScreenWidth];
    [table PSSetBottom:HeightRate(70)];
    
    UIButton *addMBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addMBtn.translatesAutoresizingMaskIntoConstraints = NO;
    addMBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
    [addMBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [addMBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
    [addMBtn addTarget:self action:@selector(addMemberIntoTeam) forControlEvents:UIControlEventTouchUpInside];
    addMBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
    addMBtn.layer.cornerRadius = 6;
    addMBtn.clipsToBounds = YES;
    [self.view addSubview:addMBtn];
    [addMBtn PSSetLeft:WidthRate(33)];
    [addMBtn PSSetSize:WidthRate(310) Height:HeightRate(40)];
    [addMBtn PSSetBottom:HeightRate(20)];
    
    
}
//提现
- (void)getCurrentMoney{

    YHMyAccountViewController *vc = [[YHMyAccountViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//个人详情
- (void)getCurrentMyOrder{
    YHContributionsViewController *vc = [[YHContributionsViewController alloc]init];
    vc.title = @"个人订单金额明细";
    vc.isTeam = false;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//团队详情
- (void)getCurrentTeamOrder{
    YHContributionsViewController *vc = [[YHContributionsViewController alloc]init];
    vc.title = @"团队订单金额明细";
    vc.isTeam = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)goMyTeamActityRulerVC{
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.time = WebTypeInsurancesInstructions;
    vc.titleName = @"团队提成规则";
    NSString * catagory = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    NSString *kind = [catagory isEqualToString:@"001-001"]?@"1":@"2";
    
    vc.URLString = [NSString stringWithFormat:@"%@/%@/%@",TeamActivtyInstructionURL,userType,kind];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)emptyViewWithNoneData
{
    [emptyBgView removeFromSuperview];
    UIView *emptyView = [[UIView alloc] init];
    [table addSubview:emptyView];
    emptyView.center = CGPointMake(table.centerX, HeightRate(180));
    emptyView.bounds =CGRectMake(0, 0, WidthRate(200), HeightRate(230));

    emptyBgView = emptyView;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizesSubviews = YES;
    imageView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;    imageView.image = [UIImage imageNamed:@"zanwupinpai"];
    [emptyView addSubview:imageView];
    [imageView PSSetConstraint:0 Right:0 Top:0 Bottom:HeightRate(20)];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    lable.text = @"还没有小伙伴贡献";
    lable.textAlignment = NSTextAlignmentCenter;
    [emptyView addSubview:lable];
    [lable PSSetBottomAtItem:imageView Length:0];
    [lable PSSetLeft:0];
    [lable PSSetRight:0];
    [lable PSSetHeight:HeightRate(20)];
    
    
}
-(void)getControbutionData
{
    [self.view showWait:@"加载中" viewType:CurrentView];


        [[YHJsonRequest shared] getUserTeamContribution:nil SuccessBlock:^(NSDictionary *successMessage) {
            if (successMessage.count>0) {
                self.model = successMessage[@"model"];
                self.listArr = [NSMutableArray arrayWithArray:self.model.memberArr];
                [self progressview:self.model];
                [table reloadData];
            }
            [self.view hideWait:CurrentView];

            
        } fialureBlock:^(NSString *errorMessages) {
            [self.view hideWait:CurrentView];
            [self.view makeToast:errorMessages];
        }];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightRate(41);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(41))];
    headView.backgroundColor =    ColorWithHexString(@"ffffff");
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(40))];
    
    lable.font = [UIFont systemFontOfSize:AdaptFont(15)];
    lable.textColor = ColorWithHexString(@"333333");
    [headView addSubview:lable];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [headView addSubview:button];
    lable.textAlignment = NSTextAlignmentCenter;
    [button setTitle:@"提成规则" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"placehold"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
//    [button setimageTopAndTitleDown];
    [button setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goMyTeamActityRulerVC) forControlEvents:UIControlEventTouchUpInside];
    //        [button setImage:[UIImage imageNamed:@"tianjiatuanyuan"] forState:UIControlStateNormal];
    [button PSSetRight:WidthRate(3)];
    [button PSSetCenterHorizontalAtItem:lable];
    [button PSSetSize:WidthRate(80) Height:HeightRate(30)];
//    if ([userType isEqualToString:@"2"]) {
//
//      lable.text = @"经销团队成员";
//
//    }else
//    {
//        lable.text = @"分销团队成员";
//
//    }
            lable.text = @"团队成员";

    UILabel *line = [[UILabel alloc] init];
    line.translatesAutoresizingMaskIntoConstraints =NO;
    line.backgroundColor = SepratorLineColor;
    [headView addSubview:line];
    
    [line PSSetLeft:0];
    [line PSSetSize:ScreenWidth Height:1];
    [line PSSetBottom:1];
    
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHUserContribution *model = self.listArr[indexPath.row];
    if ([userType isEqualToString:@"2"]) {//经销

    YHTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[YHTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString * buddyMoney ;
        buddyMoney = model.ContractAmount ;

        cell.leadImageView.hidden = YES;
        cell.rightImageView.hidden = YES;
        NSString *nameStr = [NSString stringWithFormat:@"%@ %@",model.RealName,model.BelongUsername];
        NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:nameStr];
        [attName addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(@"999999") range:NSMakeRange(model.RealName.length,nameStr.length- model.RealName.length)];
        cell.leadName.attributedText = attName;
//        cell.detailLable.text = [NSString stringWithFormat:@"%@",model.BelongUsername];
        [cell.leadImageView PSUpdateConstraintsWidth:WidthRate(0.01)];
        cell.leadImageView.image = [UIImage imageNamed:@"wode_renzheng"];
        [cell.contributeImageview PSUpdateConstraintsHeight:HeightRate(30)];
//        UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContribution)];
//        [cell.contributeImageview addGestureRecognizer:tap];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"tuanzhang"]];
        cell.contributeImageview.layer.cornerRadius = HeightRate(15);
        cell.contributeImageview.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
        cell.contributeImageview.backgroundColor = ColorWithHexString(@"ffffff");
        cell.calledLable.hidden = YES;
        cell.imageView.hidden = YES;
//    cell.leadName.text = model.RealName;
    cell.phoneLable.text = model.MobileNumber;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"tuanyuan-1"]];

    NSString *CommitMoneyStr = [Tools getNsstringFromDouble:buddyMoney.doubleValue isShowUNIT:YES];
        NSString *str1 =[NSString stringWithFormat:@"订单金额%@元",CommitMoneyStr];
    NSMutableAttributedString *addStr1  = [[NSMutableAttributedString alloc] initWithString:str1];
    [addStr1 addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"4DBECD")
                    range:NSMakeRange(4, CommitMoneyStr.length+1)];
    
    cell.contributedLable.attributedText = addStr1;

    return cell;
    }else
    {
        YHTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        if (!cell) {
            cell = [[YHTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        NSString *strtt;
        if ([model.UserType isEqualToString:@"3"] || [model.UserType isEqualToString:@"4"]) {
            NSString *str =model.BelongUsername.length>0? [NSString  stringWithFormat:@"(%@)",model.BelongUsername]:@"";
            strtt = [NSString stringWithFormat:@"%@ B端用户",str];
            [cell.contributeImageview PSUpdateConstraintsHeight:HeightRate(30)];
            
            cell.contributeImageview.layer.cornerRadius = HeightRate(15);
        }else
        {
            NSString *str =model.BelongUsername.length>0? [NSString  stringWithFormat:@"(%@)",model.BelongUsername]:@"";
            strtt = [NSString stringWithFormat:@"%@ 分销商",str];
            [cell.contributeImageview PSUpdateConstraintsHeight:HeightRate(54)];
            
            cell.contributeImageview.layer.cornerRadius = HeightRate(27);
            
        }
        NSString *nameStr = [NSString stringWithFormat:@"%@ %@",model.RealName,strtt];
        NSMutableAttributedString *attName = [[NSMutableAttributedString alloc] initWithString:nameStr];
        [attName addAttribute:NSForegroundColorAttributeName value:ColorWithHexString(@"999999") range:NSMakeRange(model.RealName.length, nameStr.length-model.RealName.length)];
        cell.leadName.attributedText = attName;
        cell.leadImageView.hidden = YES;
        cell.rightImageView.hidden = YES;
        [cell.leadImageView PSUpdateConstraintsWidth:0.01];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"tuanyuan-1"]];
        cell.contributeImageview.layer.borderColor = ColorWithHexString(@"4DBECD").CGColor;
        cell.contributeImageview.backgroundColor = ColorWithHexString(@"ffffff");

        cell.phoneLable.text = model.MobileNumber;

        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"tuanyuan-1"]];
        
        NSString *CommitMoneyStr = [Tools getNsstringFromDouble:model.ContractAmount.doubleValue isShowUNIT:YES];
        NSString *str1 =[NSString stringWithFormat:@"订单金额%@元",CommitMoneyStr];
        NSMutableAttributedString *addStr1  = [[NSMutableAttributedString alloc] initWithString:str1];
        [addStr1 addAttribute:NSForegroundColorAttributeName
                        value:ColorWithHexString(@"4DBECD")
                        range:NSMakeRange(4, CommitMoneyStr.length+1)];
        
        cell.contributedLable.attributedText = addStr1;
        
        NSString *num = [NSString stringWithFormat:@"%ld",model.JingxiaoCount.integerValue];
        NSString *str =[NSString stringWithFormat:@"已召集%@个B端用户",num];
        NSMutableAttributedString *addStr  = [[NSMutableAttributedString alloc] initWithString:str];
        [addStr addAttribute:NSForegroundColorAttributeName
                       value:ColorWithHexString(@"4DBECD")
                       range:NSMakeRange(3, num.length+1)];
        cell.calledLable.attributedText = addStr;
        return cell;
    }
}
#pragma mark--button 添加成员
-(void)addMemberIntoTeam
{
    [MobClick event:@"PhoneNumberInvented" label:@"我的团队手机号邀请"];

    YHTeamInviteViewController *vc =  [[YHTeamInviteViewController alloc]init];
//    vc.title = self.title;
    NSString *CompleteMoney = [Tools getNsstringFromDouble:self.model.CompleteMoney isShowUNIT:YES];
    vc.moneyText =CompleteMoney ;
    vc.GroupId = self.model.GroupId;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)lookDeailContributions
{
    YHContributionsViewController *con = [[YHContributionsViewController alloc] init];
    con.groupID = self.model.GroupId;
    [self.navigationController pushViewController:con animated:YES ];
    
}
-(void)tapContribution
{
    YHContributionsViewController *con = [[YHContributionsViewController alloc] init];
    con.groupID = self.groupID;
    [self.navigationController pushViewController:con animated:YES ];
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
