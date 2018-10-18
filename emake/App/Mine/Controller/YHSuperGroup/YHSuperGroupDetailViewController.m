//
//  YHSuperGroupDetailViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/13.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupDetailViewController.h"
#import "YHSuperGroupDetailTableViewCell.h"
#import "YHSuperGroupTableViewCell.h"
#import "YHJoinSuperGroupView.h"
#import "YHPayViewController.h"
#import "YHSuperGroupConfirmOrderViewController.h"
#import "ChatNewViewController.h"
#import "YHProductDetailsViewController.h"
#import "YHSuperGroupViewController.h"
#import "YHSuperGroupCollageViewController.h"
#import "YHCommonWebViewController.h"
#import "YHShareView.h"
@interface YHSuperGroupDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,YHSuperGroupPayDelegate>
{
    dispatch_source_t _timer;
    NSMutableArray * titleTimeArr;

}
@property(nonatomic,strong)UIScrollView *scrollView;//leftView
@property(nonatomic,strong)UIView *leftView;//leftView
@property(nonatomic,strong)UIImageView *itemImageView;//leftView
@property(nonatomic,strong)UIView *imageTipsView;//leftView
@property(nonatomic,strong)UILabel *labelName;//leftView
@property(nonatomic,strong)UILabel *lableOriginalPrice;//leftView
@property(nonatomic,strong)UILabel *labelNumber;//leftView
@property(nonatomic,strong)UILabel *labelPrice;//leftView
@property(nonatomic,strong)UILabel *labelTax;//leftView
@property(nonatomic,strong)UILabel *labelFreightPrice;//leftView
@property(nonatomic,strong)UILabel *lableDateEnd;//leftView
@property(nonatomic,strong)UITableView *superTable;//leftView

@property(nonatomic,strong)NSArray *groupArr;//leftView
@property(nonatomic,strong)NSArray *groupLikeArr;//leftView

@property(nonatomic,assign)NSInteger tableSection;//leftView NSTimer
@property(nonatomic,strong)NSTimer *infotimer;//leftView
@property(nonatomic,assign)NSInteger totalSeconds;
@property(nonatomic,strong)NSArray * totalLastTime;


@property(nonatomic,strong)NSIndexPath * recoderJoinSuccessPath;//row 记录位置个数 section申请是否成功
@property(nonatomic,assign)NSInteger recoderJoinRow;
@property(nonatomic,assign)BOOL isNOtStartTimer;
@property(nonatomic,strong)NSString * orderNO;
@property(nonatomic,strong)NSString * mySuperId;

@end

@implementation YHSuperGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"超级团";
    [self addRightNavBtn:@"超级团说明" showBordColor:@"F8695D"];

    [self configSubViews];
    [self configBottomView];
    self.tableSection = 1;
 
    [self getSuperGroupDetailData];

    [self activeCountDownAction];
//    self.recoderJoinSuccess = -1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNotify:) name:NsuserDefaultsPaySuccessState object:nil];
}
-(void)payNotify:(NSNotification *)notify
{
    NSNumber *SuccessState = notify.userInfo[@"NsuserDefaultsPaySuccessState"];
    self.orderNO = notify.userInfo[@"OrderNo"];
    
    YHSuperGroupViewController *vc = [[YHSuperGroupViewController alloc] init];
    YHAlertView *alert =  [[YHAlertView alloc] initWithDelegete:vc Title:@"支付成功" bottomTitle:@"客服热线：400-867-0211" ButtonTitle:@"查看详情"];
    [alert showAnimated];
    vc.orderNo = notify.userInfo[@"OrderNo"];
    vc.mySuperid = self.mySuperId;
    self.isNOtStartTimer = YES;
    [self getSuperGroupDetailData];
    
    vc.isShowPayAlert = YES;
    vc.isFromMine = YES;
    vc.index = self.recordIdex;
    [self.navigationController  pushViewController:vc animated:YES];
    
    
    
    
    
}

-(void)rightBtnClick:(UIButton *)sender
{
    
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"超级团说明";
//    vc.time = UserSuperGroupInstructionURL;
    vc.URLString = UserSuperGroupInstructionURL;
    [self.navigationController pushViewController:vc animated:YES];

    
}

-(void)getSuperGroupDetailData
{
    [[YHJsonRequest shared] getAppSuperGroupDetailWithSuperGroupIdS:@{@"SuperGroupId":self.model.SuperGroupId} SuccessBlock:^(NSArray *success) {
        self.groupArr = [NSArray arrayWithArray:success];;
        [self.superTable reloadData];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, (self.superTable.y+self.superTable.contentSize.height) );
        /// 1.初始化 传入当前视图和数据数组
        NSMutableArray *arr=[NSMutableArray array];
        for (YHSuperGroupInfoModel *model1 in success) {
            NSArray *timeArr= [model1.Hour componentsSeparatedByString:@":"];
            NSString *timeH = timeArr[0];
            NSString *timeM = timeArr[1];
            NSString *timeS = timeArr[2];
            NSInteger secondsCountDown =model1.Day.integerValue*24*3600+timeH.integerValue*3600+timeM.integerValue*60+timeS.integerValue;
            [arr addObject:[NSString stringWithFormat:@"%ld",secondsCountDown]];
        }
        titleTimeArr =[NSMutableArray arrayWithArray:arr] ;
        if (self.isNOtStartTimer==false) {
            [self startTimer];

        }



    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];

    }];
}



-(void)goIntoProductDetailVC
{
    NSArray* catagoryIds  = Userdefault(CatagoryIDs);

    NSDictionary *dic = catagoryIds[0];

    YHProductDetailsViewController *vc = [[YHProductDetailsViewController alloc] init];
    vc.GoodsSeriesCode = self.model.GoodsSeriesCode;
    vc.StoreID = self.model.StoreId;
    vc.CouponNumberStr = dic[@"DisCount"];
    vc.StoreName = self.model.StoreName;
    vc.storeAvata = self.model.StorePhoto;
    vc.storePhoneNumber = @"";
    //    [Tools jumpIntoOnlyVC:self.navigationController destnationViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)configSubViews{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight-60-HeightRate(50))];
    self.scrollView.contentSize =CGSizeMake(0, ScreenHeight*6+486);
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.alwaysBounceHorizontal = false;
    self.scrollView.delegate = self;
    self.scrollView.tag = 100;
    [self.view addSubview:self.scrollView];
    
    UIView *leftView = [[UIView alloc]init];//WithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-66-HeightRate(50))];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
//        make.height.mas_equalTo(440);

        make.top.mas_equalTo(0);
    }];
    self.leftView = leftView;
    
    
    UIScrollView * scrollImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(245))];
    scrollImageView.alwaysBounceVertical = YES;
    scrollImageView.scrollEnabled = NO;
    scrollImageView.showsVerticalScrollIndicator = false;
    scrollImageView.showsHorizontalScrollIndicator = true;
    scrollImageView.alwaysBounceHorizontal = false;
    scrollImageView.pagingEnabled = YES;
    scrollImageView.delegate = self;
    [leftView addSubview:scrollImageView];
    [scrollImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goIntoProductDetailVC) ]];
    
    NSArray *imageArr = [Tools stringToJSON:self.model.GoodsSeriesPhotos];
    scrollImageView.contentSize =CGSizeMake(ScreenWidth*(imageArr.count>0?imageArr.count:1),0);
    UIImageView *itemImageView1;
    for (int i=0;i<imageArr.count;i++) {
        NSString *imageStr = imageArr[i];
        UIImageView *itemImageView = [[UIImageView alloc]init];
        itemImageView.contentMode =  UIViewContentModeScaleAspectFit ;
        itemImageView.clipsToBounds = YES;
//        itemImageView.image = [UIImage imageNamed:@"placehold"];
        [itemImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];

        [scrollImageView addSubview:itemImageView];
        [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ScreenWidth*(i));
            make.width.mas_equalTo(ScreenWidth);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(215));
        }];
        itemImageView1 = itemImageView;
    }
   
    
    UIView *imageTipsView = [[UIView alloc] init];
    imageTipsView.backgroundColor = ColorWithHexString(@"F3F3F3");
    [scrollImageView addSubview:imageTipsView];
    [imageTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(itemImageView1.mas_bottom);
        make.height.mas_equalTo(HeightRate(30));
        
    }];
    self.imageTipsView = imageTipsView;

//    NSString *tipsStr = se [self.m objectForKey:@"GoodsSeriesKeywords"];
    if (self.model.GoodsSeriesKeywords.length > 0) {
        NSArray * tipsArr = [self.model.GoodsSeriesKeywords componentsSeparatedByString:@"|"];
        [self tipsButtons:imageTipsView Updata:tipsArr];
    }else{
        [self tipsButtons:imageTipsView Updata:@[]];

        [self.imageTipsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.001);
        }];
    }

    
    UILabel *lineOne = [[UILabel alloc]init];
    lineOne.backgroundColor = SepratorLineColor;
    [self.leftView addSubview:lineOne];
    
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollImageView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    self.labelName = [[UILabel alloc]init];
    self.labelName.text = self.model.GroupName;
    self.labelName.font = [UIFont systemFontOfSize:AdaptFont(16)];
    self.labelName.numberOfLines = 0;
    [self.leftView addSubview:self.labelName];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(WidthRate(-10));
        make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(12));
    }];
    
    if (self.isFromMine==YES) {
        UIImageView *itemImageView = [[UIImageView alloc]init];
        itemImageView.contentMode =  UIViewContentModeScaleAspectFit ;
        itemImageView.clipsToBounds = YES;
        itemImageView.image = [UIImage imageNamed:@"pintuanchenggongw"];
        [self.leftView addSubview:itemImageView];
        [itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WidthRate(15));
            make.width.mas_equalTo(WidthRate(90));
            make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(-10));
            make.height.mas_equalTo(HeightRate(90));
        }];
    }
  
    
    UILabel *labelFreightPrice = [[UILabel alloc] init];
//    labelFreightPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:self.model.GroupPrice.doubleValue]];
    labelFreightPrice.font = [UIFont systemFontOfSize:AdaptFont(28)];
    labelFreightPrice.textColor = ColorWithHexString(@"F8695D");
//    labelFreightPrice.hidden = true;
    labelFreightPrice.textAlignment = NSTextAlignmentLeft;
    [self.leftView addSubview:labelFreightPrice];
    [labelFreightPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(5));
        make.left.mas_equalTo(HeightRate(10));
    }];
    self.labelFreightPrice = labelFreightPrice;
    NSString *freightStr =  [NSString stringWithFormat:@"¥%@ 起",[Tools getHaveNum:self.model.GroupPrice.doubleValue]];
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:freightStr];
    [attrStr1 addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:AdaptFont(16)]
                     range:NSMakeRange(freightStr.length-1, 1)];
    self.labelFreightPrice.attributedText = attrStr1 ;
    
    UILabel *labelpriceTip = [[UILabel alloc] init];
    labelpriceTip.text = @"拼团价";
    labelpriceTip.font = [UIFont systemFontOfSize:AdaptFont(12)];
    labelpriceTip.textColor = ColorWithHexString(@"F8695D");
    labelpriceTip.textAlignment = NSTextAlignmentLeft;
    [self.leftView addSubview:labelpriceTip];
    [labelpriceTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(labelFreightPrice.mas_bottom);
        make.left.mas_equalTo(labelFreightPrice.mas_right).offset(10);
        make.height.mas_equalTo(HeightRate(24));
    }];
    
    
    
    NSString *originalPriceStr = [NSString stringWithFormat:@"¥%@ 原价",[Tools getHaveNum:self.model.OldPrice.doubleValue]];;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:originalPriceStr];
    [attrStr addAttribute:NSStrikethroughStyleAttributeName
                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                    range:NSMakeRange(0,originalPriceStr.length)];
    
    
    UILabel *originalPrice = [[UILabel alloc]init];
    originalPrice.textColor = ColorWithHexString(@"999999");
    originalPrice.attributedText =attrStr;
    originalPrice.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [self.leftView addSubview:originalPrice];
    [originalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(labelFreightPrice.mas_bottom).offset(HeightRate(5));
    }];
    self.lableOriginalPrice = originalPrice;
    
    self.labelTax = [[UILabel alloc]init];
    self.labelTax.text =[NSString stringWithFormat:@"%@",self.model.GoodsAddValue];
    self.labelTax.font = [UIFont systemFontOfSize:AdaptFont(13)];
    self.labelTax.textColor = ColorWithHexString(SymbolTopColor);
    [self.leftView addSubview:self.labelTax];
    
    [self.labelTax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(originalPrice.mas_bottom).offset(HeightRate(5));
        
    }];
    
    self.lableDateEnd = [[UILabel alloc]init];
    self.lableDateEnd.textColor = ColorWithHexString(@"999999");
    self.lableDateEnd.font = SYSTEM_FONT(AdaptFont(12));
//    self.lableDateEnd.text = [NSString stringWithFormat:@"距离结束%@天 %@",self.model.Day,self.model.Hour];//@"距离结束12天 23时12分45秒";
    [self.leftView addSubview:self.lableDateEnd];
    [self.lableDateEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-16));
        make.centerY.mas_equalTo(self.labelTax.mas_centerY).offset(HeightRate(0));
//        make.bottom.mas_equalTo(HeightRate(-10));
    }];
    NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:self.model.Day time:self.model.Hour isShowSecond:YES];
    
    self.lableDateEnd.attributedText = att;
    
    UITableView *superTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 400, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(45)) style:UITableViewStyleGrouped];
    superTable.delegate =self;
    superTable.dataSource = self;
//    superTable.backgroundColor = ColorWithHexString(StandardBlueColor);
    superTable.sectionHeaderHeight =0.1;
    superTable.sectionFooterHeight= 0.1;
    superTable.estimatedRowHeight =100;
    superTable.scrollEnabled = false;
    [self.leftView addSubview:superTable];
    [superTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(888));

        make.top.mas_equalTo(self.lableDateEnd.mas_bottom).offset(HeightRate(15));
    }];
    self.superTable = superTable;
    _scrollView.contentSize = CGSizeMake(ScreenWidth, 1300);

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return HeightRate(30);
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
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
        label.text =@"超级团";
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
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableSection;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
        YHSuperGroupDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell = [[YHSuperGroupDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            
        }
        YHSuperGroupInfoModel *model = self.groupArr[indexPath.row];
//        model.FrontMoney = self.model.FrontMoney;
        [cell setRequestData:model isShowDate:YES];
        cell.joinview.tag = indexPath.row+10;
        [cell.joinview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(joinsuperGroupButtonClick:)] ];
//    cell.dateEnd.text = [countDown countDownWithPER_SEC:indexPath];
    
    
        return cell;
}


-(void)joinsuperGroupButtonClick:(UITapGestureRecognizer *)tap
{
    UIView *joinview = (UIView *)tap.view;
    NSInteger index = joinview.tag-10;
    
//    YHPayViewController *vc = [[YHPayViewController alloc] init];
//    vc.isHidenTopTitle = false;
//    [self.navigationController pushViewController:vc animated:YES];
//   YHJoinSuperGroupView *superView = [[YHJoinSuperGroupView alloc] initWithJoinSuperGroupViewWithprouctExplain:self.model.GoodsExplain depositMoney:@"1000" prouctNumber:@"100" Delegate:self];
//
//    [superView showAnimated];
    YHSuperGroupInfoModel *model11 = self.groupArr[index];
    
    if (model11.IsJoin.integerValue ==1 ) {
        [self.view makeToast:@"您已经加入过该团" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    self.recoderJoinSuccessPath =[NSIndexPath indexPathForRow:index inSection:0];
    NSInteger timeout=[titleTimeArr[index] integerValue];
    
    NSInteger days = (int)(timeout/(3600*24));
    NSInteger hours = (int)((timeout-days*24*3600)/3600);
    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
    NSString *strTime = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", hours, minute, second];
    model11.Hour = strTime;
    model11.Day = [NSString stringWithFormat:@"%ld",days];
    YHSuperGroupConfirmOrderViewController *vc = [[YHSuperGroupConfirmOrderViewController alloc] init];
    self.recoderJoinRow = index;
    vc.supermodel = self.model;
    vc.infomodel =model11;
    self.mySuperId = model11.SuperGroupDetailId;
    vc.recordIdex = self.recordIdex;
    [self.navigationController pushViewController:vc animated:YES];
    
}




#pragma mark--delegate
- (void)superGroupPay:(UIView *)superGroupPayView payIndex:(NSInteger)index
{
    
    if (index ==1) {
        
        
    }else
    {
        
    }
    
}







///／关键字tipsbutton
-(void)tipsButtons:(UIView *)bgview Updata:(NSArray *)tipsArray
{
    CGFloat leftspace = 0;
    CGFloat width = 0;
    
    for (int i = 0; i <tipsArray.count ; i++) {
        
        
        UIImage *image = [UIImage imageNamed:@"tezhengstar"];
        NSString *title =  tipsArray[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat space1 = 8;
        CGFloat space = i==0?12:3;
        leftspace =leftspace+width+space;
        
        button.imageEdgeInsets = UIEdgeInsetsMake(space1, 0, space1, 0);
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:ColorWithHexString(@"666666") forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [button setBackgroundColor:[UIColor clearColor]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.imageTipsView addSubview:button];
        [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
        //根据字体得到nsstring的尺寸
        CGSize size = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:AdaptFont(13)],NSFontAttributeName, nil]];
        width =image.size.width+size.width+6;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftspace);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(30));
        }];
        
    }
}

- (void)configBottomView{
    
   UIView * bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(50));
    }];
    
    UIButton *addItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addItemBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [addItemBtn setTitle:@"邀请好友参团" forState:UIControlStateNormal];
    [addItemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addItemBtn addTarget:self action:@selector(inviteFreightJoniSuperGroup) forControlEvents:UIControlEventTouchUpInside];
    addItemBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [bottomView addSubview:addItemBtn];
    
    [addItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(WidthRate(159));
    }];
    
    UIButton *customSeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [customSeviceBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [customSeviceBtn setTitle:@"小二" forState:UIControlStateNormal];
    [customSeviceBtn setImage:[UIImage imageNamed:@"shouyekefu"] forState:UIControlStateNormal];
    [customSeviceBtn setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
    [customSeviceBtn addTarget:self action:@selector(goChatVC) forControlEvents:UIControlEventTouchUpInside];
    customSeviceBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [bottomView addSubview:customSeviceBtn];
    
    [customSeviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(addItemBtn.mas_left).offset(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = SepratorLineColor;
    [bottomView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
}

-(void)inviteFreightJoniSuperGroup
{
    
    NSString *userID = Userdefault(LOGIN_USERID);
    YHShareView *share = [[YHShareView alloc] initShareWithContentTitle:@"易智造" theOtherTitle:self.model.GroupName image:nil url:[NSString stringWithFormat:@"%@%@/%@",UserSuperGroupIDShareURL,self.model.SuperGroupId,userID] withCancleTitle:@"取消"];
    [share showAnimated];

}
- (void)goChatVC{
    
    //    NSString *storeID = dic[@"StoreId"];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    [[YHMQTTClient sharedClient] sendRequestChatroomCustomerListCMDWith:userID andStoreId:self.model.StoreId];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    vc.hidesBottomBarWhenPushed = YES;
//    vc.isCatagory =  [self.model.CategoryBId ];
    vc.listID = [NSString stringWithFormat:@"%@_%@",self.model.StoreId,userID];
    vc.storeID = self.model.StoreId;
    vc.storeName =self.model.StoreName;
    vc.storeAvata =self.model.StorePhoto;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 倒计时计数

- (void)activeCountDownAction {
    
//    [Tools getHaveNum:11];
    // 1.计算截止时间与当前时间差值
    NSArray *timeArr= [self.model.Hour componentsSeparatedByString:@":"];
    NSString *timeH = timeArr[0];
    NSString *timeM = timeArr[1];
    NSString *timeS = timeArr[2];
    // 计算时间差值
    NSInteger secondsCountDown =self.model.Day.integerValue*24*3600+timeH.integerValue*3600+timeM.integerValue*60+timeS.integerValue;
    
   
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
                        NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:@"0" time:@"00:00:00" isShowSecond:YES];

                        weakSelf.lableDateEnd.attributedText = att;
                    });
                } else { // 倒计时重新计算 时/分/秒
                    
                  
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days == 0) {
                            NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:@"0" time:strTime isShowSecond:YES];
                            weakSelf.lableDateEnd.attributedText = att;
                        } else {
                            NSAttributedString *att = [Tools getFrontStr:@"距离结束" day:[NSString stringWithFormat:@"%ld",days] time:strTime isShowSecond:YES];
                            
                            weakSelf.lableDateEnd.attributedText = att;
                        }
                        
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)startTimer
{
    self.infotimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshLessTime) userInfo:@"" repeats:YES];
    
//    如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:self.infotimer forMode:UITrackingRunLoopMode];
    
}
- (void)refreshLessTime
{
    NSUInteger time;
    for (int i = 0; i < titleTimeArr.count; i++) {
        time = [titleTimeArr[i] integerValue] ;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        YHSuperGroupDetailTableViewCell *cell = (YHSuperGroupDetailTableViewCell *)[self.superTable cellForRowAtIndexPath:indexPath];
        
        cell.dateEnd.text = [NSString stringWithFormat:@"%@",[self lessSecondToDay:time>0?--time:0]];
        
        [titleTimeArr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%ld",time]];
    }
}

- (NSString *)lessSecondToDay:(NSUInteger)seconds
{
    NSUInteger day  = (NSUInteger)seconds/(24*3600);
    NSUInteger hour = (NSUInteger)(seconds%(24*3600))/3600;
    NSUInteger min  = (NSUInteger)(seconds%(3600))/60;
    NSUInteger second = (NSUInteger)(seconds%60);
    
    NSString *time ;
    if (day==0) {
        
        time =seconds==0?@"还剩 00:00:00": [NSString stringWithFormat:@"还剩%02lu：%02lu：%02lu",(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    }else
    {
        time = [NSString stringWithFormat:@"还剩%02lu天%02lu：%02lu：%02lu",(unsigned long)day,(unsigned long)hour,(unsigned long)min,(unsigned long)second];
    }
    return time;
    
}
- (void)dealloc {
    /// 2.销毁
    [self.infotimer invalidate];
    self.infotimer =nil;
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
