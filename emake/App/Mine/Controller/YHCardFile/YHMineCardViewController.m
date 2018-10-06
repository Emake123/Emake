//
//  YHMineCardViewController.m
//  emake
//
//  Created by eMake on 2017/8/16.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHMineCardViewController.h"
#import "YHCardNewCell.h"
#import "YHUploadCardImgaeViewController.h"
#import "UserInfoModel.h"
#import "TPKeyboardAvoidingTableView.h"
#import "ClipViewController.h"
#import "HDPickerView.h"
enum editState
{
    editStateUpload,
    editStateChange,
    editStateSave
};
@interface YHMineCardViewController ()<UITableViewDataSource,UITableViewDelegate,ClipViewControllerDelegate,UITextFieldDelegate>{
    
    UITableView * myTableView;
    
    NSString *fileName;
    
    UIImage *uploadImage;
    
    NSDictionary *cardMessage;
    
    UIImageView *cardImage;
    
    UIImageView *takePhotoImage;
    
    UIButton *uploadBtn;
    
    UIView *backView;
    
    UserInfoModel * userModel;
    
    UILabel *labelTips;
    
    UIButton *deleteBtn;
    
    UILabel *rightBtnLabel;
    
    BOOL editState;

}
@property (nonatomic,retain)UIButton *leftNavBtn;
@property (nonatomic,retain)UIButton *backButton;
@property (nonatomic, strong) HDPickerView *pickerView;
@end

@implementation YHMineCardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title =@"我的名片";
    self.view.backgroundColor = TextColor_F5F5F5;
    cardMessage = [[NSDictionary alloc]init];
    [self addRightNavBtn];
    [self setBackBtn];
    [self getfileName];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserInfo];
    
}
- (void)setLeftNavBtn{
    
    self.leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftNavBtn.frame = CGRectMake(0, 0, 60, 30);
    [self.leftNavBtn setTitle:@"重新拍照" forState:UIControlStateNormal];
    self.leftNavBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(13));
    [self.leftNavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0 );
    [self.leftNavBtn addTarget:self action:@selector(uploadNewCardImage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavBtn];
}
- (void)addEamptyView{
    
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(145))];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(287));
    }];
    
    cardImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    cardImage.image = [UIImage imageNamed:@"wo_mingpian"];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadCardImage)];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(deleteBtnShow)];
    [cardImage addGestureRecognizer:gesture];
    [cardImage addGestureRecognizer:longPressGesture];
    cardImage.userInteractionEnabled=YES;
    [backView addSubview:cardImage];
    
    [cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(37));
        make.right.mas_equalTo(WidthRate(-37));
        make.top.mas_equalTo(HeightRate(39));
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.height.mas_equalTo(HeightRate(206));
    }];
    
    deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"mingpianshanchu"] forState:UIControlStateNormal];
    deleteBtn.hidden = true;
    [deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cardImage.mas_right).offset(WidthRate(-13));
        make.bottom.mas_equalTo(cardImage.mas_top).offset(WidthRate(13));
        make.width.mas_equalTo(WidthRate(23));
        make.height.mas_equalTo(WidthRate(23));
    }];
    

    takePhotoImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    takePhotoImage.image = [UIImage imageNamed:@"wode_shangchuan"];
    [backView addSubview:takePhotoImage];
    
    
    [takePhotoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(cardImage.mas_centerX);
        make.centerY.mas_equalTo(cardImage.mas_centerY);
        make.width.mas_equalTo(WidthRate(52));
        make.height.mas_equalTo(WidthRate(52));
    }];
    
    
    
    labelTips = [[UILabel alloc]init];
    labelTips.font = [UIFont systemFontOfSize:AdaptFont(16)];
    labelTips.textColor = [UIColor whiteColor];
    labelTips.text = @"点击上传名片";
    labelTips.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:labelTips];
    
    
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(takePhotoImage.mas_bottom).offset(HeightRate(12));
        make.width.mas_equalTo(WidthRate(110));
        make.height.mas_equalTo(HeightRate(26));
        make.centerX.mas_equalTo(takePhotoImage.mas_centerX);
    }];
    
}
- (void)configSubView{
    
    myTableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.userInteractionEnabled = false;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];

}
- (void)addRightNavBtn{

    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    rightBtnLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 30)];
    rightBtnLabel.textAlignment = NSTextAlignmentCenter;
    rightBtnLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:rightBtnLabel];

    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightNavBtn.frame = CGRectMake(0, 0, 60, 30);
    rightNavBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0,0 );
    [rightNavBtn addTarget:self action:@selector(uploadCardImage) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightNavBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
}
- (void)deleteBtnShow{
    
    if (uploadImage) {
        
        deleteBtn.hidden = false;
        
    }
}
-(void)deleteImage{
    
    deleteBtn.hidden = true;
    uploadImage = nil;
    cardImage.image = [UIImage imageNamed:@"wo_mingpian"];
    takePhotoImage.hidden = false;
    labelTips.hidden = false;
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [uploadBtn removeFromSuperview];
}
- (void)getfileName{
    
    fileName = [Tools getUploadFileName];
}
#pragma  mark====UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHCardNewCell *cell = nil;
    if (!cell) {
        cell = [[YHCardNewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setData:userModel];
    }
    cell.labelNameText.delegate = self;
    cell.labelNameText.tag = 100;
    cell.labelPhoneText.delegate = self;
    cell.labelPhoneText.tag = 101;
    cell.labelCompanyText.delegate = self;
    cell.labelCompanyText.tag = 102;
    cell.labelAdressText.delegate = self;
    cell.labelAdressText.tag = 103;
    [cell.selectBtn addTarget:self action:@selector(selectDestrict) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HeightRate(443);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return TableViewHeaderNone;
    }else{
        return TableViewFooterNone;
    }
}


- (void)getUserInfo{
    
    userModel = [[UserInfoModel alloc]init];
    
    [[YHJsonRequest shared]getUserInfoSuccessBlock:^(UserInfoModel*model) {
        userModel = model;
        if ([userModel.RawCardUrl isEqualToString:@""]) {
            [backView removeFromSuperview];
            [myTableView removeFromSuperview];
            [self addEamptyView];
        }else{
            [backView removeFromSuperview];
            [myTableView removeFromSuperview];
            [self configSubView];
            [myTableView reloadData];
            if (editState){
                rightBtnLabel.text = @"保存";
                myTableView.userInteractionEnabled = YES;
                [self setLeftNavBtn];
            }else{
                rightBtnLabel.text =@"更换";
            }
        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages];
        if (!userModel.RawCardUrl) {
            [backView removeFromSuperview];
            [myTableView removeFromSuperview];
            [self addEamptyView];
            
        }else{
            [backView removeFromSuperview];
            [myTableView removeFromSuperview];
            [self configSubView];
            rightBtnLabel.text =@"更换";
        }

    }];
}
-(void)setBackBtn{
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"direction_leftNew"] forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(0, 0, 18, 36);
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];

}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)uploadCardImage{
    
    deleteBtn.hidden = true;
    
    if (editState) {
        //调用接口
        [[YHJsonRequest shared]putUserInfo:[userModel mj_keyValues] SuccessBlock:^(NSDictionary *successMessage) {
            [self.view makeToast:@"保存成功" duration:1.0 position:CSToastPositionCenter];
        } fialureBlock:^(NSString *errorMessages) {
            [self.view makeToast:errorMessages];
        }];
        editState = false;
        myTableView.userInteractionEnabled = false;
        [self setBackBtn];
        rightBtnLabel.text =@"更换";
    }else{
        ClipViewController *clip = [[ClipViewController alloc]init];
        clip.delegate = self;
        [self.navigationController pushViewController:clip animated:YES];
        editState = true;
    }
}
- (void)uploadNewCardImage{
    ClipViewController *clip = [[ClipViewController alloc]init];
    clip.delegate = self;
    [self.navigationController pushViewController:clip animated:YES];
    editState = true;
}
-(void)selectDestrict{
    
    [self.view endEditing:YES];
    
    __block YHMineCardViewController *weakSelf = self;
    
    _pickerView  = [HDPickerView selectArea:^(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets) {
        
        weakSelf->userModel.Province = province;
        weakSelf->userModel.City = city;
        [myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    [_pickerView show];
}
#pragma mark---clip--delegate
-(void)didSuccessClipImage:(UIImage *)clipedImage
{
    uploadImage = clipedImage;
    YHUploadCardImgaeViewController *controller = [[YHUploadCardImgaeViewController alloc]init];
    controller.uploadImge = uploadImage;
    [self.navigationController pushViewController:controller animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark===UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 100) {
        userModel.RealName = textField.text;
    }else if (textField.tag == 101){
        userModel.TelCell = textField.text;
    }else if (textField.tag == 102){
        userModel.Company = textField.text;
    }else if (textField.tag == 103){
        userModel.Address = textField.text;
    }}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
