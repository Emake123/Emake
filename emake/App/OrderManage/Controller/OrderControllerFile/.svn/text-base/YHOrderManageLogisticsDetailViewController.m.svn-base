//
//  YHOrderManageLogisticsDetailViewController.m
//  emake
//
//  Created by 袁方 on 2017/7/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderManageLogisticsDetailViewController.h"

#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

#import <WebKit/WebKit.h>

static CGFloat const ProgressBarHeight = 2.0f;

@interface YHOrderManageLogisticsDetailViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

@end

@implementation YHOrderManageLogisticsDetailViewController

#pragma mark - LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self configWebViewProgress];
    
    [self loadRequest];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.progressView removeFromSuperview];
}

#pragma mark - Private

- (void)configUI {
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    _webView = webView;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)configWebViewProgress {
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - ProgressBarHeight, navigationBarBounds.size.width, ProgressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}


- (void)loadRequest {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: @"https://www.baidu.com/"]];
    [_webView loadRequest:urlRequest];
}

#pragma mark - NJKWebViewProgressDelegate

-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
}

@end
