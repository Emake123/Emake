#import "PSVCBase.h"
#import "YHMQTTClient.h"
#import "chatNewModel.h"
#import "chatUserModel.h"
#import "chatBodyModel.h"
#import "MessageModel.h"
#import "UserModel.h"
#import "FMDBManager.h"
#import "SDChatMessage.h"
#import "YHShoppingCartNewViewController.h"
#import "YBPopupMenu.h"
#import "YHMainViewController.h"
#import "YHMainMessageCenterViewController.h"
#import "YHMissonCreatSuccessView.h"
#import "YHTabBarViewController.h"
#import "YHSixTeamViewController.h"
#import "YHMineViewController.h"
#import "YHMineShareCodeViewController.h"
#import "ChatNewViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHCertificationStateOriginalViewController.h"
#import "YHFileModel.h"
#import "YHLoginViewController.h"
#import "YHShareView.h"
#import "YHProductDetailsViewController.h"
#import "MQTTCommandModel.h"
#import "YHMainMessageCenterViewController.h"
#import "YHMineCityDelegateSuccessViewController.h"
static NSString *lastTimeSend;
@interface PSVCBase ()<YHMQTTClientDelegate,YBPopupMenuDelegate>
{
    NSInteger count;
    UILabel *bglable;
}
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * topButton;
@property (nonatomic,assign)BOOL isShowShare;
@property (nonatomic,assign)BOOL isShowChat;

@property (nonatomic, strong) UIButton * rightNavBtn;
@property (nonatomic, strong) UIButton * informationCardBtn;
@property (nonatomic, retain) NSArray * Titles;
@property (nonatomic, retain) NSArray * ICONS;
@property (nonatomic, assign) NSInteger IconWidth;
@property (nonatomic, strong) UIButton * settingBtn;
@property (nonatomic,assign)NSInteger messageMaxCount;
@property (nonatomic,assign)NSInteger Count;
@property (nonatomic,assign)NSInteger MessageCount;

@end

@implementation PSVCBase
- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"direction_leftNew"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(-0, 0, 40, 40);
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10 );
        [_backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [YHMQTTClient sharedClient].delegate = self;
    self.navigationController.navigationBarHidden = NO;
    [self refreshMesssageCount];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificatonGetNewTocken object:nil];
    
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self layoutCustomNavigationBar];
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[self class]]) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAgainLoginVC:) name:NotificatonGetNewTocken object:[Tools currentViewController]];
            
        }
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)){
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMesssageCount:) name:NotificatonChatMessagesCount object:nil];

}
- (void)layoutCustomNavigationBar{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:StatusAndTopBarBackgroundColor]];
    //navbar背景
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundColor:[UIColor colorWithHexString:StatusAndTopBarBackgroundColor]];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    //去除边框
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
}

- (void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

- (void)textFieldDone{
    
    [self.view endEditing:YES];
}
- (void)addRightNavBtn:(NSString *)title{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:AdaptFont(12)] constrainedToSize:CGSizeMake(WidthRate(125), 30)];
    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(20, 0, size.width+20, 30);
    [self.rightNavBtn setTitle:title forState:UIControlStateNormal];
    self.rightNavBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(12));
    [self.rightNavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0 );
    [self.rightNavBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
    
}
- (void)addRightNavBtn:(NSString *)title showColor:(NSString *)myCololr{
    
    [self addRightNavBtn:title];
    [self.rightNavBtn setTitleColor:ColorWithHexString(myCololr) forState:UIControlStateNormal];
   
    
    
}
- (void)addRightNavBtn:(NSString *)title showBordColor:(NSString *)myCololr{
    
    [self addRightNavBtn:title];
    [self.rightNavBtn setTitleColor:ColorWithHexString(myCololr) forState:UIControlStateNormal];
    self.rightNavBtn.layer.borderColor = ColorWithHexString(myCololr).CGColor;
    self.rightNavBtn.layer.borderWidth=1;
    self.rightNavBtn.layer.cornerRadius = 15;
    self.rightNavBtn.clipsToBounds = YES;
    
    
}

- (void)addRightNavBtnWithImage:(NSString *)imageName{
    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(10, 0, 30, 30);
    [self.rightNavBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.rightNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0 );
    [self.rightNavBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
}
-(UIButton *)TopButton:(UIView *)bgview
{
    if (self.topButton ==nil) {
        UIButton *  topBtn = [[UIButton alloc] init];
        [topBtn setImage:[UIImage imageNamed:@"huidaodingbu"] forState:UIControlStateNormal];
        topBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [bgview addSubview:topBtn];
        [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(HeightRate(-75));
            make.right.mas_offset(WidthRate(-5));
            make.width.mas_offset(WidthRate(40));
            make.height.mas_offset(HeightRate(40));
        }];
        self.topButton = topBtn;
    }
    return self.topButton;
}
-(void)refreshMesssageCount{
    NSDictionary *userInfo = [YHMQTTClient sharedClient].messageCountDic ;
    
    NSInteger messageCount =[ userInfo[@"messageCount"] integerValue];
    
//    NSInteger messageCount =  self.MessageCount ;
        NSInteger EventCount = [YHMQTTClient sharedClient].messageCount;
 
    
    

    
    if (self.isShowChat==YES) {
//        NSInteger messageCount = 0;
        if (messageCount>0) {
            if (messageCount>99){
                messageCount = 99;
            }
            bglable.hidden = NO;
            [self addItem:self.settingBtn Bage:messageCount];
            [self addItem: self.informationCardBtn Bage:messageCount];

           
        }else{
            bglable.hidden = YES;
        }
    }
    

        //        NSInteger messageCount = 0;
        if (messageCount>0) {
            if (messageCount>99){
                messageCount = 99;
            }
            bglable.hidden = NO;
            [self addItem: self.informationCardBtn Bage:messageCount];
            
            
        }else{
            bglable.hidden = YES;
        }
    
   
}
- (void)setRightBtnTitle:(NSString *)title{
    
    if([title isEqualToString:@"管理"])
    {
        [self.rightNavBtn setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
    }
    [self.rightNavBtn setTitle:title forState:UIControlStateNormal];
}
- (void)addRigthDetailButtonTeamIsShowCart:(BOOL)isShow{
    
    [self addRigthDetailButtonIsShowCart:false];
    NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    if ([userType isEqualToString:@"1"]) {
        self.Titles  =  @[@"首页", @"消息"];
        self.ICONS =  @[@"shouye-g",@"xiaoxi-g"];
        
    }else{
        self.Titles  =  @[@"首页", @"消息"];
        self.ICONS =  @[@"shouye-g",@"xiaoxi-g"];
        self.IconWidth = 160;
    }
}
- (void)addRigthDetailButtonIsNotChat:(BOOL)isShow{
    
    self.isShowChat = !isShow;
    [self addRigthDetailButtonIsShowCart:false];
}
- (void)addRigthDetailButtonIsShowShare:(BOOL)isShow{
    
    self.isShowShare = isShow;
    [self addRigthDetailButtonIsShowCart:false];
}
- (void)addRigthDetailButtonIsShowCart:(BOOL)isShow{
    self.Titles =  @[@"首页", @"消息"];
    self.ICONS =  @[@"shouye-g",@"xiaoxi-g"];
    self.IconWidth = 120;
    self.informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.informationCardBtn setImage:[UIImage imageNamed:@"xiaoxi-r"] forState:UIControlStateNormal];
    [self.informationCardBtn addTarget:self action:@selector(showMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self.informationCardBtn sizeToFit];
    
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:self.informationCardBtn];
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.hidden = !isShow;
    if (self.isShowChat == false  && self.isShowShare == false) {
        [settingBtn setImage:[UIImage imageNamed:@"gouwuche-b"] forState:UIControlStateNormal];
    }else if(self.isShowChat == YES){
        NSInteger messageCount = self.MessageCount;
        if (messageCount>0) {
            if (messageCount>99){
                messageCount = 99;
            }
            bglable.hidden = NO;
            [self addItem:settingBtn Bage:messageCount];
        }else{
            bglable.hidden = YES;
        }
        settingBtn.hidden = false;
        [settingBtn setImage:[UIImage imageNamed:@"shouyekefu"] forState:UIControlStateNormal];
    }else if (self.isShowShare == YES)
    {
        settingBtn.hidden = false;
        [settingBtn setImage:[UIImage imageNamed:@"wo_fenxiang"] forState:UIControlStateNormal];
        
    }
    [settingBtn addTarget:self action:@selector(goShoppingCartVC) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn sizeToFit];
    self.settingBtn = settingBtn;
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,settingBtnItem];
}

-(UILabel *)addItem:(UIView *)item Bage:(NSInteger)count{
    if(item){
        CGFloat widthF;
        CGFloat heightF;
        if (count>99) {
            widthF = 16;
            heightF = 14;
            
        }else{
            widthF = 14;
            heightF = 14;
        }
        count = count>99?+99:count;
        if (bglable ==nil) {
            bglable = [[UILabel alloc] init];
            bglable.translatesAutoresizingMaskIntoConstraints = NO;
            bglable.clipsToBounds = YES;
            bglable.layer.cornerRadius = 7;
            bglable.backgroundColor = [UIColor redColor];
            bglable.textAlignment = NSTextAlignmentCenter;
            bglable.textColor = [UIColor whiteColor];
            bglable.font = [UIFont systemFontOfSize:9];
            [item addSubview:bglable];
            [bglable PSSetTop:0];
            [bglable PSSetRight:WidthRate(-widthF/2.0)];
            [bglable PSSetSize:widthF Height:heightF];
        }
        bglable.text = [NSString stringWithFormat:@"%ld",count];
        return bglable;
    }else{
        return nil;
    }
}
- (void)showMenuView{
    
    NSInteger EventCount = self.MessageCount;
    [YBPopupMenu showRelyOnView:self.informationCardBtn titles:self.Titles icons:self.ICONS menuWidth:self.IconWidth messgaeCount:EventCount  delegate:self];
}
- (void)goShoppingCartVC{
    
    if (self.isShowChat) {
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        if (phone.length<=0) {
            YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
            loginViewController.navigationController.navigationBarHidden = YES;
            loginViewController.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
        ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
        vc.hidesBottomBarWhenPushed = YES;
        NSString *userID = Userdefault(LOGIN_USERID);
        vc.listID = userID;
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if(self.isShowShare){
        if (self.navigationController.viewControllers) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[YHProductDetailsViewController class]]) {
                    YHProductDetailsViewController *vc1 = (YHProductDetailsViewController *)vc;
                    vc1.shareblock();
                    
                }else if([vc isKindOfClass:[YHMineCityDelegateSuccessViewController class]])
                {
                    YHMineCityDelegateSuccessViewController *vc1 = (YHMineCityDelegateSuccessViewController *)vc;
                    vc1.shareblock();
                }
            }
        }
    }else{
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        if (phone.length<=0) {
            YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
            loginViewController.navigationController.navigationBarHidden = YES;
            loginViewController.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:loginViewController animated:YES];
            return;
        }
        if (self.navigationController.viewControllers) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[YHShoppingCartNewViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
        }
        YHShoppingCartNewViewController  *vc  = [[YHShoppingCartNewViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isBottomViewLow = YES;
        vc.isShowLeftButton = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (void)rightBtnClick:(UIButton *)sender{
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
#pragma mark --- YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    switch (index) {
            //回到首页
        case 0:
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[YHMainViewController class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
            //回到消息
        case 1:{
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
            break;
        case 2:{
            
            YHMainMessageCenterViewController *vc = [[YHMainMessageCenterViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark========YHMQTTClientDelegate
-(void)onMessgae:(NSData *)messgae andTopic:(NSString *)topic{
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:messgae options:NSJSONReadingMutableLeaves error:nil];
    NSString *listID = @"";
    NSArray *topicArray = [topic componentsSeparatedByString:@"/"];
    if (topicArray.count == 2) {
        listID = topicArray[1];
    }else if (topicArray.count == 3) {
        listID = [NSString stringWithFormat:@"%@_%@",topicArray[1],topicArray[2]];
    }
    if (payload) {
        BOOL isContain = false;
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ChatNewViewController class]]) {
                ChatNewViewController *chatVC = (ChatNewViewController *)vc;
                [chatVC onMessgae:messgae andTopic:(NSString *)topic];
                isContain = true;
                return;
            }
        }
        chatNewModel *model = [chatNewModel mj_objectWithKeyValues:payload];
        chatBodyModel *body = [chatBodyModel mj_objectWithKeyValues:model.MessageBody];
        chatUserModel *form = [chatUserModel mj_objectWithKeyValues:model.From];
        form.DisplayName =  form.DisplayName.length>0?form.DisplayName:@"";
        NSString *userId =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        NSString *sender = @"";
        if ([form.UserId isEqualToString:userId]) {
            sender = @"1";
        }else{
            sender = @"0";
        }
        if ([body.Type isEqualToString:@"Text"]){
            [self addToFMDB:body.Text messageId:model.MessageID sender:sender sendTime:model.Timestamp msgType:@"SEND_TEXT" staffName:form.DisplayName staffAvata:form.Avatar withListID:listID clientID:form.ClientID storeInfo:form.Group];
        }else if ([body.Type isEqualToString:@"Image"]){
            [self addToFMDB:body.Image messageId:model.MessageID sender:sender sendTime:model.Timestamp msgType:@"SEND_IMAGE" staffName:form.DisplayName staffAvata:form.Avatar withListID:listID clientID:form.ClientID storeInfo:form.Group];
        }else if ([body.Type isEqualToString:@"MutilePart"]){
            YHChatContractModel *modelContract = [[YHChatContractModel alloc] init];
            modelContract.Text = body.Text;
            modelContract.Image = body.Image;
            modelContract.Url = body.Url;
            modelContract.ContractType = body.ContractType;
            modelContract.ContractNo = body.Contract;
            modelContract.IsIncludeTax = body.IsIncludeTax;
            modelContract.ContractState = body.ContractState;
            [self addToFMDB:[modelContract mj_JSONString] messageId:model.MessageID sender:sender sendTime:model.Timestamp msgType:@"SEND_MutilePart" staffName:form.DisplayName staffAvata:form.Avatar withListID:listID clientID:form.ClientID storeInfo:form.Group];
        }else if ([body.Type isEqualToString:@"Goods"]){
            [self addToFMDB:body.Text messageId:model.MessageID sender:sender sendTime:model.Timestamp msgType:@"SEND_Goods" staffName:form.DisplayName staffAvata:form.Avatar withListID:listID clientID:form.ClientID storeInfo:form.Group];
        }else if ([body.Type isEqualToString:@"Voice"]){
            YHChatVoiceModel *voiceModel = [[YHChatVoiceModel alloc] init];
            voiceModel.VoiceFilePath = body.Voice;
            voiceModel.VoiceLength = body.VoiceDuration;
            NSString *voiceDataStr = [voiceModel mj_JSONString];
            
            NSURL *voiceUrl = [NSURL URLWithString:body.Voice];
            NSString *voiceLastComponent = [voiceUrl lastPathComponent];
            if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getVoicePath:voiceLastComponent]]) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:body.Voice]];
                if (data.bytes>0&&data) {
                    [data writeToFile:[Tools getVoicePath:voiceLastComponent] atomically:YES];
                }
            }
            
            [self addToFMDB:voiceDataStr messageId:model.MessageID sender:sender sendTime:model.Timestamp msgType:@"SEND_Voice" staffName:form.DisplayName staffAvata:form.Avatar withListID:listID clientID:form.ClientID storeInfo:form.Group];
        }else if ([body.Type isEqualToString:@"File"]){
            YHFileModel *modelFile = [YHFileModel mj_objectWithKeyValues:body.Text];
            modelFile.FilePath = body.Url;
            [self addToFMDB:[modelFile mj_JSONString] messageId:model.MessageID sender:sender sendTime:model.Timestamp msgType:@"SEND_File" staffName:form.DisplayName staffAvata:form.Avatar withListID:listID clientID:form.ClientID storeInfo:form.Group];
        }
        
        NSInteger messageCount1111 = [[FMDBManager sharedManager] getUserMessageCount:listID];
        
        messageCount1111 +=1;
        
        [[FMDBManager sharedManager] updateUserMessageCount:5 withListID:listID ];
        NSInteger messageCount11112 = [[FMDBManager sharedManager] getUserMessageCount:listID];

        [self refreshMesssageCount];

    }
    
}
- (void)onCommand:(NSData *)messgae andTopic:(NSString *)topic{
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:messgae options:NSJSONReadingMutableLeaves error:nil];
    NSString *listID = @"";
    NSArray *topicArray = [topic componentsSeparatedByString:@"/"];
    if (topicArray.count == 2) {
        listID = topicArray[1];
    }else if (topicArray.count == 3) {
        listID = [NSString stringWithFormat:@"%@_%@",topicArray[1],topicArray[2]];
    }
    MQTTCommandModel *model = [MQTTCommandModel mj_objectWithKeyValues:payload];
    NSString *currentTime = [NSDate getCurrentTimeStr];
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    if ([model.cmd isEqualToString:@"CustomerAcceptService"]){
        if ([listID containsString:@"_"]) {
            NSArray *part = [listID componentsSeparatedByString:@"_"];
            NSString *serverList = [[FMDBManager sharedManager] getServerListWithStoreID:part[0]];
            NSArray *customer_ids = [serverList mj_JSONObject];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers addObject:model.customer_id];
            [[FMDBManager sharedManager] updateServerList:[customers mj_JSONString] withStoreId:part[0]];
        }else{
            NSArray *customer_ids = [[NSUserDefaults standardUserDefaults] objectForKey:USERREQUESTSERVER];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers addObject:model.customer_id];
            [[NSUserDefaults standardUserDefaults] setObject:customers forKey:USERREQUESTSERVER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSArray *array = [model.customer_id componentsSeparatedByString:@"/"];
        if (array.count==2) {
            NSString *customer = [NSString stringWithFormat:@"客服：%@为你服务",array[1]];
            [self addToAddtionalFMDB:customer messageId:messageIdString sender:@"0" sendTime:currentTime msgType:@"SEND_Tips" staffName:@"" staffAvata:@"" withListID:listID];
        }else if (array.count==3) {
            NSString *customer = [NSString stringWithFormat:@"客服：%@为你服务",array[2]];
            [self addToAddtionalFMDB:customer messageId:messageIdString sender:@"0" sendTime:currentTime msgType:@"SEND_Tips" staffName:@"" staffAvata:@"" withListID:listID];
        }
    }else if ([model.cmd isEqualToString:@"CustomerClosedService"]){
        NSArray *part = [listID componentsSeparatedByString:@"_"];
        if ([listID containsString:@"_"]) {
            NSString *serverList = [[FMDBManager sharedManager] getServerListWithStoreID:part[0]];
            NSArray *customer_ids = [serverList mj_JSONObject];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers removeObject:model.customer_id];
            [[FMDBManager sharedManager] updateServerList:[customers mj_JSONString] withStoreId:part[0]];
        }else{
            NSArray *customer_ids = [[NSUserDefaults standardUserDefaults] objectForKey:USERREQUESTSERVER];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers removeObject:model.customer_id ];
            [[NSUserDefaults standardUserDefaults] setObject:customers forKey:USERREQUESTSERVER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSArray *array = [model.customer_id componentsSeparatedByString:@"customer/"];
        if (array.count>1) {
            NSString *customer = [NSString stringWithFormat:@"客服：%@已离开",array[1]];
            [self addToAddtionalFMDB:customer messageId:messageIdString sender:@"0" sendTime:currentTime msgType:@"SEND_Tips" staffName:@"" staffAvata:@"" withListID:listID];
        }
    }else if ([model.cmd isEqualToString:@"ChatroomCustomerList"]){
        if ([listID containsString:@"_"]) {
            NSArray *part = [listID componentsSeparatedByString:@"_"];
            if ([[FMDBManager sharedManager] serverLisIsAlreadyExist:part[0]]) {
                [[FMDBManager sharedManager] updateServerList:[model.customer_ids mj_JSONString] withStoreId:part[0]];
            }else{
                [[FMDBManager sharedManager] addServerListMessage:[model.customer_ids mj_JSONString] withStoreId:part[0]];
            }
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:model.customer_ids forKey:USERREQUESTSERVER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }else if ([model.cmd isEqualToString:@"UserMessageList"]) {
        
    }
}
- (void)addToFMDB:(NSString *)messageText messageId:(NSString *)messageId sender:(NSString *)sender sendTime:(NSString *)sendTime msgType:(NSString *)sendType staffName:(NSString *)staffName staffAvata:(NSString *)staffAvata withListID:(NSString *)listID clientID:(NSString *)clientId storeInfo:(NSString *)storeInfo{
    NSDictionary *dic =@{@"msg":messageText,@"msgID":messageId,@"sender":sender,@"sendTime":sendTime,@"msgType":sendType,@"staffName":staffName,@"staffAvata":staffAvata,@"Group":storeInfo.length>0?storeInfo:@""};
    SDChatMessage *msg =[SDChatMessage chatMessageWithDic:dic];

    //添加聊天数据
    if (![[FMDBManager sharedManager] messageIsAlreadyExist:messageId withListID:listID]) {
        [[FMDBManager sharedManager] addMessage:msg withListID:listID];
    }
    NSInteger messageCount = [[FMDBManager sharedManager] getUserMessageCount:listID];
    
    //添加聊天列表
    if ([[FMDBManager sharedManager] isChatListAllreadyExistWith:listID]) {
        NSString *jsonStr = [[FMDBManager sharedManager] getStoreInfoFromUserList:listID];
        if (jsonStr.length > 0) {
            msg.Group = jsonStr;
            [[FMDBManager sharedManager] deleteUserListWithListID:listID];
            [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:messageCount];
        }else{
            [[FMDBManager sharedManager] deleteUserListWithListID:listID];
            [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:messageCount];
        }
    }else{
        [[FMDBManager sharedManager] deleteUserListWithListID:listID];
        
        [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:messageCount];
    }
    if ([[Tools currentViewController] isKindOfClass:[YHMainMessageCenterViewController class]]) {
        YHMainMessageCenterViewController *vc =(YHMainMessageCenterViewController *) [Tools currentViewController];
        vc.chatListArray = [[FMDBManager sharedManager] getAllMessageChatList];
        [vc messageRefresh];
    }
    
}
- (void)addToAddtionalFMDB:(NSString *)messageText messageId:(NSString *)messageId sender:(NSString *)sender sendTime:(NSString *)sendTime msgType:(NSString *)sendType staffName:(NSString *)staffName staffAvata:(NSString *)staffAvata withListID:(NSString *)listID{
    messageText = messageText.length ==0?@"":messageText;
    NSDictionary *dic =@{@"msg":messageText,@"msgID":messageId,@"sender":sender,@"sendTime":sendTime,@"msgType":sendType,@"staffName":staffName,@"staffAvata":staffAvata};
    SDChatMessage *msg =[SDChatMessage chatMessageWithDic:dic];
    //添加附加消息聊天数据
    if ([[FMDBManager sharedManager] isChatAdditionalDataExistWith:listID]) {
        [[FMDBManager sharedManager] addAditionalMessage:msg withRecoedMessageID:[NSString stringWithFormat:@"%ld",(long)self.messageMaxCount] withListID:listID];
    }else{
        [[FMDBManager sharedManager] initAdditionalMessageDataBaseWithUserId:listID];
        [[FMDBManager sharedManager] addAditionalMessage:msg withRecoedMessageID:[NSString stringWithFormat:@"%ld",(long)self.messageMaxCount] withListID:listID];
    }
    
}

- (NSString *)getFilePath:(NSString *)MessageId andFileName:(NSString *)fileName{
    
    return [NSString stringWithFormat:@"https://voi-emake-cn.oss-cn-shanghai.aliyuncs.com/file/%@_%@",MessageId,fileName];
}

- (NSString *)getPath:(NSString *)UUID {
    return [NSString stringWithFormat:@"https://img-emake-cn.oss-cn-shanghai.aliyuncs.com/images/%@.png", UUID];
}
-(void)loginAgainLoginVC:(NSNotification *)notifigation{
    
    NSDictionary *dic;
    if (notifigation.userInfo) {
        dic= notifigation.userInfo;
        
    }
    
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        if ([vc isKindOfClass:[self class]]) {
            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_Refresh_Token];
//            if (   token.length>0) {
//                if ([token isEqualToString:dic[@"token"]]) {
    if ([dic[@"code"] isEqualToString:@"401"]) {
        [[YHJsonRequest  shared] getRefreshTockeWith:@{@"refresh_token":token} SuccessBlock:^(NSDictionary *success) {
            NSString *refreshTokenStr = success[@"Refresh_token"];
            NSString *accessTokenStr = success[@"Access_token"];

            [[NSUserDefaults standardUserDefaults] setObject:refreshTokenStr.length>0?refreshTokenStr:@"" forKey:LOGIN_Refresh_Token];//
            [[NSUserDefaults standardUserDefaults] setObject:accessTokenStr.length>0?accessTokenStr:@"" forKey:LOGIN_Access_Token];
//            NSLog(@"LOGIN_Access_Token==%@;;;refreshTokenStr==%@",accessTokenStr,refreshTokenStr);
        } fialureBlock:^(NSString *errorMessages) {
//            [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
            
        }];
    }else
    {
        [[YHMQTTClient sharedClient] disConnect];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:LOGIN_MOBILEPHONE];
        [defaults removeObjectForKey:LOGIN_Refresh_Token];
        [defaults removeObjectForKey:LOGIN_Access_Token];
        [defaults removeObjectForKey:LOGIN_USERNICKNAME];
        [defaults removeObjectForKey:LOGIN_USERTYPE];
        [defaults removeObjectForKey:LOGIN_HeadImageURLString];
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed = YES;
        loginViewController.isLoginValid = YES;
        [loginViewController.view makeToast:@"登录过期"];
        [self.navigationController pushViewController:loginViewController animated:NO];
    }
    
                    
    
//                }
    
//            }
//        }
//    }

}


- (bool)isVisitorLoginByPhoneNumberExits{
    
    NSString *phone =Userdefault(LOGIN_MOBILEPHONE) ;
    
    if(phone.length<=0 )
    {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.navigationController.navigationBar.hidden = YES;
        
        loginViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:loginViewController animated:NO];
        return false;
    }
    return YES;
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
