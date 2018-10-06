//
//  YHSendMessageToStoreListViewController.m
//  emake
//
//  Created by 张士超 on 2018/8/10.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSendMessageToStoreListViewController.h"
#import "YHStoreModel.h"
#import "YHSendMessageStoreTableViewCell.h"
#import "YHSendFileTipsView.h"
#import "ChatNewViewController.h"
@interface YHSendMessageToStoreListViewController ()<UITableViewDelegate,UITableViewDataSource,YHSendFileTipsViewDelegete>

@property(nonatomic,strong)NSMutableArray *storeData;
@property(nonatomic,strong)UITableView *storeListTableView;
@property(nonatomic,strong)YHSendFileTipsView *FileTipsView;

@end

@implementation YHSendMessageToStoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发送文件";
     self.storeListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)) style:UITableViewStyleGrouped];
     self.storeListTableView.delegate = self;
     self.storeListTableView.dataSource = self;
    self.storeListTableView.sectionFooterHeight = 0;
    [self.view addSubview: self.storeListTableView];
    [self getStoreData];
}

- (void)getStoreData{
    self.storeData = [NSMutableArray arrayWithCapacity:0];
    [[YHJsonRequest shared] getFindStoreListSuccessBlock:^(NSArray *Success) {
        self.storeData = [NSMutableArray arrayWithArray:Success];
        [ self.storeListTableView reloadData];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.storeData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    YHSendMessageStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell==nil) {
        cell = [[YHSendMessageStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section==0) {
        cell.storeImageView.image = [UIImage imageNamed:@"wo-yizhizaokefu"];
        cell.storeNameLable.text =@"易智造官方客服";
    }else{
       YHStoreModel *model = [self.storeData objectAtIndex:indexPath.row];
       [cell.storeImageView sd_setImageWithURL:[NSURL URLWithString:model.StorePhoto]];
       cell.storeNameLable.text = model.StoreName;
    }
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HeightRate(60);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
    if (section==0) {
        lable.text =@"官方客服";
    }else
    {
        lable.text =@"店铺客服";
    }
    return lable;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeightRate(30);
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (self.FileTipsView==nil) {
        self.FileTipsView = [[YHSendFileTipsView alloc] initWithDelegete:self andFileurl:self.urlStr andFileName:self.fileNameStr];
        self.FileTipsView.tag = indexPath.section;
    }

    [self.FileTipsView showAnimated];
   

}


#pragma mark ---- YHSendFileTipsViewDelegete
- (void)alertViewLeftBtnClick:(id)alertView{
    
}
- (void)alertViewRightBtnClick:(id)alertView withFileUrl:(NSString *)fileurl withfileName:(NSString *)fileName{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileurl]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    YHSendFileTipsView *sendView = (YHSendFileTipsView *)alertView;
    NSInteger section= sendView.tag/100;
    NSInteger row= sendView.tag%100;

    if (section==0) {
        vc.listID = userID;

    }else{
        
        YHStoreModel *model = [self.storeData objectAtIndex:row];
        vc.storeID = model.StoreId;
        vc.listID = [NSString stringWithFormat:@"%@_%@",model.StoreId,userID];
    }
    vc.hidesBottomBarWhenPushed = YES;
    
    
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    vc.filePath = messageIdString;
    vc.fileName = fileName;
    vc.fileData = data;
    vc.isUploadFile = YES;
    if (!vc.storeID) {
      [vc sendCMDRequestService];
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:false];
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
