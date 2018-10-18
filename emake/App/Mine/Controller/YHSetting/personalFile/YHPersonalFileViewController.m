 //
//  YHPersonalFileViewController.m
//  emake
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHPersonalFileViewController.h"
#import "YHPersonalFileCommonCell.h"
#import "HYPersonalFileHeaderTableViewCell.h"
#import "OSSClientLike.h"
#import "YHSexChangeViewController.h"
#import "YHChangeNickNameViewController.h"
#import "UserInfoModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "YHSettingItemCell.h"
#import "YHMemberExperienceViewController.h"
#import "YHMineCityDelegateSuccessViewController.h"
#import "YHMineMemberInterestViewController.h"
@interface YHPersonalFileViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate,UIAlertViewDelegate>{
    
    UITableView *myTableView;
    
    UIImage *uploadImage;
    
    NSDictionary *userInfo;
    
    NSArray * userArry;
    
    UserInfoModel *userModel;
}
@property (strong, nonatomic) CLLocation *location;
@property (copy, nonatomic) NSString *uploadImageID;
@property (copy, nonatomic) NSString *uploadImageString;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (copy, nonatomic) NSString *myVipState;
@property (assign, nonatomic) NSInteger mySection;

@end

@implementation YHPersonalFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"个人资料";
    [self addRigthDetailButtonIsShowCart:YES];
    
    self.myVipState = Userdefault(VipState);
    NSString * HidenVip =Userdefault(HidenCatagoryVip);
    self.mySection = HidenVip.integerValue==0?1:( self.myVipState.integerValue==0 ?1:2);
    
    [self getUserInfo];
    [self configUI];
 
}
- (void)configUI{
    
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.frame.size.width, HeightRate(91+47*5)) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorColor = SepratorLineColor;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}
- (void)getUserInfo{
    userModel = [[UserInfoModel alloc]init];
    [[YHJsonRequest shared]getUserInfoSuccessBlock:^(UserInfoModel*model) {
        userModel = model;
        [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark====UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        YHSettingItemCell *cell = nil;
        if (!cell) {
            
            cell = [[YHSettingItemCell alloc]init];
            cell.contentImage.hidden = false;
            
            if (indexPath.row==0) {
                cell.title.text =@"会员权益";
                cell.contentImage.image= [UIImage imageNamed:@"huiyuanbiaozhi"];
                cell.lineLabel.hidden = true;
            }else
            {
                cell.title.text =@"城市代理商";
                cell.contentImage.image= [UIImage imageNamed:@"dailishangbiaozhi"];
                cell.lineLabel.hidden = true;
            }
            
        }
        return cell;
        
    }else
    {
        if(indexPath.row==0) {
            HYPersonalFileHeaderTableViewCell *cell = nil;
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"HYPersonalFileHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"HYPersonalFileHeaderTableViewCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"HYPersonalFileHeaderTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell.uploadBtn addTarget:self action:@selector(uploadHeadImage) forControlEvents:UIControlEventTouchUpInside];
                NSString *urlString = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_HeadImageURLString];
                [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"login_logo"]];
                
            }
            return cell;
        }else{
            YHPersonalFileCommonCell *cell = nil;
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"YHPersonalFileCommonCell" bundle:nil] forCellReuseIdentifier:@"YHPersonalFileCommonCell"];
                cell = (YHPersonalFileCommonCell *)[tableView dequeueReusableCellWithIdentifier:@"YHPersonalFileCommonCell"];
                switch (indexPath.row) {
                    case 5:
                        cell.title.text =@"用户名";
                        if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
                            cell.contentForTitle.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
                        }else{
                            cell.contentForTitle.text = @"未登录";
                        }
                        cell.rightImage.hidden = false;
                        
                        break;
                    case 1:{
                        cell.title.text =@"昵称";
                        NSString *nickName = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_USERNICKNAME];
                        if (nickName) {
                            cell.contentForTitle.text = nickName;
                        }else{
                            NSString *phone = Userdefault(LOGIN_MOBILEPHONE);
                            NSString *subStr;
                            if (phone.length>10) {
                                subStr = [phone substringFromIndex:7];

                            }else
                            {
                                subStr = phone;
                            }
                            cell.contentForTitle.text =[NSString stringWithFormat:@"用户%@",subStr]; //@"还是空的，快来取个有逼格的名字吧";
                        }
                    }
                        break;
                    case 2:
                        cell.title.text =@"性别";
                        if ([userModel.Sex isEqualToString:@"0"]) {
                            cell.contentForTitle.text =@"男";
                        }else if ([userModel.Sex isEqualToString:@"1"]){
                            cell.contentForTitle.text =@"女";
                        }else{
                            cell.contentForTitle.text =@"保密";
                        }
                        break;
                    default:
                        break;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
        }
        
        
    }
   
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mySection;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        if (self.myVipState.integerValue==1) {
            return 2;
        }else
        {
            return 1;
        }
    }
    return  3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        return HeightRate(46);
    }else
    {
        if (indexPath.row == 0) {
            return  HeightRate(91);
        }else{
            return  HeightRate(46);
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
            
        case 0:{
            if (indexPath.section==1) {
                if (self.myVipState.integerValue==3) {
                    NSString *date ;
                    if (userModel.IdentityCategorys.count>0) {
                        date =userModel.IdentityCategorys.firstObject[@"EndAt"];
                    }
                    
                    YHMemberExperienceViewController *vc = [[YHMemberExperienceViewController alloc] init];
                    vc.hidesBottomBarWhenPushed =YES;
                    vc.VipCount = userModel.VipCount;
                    vc.VipDate = date;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                } else {
                    
                    YHMineMemberInterestViewController *vc = [[YHMineMemberInterestViewController alloc] init];
                    vc.hidesBottomBarWhenPushed =YES;
                    vc.isExperienceVip = userModel.UserIdentity.integerValue ==0?false:YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }break;
        case 1:{
            if (indexPath.section==1) {
                YHMineCityDelegateSuccessViewController *vc =[[YHMineCityDelegateSuccessViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else
            {
                YHChangeNickNameViewController *vc = [[YHChangeNickNameViewController alloc]init];
                vc.nickName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];
                vc.block = ^(NSString *nickName) {
                    NSString *urlString = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_HeadImageURLString];
                    if (!urlString||urlString.length <= 0) {
                        urlString = @"";
                    }
                    [[YHJsonRequest shared]upDateNickName:nickName AndHeadImage:urlString SuccessBlock:^(NSString *data) {
                        [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:LOGIN_USERNICKNAME];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                        
                    } fialureBlock:^(NSString *error) {
                        
                        [self.view makeToast:error];
                    }];
                };
                
                [self.navigationController pushViewController:vc animated:YES];

            }
            
          }
            
        }
            break;
        //昵称
        case 2:{
            YHSexChangeViewController *vc = [[YHSexChangeViewController alloc]init];
            vc.sex = userModel.Sex ;
            vc.block = ^(NSString *num) {
                
                
                userModel.Sex = num;
                userInfo = [userModel mj_keyValues];
                
                [[YHJsonRequest shared]putUserInfo:userInfo SuccessBlock:^(NSDictionary *successMessage) {
                    [self getUserInfo];
//                    [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                } fialureBlock:^(NSString *errorMessages) {
                    [self.view makeToast:errorMessages];
                }];
                
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        //性别
        case 3:{
           
        }
            break;
        default:
            break;
    }
}
#pragma mark --- method

- (void)uploadHeadImage{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"照相机", nil];
    [sheet showInView:self.view];
    
}
- (void)uploadCardImage{
    [self getHeadImageURL];
    [self.view showWait:@"上传中" viewType:CurrentView];
    [[OSSClientLike sharedClient] uploadObjectAsync:uploadImage withFileName:self.uploadImageID succcessBlock:^{
        [self updateHeadImage];
    } failBLock:^{
        [self.view hideWait:CurrentView];
        [self.view makeToast:@"上传失败"];
    }];
}
- (void)getHeadImageURL{
    NSString *headImageIdString = [[NSUUID UUID] UUIDString];
    self.uploadImageID = headImageIdString;
    NSString *urlString = [NSString stringWithFormat:@"https://img-emake-cn.oss-cn-shanghai.aliyuncs.com/images/%@.png",headImageIdString];
    self.uploadImageString = urlString;
    [[NSUserDefaults standardUserDefaults] setObject:urlString forKey:LOGIN_HeadImageURLString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)updateHeadImage{
    
    NSString *nickName =@"";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_USERNICKNAME]) {
        nickName = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_USERNICKNAME];
    }
    [[YHJsonRequest shared]upDateNickName:nickName AndHeadImage:self.uploadImageString SuccessBlock:^(NSString *data) {
        
            [self.view hideWait:CurrentView];
            [self.view makeToast:data duration:1.0 position:CSToastPositionCenter];
            [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
       
    } fialureBlock:^(NSString *error) {
        
        [self.view hideWait:CurrentView];
        [self.view makeToast:error];
    }];
}
- (void)pushImagePickerController {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        [self pushTZImagePickerController];
        
    }else if (buttonIndex == 1) {
        if ([Tools isTakePhoto]) {
            [self pushImagePickerController];
        }
        
    }
}
#pragma mark - TZImagePickerController

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
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
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
            uploadImage = photos[0];
            [self uploadCardImage];
        }
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = NO;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                       // 允许裁剪,去裁剪
                        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                            uploadImage = cropImage;
                            [self uploadCardImage];
                        }];
                        imagePicker.needCircleCrop = YES;
                        imagePicker.circleCropRadius = WidthRate(150);
                        [self presentViewController:imagePicker animated:YES completion:nil];
                    }];
                }];
            }
        }];
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
