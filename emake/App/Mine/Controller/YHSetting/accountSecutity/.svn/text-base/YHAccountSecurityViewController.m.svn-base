//
//  YHAccountSecurityViewController.m
//  emake
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHAccountSecurityViewController.h"
#import "YHPersonalFileCommonCell.h"
#import "YHChangePhoneNumberViewController.h"
#import "YHChangePasswordViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHLoginViewController.h"
@interface YHAccountSecurityViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *myTableView;
}

@end

@implementation YHAccountSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账户和安全";
    [self addRigthDetailButtonIsShowCart:false];
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)configUI{
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = YES;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    
    
    [myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(0);
        
    }];
}
- (void)checkAuditState{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark====UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHPersonalFileCommonCell *cell = nil;
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"YHPersonalFileCommonCell" bundle:nil] forCellReuseIdentifier:@"YHPersonalFileCommonCell"];
        cell = (YHPersonalFileCommonCell *)[tableView dequeueReusableCellWithIdentifier:@"YHPersonalFileCommonCell"];
        switch (indexPath.section) {
            case 0:{
                cell.title.text =@"修改手机号";
                if ([[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_MOBILEPHONE]) {
                    NSString *number = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_MOBILEPHONE];
                    cell.contentForTitle.text = [number stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                }     
                cell.lineLabel.hidden = false;
            }
                break;
            case 1:
                cell.lineLabel.hidden = YES;
                cell.title.text =@"密码设置";
                cell.lineLabel.hidden = false;
                break;
            default:
                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return  1;
    }else{
        return 1;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  HeightRate(54);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        
        return HeightRate(26);
        
    }else{
        
        return HeightRate(6);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = APP_THEME_MAIN_GRAY;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return TableViewFooterNone;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        YHChangePhoneNumberViewController *controller = [[YHChangePhoneNumberViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
        
    }else{
            YHChangePasswordViewController *controller = [[YHChangePasswordViewController alloc]init];
            controller.block = ^(NSString *message){
                NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:LOGIN_UUID];
                [defaults removeObjectForKey:Is_Login];
                [defaults removeObjectForKey:LOGIN_USERTYPE];
                [defaults synchronize];
                [self performSelector:@selector(goLoginVC) withObject:nil afterDelay:1];
            };
            [self.navigationController pushViewController:controller animated:YES];

    }
}
- (void)goLoginVC{
    
    YHLoginViewController *vc = [[YHLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
