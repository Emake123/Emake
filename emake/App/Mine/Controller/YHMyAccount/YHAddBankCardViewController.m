//
//  YHAddBankCardViewController.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHAddBankCardViewController.h"
#import "ClipViewController.h"
#import <AipOcrSdk/AipOcrSdk.h>
#import <AVFoundation/AVFoundation.h>

@interface YHAddBankCardViewController ()
{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}
@property(nonatomic,strong)UITextField *cardName;
@property(nonatomic,strong)UITextField *cardNumber;
@property(nonatomic,strong)UITextField *cardPhone;

@end

@implementation YHAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    self.title = @"添加银行卡";
    [self addRigthDetailButtonIsShowCart:false];
    [self configSubViews];
}
- (void)configSubViews{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = TextColor_E6E6E6;
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRate(48));
    }];
    
    UILabel *labelTitle = [[UILabel alloc]init];
    labelTitle.text = @"请绑定易智造账号本人的储蓄卡";
    labelTitle.textColor = TextColor_999999;
    labelTitle.font = SYSTEM_FONT(AdaptFont(15));
    [topView addSubview:labelTitle];
    
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(26));
        make.height.mas_equalTo(HeightRate(22));
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    
    NSString *idStr =   [[NSUserDefaults standardUserDefaults] objectForKey:USERSCardName];

    UIView *viewOne = [self viewForBank:@"持卡人" andRight:@"持卡人姓名" andIsShowImage:true];
    viewOne.tag = 1;
    [self.view addSubview:viewOne];
    
    [viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(topView.mas_bottom);
        make.height.mas_equalTo(HeightRate(65));
    }];
    
    UIView *viewTwo2 = [self viewForBank:@"身份证号" andRight:@"身份证号码" andIsShowImage:true];
    viewTwo2.tag = 4;
    UITextField *inputTwo2 = [viewTwo2 viewWithTag:100];
    inputTwo2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:viewTwo2];
    
    [viewTwo2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(viewOne.mas_bottom);
        make.height.mas_equalTo(HeightRate(65));
    }];
    
    UIView *viewTwo = [self viewForBank:@"卡号" andRight:@"银行卡号" andIsShowImage:false];
    viewTwo.tag = 2;
    UITextField *inputTwo = [viewTwo viewWithTag:100];
    inputTwo.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:viewTwo];
    
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(viewTwo2.mas_bottom);
        make.height.mas_equalTo(HeightRate(65));
    }];
    
    
    UIView *viewThree = [self viewForBank:@"开户行" andRight:@"如：xx银行xx支行" andIsShowImage:true];
    viewThree.tag = 3;
    UITextField *inputThree = [viewThree viewWithTag:100];
    inputThree.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:viewThree];
    
    [viewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(viewTwo.mas_bottom);
        make.height.mas_equalTo(HeightRate(65));
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(18));
    confirmBtn.layer.cornerRadius = 6;
    confirmBtn.clipsToBounds = YES;
    confirmBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [confirmBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.right.mas_equalTo(WidthRate(-20));
        make.height.mas_equalTo(HeightRate(48));
        make.top.mas_equalTo(viewThree.mas_bottom).offset(HeightRate(20));
    }];
    
    UIImageView *tipimage = [[UIImageView alloc] init];
    tipimage.image  = [UIImage imageNamed:@"tishifuhao"];
    [self.view addSubview:tipimage];
    [tipimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(20));
        make.height.mas_equalTo(HeightRate(16));
        make.width.mas_equalTo(HeightRate(16));
        make.top.mas_equalTo(confirmBtn.mas_bottom).offset(HeightRate(10));
    }];
    
    
    UILabel *tipLable = [[UILabel alloc] init];
    tipLable.text = @"请认真核实您的银行卡信息，以免有误";
    tipLable.font =SYSTEM_FONT(AdaptFont(14));
    tipLable.textColor = ColorWithHexString(@"999999");
    [self.view addSubview:tipLable];
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipimage.mas_right).offset(WidthRate(5));
        make.height.mas_equalTo(HeightRate(32));
        make.centerY.mas_equalTo(tipimage.mas_centerY).offset(HeightRate(0));
    }];
    
}
-(void)commit{
    
    UIView *one = [self.view viewWithTag:1];
    UITextField *cardName = [one viewWithTag:100];
    UIView *two = [self.view viewWithTag:2];
    UITextField *cardNumber = [two viewWithTag:100];
    UIView *three = [self.view viewWithTag:3];
    UITextField *cardPhone = [three viewWithTag:100];
    
    UIView *two2 = [self.view viewWithTag:4];
    UITextField *idCard = [two2 viewWithTag:100];
    
    if (!cardName.text||cardName.text.length<=0){
        [self.view makeToast:@"请填写持卡人姓名" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (!cardNumber.text||cardNumber.text.length<=0){
        [self.view makeToast:@"请填写卡号" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (!cardPhone.text||cardPhone.text.length<=0){
        [self.view makeToast:@"请填写银行卡开户行" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (!idCard.text||idCard.text.length<=0){
        [self.view makeToast:@"请填写身份证号码" duration:1.0 position:CSToastPositionCenter];
        return;
    }

    [self.view showWait:@"请求中" viewType:CurrentView];
    
    [[YHJsonRequest shared] userAddBankCard:@{@"CardId":cardNumber.text,@"UserName":[Tools URLEncodedString:cardName.text],@"CertId":idCard.text,@"CertAddress":cardPhone.text} SuccessBlock:^(NSString *successMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:successMessage duration:1.0 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonBankAddSuccess object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
    
}
- (UIView *)viewForBank:(NSString *)leftText andRight:(NSString *)rightText andIsShowImage:(BOOL)isShow{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(65))];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.text = leftText;
    leftLabel.textColor = TextColor_333333;
    leftLabel.font = SYSTEM_FONT(AdaptFont(15));
    [view addSubview:leftLabel];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(26));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(HeightRate(22));
        make.width.mas_equalTo(WidthRate(80));
    }];
    
    UITextField *input = [[UITextField alloc]init];
    input.font = SYSTEM_FONT(AdaptFont(15));
    input.borderStyle = UITextBorderStyleNone;
    input.tag = 100;
    input.placeholder = rightText;
    [view addSubview:input];
    
    [input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftLabel.mas_right).offset(0);
        make.right.mas_equalTo(WidthRate(-65));
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    

    
    UIImageView *imagePhoto = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shibieyinhangka"]];
    imagePhoto.hidden = isShow;
    imagePhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *geture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goScanBankVC)];
    [imagePhoto addGestureRecognizer:geture];
    [view addSubview:imagePhoto];
    
    [imagePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-20));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.width.mas_equalTo(WidthRate(34));
        make.height.mas_equalTo(WidthRate(34));
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = SepratorLineColor;
    [view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(0));
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    return view;
}
- (void)goScanBankVC{
    if([Tools isTakePhoto] == YES){
        UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard andImageHandler:^(UIImage *image) {
            [self didSuccessClipImage:image];
                                 }];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(void)didSuccessClipImage:(UIImage *)clipedImage{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSData *data = UIImageJPEGRepresentation(clipedImage, 1.0);
    if (data.bytes) {
        if ([Tools fileSize:data.length] <0.3) {
            NSLog(@"图片小");
            data = UIImageJPEGRepresentation(clipedImage, 1.0);
        }else{
            NSLog(@"图片大");
            float pressValue = 0.3 / [Tools fileSize:data.length];
            data = UIImageJPEGRepresentation(clipedImage, pressValue);
        }
    }
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *parameters = @{@"app_id": ScanCardAPIAppAppID,@"image": encodedImageStr};
    [self.view showWait:@"扫描中" viewType:CurrentView];
    [[YHJsonRequest shared] scanCardWithParameters:parameters SuccessBlock:^(NSString *successMessage) {
        UIView *two = [self.view viewWithTag:2];
        UITextField *cardNumber = [two viewWithTag:100];
        cardNumber.text = successMessage;
        [self.view hideWait:CurrentView];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        [self.view hideWait:CurrentView];
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
