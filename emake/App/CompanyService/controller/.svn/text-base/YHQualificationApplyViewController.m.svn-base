//
//  YHQualificationApplyViewController.m
//  emake
//
//  Created by 谷伟 on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationApplyViewController.h"
#import "YHQualificationInputCellTableViewCell.h"
#import "YHQualificationSelectCell.h"
#import "YHQualificationPictureCell.h"
#import "YHQualificationSelectDestrictCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "HDPickerView.h"
@interface YHQualificationApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,YHSelectViewDelegete>{
    UITableView *myTable;
    NSArray *titleArray2;
    NSArray *selectTitleArray2;
    NSArray *titleArray;
}
@property (nonatomic, strong) HDPickerView *pickerView;
@property(nonatomic,strong) NSArray *pickArr;
@property(nonatomic,strong) NSString *destrict;
@property(nonatomic,strong) NSString *Province;
@property(nonatomic,strong) NSString *City;
@property(nonatomic,strong) NSString *Area;
@property(nonatomic,strong) NSString *adresss;
@property(nonatomic,copy) NSString *adresssDetail;

@property(nonatomic,strong) NSString *invoceType;
@property(nonatomic,strong) NSString *invoceTypeValue;
@property(nonatomic,retain)UIButton *commitBtn;

@property (nonatomic,retain)NSArray *invoceTypeArr;
@property (nonatomic,retain)NSMutableArray *invoceTypeTileArr;
@property (nonatomic,retain)NSMutableArray *invoceTypeCodeArr;



@property(nonatomic,copy) NSString *invoiceHead;//发票抬头
@property(nonatomic,copy) NSString *invoiceAmount;//发票抬头
@property(nonatomic,copy) NSString *invoiceTaxID;//企业税号
@property(nonatomic,copy) NSString *invoiceBank;//开户行及账号
@property(nonatomic,copy) NSString *invoiceContact;//地址及电话
@property(nonatomic,copy) NSString *recieveName;//发票抬头
@property(nonatomic,copy) NSString *recieveContact;//发票抬头
@end

@implementation YHQualificationApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TextColor_F5F5F5;
    [self configSubViews];
   
    titleArray = [NSArray arrayWithObjects:@"发票详情",@"收件信息",nil];
    
    if(self.ContractNo.length>0)
    {
        self.title =@"申请发票";
        titleArray2 = [NSArray arrayWithObjects:@"发票抬头", @"开票金额",@"企业税号",@"开户行及账号",@"地址及电话",nil];
        selectTitleArray2 = [NSArray arrayWithObjects:@"请填写发票抬头",@"请填写开票金额", @"请填写企业纳税人识别号",@"请填写开户行及账号", @"请填写地址及电话",nil];
    [[YHJsonRequest shared] getRemainInvoiceAmount:self.ContractNo success:^(NSNumber *invoiceAmount) {
        self.invoiceAmount = [NSString stringWithFormat:@"%.2f",invoiceAmount.doubleValue];
        self.RemainApplyAmount = invoiceAmount.stringValue;
        [myTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } fialureBlock:^(NSString *errorMessages) {
        self.invoiceAmount = @"0";
        self.RemainApplyAmount = @"0";
        [myTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    }else{
        titleArray2 = [NSArray arrayWithObjects:@"发票抬头",@"企业税号",@"开户行及账号",@"地址及电话",nil];
        selectTitleArray2 = [NSArray arrayWithObjects:@"请填写发票抬头", @"请填写企业纳税人识别号",@"请填写开户行及账号", @"请填写地址及电话",nil];
        self.title =@"开票信息";

    }
}
- (void)configSubViews{
    
    myTable = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    myTable.separatorColor = [UIColor clearColor];
    myTable.backgroundColor = [UIColor clearColor];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.showsVerticalScrollIndicator = false;
    myTable.showsHorizontalScrollIndicator = false;
    
    [self.view addSubview:myTable];
    [myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.bottom.mas_equalTo(HeightRate(-44));
    }];
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(15)];
    if(self.ContractNo.length > 0){
    [self.commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    }else
    {
        if(self.Model.InvoiceTitle.length>0)
        {
            [self.commitBtn setTitle:@"修改" forState:UIControlStateNormal];

        }else
        {
        [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        }

    }
    self.commitBtn.backgroundColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
    [self.commitBtn addTarget:self action:@selector(goCommit) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.commitBtn];
    self.commitBtn.layer.cornerRadius = 6;
    self.commitBtn.clipsToBounds = YES;
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(33));
        make.right.mas_equalTo(WidthRate(-33));
        make.bottom.mas_equalTo(-HeightRate(0));
        make.height.mas_equalTo(HeightRate(44));
    }];
}
#pragma mark ===== UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isInvoice = self.Model.InvoiceTitle.length>0?YES:false;
    if (indexPath.section == 0){
        if (indexPath.row == 0) {
            YHQualificationSelectCell *cell = nil;
            if (!cell) {
                cell = [[YHQualificationSelectCell alloc]init];
                cell.leftTitle.text =@"发票类型";
                if (isInvoice == YES) {
                    [cell.selectBtn setTitle:self.Model.InvoiceTypeName forState:UIControlStateNormal];
                    [cell.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                   
                }else{
                     if (!self.invoceType) {
                       [cell.selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
                       [cell.selectBtn setTitleColor:TextColor_BBBBBB forState:UIControlStateNormal];
                     }else{
                        [cell.selectBtn setTitle:self.invoceType forState:UIControlStateNormal];
                        [cell.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                }
                cell.selectBtn.tag = 200 +indexPath.row;
                [cell.selectBtn addTarget:self action:@selector(selectSectionOne:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else{//开票金额
            
            YHQualificationInputCellTableViewCell *cell = nil;
            if (!cell) {
                cell = [[YHQualificationInputCellTableViewCell alloc]init];
                cell.leftTitle.text =titleArray2[indexPath.row-1];
                cell.input.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (indexPath.row == 2){
                    cell.input.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

                    if (self.ContractNo.length>0) {
                        cell.input.text = self.invoiceAmount;
                        cell.input.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
                    } else {
                        
                    }
                   
                }
                
                switch (indexPath.row) {
                    case 1:
                        cell.input.text =isInvoice==YES?self.Model.InvoiceTitle:self.invoiceHead;
                        if (self.ContractNo.length == 0) {
                            cell.input.tag = 200 + indexPath.row;

                        }
                        break;
                    case 2:
                        if (self.ContractNo.length>0) {
                            cell.input.text = self.invoiceAmount;

                        } else {
                            cell.input.text = isInvoice==YES?self.Model.CustomerTaxCode:self.invoiceTaxID;
                            cell.input.tag = 201 + indexPath.row;
                         

                        }
                        break;
                    case 3:
                        if (self.ContractNo.length>0) {
                            cell.input.text =isInvoice==YES?self.Model.CustomerTaxCode: self.invoiceTaxID;
                            
                        } else {
                            cell.input.text = isInvoice==YES?self.Model.CustomerBankAccount:self.invoiceBank;
                            cell.input.tag = 201 + indexPath.row;

                        }
                        break;
                    case 4:
                        if (self.ContractNo.length>0) {
                            cell.input.text = isInvoice==YES?self.Model.CustomerBankAccount:self.invoiceBank;

                        } else {
                            cell.input.text =isInvoice==YES?self.Model.CustomerAddressTel: self.invoiceContact;
                            cell.input.tag = 201 + indexPath.row;

                        }
                        break;
                    case 5:
                        cell.input.text =isInvoice==YES?self.Model.CustomerAddressTel: self.invoiceContact;
                        break;
                    default:
                        break;
                }
                if (self.ContractNo.length>0) {
                    cell.input.tag = 200 + indexPath.row;

                }
            }
            return cell;
        }
    }else{
        if (indexPath.row ==1 ||indexPath.row ==0) {
            YHQualificationInputCellTableViewCell *cell = nil;
            if (!cell) {
                cell = [[YHQualificationInputCellTableViewCell alloc]init];
                if (indexPath.row == 0) {
                    cell.leftTitle.text =@"收件人";
                    cell.input.placeholder =@"请填写收件人姓名";
                    cell.input.text =isInvoice ==YES?self.Model.Receiver:self.recieveName;
                }else{
                    cell.leftTitle.text =@"联系电话";
                    cell.input.placeholder =@"请填写联系电话";
                    cell.input.keyboardType = UIKeyboardTypePhonePad;
                    cell.input.text = isInvoice ==YES?self.Model.ReceiverPhone:self.recieveContact;
                }
                cell.input.tag = 300 + indexPath.row;
                cell.input.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 4){
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            PlaceholderTextView *textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(WidthRate(14), HeightRate(6), ScreenWidth, HeightRate(75))];
            textView.delegate = self;
            textView.placeholder = @"请填写所在地区的详细地址";
            textView.placeholderColor = TextColor_BBBBBB;
            textView.text = isInvoice ==YES?self.Model.Address:self.adresssDetail;
            [cell.contentView addSubview:textView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            YHQualificationSelectDestrictCell *cell = nil;
            if (!cell) {
                cell = [[YHQualificationSelectDestrictCell alloc]init];
                if (indexPath.row == 2) {
                    cell.leftTitle.text =@"所在地区";
                    if (isInvoice == YES) {
                        NSString *address = [NSString stringWithFormat:@"%@%@%@",self.Model.Province,self.Model.City,self.Model.Area];
                        [cell.selectBtn setTitle:address forState:UIControlStateNormal];
                        [cell.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    } else {
                        
                         if (self.destrict !=nil) {
                          [cell.selectBtn setTitle:self.destrict forState:UIControlStateNormal];
                          [cell.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                         }else{
                       
                          [cell.selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
                          [cell.selectBtn setTitleColor:TextColor_BBBBBB forState:UIControlStateNormal];
                       }
                    }
                }else{
                    cell.leftTitle.text =@"街道";
                    if (isInvoice == YES) {
                        [cell.selectBtn setTitle:self.Model.Street forState:UIControlStateNormal];
                        [cell.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    } else {
                      if (self.adresss !=nil) {
                        [cell.selectBtn setTitle:self.adresss forState:UIControlStateNormal];
                        [cell.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                      }else{
                        [cell.selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
                        [cell.selectBtn setTitleColor:TextColor_BBBBBB forState:UIControlStateNormal];
                      }
                        
                    }
                    
                }
                cell.selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                cell.selectBtn.tag = 300 +indexPath.row;
                [cell.selectBtn addTarget:self action:@selector(selectSectionOne:) forControlEvents:UIControlEventTouchUpInside];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return HeightRate(45);
    }else{
        if (indexPath.row == 4) {
            return  HeightRate(80);
        }else{
            return HeightRate(45);
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if(self.ContractNo.length > 0){
            return 6;

        }else
        {
            return 5;

        }

    }else{
        return 5;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(45))];
    view.backgroundColor = TextColor_F7F7F7;
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(WidthRate(14), 0, ScreenWidth-WidthRate(20), HeightRate(30))];
    labelTitle.text = titleArray[section];
    labelTitle.font = SYSTEM_FONT(AdaptFont(13));
    [view addSubview:labelTitle];
    
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(14));
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    return  view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return HeightRate(45);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return TableViewFooterNone;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [myTable TPKeyboardAvoiding_scrollToActiveTextField];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    BOOL isModel = self.Model.CustomerTaxCode.length>0?YES:NO;
    switch (textField.tag) {
        case 201:
            self.invoiceHead = textField.text;
            self.Model.InvoiceTitle = textField.text;
            break;
        case 202:
            self.invoiceAmount = textField.text;
            textField.placeholder = [NSString stringWithFormat:@"最大开票金额%@",self.RemainApplyAmount];

            if ([self.invoiceAmount doubleValue] > [self.RemainApplyAmount doubleValue]) {
                NSString *text = [NSString stringWithFormat:@"您可申请剩余开票的金额不能超过%@",self.RemainApplyAmount];
                [self.view makeToast:text duration:1.0 position:CSToastPositionCenter];
                self.invoiceAmount = self.RemainApplyAmount;
                [myTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

            }
            break;
        case 203:
            self.invoiceTaxID = textField.text;
            self.Model.CustomerTaxCode = textField.text;

            break;
        case 204:
            self.invoiceBank = textField.text;
            self.Model.CustomerBankAccount = textField.text;

            break;
        case 205:
            self.invoiceContact = textField.text;            self.Model.CustomerAddressTel = textField.text;

            break;
        case 300:
            self.recieveName = textField.text;            self.Model.Receiver = textField.text;
            break;
        case 301:
            self.recieveContact = textField.text;            self.Model.ReceiverPhone = textField.text;

            break;
        default:
            break;
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
        view.placeholder = @"请填写所在地区的详细地址";
    }
    self.adresssDetail = textView.text;
    self.Model.Address = textView.text;
}
#pragma mark ---- YHSelectViewDelegete
- (void)selectView:(id)selectView selectItemWithIndex:(NSInteger)index{
    
    self.invoceType = self.invoceTypeTileArr[index-1];
    self.invoceTypeValue = self.invoceTypeCodeArr[index-1];
    self.Model.InvoiceTypeName = self.invoceTypeTileArr[index-1];
    self.Model.InvoiceType = self.invoceTypeCodeArr[index-1];
    [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark ----Method
- (void)selectSectionOne:(UIButton *)btn{
    [self.view endEditing:YES];
    switch (btn.tag) {
            //发票类型
        case 200:
            [self addListView:btn];
            break;
            //地区
        case 302:
            [self selectDestrict];
            break;
            //街道
        case 303:
            [self detailadresssChooseClick];
            break;
        default:
            break;
    }
}
- (void)addListView:(UIButton *)btn{
     
    [[YHJsonRequest shared] getInvoiceTypeSucess:^(NSArray *successMessage) {
        self.invoceTypeArr = [NSArray arrayWithArray:successMessage];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
    self.invoceTypeTileArr =[NSMutableArray arrayWithCapacity:0];
    self.invoceTypeCodeArr =[NSMutableArray arrayWithCapacity:0];
    if (self.invoceTypeArr.count >0) {
        for (int i = 0; i<self.invoceTypeArr.count; i++) {
            NSString *ParamValue = [self.invoceTypeArr[i] objectForKey:@"ParamValue"];
            NSString *ParamCode = [self.invoceTypeArr[i] objectForKey:@"ParamCode"];
            [self.invoceTypeTileArr addObject:ParamValue];
            [self.invoceTypeCodeArr addObject:ParamCode];
        }
        YHSelectView *selectView = [[YHSelectView alloc]initWithDelegat:self andTitle:@"发票类型" items:self.invoceTypeTileArr];
        [selectView showAnimated];
    }
}
-(void)selectDestrict{
    
    [self.view endEditing:YES];
    
    __block YHQualificationApplyViewController *weakSelf = self;
    
    _pickerView  = [HDPickerView selectArea:^(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets) {
        
        weakSelf.destrict = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
        weakSelf.Province = province;
        weakSelf.City = city;
        weakSelf.Area = area;
        weakSelf.adresss = nil;
        weakSelf.Model.Province = province;
        weakSelf.Model.City = city;
        weakSelf.Model.Area = area;

        _pickArr = streets.count?streets:@[@"暂无街道"];
        [myTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
        [myTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    [_pickerView show];
}
-(void)detailadresssChooseClick
{
    [self.view endEditing:YES];
    _pickerView = [HDPickerView selectStreet:^(NSString * _Nullable streets) {
        self.adresss = streets.length?streets:_pickArr[0];
        self.Model.Street =  streets.length?streets:_pickArr[0];
        [myTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    } arr:_pickArr=_pickArr?_pickArr:@[@"请先选择省市区"]];
    [_pickerView show];
    
    
}
- (void)goCommit{
    [self.view endEditing:YES];
    
   
    if(self.Model.CustomerTaxCode.length>0)
    {
       NSDictionary *dic = [self.Model mj_keyValues];
        for (NSString *key in dic) {
            NSString *value = dic[key];
            if ([key isEqualToString:@"ExpressCompany"] || [key isEqualToString:@"ExpressNo"]) {
//                && (![key isEqualToString:@"ExpressNo"]||![key isEqualToString:@"ExpressCompany"])
                continue;
            }
            if (value.length == 0 ) {
                [self.view makeToast:[NSString stringWithFormat:@"发票内容不完善，%@不能为空",key] duration:1.0 position:CSToastPositionCenter];
                return;
            }
        }
        
    }else{
    if (self.invoceTypeValue == nil || self.invoceTypeValue.length == 0) {
        [self.view makeToast:@"请选择发票类型" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.invoiceHead == nil || self.invoiceHead.length == 0) {
        [self.view makeToast:@"请填写发票抬头" duration:1.0 position:CSToastPositionCenter];
        return;
    }

    if (self.invoiceTaxID == nil || self.invoiceTaxID.length == 0) {
        [self.view makeToast:@"请填写企业纳税人识别号" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.invoiceBank == nil || self.invoiceBank.length == 0) {
        [self.view makeToast:@"请填写企业纳税人开户行和账号" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.invoiceContact == nil || self.invoiceContact.length == 0) {
        [self.view makeToast:@"请填写企业纳税人地址及电话" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.recieveName == nil || self.recieveName.length == 0) {
        [self.view makeToast:@"请填写收件人姓名" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.recieveContact == nil || self.recieveContact.length == 0) {
        [self.view makeToast:@"请填写联系电话" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.destrict == nil || self.destrict.length == 0) {
        [self.view makeToast:@"请选择所在区域" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.adresss == nil || self.adresss.length == 0) {
        [self.view makeToast:@"请选择所在街道" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if (self.adresssDetail == nil || self.adresssDetail.length == 0) {
        [self.view makeToast:@"请填写所在地区的详细地址" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if ([self.invoiceAmount floatValue] > [self.RemainApplyAmount floatValue]) {
        
        NSString *text = [NSString stringWithFormat:@"您可申请剩余开票的金额不能超过%@",self.RemainApplyAmount];
        [self.view makeToast:text duration:1.0 position:CSToastPositionCenter];
        return;
    }
  
    if (self.recieveContact.length==0) {//![Tools isMobileNumber:self.recieveContact]
        [self.view makeToast:@"收件人手机号格式填写不正确" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    }
    if (self.ContractNo.length>0) {
        
        if (self.invoiceAmount == nil || self.invoiceAmount.length == 0) {
            [self.view makeToast:@"请填写开票金额" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        if ([self.invoiceAmount floatValue] <=0) {
            
            NSString *text = [NSString stringWithFormat:@"您申请的的剩余开票的金额不能低于0"];
            [self.view makeToast:text duration:1.0 position:CSToastPositionCenter];
            return;
        }
        [self.view showWait:@"上传中" viewType:CurrentView];
        NSDictionary *parameters =nil;
        if (self.Model.CustomerTaxCode.length>0) {
            parameters = @{@"ContractNo":self.ContractNo,@"RefNo":self.refNo,@"InvoiceTitle":self.Model.InvoiceTitle,@"InvoiceType":self.Model.InvoiceType,@"InvoiceAmount":self.invoiceAmount,@"CustomerTaxCode":self.Model.CustomerTaxCode,@"CustomerBankAccount":self.Model.CustomerBankAccount,@"CustomerAddressTel":self.Model.CustomerAddressTel,@"Receiver":self.Model.Receiver,@"ReceiverPhone":self.Model.ReceiverPhone,@"Province":self.Model.Province,@"City":self.Model.City,@"Area":self.Model.Area,@"Street":self.Model.Street,@"Address":self.Model.Address };
        }else
        {
               parameters = @{@"ContractNo":self.ContractNo,@"RefNo":self.refNo,@"InvoiceTitle":self.invoiceHead,@"InvoiceAmount":self.invoiceAmount,@"InvoiceType":self.invoceTypeValue,@"CustomerTaxCode":self.invoiceTaxID,@"CustomerBankAccount":self.invoiceBank,@"CustomerAddressTel":self.invoiceContact,@"Receiver":self.recieveName,@"ReceiverPhone":self.recieveContact,@"Province":self.Province,@"City":self.City,@"Area":self.Area,@"Street":self.adresss,@"Address":self.adresssDetail};
               
        }
      
        
        [[YHJsonRequest shared] applyInvoice:parameters sucess:^(NSString *successMessage) {
            
            [self.view makeToast:@"开票申请已提交" duration:1.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [self.view hideWait:CurrentView];
        } fialureBlock:^(NSString *errorMessages) {
            [self.view hideWait:CurrentView];

            [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        }];
    } else {
        [self.view showWait:@"上传中" viewType:CurrentView];

        NSDictionary *parameters;
        if (self.Model.CustomerTaxCode.length>0) {
            parameters = @{@"RefNo":self.refNo,@"InvoiceTitle":self.Model.InvoiceTitle,@"InvoiceType":self.Model.InvoiceType,@"CustomerTaxCode":self.Model.CustomerTaxCode,@"CustomerBankAccount":self.Model.CustomerBankAccount,@"CustomerAddressTel":self.Model.CustomerAddressTel,@"Receiver":self.Model.Receiver,@"ReceiverPhone":self.Model.ReceiverPhone,@"Province":self.Model.Province,@"City":self.Model.City,@"Area":self.Model.Area,@"Street":self.Model.Street,@"Address":self.Model.Address};
            
            [[YHJsonRequest shared] editUserInvoiceManage:parameters SuccessBlock:^(NSString *success) {
                
              
                    [self.view makeToast:@"开票信息已修改成功" duration:1.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
               
                [self.view hideWait:CurrentView];

            } fialureBlock:^(NSString *errorMessages) {
                [self.view hideWait:CurrentView];

                [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
            }];
        }else
        {
        parameters = @{@"InvoiceTitle":self.invoiceHead,@"InvoiceType":self.invoceTypeValue,@"CustomerTaxCode":self.invoiceTaxID,@"CustomerBankAccount":self.invoiceBank,@"CustomerAddressTel":self.invoiceContact,@"Receiver":self.recieveName,@"ReceiverPhone":self.recieveContact,@"Province":self.Province,@"City":self.City,@"Area":self.Area,@"Street":self.adresss,@"Address":self.adresssDetail};
            
            [[YHJsonRequest shared] postUserInvoiceManage:parameters SuccessBlock:^(NSString *success) {
                
                [self.view hideWait:CurrentView];

                [self.view makeToast:@"开票信息已提交" duration:1.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            } fialureBlock:^(NSString *errorMessages) {
                [self.view hideWait:CurrentView];

                [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
            }];
            
        }
      
        
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
