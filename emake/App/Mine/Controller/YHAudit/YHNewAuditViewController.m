//
//  YHNewAuditViewController.m
//  emake
//
//  Created by 张士超 on 2018/6/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHNewAuditViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHSixTeamViewController.h"
@interface YHNewAuditViewController ()
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UITextField *nameTextF;
@property(nonatomic,strong)UITextField *idTextF;
@property(nonatomic,strong)UIButton *commitBtn;
@property (nonatomic,retain)UserInfoModel *model;


@end

@implementation YHNewAuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addRigthDetailButtonIsShowCart:false];
    
    self.title = @"代理商申请";
    self.view.backgroundColor = ColorWithHexString(@"F2F2F2");
    [self configView];
    [self getUserInfo];
    
}
-(void)configView
{
    NSString *  state = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERCARDSTATE];
    NSString *  userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
 BOOL isShowProgress =   [state isEqualToString:@"3"]?([userType isEqualToString:@"1"]?NO:YES):YES;
    CGFloat headviewHeight;
    if (isShowProgress == NO) {
        headviewHeight =  0.001;
        
    }else
    {
        headviewHeight = 65 ;
   
    }
    UIView *bgview = [[UIView alloc]init];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(headviewHeight));
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        
    }];
  
    [self progress:bgview];
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
//        make.top.mas_equalTo(headviewHeight);
        make.top.mas_equalTo(bgview.mas_bottom).offset(HeightRate(6));
    }];
    UILabel *labelName = [[UILabel alloc]init];
    labelName.text = @"真实姓名";
    labelName.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelName];
    
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(17));
        make.top.mas_equalTo(HeightRate(7));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
        
    }];
    
    self.nameTextF = [[UITextField alloc]init];
    self.nameTextF.placeholder =@"请输入身份证姓名";
    self.nameTextF.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:self.nameTextF];
    [self.nameTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelName.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(labelName.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *lineOne = [[UILabel alloc]init];
    lineOne.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineOne];
    
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(17));
        make.top.mas_equalTo(HeightRate(41));
        make.right.mas_equalTo(WidthRate(-17));
        make.height.mas_equalTo(HeightRate(0.5));
        
    }];
    
    UILabel *labelID = [[UILabel alloc]init];
    labelID.text = @"身份证号";
    labelID.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelID];
    
    [labelID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(17));
        make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(11));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
        
    }];
    
    self.idTextF = [[UITextField alloc]init];
    self.idTextF.placeholder =@"请填写18位身份证号";
    self.idTextF.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:self.idTextF];
    [self.idTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelID.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(labelID.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
        make.bottom.mas_equalTo(HeightRate(-10));
    }];
    self.commitBtn.clipsToBounds = YES;

    NSString *title = [state isEqualToString:@"3"]?([userType isEqualToString:@"1"]?@"查看我的团队":@"提交审核"):@"提交审核";
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [self.commitBtn setTitle:title forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    self.commitBtn.layer.cornerRadius = 6;
  
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(33));
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(HeightRate(25));
        make.right.mas_equalTo(WidthRate(-33));
        make.height.mas_equalTo(HeightRate(45));
    }];
    
    NSString *commitTipsStr = @"遇到问题，请联系客服";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commitTipsStr];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(APP_THEME_MAIN_COLOR)
                    range:NSMakeRange(commitTipsStr.length-4 , 4)];
    [attrStr addAttribute:NSUnderlineStyleAttributeName
                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                    range:NSMakeRange(commitTipsStr.length-4, 4)];
    UILabel *lable = [[UILabel alloc] init];
    lable.attributedText = attrStr;
    lable.font = SYSTEM_FONT(AdaptFont(13));
    [self.view addSubview:lable];
    lable.userInteractionEnabled = YES;
    lable.hidden =[state isEqualToString:@"3"]?([userType isEqualToString:@"1"]?YES:NO):NO;
    [lable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(customerSevicerClick)]];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(35));
        make.top.mas_equalTo(self.commitBtn.mas_bottom).offset(HeightRate(15));
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(HeightRate(45));
        
    }];
   
}

//联系客服
-(void)customerSevicerClick
{
    NSString *telStr = @"400-8670-211";
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL          = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
}
- (void)commit:(UIButton *)button{
    
    if ([button.currentTitle isEqualToString:@"查看我的团队"]) {
        
        YHSixTeamViewController *vc = [[YHSixTeamViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        if (self.nameTextF.text.length <=0) {
            [self.view makeToast:@"当前姓名不能为空" duration:1.5 position:CSToastPositionCenter];
            return;
        }
        
        if (self.idTextF.text.length <=0) {
            [self.view makeToast:@"当前身份证不能为空" duration:1.5 position:CSToastPositionCenter];
            return;
        }
        if (self.idTextF.text.length > 0 && ![Tools judgeIdentityStringValid:self.idTextF.text]) {
            [self.view makeToast:@"当前身份证格式不对" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        
        NSString *BusinessCategory = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
        NSDictionary * parameters = @{@"PSPDId":self.idTextF.text,@"RawCardUrl":@"",@"Province":@"",@"City":@"",@"RealName":self.nameTextF.text,@"BusinessCategory":BusinessCategory.length>0?BusinessCategory:@"",@"Address":@"",@"TelCell":@"",@"Company":@"",@"PSPDIdIconBack":@"",@"PSPDIdIconFront":@""};
        
        
        [[YHJsonRequest shared] userAudit:parameters SuccessBlock:^(NSDictionary *successMessage) {
            [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:LOGIN_USERCARDSTATE];
            [[NSUserDefaults standardUserDefaults] setObject:self.nameTextF.text forKey:USERSCardID];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc]init];
            vc.successDate =successMessage[@"EditWhen"];
            [self.navigationController pushViewController:vc animated:YES];
            
        } fialureBlock:^(NSString *errorMessages) {
            
            [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        }];
    
    }
}

-(void)progress:(UIView *)bgview
{
    NSArray *titleArr = @[@"填写基本信息",@"等待客服审核",@"审核完成"];
    
    
    NSArray *imageArr =@[@"0201",@"0102",@"0103"];//[state isEqualToString:@"2"]?@[@"0201",@"0202",@"0103"]: @[@"0101",@"0102",@"0103"];
    
    CGFloat width = (ScreenWidth-20)/3;
    for (int i = 0; i < titleArr.count; i ++) {
        
        
        UIImageView *progressImageView = [[UIImageView alloc] init];
        progressImageView.image = [UIImage imageNamed:imageArr[i]];
        progressImageView.frame = CGRectMake(10+width*i, 15, width, HeightRate(16));
        [bgview addSubview:progressImageView];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = titleArr[i];
        title.font = [UIFont systemFontOfSize:AdaptFont(10)];
        title.frame = CGRectMake(10+width*i,  HeightRate(31), width, HeightRate(20));
        title.textColor = ColorWithHexString(@"797979");
        title.textAlignment = NSTextAlignmentCenter;
        [bgview addSubview:title];
        
    }
    
}

- (void)getUserInfo{

[self.view showWait:@"加载中" viewType:CurrentView];
[[YHJsonRequest shared] getUserInfoSuccessBlock:^(UserInfoModel*model) {
    [self.view hideWait:CurrentView];
    self.model = model;
    NSString *realName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERREALNAME];
    if (![realName isEqualToString:model.RealName]) {
        [[NSUserDefaults standardUserDefaults] setObject:model.RealName forKey:LOGIN_USERREALNAME];
    }
    [[NSUserDefaults standardUserDefaults] setObject:model.BusinessCategory forKey:USERSELECCATEGORY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.idTextF.text = model.PSPDId;
    self.nameTextF.text = model.RealName;   
    
    if ([model.UserState isEqualToString:@"3"]) {

        self.idTextF.userInteractionEnabled = false;
        self.nameTextF.userInteractionEnabled = false;
    }
   

} fialureBlock:^(NSString *errorMessages) {
    [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    [self.view hideWait:CurrentView];
}];
//    }
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
