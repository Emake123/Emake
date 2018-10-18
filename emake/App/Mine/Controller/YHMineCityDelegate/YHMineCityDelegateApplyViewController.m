//
//  YHMineCityDelegateApplyViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/12.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineCityDelegateApplyViewController.h"
#import "YHCityDelegateApplyTableViewCell.h"
#import "HDPickerView.h"
#import "TPKeyboardAvoidingTableView.h"
#import "verificationCodeView.h"
#import "YHCertificationStateViewController.h"
@interface YHMineCityDelegateApplyViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)NSArray *nameArr;
@property(nonatomic,strong)NSArray *placeHoldNameArr;
@property(nonatomic,strong)UIButton *commitBtn;
@property(nonatomic,strong)NSMutableDictionary *textFielfDic;
@property(nonatomic,strong)NSString *delegateCity;
@property(nonatomic,strong)NSString *codeStr;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,strong)NSArray *catagoryIds;
@property(nonatomic,strong)NSMutableArray *selectCatagoryIds;

@property(nonatomic,strong)TPKeyboardAvoidingTableView *mytable;


@end

@implementation YHMineCityDelegateApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代理商申请";
    self.nameArr = [NSArray arrayWithObjects:@"真实姓名",@"代理城市",@"手机号码",@"验 证 码", nil];
    self.placeHoldNameArr = [NSArray arrayWithObjects:@"请输入真实姓名",@"请选择代理城市",@"请输入手机号码",@"请输入手机验证码", nil];
    self.textFielfDic = [NSMutableDictionary dictionary];
    self.catagoryIds= Userdefault(CatagoryIDs);
    
    self.selectCatagoryIds = [NSMutableArray array];
    [self configView];
    
}
-(void)configView
{
  
    TPKeyboardAvoidingTableView *mytable = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    mytable.delegate = self;
    mytable.dataSource = self;
//    mytable.rowHeight = HeightRate(60);
    mytable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mytable];
    mytable.translatesAutoresizingMaskIntoConstraints = false;
    [mytable PSSetTop:TOP_BAR_HEIGHT];
    [mytable PSSetLeft:0];
    [mytable PSSetSize:ScreenWidth Height:ScreenHeight-(TOP_BAR_HEIGHT)-HeightRate(80)];
    self.mytable = mytable;
    mytable.scrollEnabled = false;
    NSString *commitTipsStr = @"遇到问题，请联系客服";
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
    [self.view addSubview:lable];
    lable.userInteractionEnabled = YES;
    lable.translatesAutoresizingMaskIntoConstraints=false;
//    lable.hidden =[state isEqualToString:@"3"]?([userType isEqualToString:@"1"]?YES:NO):NO;
    [lable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(customerSevicerClick)]];
    [lable PSSetLeft:WidthRate(33)];
//    [lable PSSetBottomAtItem:mytable Length:HeightRate(20)];
    [lable PSSetBottom:HeightRate(75)];
   
    
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setBackgroundColor:ColorWithHexString(APP_THEME_MAIN_COLOR)];
    [self.commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitApply) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitBtn];
    self.commitBtn.layer.cornerRadius = 6;
    self.commitBtn.clipsToBounds = YES;
    self.commitBtn.translatesAutoresizingMaskIntoConstraints = false;
    [self.commitBtn PSSetBottomAtItem:lable Length:HeightRate(5)];
    [self.commitBtn PSSetLeft:WidthRate(33)];
    [self.commitBtn PSSetSize:WidthRate(310) Height:HeightRate(40)];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeightRate(90);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return [self conculateHeight];
    }else
    {
        return HeightRate(60);
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeightRate(90))];
    headView.backgroundColor = ColorWithHexString(@"ffffff");
    UIView *topView = [self progressView];
    topView.translatesAutoresizingMaskIntoConstraints = false;
    [headView addSubview:topView];
    [topView PSSetTop:0];
    [topView PSSetLeft:0];
    [topView PSSetSize:ScreenWidth Height:HeightRate(51)];
    
    
    UILabel *labelName = [[UILabel alloc]init];
    labelName.text = @"选择品类";
    labelName.font = SYSTEM_FONT(AdaptFont(16));
    labelName.textColor = ColorWithHexString(@"333333");
    labelName.translatesAutoresizingMaskIntoConstraints = false;
    [headView addSubview:labelName];
    [labelName PSSetBottomAtItem:topView Length:HeightRate(10)];
    [labelName PSSetLeft:WidthRate(16)];
    
    
    UILabel *labelNameTip = [[UILabel alloc]init];
    labelNameTip.text = @"可多选";
    labelNameTip.font = SYSTEM_FONT(AdaptFont(12));
    labelNameTip.textColor = ColorWithHexString(@"999999");
//    labelNameTip.backgroundColor = ColorWithHexString(@"F2F2F2");
    labelNameTip.translatesAutoresizingMaskIntoConstraints = false;
    [headView addSubview:labelNameTip];
    [labelNameTip PSSetRightAtItem:labelName Length:WidthRate(5)];
    [labelNameTip PSSetSize:WidthRate(72) Height:HeightRate(22)];
    
    return headView;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArr.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        YHCityDelegateApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            
            cell = [[YHCityDelegateApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
//        cell.leftButton.tag= 50;
//        cell.rightButton.tag= 51;
//        [cell.leftButton addTarget:self action:@selector(selectCatagoryID:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.rightButton addTarget:self action:@selector(selectCatagoryID:) forControlEvents:UIControlEventTouchUpInside];
        

        [self getcatagoryView:cell ArrayUI:self.catagoryIds];
        cell.catagoryView.hidden = false;
        cell.nameLable.hidden = YES;
        cell.nameTextField.hidden = YES;
        cell.lineLable.hidden = YES;
        cell.getCodeButton.hidden = YES;
        cell.DownImageView.hidden = YES;
        return cell;
        
    }else
    {
        
        YHCityDelegateApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell==nil) {
            
            cell = [[YHCityDelegateApplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        cell.catagoryView.hidden = YES;

    
        cell.nameLable.hidden = false;
        cell.nameTextField.hidden = false;
        cell.nameTextField.delegate = self;
        cell.nameTextField.tag = 10+indexPath.row;
        cell.nameTextField.userInteractionEnabled = YES;
        if (indexPath.row == 2) {
            cell.lineLable.hidden = YES;
            cell.getCodeButton.hidden = YES;
            cell.DownImageView.hidden = false;
            cell.nameTextField.userInteractionEnabled = false;
            if (self.delegateCity.length>0) {
                cell.nameTextField.text = self.delegateCity;
            }

        } else if(indexPath.row ==4) {
            cell.lineLable.hidden = false;
            cell.getCodeButton.hidden = false;
            cell.DownImageView.hidden = YES;
//            cell.getCodeButton.tag = 60;
            [cell.getCodeButton addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.getCodeButton.tag = 60;
            if (self.delegateCity.length>0) {
                cell.nameTextField.text = self.codeStr;
            }
            
        }else if(indexPath.row ==3){
            cell.nameTextField.text = Userdefault(LOGIN_MOBILEPHONE);
            cell.nameTextField.userInteractionEnabled = false;
            self.phoneNumber = Userdefault(LOGIN_MOBILEPHONE);;
            cell.lineLable.hidden = YES;
            cell.getCodeButton.hidden = YES;
            cell.DownImageView.hidden = YES;
        }else{
            cell.lineLable.hidden = YES;
            cell.getCodeButton.hidden = YES;
            cell.DownImageView.hidden = YES;
        }
        cell.nameLable.text = self.nameArr[indexPath.row-1];
        cell.nameTextField.placeholder = self.placeHoldNameArr[indexPath.row-1];
      
        return cell;
    }
    
}

-(UIView *)progressView
{
   
    
    UIView *bgview1 = [[UIView alloc] init];

    NSArray *titleArr = @[@"填写基本信息",@"等待客服审核",@"审核完成"];
    NSArray *imageArr =@[@"0201",@"0102",@"0103"];//[state isEqualToString:@"2"]?@[@"0201",@"0202",@"0103"]: @[@"0101",@"0102",@"0103"];

    CGFloat width = (ScreenWidth-20)/3;
    for (int i = 0; i < titleArr.count; i ++) {

        UIImageView *progressImageView = [[UIImageView alloc] init];
        progressImageView.image = [UIImage imageNamed:imageArr[i]];
        progressImageView.frame = CGRectMake(10+width*i, 15, width, HeightRate(16));
        [bgview1 addSubview:progressImageView];

        UILabel *title = [[UILabel alloc] init];
        title.text = titleArr[i];
        title.font = [UIFont systemFontOfSize:AdaptFont(10)];
        title.frame = CGRectMake(10+width*i,  HeightRate(31), width, HeightRate(20));
        title.textColor = ColorWithHexString(@"797979");
        title.textAlignment = NSTextAlignmentCenter;
        [bgview1 addSubview:title];

    }
    
    return bgview1;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ColorCell *vd =(ColorCell *)[self.colorTableView  cellForRowAtIndexPath:indexPath];
//    YHCityDelegateApplyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 2) {
        NSString *key = self.nameArr[indexPath.row];
        YHMineCityDelegateApplyViewController *weakSelf = self;
        HDPickerView *pickerView = [HDPickerView selectCity:^(NSString * _Nullable province, NSString * _Nullable city, NSString * _Nullable area, NSArray * _Nullable streets) {
            weakSelf.delegateCity =[province isEqualToString:city]?province:[NSString stringWithFormat:@"%@%@",province,city];
            [weakSelf.textFielfDic setObject: weakSelf.delegateCity forKey:key];
//            [tableView reloadData];
            [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];

        } flag:YES];
        [pickerView show];
    }
   
}

-(void)selectCatagoryID:(UIButton *)button
{
    button.selected = !button.selected;
    NSInteger index = button.tag-10;
    NSString *cataGoryId = @"";
    for (NSDictionary *dict in self.catagoryIds) {
        NSString *name = dict[@"CategoryBName"];
        if ([name containsString:button.currentTitle]) {
            cataGoryId= dict[@"CategoryBId"];
            break;
        }
    }
    
    if (button.selected ==false) {
        if ([self.selectCatagoryIds containsObject:cataGoryId]) {
            [self.selectCatagoryIds removeObject:cataGoryId];
        }
        button.layer.borderColor = ColorWithHexString(@"E4E4E4").CGColor ;
        [button setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
    }else
    {
        [self.selectCatagoryIds addObject:cataGoryId];

        button.layer.borderColor = ColorWithHexString(StandardBlueColor).CGColor ;
        [button setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
    }
}
//获取验证码
-(void)getCodeBtnClick:(UIButton *)button{
    
    [self.view endEditing:YES];

    if (self.phoneNumber.length == 0 ) {
        [self.view makeToast:[NSString stringWithFormat:@"手机号码不能为空"] duration:1.5 position:CSToastPositionCenter];
        return;
    }
    if (![Tools isMobileNumber:self.phoneNumber] ) {
       
        [self.view makeToast:[NSString stringWithFormat:@"手机号码格式不正确"] duration:1.5 position:CSToastPositionCenter];
        return;
    }
    [self.view showWait:@"loading..." viewType:CurrentView];
    [[YHJsonRequest shared] verificationCode:self.phoneNumber isRegisterOrReset:1 succeededBlock:^(NSString *successMessage) {
//        self.codeStr = successMessage;
        [verificationCodeView openCountdownWithButton:button];
        [self.view hideWait:CurrentView];
        [self.view makeToast:successMessage];
    } failedBlock:^(NSString *errorMessage) {
        [self.view hideWait:CurrentView];
        [self.view makeToast:errorMessage];
    }];
}
-(void)commitApply
{
    if (self.selectCatagoryIds.count ==0) {
        [self.view makeToast:[NSString stringWithFormat:@"请选择经营品类"] duration:1.5 position:CSToastPositionCenter];
        return;
    };
    if (self.realName.length ==0) {
        [self.view makeToast:[NSString stringWithFormat:@"真实姓名不能为空"] duration:1.5 position:CSToastPositionCenter];
        return;
    };
    if (self.delegateCity.length ==0) {
        [self.view makeToast:[NSString stringWithFormat:@"代理城市不能为空"] duration:1.5 position:CSToastPositionCenter];
        return;
    };
    if (self.phoneNumber.length ==0 || ![Tools isMobileNumber:self.phoneNumber]) {
        [self.view makeToast:[NSString stringWithFormat:@"手机号格式不正确"] duration:1.5 position:CSToastPositionCenter];
        return;
    };
    if (self.codeStr.length ==0) {
        [self.view makeToast:[NSString stringWithFormat:@"验证码不能为空"] duration:1.5 position:CSToastPositionCenter];
        return;
    };

    
    NSDictionary *dic = @{@"RealName":self.realName,@"AgentCity":self.delegateCity,@"MobileNumber":self.phoneNumber,@"Code":self.codeStr,@"AgentCategoryBIds":self.selectCatagoryIds};
    [[YHJsonRequest shared] getAppAgentApply:dic SuccessBlock:^(NSDictionary *success) {
        [self.view makeToast:@"提交成功" duration:1.5 position:CSToastPositionCenter];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_USERCARDSTATE];

        YHCertificationStateViewController *vc = [[YHCertificationStateViewController alloc] init];
        vc.successDate = [NSDate getCurrentTime];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}


#pragma mark--TextField delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger index = textField.tag -10;
    
    switch (textField.tag) {
        case 11:
            self.realName = textField.text;
            break;
        case 12:
            self.delegateCity = textField.text;
            break;
        case 13:
            self.phoneNumber = textField.text;
            break;
        case 14:
            self.codeStr = textField.text;
            break;
        default:
            break;
    }
//    NSString * key = self.nameArr[index];
//    [self.textFielfDic setObject:textField.text forKey:key];
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

-(void)getcatagoryView:(UIView *)bgview  ArrayUI:(NSArray *)arr
{
    CGFloat TotalWidth = 0;
    UIButton *item;
    CGFloat recordxx =0;
    for (NSInteger i = 0; i < arr.count; i++) {
        NSDictionary *dic =self.catagoryIds[i];
        NSString *name = dic[@"CategoryBName"];
        NSString *str =[name containsString:@"云工厂"]?[name substringWithRange:NSMakeRange(0, name.length-3)]:name ;
        CGRect rect = [str boundingRectWithSize:CGSizeMake(WidthRate(300), 40) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptFont(11)]} context:nil];
        
        CGFloat w = rect.size.width+30;
        CGFloat h = 30;
        
        TotalWidth += w+10;
        
        
        int yy = (int)(WidthRate(TotalWidth)/(ScreenWidth-30));
        CGFloat Y = yy*40 +10;
        
        UIButton *lable = [[UIButton alloc] init];
//        lable.textColor = ColorWithHexString(@"333333");
        [lable setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
        lable.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(11)];
        lable.layer.borderWidth = 1;
        lable.layer.borderColor = ColorWithHexString(@"E4E4E4").CGColor;
//        lable.textAlignment = NSTextAlignmentCenter;
//        lable.text = str;
        [lable setTitle:str forState:UIControlStateNormal];
        lable.tag = i+10;
        [bgview addSubview:lable];
        lable.translatesAutoresizingMaskIntoConstraints = NO;
        [lable PSSetSize:WidthRate(w) Height:HeightRate(30)];
        
        if (item == nil | recordxx != yy) {
            [lable PSSetLeft:WidthRate(15)];
            [lable PSSetTop:HeightRate(Y)];
        }else
        {
            [lable PSSetRightAtItem:item Length:WidthRate(10)];
            [lable PSSetTop:HeightRate(Y)];
        }
//        lable.userInteractionEnabled = YES;
//        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectlableClick:)]];
        [lable addTarget:self action:@selector(selectCatagoryID:) forControlEvents:UIControlEventTouchUpInside];
        item = lable;
        recordxx = yy;
    }
    
}

-(CGFloat)conculateHeight
{
    CGFloat TotalWidth =0;
    CGFloat Totalheight = 0;
    
    for (NSInteger i = 0; i < self.catagoryIds.count; i++) {
        NSDictionary *dic =self.catagoryIds[i];
        NSString *name = dic[@"CategoryBName"];
        NSString *str =[name containsString:@"云工厂"]?[name substringWithRange:NSMakeRange(0, name.length-3)]:name ;
        CGRect rect = [str boundingRectWithSize:CGSizeMake(WidthRate(300), 40) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptFont(11)]} context:nil];
        
        CGFloat w = rect.size.width+30;
        CGFloat h = 40;
        
        TotalWidth += w+10;
        int yy = (int)(WidthRate(TotalWidth)/(ScreenWidth-30));
        Totalheight = (yy+1)*h +10;
        NSLog(@"Totalwidth=%f,yy=%d,Totalheight=%f",TotalWidth,yy,Totalheight);
        
        
    }
    return HeightRate(Totalheight);
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
