//
//  YHAdviceFeedBackViewController.m
//  emake
//
//  Created by 谷伟 on 2018/6/1.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHAdviceFeedBackViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TZImagePickerController.h"
#import "TZLocationManager.h"
#import "UIView+Layout.h"
#import "YHAdviceFeedBackSuccessViewController.h"
@interface YHAdviceFeedBackViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic,strong)PlaceholderTextView *textView;
@property (nonatomic,strong)UICollectionView *pictureCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *dataImageURLString;
@end

@implementation YHAdviceFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self addRigthDetailButtonIsShowCart:false];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.dataImageURLString = [NSMutableArray arrayWithCapacity:0];
    [self configSubViews];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoradDown) name:UIKeyboardWillHideNotification object:nil];
   
}
- (void)configSubViews{
    
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
    [self.view addSubview:self.scrollView];
    
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(40))];
    HeaderView.backgroundColor = TextColor_F5F5F5;
    [self.scrollView addSubview:HeaderView];

    UILabel *label = [[UILabel alloc]init];
    label.text = @"请描述反馈内容";
    label.textColor = TextColor_333333;
    label.font = SYSTEM_FONT(AdaptFont(12));
    [HeaderView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.centerY.mas_equalTo(HeaderView.mas_centerY);
    }];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, HeightRate(40), ScreenWidth, HeightRate(343))];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:contentView];
    
    UILabel *labelTime = [[UILabel alloc]init];
    labelTime.text = @"反馈时间";
    labelTime.font = SYSTEM_FONT(AdaptFont(13));
    [contentView addSubview:labelTime];
    
    [labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.top.mas_equalTo(HeightRate(16));
    }];
    
    UILabel *lableTimeText = [[UILabel alloc]init];
    lableTimeText.text = [NSDate getCurrentTime];
    lableTimeText.font = SYSTEM_FONT(AdaptFont(13));
    [contentView addSubview:lableTimeText];
    
    [lableTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelTime.mas_right).offset(WidthRate(20));
        make.centerY.mas_equalTo(labelTime.mas_centerY);
    }];
    
    
    UILabel *lineOne = [[UILabel alloc]init];
    lineOne.backgroundColor = SepratorLineColor;
    [contentView addSubview:lineOne];
    
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(50));
        make.left.mas_equalTo(WidthRate(22));
        make.right.mas_equalTo(WidthRate(-23));
        make.height.mas_equalTo(HeightRate(1));
    }];
    
    UILabel *labelContent = [[UILabel alloc]init];
    labelContent.text = @"反馈内容";
    labelContent.font = SYSTEM_FONT(AdaptFont(13));
    [contentView addSubview:labelContent];
    
    [labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(14));
    }];
    
    self.textView = [[PlaceholderTextView alloc]initWithFrame:CGRectZero];
    self.textView.delegate = self;
    self.textView.font = SYSTEM_FONT(AdaptFont(13));
    self.textView.placeholder = @"请填写10-100字的问题描述以便我们提供更好的服务";
    self.textView.placeholderColor = TextColor_999999;
    [contentView addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.right.mas_equalTo(WidthRate(-23));
        make.top.mas_equalTo(labelContent.mas_bottom).offset(HeightRate(15));
        make.height.mas_equalTo(HeightRate(102));
    }];
    
    
    UILabel *lineTwo = [[UILabel alloc]init];
    lineTwo.backgroundColor = SepratorLineColor;
    [contentView addSubview:lineTwo];
    
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textView.mas_bottom).offset(HeightRate(10));
        make.left.mas_equalTo(WidthRate(22));
        make.right.mas_equalTo(WidthRate(-23));
        make.height.mas_equalTo(HeightRate(1));
    }];
    
    
    UILabel *labelPicture = [[UILabel alloc]init];
    labelPicture.text = @"图片(选填)";
    labelPicture.font = SYSTEM_FONT(AdaptFont(13));
    [contentView addSubview:labelPicture];
    
    [labelPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.top.mas_equalTo(lineTwo.mas_bottom).offset(HeightRate(14));
    }];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.pictureCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.pictureCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pictureCollectionView.backgroundColor = [UIColor whiteColor];
    self.pictureCollectionView.scrollEnabled = NO;
    self.pictureCollectionView.delegate = self;
    self.pictureCollectionView.dataSource = self;
    [self.view addSubview:self.pictureCollectionView];
    [self.pictureCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [contentView addSubview:self.pictureCollectionView];
    
    [self.pictureCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.right.mas_equalTo(WidthRate(-23));
        make.top.mas_equalTo(labelPicture.mas_bottom).offset(HeightRate(14));
        make.height.mas_equalTo(HeightRate(69));
    }];
    
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(0, HeightRate(416), WidthRate(322), HeightRate(40));
    commitButton.centerX = self.scrollView.centerX;
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    commitButton.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    commitButton.layer.cornerRadius = WidthRate(3);
    [self.scrollView addSubview:commitButton];
    
    UILabel *tipsLabel = [[UILabel alloc]init];
    tipsLabel.hidden = true;
    tipsLabel.frame = CGRectMake(0, HeightRate(434), WidthRate(320), HeightRate(37));
    tipsLabel.centerX = self.scrollView.centerX;
    tipsLabel.textColor = TextColor_999999;
    tipsLabel.numberOfLines = 2;
    tipsLabel.font = SYSTEM_FONT(AdaptFont(13));
    tipsLabel.text = @"友情提示：对于您的意见反馈，我们会在1-3个工作日与您联系。";
    [contentView addSubview:tipsLabel];
}
- (void)commit{
    if (!self.textView.text||self.textView.text.length<=0) {
        [self.view makeToast:@"请填写反馈内容" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.textView.text&&self.textView.text.length<10) {
        [self.view makeToast:@"您输入的文字内容不足10字" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.textView.text&&self.textView.text.length>100) {
        [self.view makeToast:@"您输入的文字内容已超过100字" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    [self.view showWait:@"提交中" viewType:CurrentView];
    NSDictionary *params = @{@"Content":self.textView.text,@"Photos":[self.dataImageURLString mj_JSONString]};
    [[YHJsonRequest shared] appFeedbackWithParameters:params SuccessBlock:^(NSDictionary *Success) {
        [self.view hideWait:CurrentView];
        YHAdviceFeedBackSuccessViewController *vc = [[YHAdviceFeedBackSuccessViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
- (void)keyBoradDown{
    
    [self.scrollView scrollsToTop];
}
- (void)delete:(UIButton *)sender{
    NSInteger tag = sender.tag - 100;
    [self.dataArray removeObjectAtIndex:tag];
    if (self.dataImageURLString.count >0) {
        if (self.dataImageURLString.count > tag) {
            [self.dataImageURLString removeObjectAtIndex:tag];
        }
    }
    [self.pictureCollectionView reloadData];
}
#pragma mark---UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count >=3) {
        return 3;
    }
    return self.dataArray.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, WidthRate(60),  HeightRate(60))];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *image = [[UIImageView alloc]init];
    image.image = nil;
    image.contentMode = UIViewContentModeScaleAspectFit;
    if (self.dataArray.count >=3) {
        image.image = self.dataArray[indexPath.item];
    }else{
        if (indexPath.item != self.dataArray.count) {
            image.image = self.dataArray[indexPath.item];
        }else{
            image.image = [UIImage imageNamed:@"shangchuantupian"];
        }
    }

    [cell.contentView addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.tag = 100 + indexPath.item;
    [deleteBtn setImage:[UIImage imageNamed:@"shanchuanniu"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    if (self.dataArray.count>=3) {
        [cell.contentView addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(WidthRate(20));
            make.height.mas_equalTo(WidthRate(20));
        }];
    }else{
        if (self.dataArray.count != indexPath.item) {
            [cell.contentView addSubview:deleteBtn];
            [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(WidthRate(20));
                make.height.mas_equalTo(WidthRate(20));
            }];
        }
    }
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthRate(60), HeightRate(60));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return WidthRate(15);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(HeightRate(5), WidthRate(0), HeightRate(5), WidthRate(0));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == self.dataArray.count) {
        [self pushTZImagePickerController];
    }
}
#pragma mark ----UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    PlaceholderTextView *view = (PlaceholderTextView *)textView;
    view.placeholder = @"";
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    PlaceholderTextView *view = (PlaceholderTextView *)textView;
    if (view.text.length == 0 ||!view.text) {
        view.placeholder = @"请填写10-100字的问题描述以便我们提供更好的服务";
    }
}
#pragma mark----
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    //    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    //    if (self.maxCountTF.text.integerValue > 1) {
    // 1.设置目前已经选中的图片数组
    //    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    }
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = false;
    imagePickerVc.needCircleCrop = false;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = WidthRate(20);
    NSInteger widthHeight = self.view.tz_width - 2 * left;
    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    imagePickerVc.isStatusBarDefault = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photos.count <= 0) {
            return ;
        }else{
            [self postPictureToServers:photos[0]];
        }
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)postPictureToServers:(UIImage *)image{
    
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSString *imageDataStr = encodedImageStr;
    [self.view showWait:@"图片上传中" viewType:CurrentView];
    NSString *timeNumberStr =[NSDate getCurrentTimeStr];
    [[OSSClientLike sharedClient] uploadObjectAsync:image withFileName:timeNumberStr succcessBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view hideWait:CurrentView];

            [self.dataArray addObject:image];
            [self.pictureCollectionView reloadData];
            NSString * imageStr =  [NSString stringWithFormat:@"https://img-emake-cn.oss-cn-shanghai.aliyuncs.com/images/%@.png", timeNumberStr];
            [self.dataImageURLString addObject:imageStr];
        });

        
    } failBLock:^{
        [self.view hideWait:CurrentView];
        [self.view makeToast:@"上传失败" duration:1.0 position:CSToastPositionCenter];
        
    }];
//    [[YHJsonRequest shared] uploadIDCardImageWithURLpostSevice:imageDataStr SuccessBlock:^(NSString *successMessage) {
//        [self.view hideWait:CurrentView];
//        [self.dataArray addObject:image];
//        [self.pictureCollectionView reloadData];
//        [self.dataImageURLString addObject:successMessage];
//    } fialureBlock:^(NSString *errorMessages) {
//        [self.view hideWait:CurrentView];
//        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
//    }];
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
