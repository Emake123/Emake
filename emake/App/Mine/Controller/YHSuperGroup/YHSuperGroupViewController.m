//
//  YHSuperGroupViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/13.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupViewController.h"
#import "YHSuperGroupTableViewCell.h"
#import "YHSuperGroupDetailViewController.h"
#import "YHSuperGroupModel.h"
#import "YHMySuperGroupTableViewCell.h"
#import "YHSuperGroupCollageViewController.h"
@interface YHSuperGroupViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * titleTimeArr;

}
@property(nonatomic,strong)UIView *emptyView;//leftView

@property(nonatomic,strong)NSArray *CatagorydictArray;

@property(nonatomic,strong)UITableView *superTable;
@property(nonatomic,strong)YHTitleView *myTitle;

// 创建活动定时器
@property (nonatomic, strong) NSTimer *activeTimer;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger recordtime;


@end

@implementation YHSuperGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRigthDetailButtonIsShowCart:false];
//    [self addRigthDetailButtonIsNotChat:false];
    self.title = self.isFromMine?@"我的超级团": @"超级团";
    self.CatagorydictArray = Userdefault(CatagoryIDs);
    
    if (self.isFromMine == false) {
        // 启动倒计时后会每秒钟调用一次方法
        _activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(activeCountDownAction) userInfo:nil repeats:YES];
        [_activeTimer fire];
    }
  
    [self superViewLIstUI];
    self.time =0;
}
//  倒计时
-(void)activeCountDownAction
{
    self.time++;
    
    if (self.time == 60) {
        [self.myTitle selectItemWithIndex:self.index];
        self.time = 0;
      
    }
    
}
-(void)getSuperGroupList:(NSDictionary *)dic
{
    [self.view showWait:@"加载中" viewType:CurrentView];

    [[YHJsonRequest shared] getAppSuperGroup:@{@"CategoryBId":dic[@"CategoryBId"]} SuccessBlock:^(NSArray *success) {
        [self.view hideWait:CurrentView];

        self.groupList = [NSArray arrayWithArray:success];
        if (self.groupList.count==0) {
            self.superTable.hidden = YES;
            [self configEmptySubViews];
        }else
        {
            self.superTable.hidden = false;
            self.emptyView.hidden = YES;
            [self.superTable reloadData];
            /// 1.初始化 传入当前视图和数据数组
//            NSMutableArray *arr=[NSMutableArray array];
//            for (YHSuperGroupInfoModel *model1 in success) {
//                NSArray *timeArr= [model1.Hour componentsSeparatedByString:@":"];
//                NSString *timeH = timeArr[0];
//                NSString *timeM = timeArr[1];
//                NSString *timeS = timeArr[2];
//                NSInteger secondsCountDown =model1.Day.integerValue*24*3600+timeH.integerValue*3600+timeM.integerValue*60+timeS.integerValue;
//                [arr addObject:[NSString stringWithFormat:@"%ld",secondsCountDown]];
//                NSLog(@"secondsCountDown==%ld",secondsCountDown);
//            }
//            titleTimeArr =[NSMutableArray arrayWithArray:arr] ;
//            [self startTimer];
        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];

    }];
}

-(void)getMYSuperGroupList:(NSDictionary *)dic
{
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getAppMYSuperGroup:@{@"CategoryBId":dic[@"CategoryBId"]} SuccessBlock:^(NSArray *success) {
        [self.view hideWait:CurrentView];

        self.groupList = [NSArray arrayWithArray:success];
        if (self.groupList.count==0) {
            self.superTable.hidden = YES;
            [self configEmptySubViews];
        }else
        {
            self.superTable.hidden = false;
            self.emptyView.hidden = YES;
            [self.superTable reloadData];
            
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];

        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
}
- (void)configEmptySubViews{
    
    if (self.emptyView ==nil) {
        self.emptyView = [[UIView alloc] init];
        [self.view addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view.mas_centerY).offset(-HeightRate(50));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(WidthRate(123));
            make.height.mas_equalTo(HeightRate(125));
        }];
        
        UIImageView *imageShow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shangjiazhong"]];
        imageShow.contentMode = UIViewContentModeScaleAspectFit;
        [self.emptyView addSubview:imageShow];
        
        [imageShow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(0));
            make.centerX.mas_equalTo(self.emptyView.mas_centerX);
            make.width.mas_equalTo(WidthRate(123));
            make.height.mas_equalTo(HeightRate(125));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        if (self.isFromMine) {
            label.text =@"亲，暂无相关内容哦～";


        }else
        {
            label.text =@"亲，紧急备货中，客官稍候～";

        }
        label.textColor =TextColor_737273;
        label.font = SYSTEM_FONT(AdaptFont(14));
        [self.emptyView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.emptyView.mas_centerX);
            make.height.mas_equalTo(HeightRate(23));
            make.top.mas_equalTo(imageShow.mas_bottom).offset(HeightRate(10));
        }];
    }else
    {
        self.emptyView.hidden = false;
    }
    
    
    
    
}
-(void)superViewLIstUI
{
   
    self.superTable = [[UITableView alloc] initWithFrame:CGRectMake(0, (TOP_BAR_HEIGHT)+HeightRate(45), ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(45)) style:UITableViewStyleGrouped];
     self.superTable.delegate =self;
     self.superTable.dataSource = self;
//     self.superTable.backgroundColor = ColorWithHexString(StandardBlueColor);
     self.superTable.sectionHeaderHeight =0.1;
     self.superTable.sectionFooterHeight= 0.1;
     self.superTable.estimatedRowHeight =500;
    [self.view addSubview: self.superTable];
    
    NSArray *CatagorydictArray = Userdefault(CatagoryIDs);
    NSArray *array;
    if (CatagorydictArray.count == 2) {
    NSDictionary *dict = CatagorydictArray[0];
    NSDictionary *dict1 = CatagorydictArray[1];
    array = @[dict[@"CategoryBName"],dict1[@"CategoryBName"] ];
  }else
  {
      array = @[@"输配电云工厂",@"休闲食品云工厂"];
  }
    self.myTitle  =  [[YHTitleView alloc] initWithFrame:CGRectMake( WidthRate(0),TOP_BAR_HEIGHT, ScreenWidth, HeightRate(45)) titleFont:14 delegate:self andTitleArray:array];
    [self.view addSubview: self.myTitle];
    if (@available(iOS 11.0, *)) {
         self.superTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [ self.myTitle selectItemWithIndex:self.index];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isFromMine== YES) {
        
        YHMySuperGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[YHMySuperGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        [cell requestData:self.groupList[indexPath.row]];
        return cell;
    }else{
        YHSuperGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell==nil) {
           cell = [[YHSuperGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            
        }
//        cell.togetherButton.tag= indexPath.row;
        cell.togetherButton.userInteractionEnabled = false;
//        [cell.togetherButton addTarget:self action:@selector(goSuperGroupDetailVC:) forControlEvents:UIControlEventTouchUpInside];
        [cell requestData:self.groupList[indexPath.row]];
        return cell;
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isFromMine ==YES) {
        
        YHSuperGroupModel *model = self.groupList[indexPath.row];
        YHSuperGroupCollageViewController *vc = [[YHSuperGroupCollageViewController alloc] init];
        vc.SuperGroupDetailId  = model.infoModel.SuperGroupDetailId;
        vc.OrderNo = model.OrderNo;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        
        BOOL IsVisite = [self isVisitorLoginByPhoneNumberExits];
        if (IsVisite ==false) {
            return;
        }
        
        
        YHSuperGroupModel *model = self.groupList[indexPath.row];
        
        if (model.GroupState.integerValue==0) {
            [self.view makeToast:@"该团还未开始" duration:1.5 position:CSToastPositionCenter];

        } else if(model.GroupState.integerValue==2) {
            [self.view makeToast:@"该团已经结束" duration:1.5 position:CSToastPositionCenter];
        }else
        {
            YHSuperGroupDetailViewController *vc = [[YHSuperGroupDetailViewController alloc] init];

            
            vc.model  = [self lessSecondToDay:self.time model:model];
            vc.isFromMine = self.isFromMine;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }
    

}

-(void)goSuperGroupDetailVC:(UIButton *)Button
{

   BOOL IsVisite = [self isVisitorLoginByPhoneNumberExits];
    if (IsVisite ==false) {
        return;
    }
    
    
    YHSuperGroupModel *model = self.groupList[Button.tag];
    YHSuperGroupDetailViewController *vc = [[YHSuperGroupDetailViewController alloc] init];
    vc.model  = model;
    vc.isFromMine = self.isFromMine;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark -----YHTitleDelegate
-(void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index
{
    self.time = 0;
    if (index <self.CatagorydictArray.count) {
        self.index = index;
        if (self.isFromMine==YES) {
            [self getMYSuperGroupList:self.CatagorydictArray[index]];

        }else
        {
            [self getSuperGroupList:self.CatagorydictArray[index]];
        }

    }
}

- (void)startTimer
{
    self.activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    
    //    如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:self.activeTimer forMode:UITrackingRunLoopMode];
    
}
- (void)refreshLessTime
{
    NSUInteger time;
    for (int i = 0; i < titleTimeArr.count; i++) {
        time = [titleTimeArr[i] integerValue] ;
        time =time==0?0:time--;
        YHSuperGroupModel *model = self.groupList[i];
        
        NSUInteger day  = (NSUInteger)time/(24*3600);
        NSUInteger hour = (NSUInteger)(time%(24*3600))/3600;
        NSUInteger min  = (NSUInteger)(time%(3600))/60;
        NSUInteger second = (NSUInteger)(time%60);
//          [self lessSecondToDay:--seconds withType:i];

        model.Day = [NSString stringWithFormat:@"%ld",day] ;
        model.Hour = [NSString stringWithFormat:@"%ld:%ld:%ld",hour,min,second];
        if (time==0) {
            model.GroupState = model.GroupState.integerValue==2?@"2":(model.GroupState.integerValue==1?@"2":@"1");

        }
        NSString *str = model.GroupState.integerValue==0?@"距离开始":@"距离结束";
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAttributedString *att = [Tools getFrontStr:str day:model.Day time:model.Hour isShowSecond:YES ];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            YHSuperGroupTableViewCell *cell = (YHSuperGroupTableViewCell *)[self.superTable cellForRowAtIndexPath:indexPath];
//            if (model.GroupState.integerValue==0) {
//                cell.togetherButton.backgroundColor = ColorWithHexString(StandardBlueColor);
//                [cell.togetherButton setTitle:@"即将开始" forState:UIControlStateNormal];
//            }else if(model.GroupState.integerValue==1)
//            {
//                cell.togetherButton.backgroundColor = ColorWithHexString(@"F8695D");
//                [cell.togetherButton setTitle:@"去拼团" forState:UIControlStateNormal];
//
//            }else
//            {
//                cell.togetherButton.backgroundColor = ColorWithHexString(@"C9C9C9");
//                [cell.togetherButton setTitle:@"拼团结束" forState:UIControlStateNormal];
//
//            }
            cell.dateEnd.attributedText = att;
        });
        

        [titleTimeArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",time]];
        if (time <= 0) {
//            [self.superTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
        }
    }
}

- (YHSuperGroupModel *)lessSecondToDay:(NSUInteger)seconds model:(YHSuperGroupModel *)model
{
    NSArray *timeArr= [model.Hour componentsSeparatedByString:@":"];
    NSString *timeH = timeArr[0];
    NSString *timeM = timeArr[1];
    NSString *timeS = timeArr[2];
    NSInteger secondsCountDown =model.Day.integerValue*24*3600+timeH.integerValue*3600+timeM.integerValue*60+timeS.integerValue;
    NSUInteger newSeconds = secondsCountDown -seconds;

    NSUInteger day  = (NSUInteger)newSeconds/(24*3600);
    NSUInteger hour = (NSUInteger)(newSeconds%(24*3600))/3600;
    NSUInteger min  = (NSUInteger)(newSeconds%(3600))/60;
    NSUInteger second = (NSUInteger)(newSeconds%60);

    model.Day = [NSString stringWithFormat:@"%02ld",day];
    model.Hour = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,min,second];
    return model;
    
}
-(void)dealloc
{
    [_activeTimer invalidate];
    _activeTimer = nil;

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
