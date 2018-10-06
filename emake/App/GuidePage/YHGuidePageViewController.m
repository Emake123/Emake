//
//  YHGuidePageViewController.m
//  emake
//
//  Created by 谷伟 on 2018/6/1.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHGuidePageViewController.h"
#import "YHTabBarViewController.h"
@interface YHGuidePageViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIPageControl *pageControl;
@end

@implementation YHGuidePageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:false];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self getcatagoryID];

    [self configSubViews];
}
-(void)getcatagoryID
{
    [[YHJsonRequest shared] getCatagoryIDsSuccessBlock:^(NSArray *success) {
        
        if (success.count>0) {
            [[NSUserDefaults standardUserDefaults] setObject:success forKey:CatagoryIDs];
            
            
        }else
        {
            [self.view makeToast:@"数据异常" duration:1.5 position:CSToastPositionCenter];
        }
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
        
    }];
    
}

- (void)configSubViews{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.contentSize = CGSizeMake(ScreenWidth *3, ScreenHeight);
    scrollView.bounces = false;
    [self.view addSubview:scrollView];
    for (int i = 0; i<3; i++) {
        NSString *pictureName = [NSString stringWithFormat:@"GuidePage%d",i+1];
        UIImageView *guideImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:pictureName]];
        guideImage.backgroundColor = [UIColor whiteColor];
        guideImage.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight);
        [scrollView addSubview:guideImage];
        if (i == 2) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(goTransition) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(ScreenWidth*i+WidthRate((ScreenWidth-200)/2), ScreenHeight - HeightRate(60), WidthRate(200), HeightRate(50));
            [scrollView addSubview:button];
        }
    }
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth/3, 30)];
    self.pageControl.center = CGPointMake(ScreenWidth/2, ScreenHeight-HeightRate(15));
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = 3;
    
    
}
- (void)goTransition{
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    [useDef setBool:YES forKey:ISFRISTLOGIN];
    [useDef synchronize];
    self.block();
}
#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ScreenWidth;
    self.pageControl.currentPage = index;
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
