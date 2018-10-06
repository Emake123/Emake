//
//  YHCertificationSuccessViewController.m
//  emake
//
//  Created by 谷伟 on 2017/11/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCertificationSuccessViewController.h"
#import "YHSelectClassifyViewController.h"
#import "YHCertificationStateViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import "HDPickerView.h"
#import "Tools.h"
#import "YHMineViewController.h"

@interface YHCertificationSuccessViewController ()<YHAlertViewDelegete>
{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
    NSString *state;
    BOOL isShowAlert;

}
@property (nonatomic, strong) HDPickerView *pickerView;

@property (nonatomic,strong)UITextField *nameTextF;
@property (nonatomic,strong)UITextField *idTextF;
@property (nonatomic,strong)UITextField *phoneTextF;
@property (nonatomic,strong)UITextField *companyTextF;
@property (nonatomic,strong)UITextView *companyAdressTextF;


@property (nonatomic,strong)UIButton *destrictTextF;
@property (nonatomic,strong)UILabel *destrictLabel;
@property (nonatomic,retain)UIView *headView;
@property (nonatomic,retain)UIView *contentView;
@property (nonatomic,retain)UIImageView *cardImage;
@property (nonatomic,retain)UIImageView *idcardImage;
@property (nonatomic,retain)UIImageView *idBackcardImage;

@property (nonatomic,retain)UIImageView *takeImage;
@property (nonatomic,retain)UILabel *labelTips;
@property (nonatomic,retain)UserInfoModel *model;

@property (nonatomic,strong)UIButton *classifyTextF;
@property (nonatomic,strong)UILabel *classifyLabel;
@property (nonatomic,strong)UIButton *commitBtn;
@property (nonatomic,copy)NSString *CategorySelect;

@property (nonatomic,strong)UIImage *idImage;
@property (nonatomic,copy)NSString *idBackImage;
@property (nonatomic,copy)NSString *idBackImageUrl;
@property (nonatomic,copy)NSString *idImageUrl;
@property (nonatomic,copy)NSString *cardImageUrl;

@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *city;


@end

@implementation YHCertificationSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"合伙人申请";
    self.view.backgroundColor = TextColor_F5F5F5;
    
    state = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERCARDSTATE];

    [self configSubViews];
    [self getUserInfo];
    [self configCallback];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isShowCommitButton:) name:NotificatonShowCatagoryCommitBtn object:nil];

}
-(void)back:(UIButton *)button
{
    [super back:button];
    if (self.isback == YES) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[YHMineViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
                
            }
        }
        self.tabBarController.selectedIndex = 4;
    }
}
//通知回调
-(void)isShowCommitButton:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    if ([dic[@"CategoryId"] isEqualToString:self.model.BusinessCategory]) {
        if (![state isEqualToString:@"4"]) {
            self.commitBtn.hidden = TRUE;
            self.labelTips.hidden = true;

        }
    } else {
        self.labelTips.hidden = false;
        self.commitBtn.hidden = false;
        self.CategorySelect = dic[@"CategoryId"];
        self.classifyLabel.text = [NSString stringWithFormat:@"%@",dic[@"CategoryName"]];
    }
    if ([state isEqualToString:@"3"]) {
        isShowAlert = YES;
    }
    
}

- (void)configSubViews{
    
    TPKeyboardAvoidingScrollView *scroll = [[TPKeyboardAvoidingScrollView alloc] init];
    scroll.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.scrollEnabled = YES;
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(HeightRate(TOP_BAR_HEIGHT));
        make.height.mas_equalTo(ScreenHeight-(TOP_BAR_HEIGHT));
    }];
    CGFloat headviewHeight;
    if (_isfail == NO) {
        headviewHeight = 10;

    }else
    {
      [self progress:scroll];
      headviewHeight = 50;
    }
//    self.headView = [[UIView alloc]init];
//    self.headView.backgroundColor = [UIColor whiteColor];
//    [scroll addSubview:self.headView];
//    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(ScreenWidth);
//        make.top.mas_equalTo(HeightRate(headviewHeight));
//        make.height.mas_equalTo(HeightRate(350));
//    }];
    
////  上传名片
//    UILabel *label = [[UILabel alloc]init];
//    label.text =@"我的名片";
//    label.font = SYSTEM_FONT(AdaptFont(14));
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.headView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WidthRate(24));
//        make.top.mas_equalTo(HeightRate(24));
//        make.height.mas_equalTo(HeightRate(23));
//    }];
//
//    self.cardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mingpian"]];
//    self.cardImage.contentMode = UIViewContentModeScaleAspectFit;
//    [self.headView addSubview:self.cardImage];
//    self.cardImage.userInteractionEnabled = YES;
//    [self.cardImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadCardButtonClick)]];
//    [self.cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WidthRate(24));
//        make.top.mas_equalTo(label.mas_bottom).offset(HeightRate(5));
//        make.width.mas_equalTo(WidthRate(158.5));
//        make.height.mas_equalTo(HeightRate(123));
//    }];
//
//
//
//    UILabel *line = [[UILabel alloc] init];
//    line.backgroundColor = SepratorLineColor;
//    [self.headView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WidthRate(0));
//        make.top.mas_equalTo(self.cardImage.mas_bottom).offset(HeightRate(5));
//        make.width.mas_equalTo(ScreenWidth);
//        make.height.mas_equalTo(1);
//    }];
//
//    //  上传身份证(正面)
//    UILabel *Idlabel = [[UILabel alloc]init];
//    Idlabel.text =@"我的身份证";
//    Idlabel.font = SYSTEM_FONT(AdaptFont(14));
//    Idlabel.textAlignment = NSTextAlignmentCenter;
//    [self.headView addSubview:Idlabel];
//
//    [Idlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WidthRate(24));
//        make.top.mas_equalTo(line.mas_bottom).offset(10);
//        make.height.mas_equalTo(HeightRate(23));
//    }];
//
//    self.idcardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenfenzheng-zheng"]];
//    [self.headView addSubview:self.idcardImage];
//    self.idcardImage.contentMode = UIViewContentModeScaleAspectFit;
//    self.idcardImage.userInteractionEnabled = YES;
//    [self.idcardImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadIDCardButtonClick)]];
//    [self.idcardImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(WidthRate(24));
//        make.top.mas_equalTo(Idlabel.mas_bottom).offset(HeightRate(5));
//        make.width.mas_equalTo(WidthRate(158.5));
//        make.height.mas_equalTo(HeightRate(123));
//    }];
//
////    UIImageView *deleteImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardDelete"]];
////    [self.idcardImage addSubview:deleteImage1];
////    [deleteImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.mas_equalTo(WidthRate(5));
////        make.top.mas_equalTo(HeightRate(3));
////        make.width.mas_equalTo(WidthRate(24));
////        make.height.mas_equalTo(HeightRate(24));
////
////    }];
//
//
//    //  上传身份证(反面)
//    self.idBackcardImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shenfenzheng-fan"]];
//    [self.headView addSubview:self.idBackcardImage];
//    self.idBackcardImage.contentMode = UIViewContentModeScaleAspectFit;
//    self.idBackcardImage.userInteractionEnabled = YES;
//    [self.idBackcardImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadIDBackCardButtonClick)]];
//    [self.idBackcardImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.idcardImage.mas_right).offset(HeightRate(10));
//        make.top.mas_equalTo(Idlabel.mas_bottom).offset(HeightRate(5));
//        make.width.mas_equalTo(WidthRate(158.5));
//        make.height.mas_equalTo(HeightRate(123));
//    }];
////    UIImageView *deleteImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardDelete"]];
////    [self.idBackcardImage addSubview:deleteImage2];
////    [deleteImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.mas_equalTo(WidthRate(5));
////        make.top.mas_equalTo(HeightRate(3));
////        make.width.mas_equalTo(WidthRate(24));
////        make.height.mas_equalTo(HeightRate(24));
////
////    }];
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(HeightRate(headviewHeight));
//        make.top.mas_equalTo(self.headView.mas_bottom).offset(HeightRate(6));
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
    
    UILabel *labelPhone = [[UILabel alloc]init];
    labelPhone.text = @"手机号码";
    labelPhone.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelPhone];
    
    [labelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineTwo.mas_bottom).offset(HeightRate(11));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
        
    }];
    
    self.phoneTextF = [[UITextField alloc]init];
    self.phoneTextF.placeholder =@"请填写手机号码";
    self.phoneTextF.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:self.phoneTextF];
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelPhone.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(labelPhone.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *lineTwo2 = [[UILabel alloc]init];
    lineTwo2.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineTwo2];
    [lineTwo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(self.phoneTextF.mas_bottom).offset(HeightRate(11));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
    }];
    
    UILabel *labelCompany = [[UILabel alloc]init];
    labelCompany.text = @"单位名称";
    labelCompany.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelCompany];
    [labelCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineTwo2.mas_bottom).offset(HeightRate(11));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
        
    }];
    
    self.companyTextF = [[UITextField alloc]init];
    self.companyTextF.placeholder =@"请填入单位名称";
    self.companyTextF.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:self.companyTextF];
    [self.companyTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelCompany.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(20));
        make.centerY.mas_equalTo(labelCompany.mas_centerY);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *lineTwo3 = [[UILabel alloc]init];
    lineTwo3.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineTwo3];
    [lineTwo3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(self.companyTextF.mas_bottom).offset(HeightRate(11));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
    }];
    
    UILabel *labelCompanyAdress = [[UILabel alloc]init];
    labelCompanyAdress.text = @"公司地址";
    labelCompanyAdress.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelCompanyAdress];
    
    [labelCompanyAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineTwo3.mas_bottom).offset(HeightRate(11));
        make.width.mas_equalTo(WidthRate(65));
        make.height.mas_equalTo(HeightRate(23));
        
    }];
    
    self.companyAdressTextF = [[UITextView alloc]init];
    self.companyAdressTextF.font = SYSTEM_FONT(AdaptFont(14));
//    self.companyAdressTextF.text = @"请填写公司地址";
//    self.companyAdressTextF.textColor = SepratorLineColor;
    [self.contentView addSubview:self.companyAdressTextF];
    [self.companyAdressTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labelCompanyAdress.mas_right).offset(WidthRate(30));
        make.right.mas_equalTo(WidthRate(-10));
        make.centerY.mas_equalTo(labelCompanyAdress.mas_centerY);
        make.height.mas_equalTo(HeightRate(40));
    }];
    
    UILabel *lineTwo4 = [[UILabel alloc]init];
    lineTwo4.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineTwo4];
    [lineTwo4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(self.companyAdressTextF.mas_bottom).offset(HeightRate(11));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
    }];
    
    UILabel *labelDestrict = [[UILabel alloc]init];
    labelDestrict.text = @"业务区域";
    labelDestrict.font = SYSTEM_FONT(AdaptFont(14));
    [self.contentView addSubview:labelDestrict];
    
    [labelDestrict mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(lineTwo4.mas_bottom).offset(HeightRate(9));
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
    leftImage.hidden = [state isEqualToString:@"3"]?true:false;
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
        make.top.mas_equalTo(self.destrictLabel.mas_bottom).offset(HeightRate(11));
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
    [self.classifyTextF addTarget:self action:@selector(goCategoryVC) forControlEvents:UIControlEventTouchUpInside];
    self.classifyTextF.titleLabel.textAlignment = NSTextAlignmentRight;
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
    
    UILabel *lineFour= [[UILabel alloc]init];
    lineFour.backgroundColor = SepratorLineColor;
    [self.contentView addSubview:lineFour];
    
    [lineFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(self.classifyLabel.mas_bottom).offset(HeightRate(11));
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(0.5));
        make.bottom.mas_equalTo(HeightRate(-1));

    }];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [self.commitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:self.commitBtn];
    self.commitBtn.hidden = [state isEqualToString:@"3"]?true:false;

    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo (0);
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(HeightRate(20));
        make.right.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(HeightRate(45));
    }];
    
    NSString *commitTipsStr = @"遇到问题您可以联系客服";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:commitTipsStr];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(APP_THEME_MAIN_COLOR)
                    range:NSMakeRange(commitTipsStr.length-4 , 4)];
    [attrStr addAttribute:NSUnderlineStyleAttributeName
                    value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                    range:NSMakeRange(commitTipsStr.length-4, 4)];
    UILabel *lable = [[UILabel alloc] init];
    lable.attributedText = attrStr;
    lable.font = SYSTEM_FONT(AdaptFont(13));
    [scroll addSubview:lable];
    lable.userInteractionEnabled = YES;
   lable.hidden = [state isEqualToString:@"3"]?true:false;
    [lable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(customerSevicerClick)]];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (WidthRate(24));
        make.top.mas_equalTo(self.commitBtn.mas_bottom).offset(HeightRate(20));
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(HeightRate(45));
        
    }];
    self.labelTips = lable;
}
//联系客服
-(void)customerSevicerClick
{
    NSString *telStr = @"400-8670-211";
    UIWebView *callWebView = [[UIWebView alloc] init];
    NSURL *telURL          = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];
}
#pragma mark---业务区域

-(void)selectDestrict{
    
    [self.view endEditing:YES];
    
    __block YHCertificationSuccessViewController *weakSelf = self;
    
    _pickerView  = [HDPickerView selectArea:^(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets) {
        
        weakSelf.destrictLabel.text = [NSString stringWithFormat:@"%@%@",province,city];

        weakSelf.province = province;
        weakSelf.city = city;
        
    }];
    [_pickerView show];
}
#pragma mark---buttonclick
-(void)uploadCardButtonClick//获取名片图片：image
{  
    if([Tools isTakePhoto]==YES){
        
        UIViewController * vc =
        [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard
                                     andImageHandler:^(UIImage *image) {
                                         
                                         
                                         [self postServersURL:image];
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
        
//        (更改百度ocr) UI 调用相机界面image下面的title
        for (id object in vc.childViewControllers) {
            if ([object isKindOfClass:[UIViewController class]]  ) {
                // 对 object 进行了判断，它一定是 UIView 或其子类
                UIViewController * vc1 = (UIViewController *)object;
                for (id object1 in vc1.view.subviews) {
                    if ([object1 isKindOfClass:[UILabel class]]) {
                        UILabel * lable = (UILabel *)object1;
                        lable.textColor =lable.backgroundColor;
                        UILabel *showLable = [[UILabel alloc] init];
                        showLable.text = @"请将名片放置在拍照区域";
                        showLable.font = lable.font;
                        showLable.backgroundColor = lable.backgroundColor;
                        showLable.textColor = [UIColor whiteColor];
                        showLable.clipsToBounds = YES;
                        showLable.layer.cornerRadius = lable.layer.cornerRadius;
                        showLable.textAlignment = NSTextAlignmentCenter;
                        showLable.translatesAutoresizingMaskIntoConstraints = NO;
                        [lable addSubview:showLable];
                        [showLable PSSetConstraint:0 Right:0 Top:0 Bottom:0];

                        }
                }
            }
        }
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

-(void)uploadIDBackCardButtonClick
{
    if([Tools isTakePhoto]==YES){

        UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack
                                 andImageHandler:^(UIImage *image) {
        self.idBackcardImage.image =  image;
        [self uploadIDCardWithImage:image IdBack:YES];
        [[AipOcrService shardService] detectIdCardBackFromImage:image withOptions:nil  successHandler:nil failHandler:_failHandler];
        [self dismissViewControllerAnimated:YES completion:nil];
                                
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
    }
}
-(void)uploadIDCardButtonClick
{
    if([Tools isTakePhoto]==YES){
        UIViewController * vc =[AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                                 andImageHandler:^(UIImage *image) {
        self.idImage = image;

        [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                                                  withOptions:nil
                                                                               successHandler:_successHandler
                                                                                  failHandler:_failHandler];
                                 }];

        [self presentViewController:vc animated:YES completion:nil];
    }
}


-(void)commit{
    [MobClick event:@"Certification" label:@"实名认证"];
    if (![state isEqualToString:@"3"]) {
//        if (self.idImageUrl.length == 0 ) {
//            [self.view makeToast:@"未上传身份证正面照" duration:1.0 position:CSToastPositionCenter];
//            return;
//        }
//        if (self.idBackImageUrl.length == 0 ) {
//            [self.view makeToast:@"未上传身份证反面照" duration:1.0 position:CSToastPositionCenter];
//            return;
//        }
//        if (self.cardImageUrl.length == 0 ) {
//            [self.view makeToast:@"未上传名片" duration:1.0 position:CSToastPositionCenter];
//            return;
//        }
        self.idImageUrl = @"";
        self.idBackImageUrl = @"";
        self.cardImageUrl = @"";

        if (self.nameTextF.text.length == 0 ) {
            [self.view makeToast:@"当前姓名为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }if (self.companyTextF.text.length == 0 ) {
            [self.view makeToast:@"当前公司名为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }if (self.phoneTextF.text.length == 0 ) {
            [self.view makeToast:@"当前号码为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }if (self.companyAdressTextF.text.length == 0 ) {
            [self.view makeToast:@"当前公司地址为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        if (self.destrictLabel.text.length == 0 || [self.destrictLabel.text isEqualToString:@"请选择"] ) {
            [self.view makeToast:@"当前业务区域为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }if (self.CategorySelect.length == 0 ) {
            [self.view makeToast:@"当前经营品类为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        if (self.phoneTextF.text.length > 0 && ![Tools isMobileNumber:self.phoneTextF.text] ) {
            [self.view makeToast:@"当前手机格式不对" duration:1.0 position:CSToastPositionCenter];
            return;
        }if (self.idTextF.text.length > 0 && ![Tools judgeIdentityStringValid:self.idTextF.text]) {
            [self.view makeToast:@"当前身份证格式不对" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    }
    if (isShowAlert == YES) {
        
    
    //调用接口
    YHAlertView *alertView = [[YHAlertView alloc]initWithDelegete:self image:[UIImage imageNamed:@"tishifuhao"] Title:@"修改品类需要通过一段时间审核，是否提交？" leftButtonTitle:@"修改信息" rightButtonTitle:@"确认提交"];
    [alertView showAnimated];
    }else
    {
        [self alertViewRightBtnClick:nil];
    }
}
#pragma mark ====上传
- (void)postServersURL:(UIImage *)image{
    
    //压缩到0.3M以内
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageData = encodedImageStr;
    [self.view showWait:@"上传中" viewType:CurrentView];
    [[YHJsonRequest shared] postURL:imageData toServers:^(UserInfoModel *successMessagesMode) {
        
        [self.view hideWait:CurrentView];
        self.companyTextF.text = successMessagesMode.Company;
        self.phoneTextF.text = successMessagesMode.TelCell;
        NSRange range = [successMessagesMode.Address rangeOfString:@":"]; //现获取要截取的字符串位置
        if (range.location == NSNotFound) {
                    self.companyAdressTextF.text = successMessagesMode.Address;
        }else{
        NSString * result = [successMessagesMode.Address substringFromIndex:range.location+1]; //截取字符串
        self.companyAdressTextF.text = result;
        }
        self.companyAdressTextF.textColor = ColorWithHexString(@"000000");

        self.destrictLabel.textColor = [UIColor blackColor];
        self.classifyLabel.textColor = [UIColor blackColor];
        self.nameTextF.userInteractionEnabled = YES;
        self.phoneTextF.userInteractionEnabled = YES;
        self.companyAdressTextF.userInteractionEnabled = YES;
        self.companyTextF.userInteractionEnabled = YES;
        self.cardImageUrl =  successMessagesMode.RawCardUrl;
        if (successMessagesMode.RawCardUrl) {
            [self.cardImage sd_setImageWithURL:[NSURL URLWithString:successMessagesMode.RawCardUrl] placeholderImage:[UIImage imageNamed:@"mingpian"]];
            
        }
        [self.view makeToast:@"上传成功" duration:1.0 position:CSToastPositionCenter];
        
    } failBLock:^(NSString *errorMessage) {
        
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage duration:1.0 position:CSToastPositionCenter];
    }];
}

-(void)uploadIDCardWithImage:(UIImage *)image IdBack:(BOOL)isIdBack
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageData = encodedImageStr;
    [[YHJsonRequest shared] uploadIDCardImageWithURLpostSevice:imageData SuccessBlock:^(NSString *successMessage) {
        if (isIdBack == YES) {
            self.idBackImageUrl = successMessage;
            
        } else {
            self.idImageUrl = successMessage;
               [self.idcardImage sd_setImageWithURL:[NSURL URLWithString:successMessage] placeholderImage:[UIImage imageNamed:@"shenfenzheng-zheng"]];
        }
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
#pragma mark ====YHAlertViewDelegete
- (void)alertViewRightBtnClick:(id)alertView{
    
    NSDictionary *parameters;
    if ([state isEqualToString:@"3"] ) {
        
        parameters = @{@"PSPDId":self.model.PSPDId,@"RawCardUrl":self.model.RawCardUrl,@"Province":self.model.Province,@"City":self.model.City,@"RealName":self.model.RealName,@"BusinessCategory":self.CategorySelect,@"Address":self.model.Address,@"TelCell":self.model.TelCell,@"Company":self.model.Company,@"PSPDIdIconBack":self.model.PSPDIdIconBack,@"PSPDIdIconFront":self.model.PSPDIdIconFront};
        
    }else{
   
        parameters = @{@"PSPDId":self.idTextF.text,@"RawCardUrl":self.cardImageUrl,@"Province":self.province,@"City":self.city,@"RealName":self.nameTextF.text,@"BusinessCategory":self.CategorySelect,@"Address":self.companyAdressTextF.text,@"TelCell":self.phoneTextF.text,@"Company":self.companyTextF.text,@"PSPDIdIconBack":self.idBackImageUrl,@"PSPDIdIconFront":self.idImageUrl};
    }
    [[YHJsonRequest shared] userAudit:parameters SuccessBlock:^(NSDictionary *successMessage) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:LOGIN_USERCARDSTATE];
        [[NSUserDefaults standardUserDefaults] setObject:self.CategorySelect forKey:USERSELECCATEGORY];
        [[NSUserDefaults standardUserDefaults] setObject:self.nameTextF.text.length>0?self.nameTextF.text:self.model.RealName forKey:USERSCardID];

        [[NSUserDefaults standardUserDefaults] synchronize];
        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc]init];
        vc.successDate =successMessage[@"EditWhen"];
        [self.navigationController pushViewController:vc animated:YES];
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
    

}
#pragma mark---百度OCR结果回调
- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"=========%@", result);
        NSMutableString *message = [NSMutableString string];
        
//        识别成功后把图片上传到服务器
        if (weakSelf.idImage) {
            [weakSelf uploadIDCardWithImage:weakSelf.idImage IdBack:NO];
        }
        
        NSDictionary *dic = result[@"words_result"];
        message  = dic[@"姓名"][@"words"];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            weakSelf.nameTextF.text = dic[@"姓名"][@"words"];
            weakSelf.idTextF.text = dic[@"公民身份号码"][@"words"];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    };
    
    _failHandler = ^(NSError *error){
        NSLog(@"----------%@", error);
        NSString *msg = [NSString stringWithFormat:@"---%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            
            
        }];
    };
}

- (void)goCategoryVC{
    YHSelectClassifyViewController *vc = [[YHSelectClassifyViewController alloc]init];
    __block YHCertificationSuccessViewController *weakSelf = self;
    vc.block = ^(NSDictionary *Category) {
        if (Category) {
            weakSelf.classifyLabel.textColor = [UIColor blackColor];
            weakSelf.classifyLabel.text = [Category objectForKey:@"CategoryName"];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getUserInfo{
    
//    if (![state isEqualToString:@"3"] ) {
    
        @try {
            // #error 【必须！】请在 ai.baidu.com中新建App, 绑定BundleId后，在此填写授权信息
            //    #error 【必须！】上传至AppStore前，请使用lipo移除AipBase.framework、AipOcrSdk.framework的模拟器架构，参考FAQ：ai.baidu.com/docs#/OCR-iOS-SDK/top
            //     授权方法1：在此处填写App的Api Key/Secret Key
            [[AipOcrService shardService] authWithAK:@"blWTwQOP29UC40cDNzqtt3nT" andSK:@"K9b0PXdhggt1clGQtGfKgvpOI0QpyNLd"];
        } @catch (NSException *exception) {
            //捕获异常
            [self.view makeToast:@"OCR-iOS-SDK初始化失败，请稍后再试"];
        } @finally {
            //这里一定执行，无论你异常与否
            
        }
     
        
//    }else{
    self.model = [[UserInfoModel alloc]init];
    
    [self.view showWait:@"加载中" viewType:CurrentView];
    [[YHJsonRequest shared] getUserInfoSuccessBlock:^(UserInfoModel*model) {
        [self.view hideWait:CurrentView];
        self.model = model;
        NSString *realName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERREALNAME];
        if (![realName isEqualToString:model.RealName]) {
            [[NSUserDefaults standardUserDefaults] setObject:model.RealName forKey:LOGIN_USERREALNAME];
        }
        [[NSUserDefaults standardUserDefaults] setObject:model.BusinessCategory forKey:USERSELECCATEGORY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.idTextF.text = model.PSPDId;
        self.idTextF.placeholder = @"";
        self.nameTextF.text = model.RealName;
        self.companyTextF.text = model.Company;
        if (model.Address.length>0) {
            self.companyAdressTextF.text = model.Address;
            self.companyAdressTextF.textColor = ColorWithHexString(@"000000");
        }else{
        }
        
        self.phoneTextF.text = model.TelCell;
        self.destrictLabel.text = [NSString stringWithFormat:@"%@%@",model.Province,model.City];
        self.classifyLabel.text = [NSString stringWithFormat:@"%@",model.BusinessCategoryName];
        self.destrictLabel.textColor = [UIColor blackColor];
        self.classifyLabel.textColor = [UIColor blackColor];
        if ([state isEqualToString:@"3"]) {
            
        
        self.idTextF.userInteractionEnabled = false;
        self.nameTextF.userInteractionEnabled = false;
        self.phoneTextF.userInteractionEnabled = false;
        self.companyAdressTextF.userInteractionEnabled = false;
        self.companyTextF.userInteractionEnabled = false;
        self.destrictLabel.userInteractionEnabled = false;
        self.destrictTextF.userInteractionEnabled = false;
//        self.headView.userInteractionEnabled = false;
            
        }
        
        if ([state isEqualToString:@"4"]) {
//            UIImageView *deleteImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardDelete"]];
//            [self.cardImage addSubview:deleteImage];
//            [deleteImage mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(WidthRate(5));
//                make.top.mas_equalTo(HeightRate(3));
//                make.width.mas_equalTo(WidthRate(24));
//                make.height.mas_equalTo(HeightRate(24));
//
//            }];
            
//            UIImageView *deleteImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardDelete"]];
//            [self.idBackcardImage addSubview:deleteImage1];
//            [deleteImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(WidthRate(5));
//                make.top.mas_equalTo(HeightRate(3));
//                make.width.mas_equalTo(WidthRate(24));
//                make.height.mas_equalTo(HeightRate(24));
//
//            }];
//
//            UIImageView *deleteImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardDelete"]];
//            [self.idcardImage addSubview:deleteImage2];
//            [deleteImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(WidthRate(5));
//                make.top.mas_equalTo(HeightRate(3));
//                make.width.mas_equalTo(WidthRate(24));
//                make.height.mas_equalTo(HeightRate(24));
//
//            }];
//            {@"PSPDId":self.idTextF.text,@"RawCardUrl":self.cardImageUrl,@"Province":self.province,@"City":self.city,@"RealName":self.nameTextF.text,@"BusinessCategory":self.CategorySelect,@"Address":self.companyAdressTextF.text,@"TelCell":self.phoneTextF.text,@"Company":self.companyTextF.text,@"PSPDIdIconBack":self.idBackImageUrl,@"PSPDIdIconFront":self.idImageUrl};
//            self.idImageUrl =  model.PSPDIdIconFront;
//            self.idBackImageUrl =  model.PSPDIdIconBack;
//            self.cardImageUrl =  model.RawCardUrl;
            self.province = model.Province;
            self.city = model.City;
            self.CategorySelect = model.BusinessCategory;
            
        }
        //            self.cardImageUrl  self.idImageUrl self.idBackImageUrl

//        if (model.RawCardUrl) {
//            [self.cardImage sd_setImageWithURL:[NSURL URLWithString:model.RawCardUrl] placeholderImage:[UIImage imageNamed:@"mingpian"]];
//            self.cardImageUrl = model.RawCardUrl;
//        }
//        if (model.PSPDIdIconFront) {
//            [self.idcardImage sd_setImageWithURL:[NSURL URLWithString:model.PSPDIdIconFront] placeholderImage:[UIImage imageNamed:@"shenfenzheng-zheng"]];
//            self.idImageUrl = model.PSPDIdIconFront;
//        }
//        if (model.PSPDIdIconBack) {
//            [self.idBackcardImage sd_setImageWithURL:[NSURL URLWithString:model.PSPDIdIconBack] placeholderImage:[UIImage imageNamed:@"shenfenzheng-fan"]];
//            self.self.idBackImageUrl = model.PSPDIdIconBack;
//
//        }
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];
        self.takeImage.hidden = false;
    }];
//    }
}

-(void)progress:(UIView *)bgview
{
    NSArray *titleArr = @[@"填写基本信息",@"等待客服审核",@"审核完成"];
    
  
    NSArray *imageArr =@[@"0201",@"0102",@"0103"];//[state isEqualToString:@"2"]?@[@"0201",@"0202",@"0103"]: @[@"0101",@"0102",@"0103"];

    CGFloat width = (ScreenWidth-20)/3;
    for (int i = 0; i < titleArr.count; i ++) {
        
        
        UIImageView *progressImageView = [[UIImageView alloc] init];
        progressImageView.image = [UIImage imageNamed:imageArr[i]];
        progressImageView.frame = CGRectMake(10+width*i, 15, width, HeightRate(16));
        [bgview addSubview:progressImageView];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = titleArr[i];
        title.font = [UIFont systemFontOfSize:AdaptFont(10)];
        title.frame = CGRectMake(10+width*i,  HeightRate(31), width, HeightRate(20));
        title.textColor = ColorWithHexString(@"797979");
        title.textAlignment = NSTextAlignmentCenter;
        [bgview addSubview:title];

    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificatonShowCatagoryCommitBtn object:nil];
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
