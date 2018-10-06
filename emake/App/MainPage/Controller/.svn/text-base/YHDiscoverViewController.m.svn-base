//
//  YHDiscoverViewController.m
//  emake
//
//  Created by 张士超 on 2018/5/10.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHDiscoverViewController.h"
#import <WebKit/WebKit.h>
#import "YHMineShareCodeViewController.h"
#import "YHMainMessageCenterViewController.h"
#import "YBPopupMenu.h"
@interface YHDiscoverViewController ()<WKNavigationDelegate,WKUIDelegate,YBPopupMenuDelegate>
@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) UIButton *rightNavBtn;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL isReload;

@property (nonatomic, strong) UIButton * informationCardBtn;
@property (nonatomic, retain) NSArray * Titles;
@property (nonatomic, retain) NSArray * ICONS;
@property (nonatomic, assign) NSInteger IconWidth;
@property (nonatomic, strong) UIButton * tipSButton;

@property (nonatomic, assign) BOOL isShowshare;
@property (nonatomic, copy) NSString *message;
@end




@implementation YHDiscoverViewController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    self.view.backgroundColor = [UIColor whiteColor];
        [self configWebViewProgress];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image2 = [UIImage imageNamed:@"direction_leftNew"];//direction_left copy  direction_left
    [back setImage:image2 forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    back.translatesAutoresizingMaskIntoConstraints =NO;
    [self.view addSubview:back];
    if (ScreenHeight == 812) {
        [back PSSetTop:HeightRate(50)];
    }else{
        [back PSSetTop:HeightRate(26)];
    }
    [back PSSetLeft:WidthRate(10)];
    [back PSSetSize:WidthRate(34) Height:HeightRate(34)];
    
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.text = @"发现";
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment =  NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:titleLable];
    titleLable.translatesAutoresizingMaskIntoConstraints = NO;
    [titleLable PSSetCenterX];
    [titleLable PSSetCenterHorizontalAtItem:back];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    line.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:line];
    [line PSSetBottomAtItem:back Length:HeightRate(5)];
    [line PSSetSize:ScreenWidth Height:1];
    [line addSubview:self.progressView];

    [self configUI:line];

    
    self.tipSButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tipSButton setImage:[UIImage imageNamed:@"xiaoxi-r"] forState:UIControlStateNormal];
    [self.tipSButton setImage:[UIImage imageNamed:@"goodsdetail_share"] forState:UIControlStateSelected];


    [self.tipSButton addTarget:self action:@selector(showMenuView) forControlEvents:UIControlEventTouchUpInside];
    self.tipSButton.translatesAutoresizingMaskIntoConstraints =NO;
    [self.view addSubview:self.tipSButton];
    if (ScreenHeight == 812) {
        [self.tipSButton PSSetTop:HeightRate(50)];
    }else{
        [self.tipSButton PSSetTop:HeightRate(26)];
    }
    [self.tipSButton PSSetRight:WidthRate(10)];
    [self.tipSButton PSSetSize:WidthRate(34) Height:HeightRate(34)];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
    [Tools cleanCacheAndCookie];
}


- (void)showMenuView{
    if (self.isShowshare ==NO){
        NSArray * TITLES =  @[@"首页", @"消息"];
        NSArray * ICONS =  @[@"shouye-g",@"xiaoxi-g"];
        [YBPopupMenu showRelyOnView:self.tipSButton titles:TITLES icons:ICONS menuWidth:WidthRate(130) messgaeCount:0 delegate:self];
    }else{
        [self iosOriginalShare:self.message];
    }
}

-(void)back:(UIButton *)button
{
    //返回上一级网页
    if ([self.webView canGoBack]) {
        [_webView goBack];
        
    }
    //返回app主界面
    else{
        [super back:button];
    }
}


#pragma mark - Private


- (void)configUI:(UILabel *)toplable{
    WKWebView *wk =  [[WKWebView alloc] init];
    NSString *catagory = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    NSString *urlStr;
    if (catagory.length>0) {
         urlStr = [NSString stringWithFormat:@"%@/%@",DiscoverUrl,catagory];
    }else
    {
        urlStr = [NSString stringWithFormat:@"%@",DiscoverUrl];

    }
   NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60 ];
    [wk loadRequest:urlRequest];
    wk.navigationDelegate = self;
    wk.UIDelegate = self;
    self.webView = wk;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(toplable.mas_bottom).offset(HeightRate(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}

- (void)configWebViewProgress {
    
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, 0, navigationBarBounds.size.width, 2.0);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

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
    }else if(object == self.webView && [keyPath isEqualToString:@"canGoBack"]){
        NSInteger canGoBack = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (canGoBack == 1) {
            self.isShowshare = YES;
            self.tipSButton.selected = YES;
        }else{
            self.tipSButton.selected = NO;
            self.isShowshare = NO;
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    

    // 禁用选中效果
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    if (!str||str.length<=0) {
        NSString *iphone= [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        if (!iphone||iphone.length<=0) {
            str = @"";
        }else{
            str = iphone;
        }
    }
    NSString *iphone= [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    if (!iphone||iphone.length<=0) {
        iphone = @"";
    }
    NSString *gettStr = [NSString stringWithFormat:@"%@:%@",str,iphone];
    NSString *baseStr = [[gettStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    NSString *stringJS = [NSString stringWithFormat:@"localStorage.setItem('Authorization','%@')",baseStr];
    [self.webView evaluateJavaScript:stringJS completionHandler:nil];
   
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

        completionHandler();
}

-(void)iosOriginalShare:(NSString *)shareUrlStr{
  //分享的标题
    NSString *textToShare = @"易智造资讯";
  //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];//login_logo
    //分享的url
    NSURL *urlToShare = self.webView.URL;//[NSURL URLWithString:@"http://chrispangpang.github.io"];
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[urlToShare,textToShare,imageToShare];

    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"分享 成功completed");
            //分享 成功
        } else  {
            NSLog(@"分享 取消cancled");
            //分享 取消
        }
    };
}

- (void)dealloc{
    
    [self.progressView removeFromSuperview ];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"canGoBack"];

    [_webView stopLoading];
    _webView.UIDelegate = nil;
    _webView.navigationDelegate = nil;
    _webView = nil;
}
@end



