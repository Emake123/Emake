//
//  YHOrderContractViewController.m
//  emake
//
//  Created by 张士超 on 2018/1/15.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHOrderContractViewController.h"
#import "YBPopupMenu.h"
#import <WebKit/WebKit.h>
#import "ClipViewController.h"
#import "OSSClientLike.h"
#import "YHActionSheetView.h"
#import "YHcontractImageModel.h"

@interface YHOrderContractViewController ()<YBPopupMenuDelegate,WKNavigationDelegate,WKUIDelegate,YHActionSheetViewDelegete,UIDocumentInteractionControllerDelegate,YHAlertViewDelegete>
{
    BOOL isShowRightEvent;
    BOOL ishidenRightButton;
    NSInteger count;
    UIView *emptyVieww;

}
@property (nonatomic,retain)YHTitleView *selectView;
@property(nonatomic, strong)UIButton *tipSButton;
@property(nonatomic, strong)UIButton *commitButton;
@property(nonatomic, strong)UIButton *cancelButton;

@property(nonatomic, strong)UICollectionView *imageCollection;

@property(nonatomic, strong)UIScrollView  *scrolview;

@property(nonatomic, strong)NSArray *titleArr;
@property(nonatomic, strong)NSArray *iconsArr;
@property(nonatomic, strong)NSMutableArray *addImageStrArr;
@property(nonatomic, strong)NSMutableArray *addImageModelArr;

@property(nonatomic, strong)NSMutableArray *addImageRefArr;

@property (nonatomic, retain) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@property(nonatomic,strong)UIDocumentInteractionController *documentInteractionController;
@property(nonatomic,strong)NSMutableData *data;

@property(nonatomic,strong)NSString *PDFStr;

//// 下载文件显示
//
//@property (weak, nonatomic)  UIImageView *imageView;
//// 下载进度条显示
//
//@property (weak, nonatomic)  UIProgressView *progressView;

@end

@implementation YHOrderContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRigthDetailButtonIsShowCart:false];
    self.title = @"销售合同";
    [self getPdfData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.progressView removeFromSuperview];
    [MobClick event:@"Contract" label:@"合同"];
}

-(void)copytopdf:(UIButton *)button
{
   
    [self copyPdfToOtherApp];
    
}

-(void)getPdfData
{
    [[YHJsonRequest shared] getAppContractPDFWithparams:@{@"ContractNo":self.contractID} SuccessBlock:^(NSString *success) {
        self.PDFStr = success;
        [self configUI:success];

    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}




#pragma mark - Private

- (void)configUI:(NSString *)pdfStr {

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    //取消合同 、签订合同交互
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 2, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)) configuration:configuration];
//    NSString *url = [NSString stringWithFormat:@"%@/%@",ContractDisplayURL,self.contractID];
//    NSString *url = [NSString stringWithFormat:@"%@/%@.pdf",UserContractPDFURL,self.contractID];
//    NSString *urlStr = [NSString stringWithFormat:@"%@/%@.pdf",UserContractPDFURL,self.contractID];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:pdfStr]];
    [_webView loadRequest:urlRequest];
    [self.view addSubview:self.webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(-WidthRate(10));
        make.height.mas_equalTo(ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(50));
    }];
     [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self configWebViewProgress];
    
    UIButton *otherbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    otherbutton.translatesAutoresizingMaskIntoConstraints = NO;
    otherbutton.backgroundColor =ColorWithHexString(StandardBlueColor) ;
    [otherbutton setTitle:@"用其他应用打开" forState:UIControlStateNormal];
    otherbutton.layer.cornerRadius = 3;
    otherbutton.clipsToBounds = YES;
    [otherbutton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    otherbutton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [otherbutton addTarget:self action:@selector(copytopdf:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:otherbutton];
    [otherbutton PSSetSize:WidthRate(325) Height:HeightRate(36)];
    [otherbutton PSSetLeft:WidthRate(25)];
    [otherbutton PSSetBottom:HeightRate(10)];


    
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



#pragma mark---clipviewDelegate 生成PDF文件
-(void)copyPdfToOtherApp{
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@/%@.pdf",UserContractPDFURL,self.contractID];
    [self downloadPDF:self.PDFStr];
}

-(void)downloadPDF:(NSString *)pdfUrl{

    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {

 
        //远程地址
        //默认配置
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //AFN3.0+基于封住URLSession的句柄
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        //请求
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pdfUrl]];
        
        //下载Task操作
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
            // @property int64_t totalUnitCount;     需要下载文件的总大小
            // @property int64_t completedUnitCount; 当前已经下载的大小
            
            // 给Progress添加监听 KVO
            NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
            
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
            
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            //        response.suggestedFilename
            NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",self.contractID]];
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            //设置下载完成操作
            // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
            _documentInteractionController = [UIDocumentInteractionController
                                              interactionControllerWithURL:filePath];
            [_documentInteractionController setDelegate:self];
            [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
                    }];
        [downloadTask resume];
    }else
    {
        [self.view makeToast:@"当前网络断开或网速缓慢，请检查网络"];
    }
    
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