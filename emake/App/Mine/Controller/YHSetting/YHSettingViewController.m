//
//  YHSettingViewController.m
//  emake
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSettingViewController.h"
#import "YHSettingHeaderCellTableViewCell.h"
#import "YHSettingItemCell.h"
#import "SDWebImageManager.h"
#import "YHPersonalFileViewController.h"
#import "YHAboutViewController.h"
#import "YHLoginViewController.h"
#import "YHAccountSecurityViewController.h"
#import "YHAdressViewController.h"
#import "SDImageCache.h"
#import "YHMQTTClient.h"
#import "YHAdviceFeedBackViewController.h"
#import "YHMySettingVipTableViewCell.h"
#import "YHMineMemberInterestViewController.h"
#import "YHMineCityDelegateSuccessViewController.h"
#import "YHMemberExperienceViewController.h"
@interface YHSettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,YHAlertViewDelegete,YHActionSheetViewDelegete>{
    
    UITableView * myTableView;
    
}
@property (nonatomic,retain)NSArray *scrollImages;
@property (nonatomic,retain)NSString *myVipState;
@property (nonatomic,assign)NSInteger mySection;


@end

@implementation YHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =self.titleStr;
    [self configUI];
    [self addRigthDetailButtonIsShowCart:false];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)configUI{
    
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(80)) style:UITableViewStylePlain];
    myTableView.backgroundColor = APP_THEME_MAIN_GRAY;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];


    UIButton * exit = [UIButton buttonWithType:UIButtonTypeCustom];
    exit.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
    exit.titleLabel.font = [UIFont systemFontOfSize:16];
    [exit addTarget:self action:@selector(quitCurrentAccount) forControlEvents:UIControlEventTouchUpInside];
    [exit setTitle:@"退出当前账户" forState:UIControlStateNormal];
    exit.layer.cornerRadius = 6;
    exit.clipsToBounds = YES;
    [self.view addSubview:exit];
    
    [exit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(HeightRate(-20));
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(HeightRate(40));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)checkAPPStoreVersion{
    
    [self.view showWait:@"获取中..." viewType:CurrentView];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/lookup?id=1260429389"]];
    NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (responseData) {
        [self.view hideWait:CurrentView];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"results"];
        NSDictionary *dict = [array lastObject];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        if ([app_Version isEqualToString:dict[@"version"]]) {
            [self.view makeToast:@"已经是最新版本了" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        if (![app_Version isEqualToString:dict[@"version"]]){
            [self.view hideWait:CurrentView];
            NSString*str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1260429389"];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
        }
    }else{
        [self.view hideWait:CurrentView];
        [self.view makeToast:@"获取最新版本失败" duration:1.0 position:CSToastPositionCenter];
    }
}
#pragma  mark====UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        if(indexPath.row==0) {
            YHSettingHeaderCellTableViewCell *cell = nil;
            if (!cell) {
                cell = [[YHSettingHeaderCellTableViewCell alloc]init];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString *uslString = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_HeadImageURLString];
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:uslString] placeholderImage:[UIImage imageNamed:@"login_logo"]];
                if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
                    cell.nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
                }else{
                    cell.nameLabel.text = @"未登录";
                }
                cell.nickNameLabel.text = @"点击设置个人资料";
            }
            
            return cell;
        }else{
            YHSettingItemCell *cell = nil;
            if (!cell) {
                
                cell = [[YHSettingItemCell alloc]init];
                switch (indexPath.row) {
                    case 1:
                        cell.title.text =@"账户和安全";
                        cell.lineLabel.hidden = true;
                        break;
                    case 2:{
                        cell.title.text =@"清理缓存";
                        cell.contentLabel.hidden = false;
                        //获取缓存的大小
                        NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
                        NSString * currentVolum = [NSString stringWithFormat:@"%.1fM",[Tools fileSize:intg]];
                        cell.lineLabel.hidden = true;
                        cell.contentLabel.text = currentVolum;
                    }
                        break;
                    case 3:{
                        cell.title.text =@"意见反馈";
                        cell.lineLabel.hidden = true;
                    }
                        break;
                    case 4:{
                        cell.title.text =@"检查更新";
                        cell.lineLabel.hidden = false;
                        cell.contentLabel.hidden = false;
                        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                        cell.contentLabel.text = app_Version;
                    }
                        break;
                    default:
                        break;
                }
            }
            cell.contentImage.hidden = YES;
            return  cell;
        }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        return HeightRate(46);
    }else
    {
        if (indexPath.row == 0) {
            return  HeightRate(91);
        }else{
            return  HeightRate(46);
        }
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        //账户设置
        case 0:{
           
                [MobClick event:@"Personal" label:@"个人中心"];
                YHPersonalFileViewController *vc = [[YHPersonalFileViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            
         
        }
            break;
        //账户和安全
        case 1:{
          
                YHAccountSecurityViewController *vc = [[YHAccountSecurityViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
           
        }
            break;
        //清理缓存
        case 2:{
            YHAlertView *alert = [[YHAlertView alloc]initWithDelegete:self Title:@"确定清理缓存" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            [alert showAnimated];
        }
            break;
        case 3:{
            [MobClick event:@"FeedBack" label:@"意见反馈"];

            YHAdviceFeedBackViewController *vc = [[YHAdviceFeedBackViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:{
            [self checkAPPStoreVersion];
        }
            break;
        default:
            break;
    }
}
#pragma mark=====YHAlertViewDelegete
- (void)alertViewRightBtnClick:(id)alertView{
    
    [self clearTmpPics];
}
#pragma mark=====YHActionSheetViewDelegete
- (void)actionSheetView:(id)actionSheet selectItemWithIndex:(NSInteger)index{
   
    switch (index) {
        case 0:{
            
            NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:LOGIN_UUID];
            [defaults removeObjectForKey:VipState];
            [defaults removeObjectForKey:LOGIN_USERID];
            [defaults removeObjectForKey:LOGIN_MOBILEPHONE];
            [defaults removeObjectForKey:LOGIN_USERNICKNAME];
            [defaults removeObjectForKey:LOGIN_USERTYPE];
            [defaults removeObjectForKey:LOGIN_HeadImageURLString];
            [defaults removeObjectForKey:USERSTATEFailReason];
            [defaults removeObjectForKey:USERSTATECommitDate];
            [defaults removeObjectForKey:USERREQUESTSERVER];
            [defaults removeObjectForKey:LOGIN_Refresh_Token];
            [defaults removeObjectForKey:LOGIN_Access_Token];
            [defaults removeObjectForKey:LOGIN_UserStyle];
            [defaults removeObjectForKey:LOGIN_UserStoreID];
            for (NSString *nameStr in [YHMQTTClient sharedClient].messageCountDic.allKeys) {
                [[YHMQTTClient sharedClient].messageCountDic removeObjectForKey:nameStr];

            }

            [defaults synchronize];
            [[YHMQTTClient sharedClient] disConnect];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
  
}
#pragma mark -----Method
- (void)quitCurrentAccount{
    NSArray *title =@[@"确定"];
    YHActionSheetView *sheetView = [[YHActionSheetView alloc]initWithDelegate:self withCancleTitle:@"取消" andItemArrayTitle:title];
    [sheetView showAnimated];
}
- (NSString *)getHeadURL{
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_USERID];
    NSString *fileName = [NSString stringWithFormat:@"%@user_icon.png",userId];
    NSString *headImageURL = [NSString stringWithFormat:@"https://img-emake-cn.oss-cn-shanghai.aliyuncs.com/images/%@",fileName];
    return headImageURL;
}
- (void)clearTmpPics{
    // 清除缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.view makeToast:@"清理缓存成功" duration:1.0 position:CSToastPositionCenter];
        [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
