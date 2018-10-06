//
//  YHTodayPriceViewController.m
//  emake
//
//  Created by 袁方 on 2017/7/17.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHTodayPriceViewController.h"
#import "ChatNewViewController.h"
#import <WebKit/WebKit.h>
#import "YHLoginViewController.h"

@interface YHTodayPriceViewController () <WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) UIButton *rightNavBtn;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, assign) BOOL isReload;
@property (nonatomic, copy) NSString * token;

@end

@implementation YHTodayPriceViewController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    
    [self getTockeData];
    if (![self.webView canGoBack] || self.webView ==nil) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLanguageLocalizedString(@"today price");
    self.view.backgroundColor = [UIColor whiteColor];
//    [self addRightNavBtn:@"我要询价"];
}
-(void)getTockeData
{

        [self configUI];
        [self configWebViewProgress];
        if (![self.webView canGoBack]) {
            self.navigationItem.leftBarButtonItem = nil;
        }
        
    
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
    [Tools cleanCacheAndCookie];
}
- (void)addRightNavBtn:(NSString *)title{
    
    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(15, 0, 70, 30);
    self.rightNavBtn.layer.cornerRadius = 5;
    [self.rightNavBtn setTitle:title forState:UIControlStateNormal];
    self.rightNavBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(13));
    [self.rightNavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightNavBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    self.rightNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0 );
    [self.rightNavBtn addTarget:self action:@selector(enquiryPrice) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavBtn];
}

-(void)back:(UIButton *)button
{
    //返回上一级网页
    if ([self.webView canGoBack]) {
        [_webView goBack];
    }else    //返回app主界面
    {
        [super back:button];
    }
}
#pragma mark - IBActions

- (void)enquiryPrice {
    NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    if (phone.length<=0) {
        YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
        loginViewController.navigationController.navigationBarHidden = YES;
        loginViewController.hidesBottomBarWhenPushed =YES;
        loginViewController.hidesBottomBarWhenPushed = YES;
        [[Tools currentNavigationController] pushViewController:loginViewController animated:YES];
        return ;
    }
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
//    ChatNewViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Chat"];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.listID = userId;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private


- (void)configUI{
    WKWebView *wk =  [[WKWebView alloc] init];
    NSString *catagoryId = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    NSString *url =[NSString stringWithFormat:@"%@/%@",TodayPriceUrl,catagoryId];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [wk loadRequest:urlRequest];
    wk.navigationDelegate = self;
    wk.UIDelegate = self;
    self.webView = wk;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
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
            [self.progressView removeFromSuperview];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }else if(object == self.webView && [keyPath isEqualToString:@"canGoBack"]){
         NSInteger canGoBack = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        if (canGoBack == 1) {
            self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.backBtn setImage:[UIImage imageNamed:@"direction_leftNew"] forState:UIControlStateNormal];
            self.backBtn.frame = CGRectMake(-30, 0, 50, 50);
            self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0 );
            [self.backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];;
        }else{
            
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
    // 当内容开始返回时调用
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




- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
   
    [self.webView.scrollView.mj_header endRefreshing];
    NSLog(@"didFinishNavigation");

    // 禁用选中效果
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none'" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    completionHandler();
}

/** 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件*/
- (void)clearCache
{
    /* 取得Library文件夹的位置*/
    NSString *libraryDir =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    /* 取得bundle id，用作文件拼接用*/
    NSString *bundleId  = @"com.cn.emake.emake";//  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    /*
     * 拼接缓存地址，具体目录为App/Library/Caches/你的APPBundleID/fsCachedData
     */
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* 取得目录下所有的文件，取得文件数组*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    
    NSLog(@"路径==%@,fileList%@",webKitFolderInCachesfs,fileList);
    /* 遍历文件组成的数组*/
    for(NSString * fileName in fileList){
        /* 定位每个文件的位置*/
        NSString * path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:@""];
        /* 将文件转换为NSData类型的数据*/
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        /* 如果FileData的长度大于2，说明FileData不为空*/
        if(fileData.length >2){
            /* 创建两个用于显示文件类型的变量*/
            int char1 =0;
            int char2 =0;
            
            [fileData getBytes:&char1 range:NSMakeRange(0,1)];
            [fileData getBytes:&char2 range:NSMakeRange(1,1)];
            /* 拼接两个变量*/
            NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
            /* 如果该文件前四个字符是6033，说明是Html文件，删除掉本地的缓存*/
            if([numStr isEqualToString:@"6033"]){
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",webKitFolderInCachesfs,fileName]error:&error];
                continue;
            }
            
        }
    }
}
@end
