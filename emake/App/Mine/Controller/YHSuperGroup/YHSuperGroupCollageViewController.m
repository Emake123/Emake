//
//  YHSuperGroupCollageViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupCollageViewController.h"
#import "YHSuperGroupConfigOrderTableViewCell.h"
#import "YHSuperGroupOrderDetailTableViewCell.h"
#import "YHOrderManageNewViewController.h"
#import "YHSuperGroupTableViewCell.h"
#import "YHSuperGroupDetailViewController.h"
#import "YHCommonWebViewController.h"
#import "YHShareView.h"
@interface YHSuperGroupCollageViewController ()<UITableViewDelegate ,UITableViewDataSource>
{
    
    dispatch_source_t _timer;
    
}
@property (nonatomic,retain)UITableView *myTableView;
@property (nonatomic,strong)adressModel * adressModel;
@property (nonatomic,assign)CGFloat TableviewAdressOfHeadHeight;
@property (nonatomic,assign)BOOL isShowAdress;
@property (nonatomic,strong)YHSuperGroupModel *model;
@property (nonatomic,strong)UIButton *inviteButton;

@property(nonatomic,strong)NSArray *groupLikeArr;//leftView

@property(nonatomic,assign)NSInteger tableSection;//leftView

@end

@implementation YHSuperGroupCollageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼团详情";
    [self addRigthDetailButtonIsNotChat:false];

    [self getMYSuperGroupDetailData];

}
-(void)getMYSuperGroupDetailData
{
    [[YHJsonRequest shared] getAppMYSuperGroupDetailWithSuperGroupIdS:@{@"SuperGroupDetailId":self.SuperGroupDetailId,@"OrderNo":self.OrderNo} SuccessBlock:^(YHSuperGroupModel *model) {
//        self.groupArr = [NSArray arrayWithArray:success];;

        self.model = model;
        self.isShowAdress = false;
        [self activeCountDownAction];

        [self congfigUI];
        NSString *number = [NSString stringWithFormat:@"%@:%@",model.Day,model.Hour];
        NSString *time = [number stringByReplacingOccurrencesOfString:@":" withString:@""];
        if (model.infoModel.IsSuccess.integerValue == 0 && time.integerValue!=0) {
            [self getMYLikeSuperGroup];

        }

//        [self.myTableView reloadData];

    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
}
-(void)getMYLikeSuperGroup
{
    [[YHJsonRequest shared] getAppMYLikeSuperGroupDetailWithSuperGroupIdS:@{@"SuperGroupId":self.model.SuperGroupId} SuccessBlock:^(NSArray *success) {
        if (success.count == 0) {
            self.tableSection = 1;
            self.inviteButton.hidden = YES;
        }else
        {
            self.tableSection = 2;
            self.groupLikeArr = [NSArray arrayWithArray:success];;
            [self.myTableView reloadData];
            self.inviteButton.hidden = false;


        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
}
-(void)congfigUI

{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.estimatedSectionHeaderHeight =0;
    self.myTableView.estimatedSectionFooterHeight = 0;
    self.myTableView.sectionHeaderHeight= TableViewHeaderNone;
    self.myTableView.estimatedRowHeight = 200;
    
    self.myTableView.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(50));
        make.left.mas_equalTo(0);
    }];
    
    _TableviewAdressOfHeadHeight = 0;
    self.tableSection = 1;

    UIButton *invitedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invitedButton.backgroundColor  = ColorWithHexString(@"F8695D");
    [invitedButton setTitle:@"邀请好友拼团" forState:UIControlStateNormal];
    [invitedButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [invitedButton addTarget:self action:@selector(inviteFreightJoniSuperGroup) forControlEvents:UIControlEventTouchUpInside];
    invitedButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    invitedButton.layer.cornerRadius = 6;;
    invitedButton.clipsToBounds = YES;
    [self.view addSubview:invitedButton];
    [invitedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.myTableView.mas_bottom).offset(HeightRate(0));
        make.right.mas_equalTo(WidthRate(-15));
        make.left.mas_equalTo(WidthRate(15));
        make.height.mas_equalTo(HeightRate(40));
        make.bottom.mas_equalTo(HeightRate(-5));

    }];
    invitedButton.hidden = YES;
    self.inviteButton = invitedButton;
}


-(void)lookOrderDetail
{
    YHOrderManageNewViewController *order = [[YHOrderManageNewViewController alloc] init];
    order.OrderState = 0;
    order.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:order animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableSection;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==1) {
      
        return 1;

    }else
    {
        if (self.model) {
            return 2;
            
        }else
        {
            return 0;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
//        YHSuperGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        if (cell==nil) {
//            cell = [[YHSuperGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//
//        }
//        [cell requestData:self.groupLikeArr[indexPath.row]];
        YHSuperGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell==nil) {
            cell = [[YHSuperGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            
        }
        cell.togetherButton.tag= indexPath.row;
        cell.togetherButton.userInteractionEnabled = false;
        //        [cell.togetherButton addTarget:self action:@selector(goSuperGroupDetailVC:) forControlEvents:UIControlEventTouchUpInside];
        [cell requestData:self.groupLikeArr[indexPath.row]];
      
        
        return cell;
    }else
    {
        if (indexPath.row==1) {
            YHSuperGroupOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell) {
                cell = [[YHSuperGroupOrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            }
            cell.successImageView.hidden = !self.model.infoModel.IsSuccess.boolValue;
            cell.successButton.hidden = !self.model.infoModel.IsSuccess.boolValue;
            [cell.successButton addTarget:self action:@selector(lookOrderDetail) forControlEvents:UIControlEventTouchUpInside];
            cell.peopleTipLable.text = [NSString stringWithFormat:@"还差%ld人团成功",self.model.infoModel.PeopleNumber.integerValue-self.model.infoModel.PeopleReadyNumber.integerValue];
            
            NSInteger totalNum =self.model.infoModel.PeopleNumber.integerValue;
            NSInteger readyNum =self.model.infoModel.PeopleReadyNumber.integerValue;
            float height = 0;
            for (int i =0; i< totalNum; i++) {
                int index  = i/5;
                CGFloat width = ( ScreenWidth)/5;
                
                CGFloat leftSpace= totalNum  <5?((5-totalNum)/2*width+width*i):  width*(i%5);
                CGFloat topH = index*HeightRate(35);
                UIImageView *imageView = [[UIImageView alloc] init];
                
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                if (i<readyNum) {
                    imageView.image = [UIImage imageNamed:@"tuanzhang"] ;
                    
                }else
                {
                    imageView.image = [UIImage imageNamed:@"tuanyuan-1"];
                    
                }
                [cell.peopleView addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(width);
                    make.top.mas_equalTo(HeightRate(topH));
                    make.height.mas_equalTo(HeightRate(30));
                    make.left.mas_equalTo(leftSpace);
                }];
                height = topH+HeightRate(30);
            }
            [cell.peopleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(HeightRate(height));
                
            }];
            cell.dateComit.text= [NSString stringWithFormat:@"交货期：%@",self.model.infoModel.DeliveryDate];
            
            cell.endDate.text = [NSString stringWithFormat:@"   还剩%@ 结束  ",self.model.infoModel.Hour];
            //
            return cell;
        }else
        {
            YHSuperGroupConfigOrderTableViewCell *cell = nil;
            if (!cell) {
                cell = [[YHSuperGroupConfigOrderTableViewCell alloc]init];
            }
            NSArray *imageArr = [Tools stringToJSON:self.model.GoodsSeriesPhotos];
            if (imageArr.count>0) {
                [cell.productImage sd_setImageWithURL:[NSURL URLWithString:imageArr.firstObject]];
            }
            cell.productNameLable.text = self.model.GroupName;
            cell.lbOrderDetail.text = self.model.GoodsExplain;
            cell.productPriceLable.text =[NSString stringWithFormat:@"¥%@",[Tools getHaveNum:self.model.GroupPrice.doubleValue]] ;
            cell.productNumberLable.text = [NSString stringWithFormat:@"x%@",self.model.infoModel.SetNum];
            cell.smallPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:self.model.GroupPrice.doubleValue*self.model.infoModel.SetNum.integerValue]];
            cell.TotalNumberName.text = [NSString stringWithFormat:@"共%@件商品 合计：",self.model.infoModel.SetNum];
            cell.lbtax.text = self.model.GoodsAddValue;
            
           
            return cell;
        }
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return HeightRate(30)+_TableviewAdressOfHeadHeight;
    }
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==1){
        UIView *headView = [[UIView alloc] init];
        
        UIImageView*itemTopImage = [[UIImageView alloc]init];
        itemTopImage.contentMode = UIViewContentModeScaleAspectFit;
        itemTopImage.backgroundColor = ColorWithHexString(@"f2f2f2");
        itemTopImage.image = [UIImage imageNamed:@"chaojituantitle"];
        [headView addSubview:itemTopImage];
        [itemTopImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(HeightRate(30));
            make.top.mas_equalTo(HeightRate(5));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text =@"猜你喜欢";
        label.textColor = ColorWithHexString(@"ffffff");
        label.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [headView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(HeightRate(30));
            make.top.mas_equalTo(HeightRate(5));
        }];
        
        return headView;
   }else
   {
       UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(67))];
       backView.backgroundColor = ColorWithHexString(@"99CCFF");
       
       
       [self TitleHeadView:backView item:nil];
       
       return backView;
   }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        YHSuperGroupModel *model = self.groupLikeArr[indexPath.row];
        
        if (model.GroupState.integerValue==0) {
            [self.view makeToast:@"该团还未开始" duration:1.5 position:CSToastPositionCenter];
            
        } else if(model.GroupState.integerValue==2) {
            [self.view makeToast:@"该团已经结束" duration:1.5 position:CSToastPositionCenter];
        }else
        {
            YHSuperGroupDetailViewController *vc = [[YHSuperGroupDetailViewController alloc] init];
            vc.model  = model;
//            vc.isFromMine = self.isFromMine;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
   
    
}

-(void)TitleHeadView:(UIView *)customHeadView item:(UIView *)addressView
{
    if (self.model==nil) {
        return;
    }
    UIView *companyView = [[UIView alloc] init];//WithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(30))];
    companyView.backgroundColor = ColorWithHexString(@"FAFAFA");
    [customHeadView addSubview:companyView];
    companyView.translatesAutoresizingMaskIntoConstraints = NO;
    if (addressView==nil) {
        [companyView PSSetTop:0];
    }else
    {
        [companyView PSSetBottomAtItem:addressView Length:0];

    }
    [companyView PSSetLeft:0];
    [companyView PSSetSize:ScreenWidth Height:HeightRate(35)];
    
    
    UIImageView * shopHeadImageView = [[UIImageView alloc] init];
    //        shopHeadImageView.image = [UIImage imageNamed:@"placehold"];
    [shopHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.model.StorePhoto]];
    shopHeadImageView.contentMode = UIViewContentModeScaleAspectFit;
    shopHeadImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [companyView addSubview:shopHeadImageView ];
    [shopHeadImageView PSSetLeft:WidthRate(10)];
    [shopHeadImageView PSSetSize:WidthRate(20) Height:HeightRate(20)];
    [shopHeadImageView PSSetCenterHorizontalAtItem:companyView];
    
    UILabel *companyLabelName = [[UILabel alloc] init];
    companyLabelName.text = self.model.StoreName;
    companyLabelName.font = [UIFont systemFontOfSize:AdaptFont(14)];
    companyLabelName.textColor = ColorWithHexString(@"333333");
    [companyView addSubview:companyLabelName];
    companyLabelName.translatesAutoresizingMaskIntoConstraints= NO;
    [companyLabelName PSSetRightAtItem:shopHeadImageView Length:WidthRate(5)];
    
    UILabel *shopGoodsInvoiceLable = [[UILabel alloc] init];
    shopGoodsInvoiceLable.text = @"含税";
    shopGoodsInvoiceLable.textAlignment = NSTextAlignmentCenter;
    shopGoodsInvoiceLable.font = [UIFont systemFontOfSize:AdaptFont(9)];
    shopGoodsInvoiceLable.textColor = ColorWithHexString(@"ffffff");
    shopGoodsInvoiceLable.layer.cornerRadius = 6;
    shopGoodsInvoiceLable.clipsToBounds = YES;
    shopGoodsInvoiceLable.backgroundColor = ColorWithHexString(@"FFCC00");
    [companyView addSubview:shopGoodsInvoiceLable];
    shopGoodsInvoiceLable.translatesAutoresizingMaskIntoConstraints= NO;
    [shopGoodsInvoiceLable PSSetRightAtItem:companyLabelName Length:WidthRate(5)];
    [shopGoodsInvoiceLable PSSetSize:WidthRate(33) Height:HeightRate(17)];
//    shopGoodsInvoiceLable.hidden = boolUserdefault(IsIndustryCatagory)==YES?YES:[self.contract.IsIncludeTax isEqualToString:@"0"];
    

  
    
    
    
}


-(void)inviteFreightJoniSuperGroup
{
    
    NSString *userID = Userdefault(LOGIN_USERID);
    YHShareView *share = [[YHShareView alloc] initShareWithContentTitle:@"易智造" theOtherTitle:@"超级团详情" image:nil url:[NSString stringWithFormat:@"%@%@/%@",UserSuperGroupInfoSahreURL,self.SuperGroupDetailId,userID] withCancleTitle:@"取消"];
    [share showAnimated];
    
    
}
-(UIView *)getCustomTopAdressView:(adressModel *)adressModel
{
    
    
    UIView * adressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(78))];
    
    if (self.isShowAdress ==false) {
        adressView.hidden = YES;
        adressView.frame = CGRectMake(0, 0, ScreenWidth, HeightRate(0.01));
        
    }else{
        adressView.backgroundColor = ColorWithHexString(@"99CCFF");
        
        UIImageView *adressImageView = [[UIImageView alloc] init];
        adressImageView.contentMode = UIViewContentModeScaleAspectFit;
        adressImageView.image = [UIImage imageNamed:@"dizhi_icons"];
        [ adressView addSubview:adressImageView];
        
        [adressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(WidthRate(16));
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(WidthRate(20));
            make.centerY.mas_equalTo(adressView.mas_centerY);
            
        }];
        
        UILabel *nameInfoLable  =[[UILabel alloc] init];
        nameInfoLable.text  = [NSString stringWithFormat:@"%@    %@",adressModel.UserName,adressModel.MobileNumber];
        nameInfoLable.textColor = ColorWithHexString(@"ffffff");
        nameInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:nameInfoLable];
        [nameInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(HeightRate(15));
        }];
        
        UILabel *adressInfoLable  =[[UILabel alloc] init];
        adressInfoLable.text  = [NSString stringWithFormat:@"%@%@%@%@%@",adressModel.Province,adressModel.City,adressModel.County,adressModel.District,adressModel.Address];;
        adressInfoLable.numberOfLines = 0;
        //        adressInfoLable.lineBreakMode = NSLineBreakByWordWrapping;
        adressInfoLable.textColor = ColorWithHexString(@"ffffff");
        adressInfoLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [ adressView addSubview:adressInfoLable];
        [adressInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRate(35));
            make.left.mas_equalTo(adressImageView.mas_right).offset(WidthRate(25));
            make.top.mas_equalTo(nameInfoLable.mas_bottom).offset(5);
        }];
        
        
    }
    
    return  adressView;
}

#pragma mark - 倒计时计数

- (void)activeCountDownAction {
    
    //    [Tools getHaveNum:11];
    // 1.计算截止时间与当前时间差值
    NSArray *timeArr= [self.model.infoModel.Hour componentsSeparatedByString:@":"];
    NSString *timeH = timeArr[0];
    NSString *timeM = timeArr[1];
    NSString *timeS = timeArr[2];
    // 计算时间差值
    NSInteger secondsCountDown =self.model.infoModel.Day.integerValue*24*3600+timeH.integerValue*3600+timeM.integerValue*60+timeS.integerValue;
    
    // 2.使用GCD来实现倒计时 用GCD这个写有一个好处，跳页不会清零 跳页清零会出现倒计时错误的
    __weak __typeof(self) weakSelf = self;
    
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"还剩 00:00:00 结束"];
                        [att addAttribute:NSForegroundColorAttributeName
                                    value:ColorWithHexString(@"F8695D")
                                    range:NSMakeRange(3, 8)];//                        NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:@"0" time:@"00:00:00" isShowSecond:YES];
                        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                        YHSuperGroupOrderDetailTableViewCell *cell =(YHSuperGroupOrderDetailTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                        
                        cell.endDate.attributedText = att;
                        //                        weakSelf.lableDateEnd.attributedText = att;
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (weakSelf.model.infoModel.IsSuccess.integerValue == 1) {
                            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"还剩 00:00:00 结束"];
                            [att addAttribute:NSForegroundColorAttributeName
                                        value:ColorWithHexString(@"F8695D")
                                        range:NSMakeRange(3, 8)];//                        NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:@"0" time:@"00:00:00" isShowSecond:YES];
                            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                            YHSuperGroupOrderDetailTableViewCell *cell =(YHSuperGroupOrderDetailTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                            
                            cell.endDate.attributedText = att;
                            return ;
                        }
                        if (days == 0) {
                            NSString *str =[NSString stringWithFormat:@"还剩 %02ld : %02ld : %02ld 结束",hours, minute, second];
                            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
                            [att addAttribute:NSForegroundColorAttributeName
                                        value:ColorWithHexString(@"F8695D")
                                        range:NSMakeRange(3, 13)];
                            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                            YHSuperGroupOrderDetailTableViewCell *cell =(YHSuperGroupOrderDetailTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                            cell.endDate.attributedText = att;
                        } else {
                            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
                            YHSuperGroupOrderDetailTableViewCell *cell =(YHSuperGroupOrderDetailTableViewCell *)[self.myTableView cellForRowAtIndexPath:path];
                            NSString *str =[NSString stringWithFormat:@"还剩 %02ld天 %02ld : %02ld : %02ld 结束",days,hours, minute, second];
                            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];
                            [att addAttribute:NSForegroundColorAttributeName
                                        value:ColorWithHexString(@"F8695D")
                                        range:NSMakeRange(3, 17)];
                            cell.endDate.attributedText = att;
                        }
                        
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
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
