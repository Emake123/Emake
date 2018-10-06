 //
//  YHNewAdresssViewController.m
//  emake
//
//  Created by eMake on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHNewAdresssViewController.h"
#import "YHAdressViewController.h"
#import "HDPickerView.h"
#import "adressModel.h"
#import "Tools.h"

@interface YHNewAdresssViewController ()

@property(nonatomic,strong) UIButton *deleteBtn;
@property(nonatomic,strong) NSMutableDictionary *saveDic;

@property(nonatomic,strong) UITextField *textName;
@property(nonatomic,strong) UITextField *textPhone;
@property(nonatomic,strong) UILabel *lable3;
@property(nonatomic,strong) UILabel *lable4;
@property(nonatomic,strong) UITextField *detailText;
@property(nonatomic,strong) UIButton *adressBtn;
@property(nonatomic,strong) UIButton *detailBtn;

@property (nonatomic, strong) HDPickerView *pickerView;
@property(nonatomic,strong) NSArray *pickArr;

@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *area;


@end

@implementation YHNewAdresssViewController
UIView *bgview;
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title =self.adressTitle;
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    
    bgview  = [[UIView alloc] init];
    bgview.translatesAutoresizingMaskIntoConstraints = NO;
    bgview.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    [bgview PSSetTop:0 ];
    [bgview PSSetLeft:0];
    [bgview PSSetWidth:ScreenWidth];


//需要填写数据
  _textName = [self showAdressItem:nil name:@"收  货  人" placehold:@"请输入收货人姓名" top:HeightRate(15)];
  _textPhone =  [self showAdressItem:_textName name:@"联系电话" placehold:@"请输入联系人电话" top:HeightRate(15)];
  _textPhone.keyboardType =UIKeyboardTypeNumberPad;
  _lable3 =  [self showAdressItem:_textPhone name:@"所在地区" placehold:@"请选择" top:HeightRate(15)];
  _lable4 =  [self showAdressItem:_lable3 name:@"街       道" placehold:@"请选择" top:HeightRate(15)];

    _detailText  = [[UITextField alloc] init];
    _detailText.placeholder = @"请填写详细地址，不少于5个字";
    _detailText.font = [UIFont systemFontOfSize:14];
    _detailText.textColor =ColorWithHexString(@"A8A7A8");
    _detailText.translatesAutoresizingMaskIntoConstraints = NO;
    [bgview addSubview:_detailText];
    [_detailText PSSetBottomAtItem:_lable4 Length:HeightRate(30)];
    [_detailText PSSetLeft:WidthRate(23)];
    [_detailText PSSetWidth:WidthRate(340)];
    [_detailText PSSetBottom:HeightRate(50)];
    
    _lable3.userInteractionEnabled= YES;
    [_lable3 addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adresssChooseClick)] ];
    _lable4.userInteractionEnabled =YES;
    [_lable4 addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailadresssChooseClick)] ];
    
//model有数据显示，修改
    if (self.model) {
        _lable4.textColor = ColorWithHexString(@"000000");
        _lable3.textColor = ColorWithHexString(@"000000");
        _detailText.textColor =ColorWithHexString(@"000000");
        _textName.text = self.model.UserName;
        _textPhone.text =self.model.MobileNumber;
        _lable3.text = [NSString stringWithFormat:@"%@%@%@",self.model.Province,self.model.City,self.model.County] ;
        _lable4.text = self.model.District;
        _detailText.text = self.model.Address;;
//        [_deleteBtn setTitle:@"保存" forState:UIControlStateNormal];

        UIButton *deleteAdressButton  = [UIButton buttonWithType:UIButtonTypeSystem];
        deleteAdressButton.translatesAutoresizingMaskIntoConstraints = NO;
        [deleteAdressButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteAdressButton setTitleColor:ColorWithHexString(@"FFFFFF") forState:UIControlStateNormal];
        deleteAdressButton.backgroundColor = ColorWithHexString(StandardBlueColor);
        deleteAdressButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        [deleteAdressButton addTarget:self action:@selector(deleteadress) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:deleteAdressButton];
        [deleteAdressButton PSSetBottomAtItem:bgview Length:20];
        [deleteAdressButton PSSetSize:WidthRate(140) Height: HeightRate(40)];
        [deleteAdressButton PSSetLeft:WidthRate(32)];
        deleteAdressButton.layer.cornerRadius = 6;
        deleteAdressButton.layer.masksToBounds = YES;
        
        UIButton *saveAdressButton  = [UIButton buttonWithType:UIButtonTypeSystem];
        saveAdressButton.translatesAutoresizingMaskIntoConstraints = NO;
        [saveAdressButton setTitle:@"保存" forState:UIControlStateNormal];
        saveAdressButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        
        [saveAdressButton setTitleColor:ColorWithHexString(@"FFFFFF") forState:UIControlStateNormal];
        saveAdressButton.backgroundColor = ColorWithHexString(StandardBlueColor);
        [saveAdressButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveAdressButton];
        [saveAdressButton PSSetBottomAtItem:bgview Length:20];
        [saveAdressButton PSSetSize:WidthRate(140) Height: HeightRate(40)];
        [saveAdressButton PSSetRight:WidthRate(32)];
        saveAdressButton.layer.cornerRadius = 6;
        saveAdressButton.layer.masksToBounds = YES;
       
    }else
    {
        UIButton *commitAdressButton  = [UIButton buttonWithType:UIButtonTypeSystem];
        commitAdressButton.translatesAutoresizingMaskIntoConstraints = NO;
        [commitAdressButton setTitle:@"提交" forState:UIControlStateNormal];
        [commitAdressButton setTitleColor:ColorWithHexString(@"FFFFFF") forState:UIControlStateNormal];
        commitAdressButton.backgroundColor = ColorWithHexString(StandardBlueColor);
        commitAdressButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        [commitAdressButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:commitAdressButton];
        commitAdressButton.layer.cornerRadius = 6;
        commitAdressButton.layer.masksToBounds = YES;
        [commitAdressButton PSSetBottomAtItem:bgview Length:20];
        [commitAdressButton PSSetSize:WidthRate(310) Height: HeightRate(40)];
        [commitAdressButton PSSetLeft:WidthRate(33)];
        

        
    }
}
#pragma mark---button的点击事件
//省，市，区的选择
-(void)adresssChooseClick
{
    _lable4.textColor = ColorWithHexString(@"000000");
    _lable3.textColor = ColorWithHexString(@"000000");
    _detailText.textColor =ColorWithHexString(@"000000");
    __block YHNewAdresssViewController *weakSelf = self;
    [_pickerView removeFromSuperview];

    _pickerView  = [HDPickerView selectArea:^(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets) {
        weakSelf.lable3.text = [NSString stringWithFormat:@"%@%@%@", province, city, area];
        weakSelf.province = province;
        weakSelf.city = city;
        weakSelf.area = area;
        weakSelf.lable4.text = @" ";
        _pickArr = streets.count?streets:@[@"暂无街道"];
    }];
 [_pickerView show];
    
}
//街道选择
-(void)detailadresssChooseClick
{
    [_pickerView removeFromSuperview];
    _pickerView = [HDPickerView selectStreet:^(NSString * _Nullable streets) {
        _lable4.text = streets.length?streets:_pickArr[0];
        
    } arr:_pickArr=_pickArr?_pickArr:@[@"请先选择省市区"]];
    [_pickerView show];

    
}
#pragma mark--button click
-(void)deleteadress
{
    
    UIAlertController*alert = [UIAlertController
                              alertControllerWithTitle:nil
                              message: @"确认删除该地址吗？"
                              preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"取消"
                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          
                          
                      }]];
    [alert addAction:[UIAlertAction
                      actionWithTitle:@"确定"
                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          [[YHJsonRequest shared] deleteUserAdressParams:@{@"RefNo":self.model.RefNo,@"AddressType":@"0"} SuccessBlock:^(NSString *successMessage) {
                              //弹出提示框
                              [self.view makeToast:successMessage duration:1 position:CSToastPositionCenter];
                              for (UIViewController *controller in self.navigationController.viewControllers) {
                                  if ([controller isKindOfClass:[YHAdressViewController class]]) {
                                      YHAdressViewController *revise =(YHAdressViewController *)controller;
                                      revise.deleteCode =1;
                                      [self.navigationController popToViewController:revise animated:NO];
                                  }
                              }
                              
                          } fialureBlock:^(NSString *errorMessages) {
                              
                              [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
                              
                              
                          }] ;
                          
                      }]];

    [self presentViewController:alert animated:YES completion:nil];
}

//保存，编辑；新增的地址
-(void)rightBtnClick:(UIButton *)sender

{
    _saveDic = [NSMutableDictionary dictionary];
    [self.view endEditing:YES];
    if (![Tools isMobileNumber:_textPhone.text]) {
        [self.view makeToast:@"手机号码错误或未填写完整" duration:2 position:CSToastPositionCenter ];
        return;
    }
    if(self.model)
    {
        if (_textName.text&&_lable3.text &&_textPhone.text &&_lable4.text) {
            if (_detailText.text.length <5) {
                [self.view makeToast:@"详细地址不能少于5个字"];
                return;
            }
            NSString *city = _city?_city:self.model.City;
            NSString *area = _area?_area:self.model.District;
            NSString *provivince = _province?_province:self.model.Province;
            [_saveDic setObject:_textName.text forKey:@"UserName"];
            [_saveDic setObject:_textPhone.text forKey:@"MobileNumber"];
            [_saveDic setObject:provivince forKey:@"Province"];
            [_saveDic setObject:city forKey:@"City"];
            [_saveDic setObject:area forKey:@"County"];//District
            [_saveDic setObject:_lable4.text forKey:@"District"];
            [_saveDic setObject:_detailText.text forKey:@"Address"];
            [_saveDic setObject:@"0" forKey:@"AddressType"];
            [_saveDic setObject:self.model.RefNo forKey:@"RefNo"];
            [[YHJsonRequest shared] putUserAdressParams:_saveDic SuccessBlock:^(NSString *successMessage) {
                
                [self.view showToast:[self.view customShowAlert:successMessage image:@"pop_success"] duration:1.5 position:CSToastPositionCenter completion:^(BOOL didTap)
                 {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                     
                }];
                
                
            } fialureBlock:^(NSString *errorMessages) {
                 [self.view makeToast:errorMessages duration:2 position:CSToastPositionCenter];
                
            }];
    }else{
        [self.view makeToast:@"请填写完整，再保存"];
    }
        return;
    }
   
    
//判断是非为空
     if (_textName.text &&_textPhone.text &&_province&&_city&&_area&&_lable4.text&&_detailText.text) {
         
         if (_detailText.text.length <5) {
             
//             [self.view makeToast:@"详细地址不能少于5个字"];
             [self.view makeToast:@"详细地址不能少于5个字" duration:1 position:CSToastPositionCenter];

             return;
         }
    [_saveDic setObject:_textName.text forKey:@"UserName"];
    [_saveDic setObject:_textPhone.text forKey:@"MobileNumber"];
    [_saveDic setObject:_province forKey:@"Province"];
    [_saveDic setObject:_city forKey:@"City"];
    [_saveDic setObject:_area forKey:@"County"];//District
    [_saveDic setObject:_lable4.text forKey:@"District"];
    [_saveDic setObject:_detailText.text forKey:@"Address"];
    [_saveDic setObject:@"0" forKey:@"AddressType"];
   
         
    [[YHJsonRequest shared] postUserAdressParams:_saveDic SuccessBlock:^(NSString *successMessage) {
            [self.view showToast:[self.view customShowAlert:successMessage image:@"pop_success"] duration:1.5 position:CSToastPositionCenter completion:^(BOOL didTap) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
        } fialureBlock:^(NSString *errorMessages) {
            
            [self.view makeToast:errorMessages duration:2 position:CSToastPositionCenter];
        }];

    }else{
        [self.view makeToast:@"请填写完整，再保存" duration:2 position:CSToastPositionCenter];
    }

}

-(id)showAdressItem:(id)item name:(NSString *)name placehold:(NSString *)placehold top:(CGFloat)top
{
    UILabel *namelable =  [[UILabel alloc] init];
    namelable.translatesAutoresizingMaskIntoConstraints = NO;
    namelable.text = name;
    namelable.font = [UIFont systemFontOfSize:14 ];
    namelable.textColor = ColorWithHexString(@"000000");

    [bgview addSubview:namelable];
    if (item) {
        [namelable PSSetBottomAtItem:item Length:HeightRate(30)];
    }else
    {
        [namelable PSSetTop:HeightRate(top+80)];
    }
    
    [namelable PSSetLeft:WidthRate(23)];
    
    UILabel *line = [[UILabel alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor= SepratorLineColor;
    [bgview addSubview:line];
    [line PSSetBottomAtItem:namelable Length:15];
    [line PSSetSize:ScreenWidth Height:0.5];
    
    if ([placehold isEqualToString:@"请选择"]) {
        UILabel *lable = [[UILabel alloc] init];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        lable.font = [UIFont systemFontOfSize:14];
        lable.textColor = ColorWithHexString(@"A8A7A8");
        lable.text= placehold;
        [bgview addSubview:lable];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"direction_right"] forState:UIControlStateNormal];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        
        [bgview addSubview:button];
        [lable PSSetRightAtItem:namelable Length:WidthRate(30)];
        [lable PSSetWidth:WidthRate(230)];
        lable.textAlignment = NSTextAlignmentRight;
        [button PSSetRightAtItem:lable Length:WidthRate(-5)];
        [button PSSetSize:30 Height:15];

        if ([name isEqualToString:@"所在地区"]) {
            _adressBtn = button;
        }else{
            _detailBtn = button;
        }
        return lable;
    }
    
    UITextField *text = [[UITextField alloc] init];
    text.translatesAutoresizingMaskIntoConstraints = NO;
    text.font = [UIFont systemFontOfSize:14];
    text.placeholder = placehold;
    [bgview addSubview:text];
    [text PSSetRightAtItem:namelable Length:WidthRate(20)];
    [text PSSetHeight:HeightRate(30)];

    return text;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
