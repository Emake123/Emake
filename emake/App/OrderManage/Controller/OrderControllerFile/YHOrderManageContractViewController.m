//
//  YHOrderManageContractViewController.m
//  emake
//
//  Created by 袁方 on 2017/7/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHOrderManageContractViewController.h"
#import <WebKit/WebKit.h>

@interface YHOrderManageContractViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation YHOrderManageContractViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"合同展示";
    [self addRigthDetailButtonIsShowCart:false];
    [self configWebViewProgress];
    [self configUI];
}

#pragma mark - Private

- (void)configUI {

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    //取消合同 、签订合同交互
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    NSString *url = [NSString stringWithFormat:@"%@/%@",ContractDisplayURL,self.contractID];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:urlRequest];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-HeightRate(65));
    }];
    UILabel *labelTips = [[UILabel alloc]init];
    labelTips.font = [UIFont systemFontOfSize:14];
    labelTips.numberOfLines = 0;
    labelTips.textAlignment = NSTextAlignmentCenter;
    labelTips.textColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
    labelTips.text =@"交易已经完成，合同已产生法律效力，不可更改或撤销。";
    [self.view addSubview:labelTips];
    
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HeightRate(5));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
}

- (void)configWebViewProgress {
    
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - 2.0f, navigationBarBounds.size.width, 2.0);
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
    }
}
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
