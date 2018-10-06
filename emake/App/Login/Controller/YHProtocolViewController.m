//
//  YHProtocolViewController.m
//  emake
//
//  Created by 谷伟 on 2017/12/12.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHProtocolViewController.h"
#import <WebKit/WebKit.h>
@interface YHProtocolViewController ()
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, retain) UIView *TopView;

@end
@implementation YHProtocolViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (WKWebView *)webView{
    if (!_webView) {
        WKWebView *wk =  [[WKWebView alloc] init];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URL] ];
        [wk loadRequest:urlRequest];
        self.webView = wk;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self configWebViewProgress];
    [self addBackBtn];
}
- (void)addBackBtn{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHEIGHT, ScreenWidth, (TOP_BAR_HEIGHT)-(StatusBarHEIGHT))];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *image2 = [UIImage imageNamed:@"direction_left"];
    [back setImage:image2 forState:UIControlStateNormal];
    [back addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    back.translatesAutoresizingMaskIntoConstraints =NO;
    [view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(10));
        make.top.mas_equalTo(HeightRate(13));
        make.width.mas_equalTo(WidthRate(34));
        make.height.mas_equalTo(HeightRate(18));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = self.titleName;
    label.font =  [UIFont boldSystemFontOfSize:16];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(HeightRate(23));
        make.centerX.mas_equalTo(view.mas_centerX);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = SepratorLineColor;
    
    [view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.view addSubview:view];
}
- (void)goBack{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)configUI {
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(WidthRate(-10));
        make.bottom.mas_equalTo(HeightRate(-10));
    }];
}
- (void)configWebViewProgress {
    
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, (TOP_BAR_HEIGHT) - 2.0f, ScreenWidth, 2.0);
    _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
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
