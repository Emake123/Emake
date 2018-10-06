//
//  YHInsuranceServersInstructionViewController.m
//  emake
//
//  Created by 谷伟 on 2017/12/15.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHInsuranceServersInstructionViewController.h"
@interface YHInsuranceServersInstructionViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, copy) NSString *HTMLString;
@end

@implementation YHInsuranceServersInstructionViewController
- (UIWebView *)webView{
    if (!_webView) {
        UIWebView *wk =  [[UIWebView alloc] init];
        self.webView = wk;
        self.webView.delegate = self;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleName;
//    [self addRigthDetailButtonIsShowCart:YES];
    [self configUI];
    [self configWebViewProgress];
    [self getHTMLStringData];
}
- (void)getHTMLStringData{
    
    [[YHJsonRequest shared] getUserInsuranceHTMLStringWithID:self.InsuranceID SuccessBlock:^(NSDictionary *successMessage) {
        self.HTMLString = [successMessage objectForKey:@"InsuranceContent"];
        [self.webView loadHTMLString:self.HTMLString baseURL:nil];
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
- (void)configUI {
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
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
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'";
    [_webView stringByEvaluatingJavaScriptFromString:str];
}
- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
