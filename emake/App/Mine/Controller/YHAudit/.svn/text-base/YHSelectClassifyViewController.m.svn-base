//
//  YHSelectClassifyViewController.m
//  emake
//
//  Created by 谷伟 on 2017/12/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSelectClassifyViewController.h"
#import "YHMainCatagoryModel.h"
@interface YHSelectClassifyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,retain)UICollectionView *collectionView;
@property (nonatomic,retain)UIButton *commitBtn;
@property (nonatomic,retain)NSArray *classArray;
//@property (nonatomic,retain)NSArray *classArray;

@end

@implementation YHSelectClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"经营品类";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubViews];
    [self getData];
}
- (void)configSubViews{
    
    self.view.backgroundColor = ColorWithHexString(@"F2F2F2");
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(100));
    }];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commitBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    self.commitBtn.layer.cornerRadius = 6;
    [self.commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(33));
        make.right.mas_equalTo(WidthRate(-33));
        make.top.mas_equalTo(self.collectionView.mas_bottom).offset(HeightRate(15));
        make.height.mas_equalTo(HeightRate(45));
    }];
}
- (void)getData{
    [self.view showWait:@"加载中" viewType:CurrentView];
    
    [[YHJsonRequest shared] addVisitorsLoginSuccessBlock:^(NSArray *categoryDict) {
       
        [self.view hideWait:CurrentView];
        self.classArray = [NSArray arrayWithArray:categoryDict];
//            self.CategoryArr = [NSMutableArray arrayWithArray:categoryDict];
//            self.storeBtnArr = [NSMutableArray arrayWithCapacity:categoryDict.count];
        [self.collectionView reloadData];

        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
    
}
- (void)commit{
    
 
    
        for (YHMainCatagoryModel *model in self.classArray) {
            if (model.isSelect == YES) {
                NSDictionary *dict = [model mj_keyValues];
                [self updateClassify:dict];
            }
            
        }
}
- (void)updateClassify:(NSDictionary *)dict{
    if (dict.count == 0) {
        [self.view makeToast:@"您还未选择经营品类" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([dict objectForKey:@"CategoryId"]) {
        
        self.block(dict);
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonShowCatagoryCommitBtn object:dict];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark -----UICollectionViewDelegate & UICollectionViewDataSources
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.classArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    for(UIView * subView in item.subviews){
        if(subView){
            [subView removeFromSuperview];
        }
    }
    if (!item) {
        item = [[UICollectionViewCell alloc]init];
    }
    UILabel *btn = [[UILabel alloc]initWithFrame:item.bounds];
    btn.textAlignment = NSTextAlignmentCenter;
    btn.backgroundColor = [UIColor whiteColor];
//    NSDictionary *dict = self.classArray[indexPath.row];
    
    YHMainCatagoryModel *model = self.classArray[indexPath.row];
    btn.text = model.CategoryName;
    btn.font = SYSTEM_FONT(AdaptFont(12));
    btn.tag = indexPath.item + 100;
    if (model.isSelect ==YES) {
        btn.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor;
        btn.textColor = ColorWithHexString(StandardBlueColor);
    }else
    {
        btn.layer.borderColor = SepratorLineColor.CGColor;
        btn.textColor = TextColor_2B2B2B;
       
    }
    btn.layer.borderWidth = 1;
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 3;

    [item addSubview:btn];
    return item;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthRate(71), HeightRate(31));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return WidthRate(16);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return HeightRate(10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(HeightRate(37), WidthRate(23), HeightRate(0), WidthRate(10));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for ( int i = 0;i <self.classArray.count;i++ ) {
        YHMainCatagoryModel *model = self.classArray[i];
        if (i == indexPath.row) {
            model.isSelect = YES;
        }else
        {
            model.isSelect = false;
        }
    }
    
    [collectionView reloadData];
//    NSArray *indexPathsArray = [collectionView indexPathsForVisibleItems];
//    for (NSIndexPath *index in indexPathsArray) {
//            UICollectionViewCell *item = [collectionView cellForItemAtIndexPath:index];
//            NSArray *views = item.subviews;
//            for (UILabel *view in views) {
//                if ([view isKindOfClass:[UILabel class]]) {
//                    UILabel *btn = (UILabel *)view;
//                    if (btn.tag == (indexPath.row + 100)) {
//                        btn.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
//                        btn.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
//                    }else{
//                        btn.layer.borderColor = SepratorLineColor.CGColor;
//                        btn.textColor = TextColor_2B2B2B;
//                
//                    }
//                }
//            }
//    }
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
