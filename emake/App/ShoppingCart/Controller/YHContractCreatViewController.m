//
//  YHContractCreatViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHContractCreatViewController.h"
#import "YHContractSighSuccessViewController.h"
#import <WebKit/WebKit.h>
@interface YHContractCreatViewController ()<WKNavigationDelegate,WKUIDelegate,YHAlertViewDelegete>{
    
    NSString *CATEGORY;
}
@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, retain) UIButton *cancleBtn;
@property (nonatomic, retain) UIButton *commitBtn;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, assign) BOOL isPost;
@end

@implementation YHContractCreatViewController

- (WKWebView *)webView{
    if (!_webView) {
        WKWebView *wk =  [[WKWebView alloc] init];
        wk.navigationDelegate = self;
        wk.UIDelegate = self;
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.ContractURL]];
        [wk loadRequest:urlRequest];
        self.webView = wk;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CATEGORY = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    self.view.backgroundColor = TextColor_F7F7F7;

    NSString *titleStr = [self.ContractType isEqualToString:@"0"]?@"销售合同":[self.ContractType isEqualToString:@"1"]?@"销售合同":@"技术协议";
    self.title = titleStr;

    if ([self.ContractType isEqualToString:@"1"]) {//总合同
        [self isContractSighed];

    }else
    {
        [self configUI];
        [self configWebViewProgress];
    }

}
-(void)isContractSighed
{
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] contractIsSighedContractNo:self.contractNo SuccessBlock:^(NSDictionary *successMessage) {
        if (successMessage.count>0) {
            [self.view hideWait:CurrentView];
            NSString *contractState = successMessage[@"ContractState"];
            self.ContractState = contractState;
            [self configUI];
            [self configWebViewProgress];
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];

        [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
    }];
}
- (void)configUI {
    
    
//  ContractType;//0买卖（销售）合同;1完整合同;2技术协议
    BOOL isShow = [self.ContractType isEqualToString:@"0"]?YES:[self.ContractType isEqualToString:@"1"]?YES:NO;
    BOOL isShowM = [self.ContractType isEqualToString:@"1"];
    CGFloat height = isShowM==NO?0.01:HeightRate(43);
    CGFloat webHeight = isShow==YES?(isShowM == YES?([self.IsIncludeTax isEqualToString:@"1"]? HeightRate(90):HeightRate(60)):0.01):0.01;

    
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(0));
        make.bottom.mas_equalTo(-webHeight);
    }];
    //取消合同 、签订合同交互
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_webView];

    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(WidthRate(-10));
        make.bottom.mas_equalTo(-webHeight);
    }];
    
   
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    self.commitBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
   
    if ([self.IsIncludeTax isEqualToString:@"1"]) {
        [self.commitBtn setTitle:@"签订合同" forState:UIControlStateNormal];

    }else
    {
        [self.commitBtn setTitle:@"确认订单" forState:UIControlStateNormal];
    }

    [self.commitBtn addTarget:self action:@selector(creatOrder) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [self.view addSubview:self.commitBtn];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(ScreenWidth);
        make.bottom.mas_equalTo(-HeightRate(5));
        make.height.mas_equalTo(height);
    }];
        self.commitBtn.hidden = !isShow;

    if ([self.ContractType isEqualToString:@"1"]  ) {
        
        UIButton * sendOnlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sendOnlineBtn setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
        sendOnlineBtn.backgroundColor = TextColor_F7F7F7;
        [sendOnlineBtn setImage:[UIImage imageNamed:@"weigouxuan"] forState:UIControlStateNormal];
        [sendOnlineBtn setImage:[UIImage imageNamed:@"yigouxuan"] forState:UIControlStateSelected];
        [sendOnlineBtn setTitle:@"邮寄线下纸质合同" forState:UIControlStateNormal];
        [sendOnlineBtn addTarget:self action:@selector(isPost:) forControlEvents:UIControlEventTouchUpInside];
        sendOnlineBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        sendOnlineBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.isPost = sendOnlineBtn.selected;
        [self.view addSubview:sendOnlineBtn];
        [sendOnlineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.width.mas_equalTo(WidthRate(150));
            make.top.mas_equalTo(self.webView.mas_bottom).offset(HeightRate(8));
            make.height.mas_equalTo(17);
        }];
        if ([self.ContractState isEqualToString:@"0"] ||[self.ContractState isEqualToString:@"-1"]) {
            sendOnlineBtn.hidden = [self.IsIncludeTax isEqualToString:@"1"]?false:true;
           
        }else
        {
            sendOnlineBtn.hidden = true;
            bgview.hidden = true;
            self.commitBtn.hidden = true;
            [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            } ];
        }
    }else
    {
        self.commitBtn.hidden = YES;
    }
}

#pragma mark--button    点击事件

//是否邮寄线下纸质合同isPost
-(void)isPost:(UIButton *)button
{
    button.selected = !button.selected;
    self.isPost = button.selected;
}
//取消合同
-(void)cancleOrder
{
    [self.navigationController popViewControllerAnimated:YES];
}
//生成合同
-(void)creatOrder{
  BOOL  IsIncludeTax = YES;
    NSString *title = IsIncludeTax==YES?@"签订合同":@"确认订单";
    NSArray  *tipArr = IsIncludeTax==YES?@[@"合同签订成功，平台电子合同获得法律效力",@"合同签订成功，30天内未付预付款，合同视为无效"]:@[@"确认销售订单，30天内未付预付款，合同视为无效"] ;
  YHAlertView *alrt =  [[YHAlertView alloc] initWithAlertViewTipsTDelegete:self Title:title tips:tipArr rightButtonTitle:@"确定"];

    [alrt showAnimated];
}

- (void)dealloc{
    
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView stopLoading];
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    _webView = nil;
}

- (void)configWebViewProgress {
    
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - 2.0f, navigationBarBounds.size.width, 2.0);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.navigationController.navigationBar addSubview:self.progressView];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark -alertView delegate
-(void)alertViewRightBtnClick:(id)alertView
{
        NSString *urlStr = [NSString stringWithFormat:@"%@?IsPost=%@",self.contractNo,[NSNumber numberWithBool:self.isPost]];
        [[YHJsonRequest shared] userSignContract:urlStr SuccessBlock:^(NSString *successMessage) {

            YHContractSighSuccessViewController *signVC = [[YHContractSighSuccessViewController alloc] init];
            signVC.contractId = self.contractNo;
            [self.navigationController pushViewController:signVC animated:YES];
            
        } fialureBlock:^(NSString *errorMessages) {
            [self.view hideWait:CurrentView];
            [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        }];
}

#pragma mark - WKNavigationDelegate &  WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.sendDataStr.length>0) {
            YHChatContractModel *chatModel = [YHChatContractModel mj_objectWithKeyValues:self.sendDataStr];
            chatModel.Text =[NSString stringWithFormat:@"%@技术协议已确认",self.contractNo];
           NSString *resultStr = [chatModel mj_JSONString];

        if([message isEqualToString:@"提交成功"]){

        if (self.contractDataBlock) {
            self.contractDataBlock(resultStr);
        }
        [self.navigationController popViewControllerAnimated:YES];
        }
        }
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    completionHandler();
}

#pragma mark---生成PDF文件
-(void)copyPdfToOtherApp:(NSString *)pdfurlStr
{
    NSURL *url = [NSURL URLWithString:pdfurlStr];
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:@[[[UIActivity alloc] init]]];
    
    // hide AirDrop
    activity.excludedActivityTypes = @[UIActivityTypeAirDrop];
    
    // incorrect usage
    
    UIPopoverPresentationController *popover = activity.popoverPresentationController;
    if (popover) {
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    [self presentViewController:activity animated:YES completion:NULL];
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self.view makeToast:error.userInfo[@"NSLocalizedDescription"] duration:3 position:CSToastPositionCenter];
    NSLog(@"didFailProvisionalNavigation---error=%@",error.description);
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
