//
//  YHCertificationViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/9.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCertificationViewController.h"
#import "HDPickerView.h"
#import "ClipViewController.h"
#import "UserInfoModel.h"
#import "YHUploadCardImgaeViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHSelectClassifyViewController.h"
@interface YHCertificationViewController ()<YHAlertViewDelegete,ClipViewControllerDelegate>
@property (nonatomic,strong)UITextField *nameTextF;
@property (nonatomic,strong)UITextField *idTextF;
@property (nonatomic,strong)UIButton *destrictTextF;
@property (nonatomic,strong)UIButton *classifyTextF;
@property (nonatomic,strong)UILabel *destrictLabel;
@property (nonatomic,strong)UILabel *classifyLabel;
@property (nonatomic, strong) HDPickerView *pickerView;
@property (nonatomic,retain)UIImageView *cardImage;
@property (nonatomic,retain)UIImageView *takeImage;
@property (nonatomic,retain)UILabel *labelTips;
@property (nonatomic,retain)UserInfoModel *model;
@property (nonatomic,copy)NSString *Province;
@property (nonatomic,copy)NSString *City;
@property (nonatomic,copy)NSString *CategorySelect;
@property (nonatomic,retain)UIView *headView;
@property (nonatomic,retain)UIView *contentView;
@property (nonatomic,retain)UIButton *commitBtn;
@property (nonatomic,retain)UIImage *uploadImage;
@end

@implementation YHCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"合伙人申请";
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.uploadImage){
        self.takeImage.hidden = true;
        self.labelTips.hidden = true;
    }else{
        self.takeImage.hidden = false;
        self.labelTips.hidden = false;
    }
    [self getUserInfo];
}

- (void)configSubViews{
    
    self.headView = [[UIView alloc]init];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(HeightRate(TOP_BAR_HEIGHT));
        make.height.mas_equalTo(HeightRate(151));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text =@"上传名片";
    label.font = SYSTEM_FONT(AdaptFont(14));
    label.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(24));
        make.top.mas_equalTo(HeightRate(24));
        make.height.mas_equalTo(HeightRate(23));
    }];
    
    self.cardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wo_mingpian"]];
    [self.headView addSubview:self.cardImage];
    
    [self.cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(89));
        make.top.mas_equalTo(HeightRate(15));
        make.width.mas_equalTo(WidthRate(176));
        make.height.mas_equalTo(HeightRate(123));
    }];
    
    self.takeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wode_shangchuan"]];
    self.takeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadCardImage)];
    [self.takeImage addGestureRecognizer:gesture];
    [self.headView addSubview:self.takeImage];
    
    [self.takeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.cardImage.mas_centerX);
        make.centerY.mas_equalTo(self.cardImage.mas_centerY);
        make.width.mas_equalTo(WidthRate(52));
        make.height.mas_equalTo(WidthRate(52));
    }];
    
    
    self.labelTips = [[UILabel alloc]init];
    self.labelTips.text =@"点击上传名片";
    self.labelTips.font = SYSTEM_FONT(16);
    self.labelTips.textColor = [UIColor whiteColor];
    self.labelTips.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.labelTips];
    

    [self.labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.takeImage.mas_centerX);
        make.top.mas_equalTo(self.takeImage.mas_bottom);
        make.height.mas_equalTo(HeightRate(26));
    }];
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headView.mas_bottom).offset(HeightRate(6));
        make.height.mas_equalTo(HeightRate(166));

    }];
    
    UILabel *labelName = [[UILabel alloc]init];
    labelName.text = @"真实姓名";
    labelName.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelName];
    
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(HeightRate(7));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
       
    }];
    
    self.nameTextF = [[UITextField alloc]init];
    self.nameTextF.placeholder =@"请输入身份证姓名";
    self.nameTextF.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:self.nameTextF];
    [self.nameTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelName.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(labelName.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *lineOne = [[UILabel alloc]init];
    lineOne.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineOne];
    
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(HeightRate(41));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
        
    }];
    
    UILabel *labelID = [[UILabel alloc]init];
    labelID.text = @"身份证号";
    labelID.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelID];
    
    [labelID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(11));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
        
    }];
    
    self.idTextF = [[UITextField alloc]init];
    self.idTextF.placeholder =@"请填写18位身份证号";
    self.idTextF.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:self.idTextF];
    [self.idTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelID.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(labelID.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *lineTwo = [[UILabel alloc]init];
    lineTwo.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineTwo];
    
    [lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(HeightRate(83));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
    }];
    
    
    UILabel *labelDestrict = [[UILabel alloc]init];
    labelDestrict.text = @"业务区域";
    labelDestrict.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelDestrict];
    
    [labelDestrict mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineTwo.mas_bottom).offset(HeightRate(9));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
    }];
    
    self.destrictTextF = [UIButton buttonWithType:UIButtonTypeCustom];
    self.destrictTextF.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [self.destrictTextF setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
    self.destrictTextF.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.destrictTextF addTarget:self action:@selector(selectDestrict) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.destrictTextF];
    
    [self.destrictTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelDestrict.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(0));
        make.centerY.mas_equalTo(labelDestrict.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UIImageView *leftImage = [[UIImageView alloc]init];
    leftImage.image = [UIImage imageNamed:@"direction_right"];
    [self.contentView addSubview:leftImage];
    
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-11));
        make.width.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(12));
        make.centerY.mas_equalTo(labelDestrict.mas_centerY);
    }];
    
    self.destrictLabel = [[UILabel alloc]init];
    self.destrictLabel.text =@"请选择";
    self.destrictLabel.font = SYSTEM_FONT(AdaptFont(14));
    self.destrictLabel.textColor = TextColor_A8A7A8;
    self.destrictLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.destrictLabel];
    
    
    [self.destrictLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(leftImage.mas_left).offset(-WidthRate(11));
        make.height.mas_equalTo(HeightRate(23));
        make.width.mas_equalTo(WidthRate(200));
        make.centerY.mas_equalTo(labelDestrict.mas_centerY);
    }];
    
    UILabel *lineThree = [[UILabel alloc]init];
    lineThree.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineThree];
    
    [lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(HeightRate(126));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
    }];
    
    UILabel *labelClassify = [[UILabel alloc]init];
    labelClassify.text = @"经营品类";
    labelClassify.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelClassify];
    
    [labelClassify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineThree.mas_bottom).offset(HeightRate(9));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
    }];
    
    self.classifyTextF = [UIButton buttonWithType:UIButtonTypeCustom];
    self.classifyTextF.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
    [self.classifyTextF setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
    self.classifyTextF.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.classifyTextF addTarget:self action:@selector(selectClassify) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.classifyTextF];
    
    [self.classifyTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelClassify.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(0));
        make.centerY.mas_equalTo(labelClassify.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UIImageView *leftImageAnother = [[UIImageView alloc]init];
    leftImageAnother.image = [UIImage imageNamed:@"direction_right"];
    [self.contentView addSubview:leftImageAnother];
    
    [leftImageAnother mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-11));
        make.width.mas_equalTo(WidthRate(12));
        make.height.mas_equalTo(WidthRate(12));
        make.centerY.mas_equalTo(labelClassify.mas_centerY);
    }];
    
    self.classifyLabel = [[UILabel alloc]init];
    self.classifyLabel.text =@"请选择";
    self.classifyLabel.font = SYSTEM_FONT(AdaptFont(14));
    self.classifyLabel.textColor = TextColor_A8A7A8;
    self.classifyLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.classifyLabel];
    
    
    [self.classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(leftImageAnother.mas_left).offset(-WidthRate(11));
        make.height.mas_equalTo(HeightRate(23));
        make.width.mas_equalTo(WidthRate(200));
        make.centerY.mas_equalTo(labelClassify.mas_centerY);
    }];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [self.commitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(HeightRate(53));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(45));
    }];
}
-(void)selectClassify{
    
    YHSelectClassifyViewController *vc = [[YHSelectClassifyViewController alloc]init];
    __block YHCertificationViewController *weakSelf = self;
    vc.block = ^(NSDictionary *Category) {
        if (Category) {
            weakSelf.CategorySelect = [Category objectForKey:@"CategoryId"];
            weakSelf.classifyLabel.textColor = [UIColor blackColor];
            weakSelf.classifyLabel.text = [Category objectForKey:@"CategoryName"];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)selectDestrict{
    
    [self.view endEditing:YES];

    __block YHCertificationViewController *weakSelf = self;
    
    _pickerView  = [HDPickerView selectArea:^(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets) {
        weakSelf.destrictLabel.textColor = [UIColor blackColor];
        weakSelf.destrictLabel.text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
        weakSelf.City = city;
        weakSelf.Province = province;
        
    }];
    [_pickerView show];
}
- (void)commit{
    
    [self.view endEditing:YES];
    if (!self.model.RawCardUrl||self.model.RawCardUrl.length == 0) {
        [self.view makeToast:@"请上传名片" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (!self.nameTextF.text||self.nameTextF.text.length==0) {
        [self.view makeToast:@"请填写真实姓名" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (!self.idTextF.text||self.idTextF.text.length==0) {
        [self.view makeToast:@"请填写身份证号" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (![Tools judgeIdentityStringValid:self.idTextF.text]) {
        [self.view makeToast:@"您填写的身份证号格式不正确" duration:1 position:CSToastPositionCenter];
        return;
    }
    if ([self.destrictLabel.text isEqualToString:@"请选择"]) {
        [self.view makeToast:@"请选择区域" duration:1 position:CSToastPositionCenter];
        return;
    }
    if ([self.classifyLabel.text isEqualToString:@"请选择"]) {
        [self.view makeToast:@"请选择经营品类" duration:1 position:CSToastPositionCenter];
        return;
    }
    //调用接口
    YHAlertView *alertView = [[YHAlertView alloc]initWithDelegete:self image:[UIImage imageNamed:@"zhuyi"] Title:@"实名信息认证通过后将无法修改，是否提交？" leftButtonTitle:@"修改信息" rightButtonTitle:@"确认提交"];
    [alertView showAnimated];
    
}
- (void)uploadCardImage{
    
    ClipViewController *clip = [[ClipViewController alloc]init];
    clip.delegate = self;
    [self.navigationController pushViewController:clip animated:YES];
    
}
#pragma mark ====YHAlertViewDelegete
- (void)alertViewRightBtnClick:(id)alertView{
    
    self.model.PSPDId = self.idTextF.text;
    self.model.RealName = self.nameTextF.text;
    self.model.City = self.City;
    self.model.Province = self.Province;
    NSDictionary *parameters = @{@"PSPDId":self.idTextF.text,@"RawCardUrl":self.model.RawCardUrl,@"Province":self.Province,@"City":self.City,@"RealName":self.nameTextF.text,@"BusinessCategory":self.CategorySelect};
    [[YHJsonRequest shared]userAudit:parameters SuccessBlock:^(NSDictionary *successMessage) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:LOGIN_USERCARDSTATE];
        [[NSUserDefaults standardUserDefaults] setObject:self.CategorySelect forKey:USERSELECCATEGORY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc ]init];
        [self.navigationController pushViewController:vc animated:YES];
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];

    }];
}
#pragma mark =====ClipViewControllerDelegate
-(void)didSuccessClipImage:(UIImage *)clipedImage
{
    self.uploadImage = clipedImage;
    self.cardImage.image = clipedImage;
    YHUploadCardImgaeViewController *controller = [[YHUploadCardImgaeViewController alloc]init];
    controller.uploadImge = self.cardImage.image;
    [self.navigationController pushViewController:controller animated:YES];

}
- (void)getUserInfo{
    
    self.model = [[UserInfoModel alloc]init];
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared]getUserInfoSuccessBlock:^(UserInfoModel*model) {
        [self.view hideWait:CurrentView];
        self.model = model;
        [self.cardImage sd_setImageWithURL:[NSURL URLWithString:self.model.RawCardUrl] placeholderImage:[UIImage imageNamed:@"wo_mingpian"]];
        if (!model.RawCardUrl||model.RawCardUrl.length == 0 ) {
            self.takeImage.hidden = false;
            self.labelTips.hidden = false;
        }else{
            [self.cardImage sd_setImageWithURL:[NSURL URLWithString:model.RawCardUrl]];
            self.takeImage.hidden = true;
            self.labelTips.hidden = true;
        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        self.takeImage.hidden = false;
        self.labelTips.hidden = false;
    }];
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
