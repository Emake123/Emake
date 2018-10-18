//
//  YHJsonRequest.m
//  emake
//
//  Created by chenyi on 2017/8/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHShoppingCartModel.h"
#import "productPagramaDicModel.h"
#import "productParamModel.h"
#import "YHOrderContract.h"
#import "YHMainShoppingModel.h"
#import "YHBrandModel.h"
#import "YHInsuranceModel.h"
#import "YHProductAddSeviceModel.h"
#import "teamModel.h"
#import "YHTeamMakeTaskModel.h"
#import "YHUserContribution.h"
#import "YHDepositModel.h"
#import "YHBankModel.h"
#import "YHInviteMessageModel.h"
#import "YHcontractImageModel.h"
#import "YHMainCatagoryModel.h"
#import "YhSearchModel.h"
#import "YHStoreModel.h"
#import "YHLogistics.h"
#import "Tools.h"
#import "YHSuperGroupModel.h"
#import "productModel.h"
#import "YHCityDelegateMOdel.h"
@implementation YHJsonRequest
DEFINE_SINGLETON_FOR_CLASS(YHJsonRequest);
//错误信息处理
- (NSString *)dealWithError:(NSInteger)code{
    
    switch (code)
    {
        case 401:
        {
//            NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_Refresh_Token];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonGetNewTocken object:[Tools currentViewController] userInfo:@{@"code":@"401"}];
            return @"登录已过期";
            
        } break;
        case 403:
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonGetNewTocken object:[Tools currentViewController] userInfo:@{@"code":@"403"}];

            return @"登录已过期";
        case 404:
            return @"请求路径错误";
        break;
        case 500 ... 505:
            return[NSString stringWithFormat:@"code:%ld 服务端异常",code] ;
        break;
//        case 502:
//            return @"502服务端异常";
//        break;
        default:
            return @"网络异常，请检查网络";
    }
}
//获取版本号
- (void)getAppVersionSucceededBlock:(void (^)(NSDictionary *dict))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock{
    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppVersion parameters:nil finished:^(NSDictionary *result, NSError *error) {
        if (!error) {
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                    succeededBlock(data);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    failedBlock(failStr);
                }
            }
        }else{
            failedBlock([self dealWithError:error.code]);
        }
    }];
}

//获取验证码
-(void) verificationCode:(NSString *) mobileNumber isRegisterOrReset:(NSInteger)flag succeededBlock:(void (^)(NSString *successMessage))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock{
    NSDictionary *parameters = @{@"MobileNumber":mobileNumber,@"VerificationType":@(flag)};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_VerificationCode parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        
//                        if(![URL_VerificationCode containsString:@"http://git.emake.cn"]){//判断是否是正式服的地址
                            succeededBlock([result objectForKey:RESPONSE_RESULT_INFO]);

//                        }else
//                        {
////                            NSDictionary *dic = result[RESPONSE_RESULT_DATA];
////                            NSNumber *num =dic[@"VerificationCode"];
////                            succeededBlock([NSString stringWithFormat:@"%@",num]);
//
//                        }
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}

//获取修改手机号验证码
-(void)exchangePhoneNumberVerificationCode: (NSString *) mobileNumber
                            succeededBlock:(void (^)(NSString *successMessage))succeededBlock
                               failedBlock:(void (^)(NSString *errorMessage))failedBlock{
    NSDictionary *parameters = @{@"MobileNumber":mobileNumber,@"VerificationType":@"2"};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_VerificationCode parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        succeededBlock([result objectForKey:RESPONSE_RESULT_INFO]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//提交修改手机号
-(void)exchangePhoneNumberMobileNumber: (NSString *) mobileNumber andVerificationCode:(NSString *) code
                        succeededBlock:(void (^)(NSString *successMessage))succeededBlock
                           failedBlock:(void (^)(NSString *errorMessage))failedBlock{
    NSDictionary *parameters = @{@"MobileNumber":mobileNumber,@"VerificationCode":code};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserMobileNumber parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        succeededBlock([result objectForKey:RESPONSE_RESULT_INFO]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//登录 
-(void)loginWithPassword: (NSString *) Password MobileNumber:(NSString *) mobileNumber
           succeededBlock:(void (^)(YHLoginUser *loginUser))succeededBlock
              failedBlock:(void (^)(NSString *errorMessage))failedBlock{
    NSString *passwordMd5 = [Tools md5:Password];
    
    NSDictionary *parameters = @{@"MobileNumber":mobileNumber,@"Password":passwordMd5,@"client_id":@"emake_app"};
    [[NSUserDefaults standardUserDefaults] setObject:mobileNumber forKey:LOGIN_MOBILEPHONE];//
    [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserLoginWithVerificationCode parameters:parameters finished:^(NSDictionary *result, NSError *error) {
        if (!error) {
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                    YHLoginUser *loginUser = [YHLoginUser mj_objectWithKeyValues:data[@"userinfo"]];
                    loginUser.access_token = data[@"access_token"];
                    loginUser.refresh_token = data[@"refresh_token"];

                    succeededBlock(loginUser);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    failedBlock(failStr);
                }
            }
        }else{
            failedBlock([self dealWithError:error.code]);
        }
    }];
}

//注册
-(void)userRegist:(NSDictionary *)params
    succeededBlock:(void (^)(YHRegesterModel *loginUser))succeededBlock
       failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserRegist parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        YHRegesterModel *loginUser = [YHRegesterModel mj_objectWithKeyValues:data];
                        succeededBlock(loginUser);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//注册后的设置密码
-(void)userReset:(NSString *)mobileNumber  VerificationPassword:(NSString *)VerificationPassword Password:(NSString *)Password succeededBlock:(void (^)(YHLoginUser *loginUser))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
    NSString *passwordMd5 = [Tools md5:Password];
    NSDictionary *parameters = @{@"MobileNumber":mobileNumber,@"VerificationPassword":passwordMd5,@"Password":passwordMd5,@"VerificationCode":VerificationPassword};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserResetPassword parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        succeededBlock([result objectForKey:RESPONSE_RESULT_INFO]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//忘记密码
-(void)userforget:(NSString *)mobileNumber  VerificationCode:(NSString *)VerificationCode Password:(NSString *)Password succeededBlock:(void (^)(YHLoginUser *loginUser))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
    
    NSString *passwordMd5 = [Tools md5:Password];
    NSDictionary *parameters = @{@"MobileNumber":mobileNumber,@"VerificationCode":VerificationCode,@"Password":passwordMd5};
    NSLog(@"erificationCode===%@",VerificationCode);
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserForgetPassword parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        succeededBlock([result objectForKey:RESPONSE_RESULT_INFO]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}

//获取首页背景图片 ---废弃
-(void)getUserMainpageBackgroudImageDataFindSucceededBlock:(void (^)(NSDictionary *shoppingCartArray))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_MainPageImage parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                       
                        succeededBlock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
   
}
//上传
- (void)postURL:(NSString *)URL toServers:(void(^)(UserInfoModel *successMessagesMode))successedBLock failBLock:(void (^) (NSString *errorMessage))failedBlock{
    NSDictionary *parameters = @{@"Image": URL};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserCard parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        UserInfoModel *model = [UserInfoModel mj_objectWithKeyValues:dic];
                        successedBLock(model);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}

//上传id身份证image
- (void)uploadIDCardImageWithURLpostSevice:(NSString *)postParems SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    
//    NSString *imagedata = postParems.firstObject;
    NSDictionary *parameters = @{@"Image": postParems};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] POST:URL_UserUploadIDImage parameters:parameters finished:^(id result, NSError *error) {
        
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *picUrl = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(picUrl[@"ImageUrl"]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
    
}
//购物车查询
-(void)userUserShoppingFindSucceededBlock:(void (^)(NSArray < YHShoppingCartModel *>*shoppingCartArray))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{

    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_UserFindingShoppingCart parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *shoppingCartArr = [YHShoppingCartModel mj_objectArrayWithKeyValuesArray:data];
                        for (YHShoppingCartModel *order11 in shoppingCartArr) {
                            NSArray *addsevice = [YHOrderAddSevice mj_objectArrayWithKeyValuesArray:order11.AddServiceInfo];
                            order11.AddServiceArr = addsevice;
                            if (order11.IsPriceTax.intValue ==1) {
                                order11.IsInvoice = @"1";
                            }
                            NSArray *imageArr = [Tools stringToJSON:order11.GoodsSeriesPhotos];
                            if (imageArr.count>0) {
                                order11.GoodsSeriesIcon = imageArr.firstObject;
                            }
                            
                        }
                        succeededBlock(shoppingCartArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//贡献战队
-(void)usersTeamMakeContributionsSucceededBlock:(void (^)(NSArray *teamArray))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_MakeContributions parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        if (data.count==0) {
                             succeededBlock(nil);
                        }else{
                        
                        NSArray *shoppingCartArr = [teamModel mj_objectArrayWithKeyValuesArray:data];
                        teamModel*model = shoppingCartArr[0];
                        model.isSelect = YES;
                                succeededBlock(shoppingCartArr);
                    }
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//订单查询
-(void)userUseOrderManageParams:(NSDictionary *)params SucceededBlock:(void (^)(NSArray *orderArray))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
//    NSString *urlStr = [isStore isEqualToString:@"1"]?URL_StoreContractOder:URL_ContractOder;
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_ContractOder parameters:params finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dataArr = [responseObject objectForKey:RESPONSE_RESULT_DATA];
//                        NSArray *keyS = data[@"index"];
                        NSMutableArray *ModelArray = [NSMutableArray array];
                        for (NSDictionary *contractDic in dataArr) {
//
                            YHOrderContract *contract = [YHOrderContract mj_objectWithKeyValues:contractDic];
                            
                            NSMutableArray *goods = [NSMutableArray array];
                           double totalFreightFee = 0 ;
                            for (NSDictionary *goodDic in contract.ProductList) {
                                YHOrder *order = [YHOrder mj_objectWithKeyValues:goodDic];
                                NSArray *addsevice = [YHOrderAddSevice mj_objectArrayWithKeyValuesArray:order.AddServiceInfo];
                                order.AddServiceArr = addsevice;
                                totalFreightFee += order.TotalShippingFee.doubleValue;
                                NSArray *imageArr = [Tools stringToJSON:order.GoodsSeriesPhotos];
                                if (imageArr.count>0) {
                                    order.GoodsSeriesIcon = imageArr.firstObject;
                                }
                                [goods addObject:order];
                            }
                            contract.goodsModelArr = goods;
                            switch (contract.OrderState.integerValue) {
                                case -2:
                                {contract.OrderStateName =contract.IsOut.integerValue==0?@"已失效": @"待签订";
                                    contract.ContractAmount =[NSString stringWithFormat:@"%f",(contract.ContractAmount.doubleValue-totalFreightFee)];
                                    NSLog(@"%@-%f-%@",contract.ContractNo,totalFreightFee,contract.ContractAmount);
                                }
                                    break;
                                case 0:
                                {
                                    contract.OrderStateName = contract.IsOut.integerValue==0?@"已失效":@"待付款";

                                }
                                    break;
                                case 1: contract.OrderStateName = @"待付款";//@"生产中";
                                    break;
                                case 2: contract.OrderStateName = @"待付款";//@"生产完成";
                                    break;
                                case 3: contract.OrderStateName = @"已发货";
                                    break;
                                default:
                                    break;
                            }
                  

                            NSArray *shipInfo = [YHOrderShippingInfo mj_objectArrayWithKeyValuesArray:contract.ShippingInfo];
                            
                            contract.shipingModelArr = shipInfo;
                            [ModelArray addObject:contract];
                        }
                        succeededBlock(ModelArray);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//订单查询
-(void)getUseOrderContractNoParams:(NSString *)OrderNo SucceededBlock:(void (^)(YHOrderContract *OrderContract))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
//    NSString *isStore = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
    NSString *urlStr = [NSString stringWithFormat:@"%@?RequestType=1&OrderNo=%@",URL_ContractOder,OrderNo];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:urlStr parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dataArr = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        //                        NSArray *keyS = data[@"index"];
                        NSMutableArray *ModelArray = [NSMutableArray array];
                        for (NSDictionary *contractDic in dataArr) {
                            //
                            YHOrderContract *contract = [YHOrderContract mj_objectWithKeyValues:contractDic];
                            switch (contract.OrderState.integerValue) {
                                case -2:contract.OrderStateName =contract.IsOut.integerValue==0?@"已失效": @"待签订";
                                    break;
                                case 0:
                                {
                                    contract.OrderStateName = contract.IsOut.integerValue==0?@"已失效":@"待付款";
                                    
                                }
                                    break;
                                case 1: contract.OrderStateName = @"生产中";
                                    break;
                                case 2: contract.OrderStateName = @"生产完成";
                                    break;
                                case 3: contract.OrderStateName = @"已发货";
                                    break;
                                default:
                                    break;
                            }
                            NSMutableArray *goods = [NSMutableArray array];
                            for (NSDictionary *goodDic in contract.ProductList) {
                                YHOrder *order = [YHOrder mj_objectWithKeyValues:goodDic];
                                NSArray *addsevice = [YHOrderAddSevice mj_objectArrayWithKeyValuesArray:order.AddServiceInfo];
                                order.AddServiceArr = addsevice;
                                [goods addObject:order];
                            }
                            NSArray *shipInfo = [YHOrderShippingInfo mj_objectArrayWithKeyValuesArray:contract.ShippingInfo];
                            
                            contract.goodsModelArr = goods;
                            contract.shipingModelArr = shipInfo;
                            [ModelArray addObject:contract];
                        }
                        succeededBlock(ModelArray);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        failedBlock(failStr);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//订单删除
-(void)deleteOrderManageContratNo:(NSString*)ContractNo SucceededBlock:(void (^)(NSString *successMessage))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
    NSString *URL = [NSString stringWithFormat:@"%@?ContractNo=%@",URL_UserOrderManage,ContractNo];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:URL parameters:nil finished:^(NSDictionary *responseObject, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(responseObject)){
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSString *info = [responseObject objectForKey:RESPONSE_RESULT_INFO];
                        succeededBlock(info);
                    }
                    else
                    {
                        failedBlock([NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO]);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
         }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//修改订单状态
-(void)putOrderManageContratNo:(NSDictionary*)params SucceededBlock:(void (^)(NSString *successMessage))succeededBlock failedBlock:(void (^)(NSString *errorMessage))failedBlock
{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserOrderManage parameters:params finished:^(NSDictionary *responseObject, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *info = [responseObject objectForKey:RESPONSE_RESULT_INFO];
                        succeededBlock(info);
                    }else{
                        failedBlock([NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO]);
                    }
                }
            }else{
                failedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        failedBlock(@"网络异常，请检查网络");
    }
}
//获取用户信息
- (void)getUserInfoSuccessBlock:(void(^)(UserInfoModel *userInfo))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserInfo parameters:nil finished:^(NSDictionary *responseObject, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        UserInfoModel *user = [UserInfoModel mj_objectWithKeyValues:data];
                        successBLock(user);
                    }else{
                        filaedBlock([responseObject objectForKey:RESPONSE_RESULT_INFO]);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
}
//获取系列产品
-(void)getGoodsseries:(NSString *)kindcode SuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    NSString *URL = [NSString stringWithFormat:@"%@?CategoryId=%@",URL_Goodsseries,kindcode];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL parameters:nil finished:^(NSDictionary *responseObject, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [productModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(arr);
                    }else{
                        filaedBlock([responseObject objectForKey:RESPONSE_RESULT_INFO]);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//获取产品增值服务
-(void)getProductAddServiceGoodcode:(NSString *)productId SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
//    3190b870-88bb-11e8-ad44-3402866ed85d productId
    NSString *URL = [NSString stringWithFormat:@"%@?ProductId=%@",URL_PropertyAddSevice,productId];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL parameters:nil finished:^(NSDictionary *responseObject, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSArray *dataArray = [responseObject objectForKey:RESPONSE_RESULT_DATA];
//                        NSArray *arr = data[@"add_service"];
                        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
                        for (NSDictionary *dict in dataArray) {
                            NSArray *array = dict[@"GoodsList"];
                            NSString *key = dict[@"GoodsTypeName"];
                            NSMutableArray *modelArr = [NSMutableArray array];
                            for (NSDictionary *dict1 in array) {
                                YHProductAddSeviceModel *model = [YHProductAddSeviceModel mj_objectWithKeyValues:dict1];
                                model.GoodsType = dict[@"GoodsType"];
                                [modelArr addObject:model];
                            }
                            YHProductAddSeviceModel *model11 ;
                            if (modelArr.count>0) {
                                model11  = modelArr[0];
                                
                            }else{
                                
                                model11 = [[YHProductAddSeviceModel alloc] init];
                                BOOL isAccesory =[key isEqualToString:@"附件"];//辅件
                                model11.GoodsType = isAccesory?@"2":@"3";
                            }
                            YHProductAddSeviceModel *model = [[YHProductAddSeviceModel alloc] init];
                            
                            if ([model11.GoodsType isEqualToString:@"2"]) {
                                model.GoodsType = @"2";
                                model.GoodsTitle= @"无";
                                model.ProductId = @"";
                                model.GoodsPrice=@"0";
                            }
                            else if ([model11.GoodsType isEqualToString:@"3"])
                            {
                                model.GoodsType = @"3";
                                model.GoodsTitle= @"无";
                                model.ProductId = @"";
                                model.GoodsPrice=@"1";
                                
                            }
                            [modelArr addObject:model];
                            [resultDic setValue:modelArr forKey:key];
                        }
                        successBLock(resultDic);
                    }else{
                        filaedBlock([responseObject objectForKey:RESPONSE_RESULT_INFO]);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
-(void)getProductAllPropertyListGoodcode:(NSString *)params seriesCode:(NSString *)seriesCode SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
//    NSString *isStore =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
    NSString *URL = [NSString stringWithFormat:@"%@?GoodsSeriesCode=%@",URL_PropertyProductList,params];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL parameters:nil finished:^(NSDictionary *responseObject, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        
                        NSDictionary *ListDic = data[@"product_dict"];
                        NSArray *keys =   ListDic[@"index"];
                        NSMutableDictionary *modelDic = [NSMutableDictionary dictionary];
                        NSMutableArray * modelArr = [NSMutableArray array];
                        
                        for (NSString *key in keys) {
                            NSDictionary *Firstdic = ListDic[key];
                            productIdModel *Idmodel = [productIdModel mj_objectWithKeyValues:Firstdic];
                            
                            NSArray *keys2  = Idmodel.Specs[@"index"];
                            
                            NSMutableDictionary *modelDic1 = [NSMutableDictionary dictionary];
                            
                            for (NSString *key2 in keys2) {
                                
                                NSDictionary *secondDic  = Idmodel.Specs[key2];
                                productParamModel * parammodel = [productParamModel  mj_objectWithKeyValues:secondDic];
                                parammodel.ProductId = key;
                                parammodel.GoodsTitle = Idmodel.GoodsTitle;
                                parammodel.PruductPrice = Idmodel.GoodsPrice;
                                parammodel.isChoose = NO;
                                parammodel.chooseIndex = -1;
                                [modelDic1 setObject:parammodel forKey:key2];
                            }
                            [modelArr addObject:modelDic1];
                            
                            [modelDic setObject:modelArr forKey:key];
                            
                        }
                        NSArray *resultList;
                        if(modelDic.count> 0)
                        {
                            resultList = [modelDic allValues][0];
                            NSMutableArray *arr = [NSMutableArray array];
                            for ( NSDictionary *dic in data[@"menu_list"]) {
                                productIndex *model = [productIndex mj_objectWithKeyValues:dic];
                                [arr addObject:model];
                            }
                            
                            NSDictionary *successDic = @{@"product_dict":resultList,@"menu_list":arr};
                            successBLock(successDic);

                        }else
                        {
                            resultList = @[];
                            successBLock(nil);

                        }

                      
                        

                    }else{
                        filaedBlock([responseObject objectForKey:RESPONSE_RESULT_INFO]);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)addShoppinCartWithParams:(NSDictionary *)Params SuccessBlock:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserFindingShoppingCart parameters:Params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        
                        NSString *data = [result objectForKey:RESPONSE_RESULT_DATA];

                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    

                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//更新昵称或头像
- (void)upDateNickName:(NSString *)nickName AndHeadImage:(NSString *)url SuccessBlock:(void (^)(NSString *))successBLock fialureBlock:(void (^)(NSString *))filaedBlock{
    NSDictionary *parameters = @{@"HeadImageUrl":url,@"NickName":nickName};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_User parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        successBLock(@"头像上传成功");
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//更新个人信息
- (void)putUserInfo:(NSDictionary *)parameters SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserInfo parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//用户审核
- (void)userAudit:(NSDictionary *)parameters SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_InfoUpdate parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic =result[RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//更新密码
- (void)updatePassword:(NSDictionary *)parameters SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserPassword parameters:parameters finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)makeShoppingCartOderParams:(NSDictionary *)params SuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_ContractOder parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)getUserAdressType:(NSString *)type SuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    NSString *URL =[NSString stringWithFormat:@"%@?AddressType=%@",URL_UserAdress,type];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *modelArr = [adressModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(modelArr);
                      
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)postUserAdressParams:(NSDictionary *)params SuccessBlock:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserAdress parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//删除地址
-(void)deleteUserAdressParams:(NSDictionary *)params SuccessBlock:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:URL_UserAdress parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
-(void)putUserAdressParams:(NSDictionary *)params SuccessBlock:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserAdress parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getUserFriendSuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserFriend parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [UserFriendModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getBannerAddInfo:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserAbout parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [UserFriendModel mj_objectArrayWithKeyValuesArray:data];
                        NSMutableArray *mArr = [NSMutableArray array];
                        for (UserFriendModel *model in arr) {
                            [mArr addObject:model.ImageUrl];
                        }
                        successBLock(mArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)shoppingCartDeleteOderNumber:(NSArray *)order Sucess:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    NSString *arrayStr = [[order mj_JSONString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 

    NSString *urlStr = [NSString stringWithFormat:@"%@?OrderNos=%@",URL_UserFindingShoppingCart,arrayStr];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:urlStr parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *data = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)shoppingCartChangeOderNumber:(NSDictionary *)order Sucess:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{

    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserFindingShoppingCart parameters:order finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        successBLock(@"success");
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getLogisticsInfomation:(NSString *)logisticsNumber Sucess:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
NSString *URL =[NSString stringWithFormat:@"%@?ContractNo=%@",URL_LogisticsInfo,logisticsNumber];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dataArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *logistMArray = [NSMutableArray array];
                        for (NSDictionary *dict  in dataArr) {
                            
                            YHLogistics *logistModel = [YHLogistics mj_objectWithKeyValues:dict];
                            NSInteger totalNum = 0;
                            for (NSDictionary * goodsDict in logistModel.Goods) {
                                NSString *GoodsNum = goodsDict[@"ShippingNumber"] ;
                                totalNum += GoodsNum.integerValue;
                            }
                            logistModel.ShippingTotalNumber = totalNum;
                            [logistMArray addObject:logistModel];
                        }
                        
                        successBLock(logistMArray);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getInvoiceTypeSucess:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *URL =[NSString stringWithFormat:@"%@?ParamName=InvoiceType",URL_InvoiceType];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)applyInvoice:(NSDictionary *)parameters sucess:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_InvoiceApply parameters:parameters finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)applyInvoiceListsucess:(void(^)(NSArray< YHInvoiceListModel *>*shoppingCartArray))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_InvoiceApply parameters:nil finished:^(id result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSArray *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *shoppingCartArr = [YHInvoiceListModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(shoppingCartArr);
                    }
                    else
                    {
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }

            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getuserShopping:(void(^)(NSArray*shoppingCartArray))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_ShoppingFormat parameters:nil finished:^(id result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSArray *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *shoppingCartArr = [YHMainShoppingModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(shoppingCartArr);
                    }
                    else
                    {
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
}

- (void)getuserBrandParams:(NSDictionary *)dic success:(void(^)(NSArray*shoppingCartArray))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{


    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_Brand parameters:dic finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *resultArr = [NSMutableArray array];
                        for (NSDictionary *dic in data) {
                            YHBrandListModel *listModel = [YHBrandListModel mj_objectWithKeyValues:dic];
                            listModel.BrandArr = [NSMutableArray array];
                            if (listModel.Brands.count>0) {
                                for (NSDictionary *dict in listModel.Brands) {
                                    YHBrandModel *Model = [YHBrandModel mj_objectWithKeyValues:dict];
                                    NSMutableArray * picArr = [NSMutableArray array];
                                    Model.industryImageArr = [YHBrandListImageModel mj_objectArrayWithKeyValuesArray:Model.industry_list];
                                   
                                    Model.zizhiImageArr  = [YHBrandListImageModel mj_objectArrayWithKeyValuesArray:Model.zizhi_list];
                                     Model.systemImageArr  = [YHBrandListImageModel mj_objectArrayWithKeyValuesArray:Model.system_list];
                                    if (Model.industryImageArr.count>0) {
                                        [picArr addObject:Model.industryImageArr];
                                    }
                                    if (Model.zizhiImageArr.count>0) {
//                                        [picArr addObject:Model.zizhiImageArr];
                                    }
                                    if (Model.systemImageArr.count>0) {
                                        [picArr addObject:Model.systemImageArr];
                                    }
                                   
                                    Model.picArr = picArr;
                                    [listModel.BrandArr addObject:Model];
                                }
                            }
                            [resultArr addObject:listModel];
                        }
                        successBLock(resultArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getRemainInvoiceAmount:(NSString *)ContractNo success:(void(^)(NSNumber *))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@?ContractNo=%@",URL_InvoiceRemainAmount,ContractNo];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:urlStr parameters:nil finished:^(id result, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0)
                    {
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSNumber *amount = [data objectForKey:@"RemainInvoiceAmount"];
                        successBLock(amount);
                    }
                    else
                    {
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
                
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getuserLastweekOrder:(void(^)(NSDictionary*shoppingCartDict))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{

        [[YHAFNetWorkingRequset sharedRequset] GET:URL_LastWeekOrder parameters:nil finished:^(NSDictionary * responseObject, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
                else
                    filaedBlock(@"服务器连接失败，请稍后再试");
            }else{
                 filaedBlock([self dealWithError:error.code]);
            }
        }];
}
- (void)getProductDetailsInfoWith:(NSString *)CategoryId seriesCode:(NSString *)seriesCode successBlock:(void(^)(NSDictionary *ProductDetailsDict))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    NSString *storeurl = userId.length>0?[NSString stringWithFormat:@"%@?GoodsSeriesCode=%@&UserId=%@",URL_ShoppingDetail,CategoryId,userId]:[NSString stringWithFormat:@"%@?GoodsSeriesCode=%@",URL_ShoppingDetail,CategoryId];
//    NSString *Url = [NSString stringWithFormat:@"%@?GoodsSeriesCode=%@",[isStore isEqualToString:@"1"]?URL_StoreShoppingDetail:URL_ShoppingDetail,CategoryId];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:storeurl parameters:nil finished:^(NSDictionary * responseObject, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
//                    GoodsSeriesPhotos
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)userSignContract:(NSString *)contractOrderNum SuccessBlock:(void(^)(NSString *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock
{
    NSString *Url = [NSString stringWithFormat:@"%@/%@",URL_MakeOrder,contractOrderNum];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:Url parameters:nil finished:^(NSDictionary * responseObject, NSError *error) {
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getUserPrizedraw:(NSString *)MobileNumber SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        NSString *url = [NSString stringWithFormat:@"%@?MobileNumber=%@",URL_UserPrizedraw,MobileNumber];
        [[YHAFNetWorkingRequset sharedRequset] GET:url parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getUserPrizedrawInfo:(NSString *)MobileNumber SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        NSString *url = [NSString stringWithFormat:@"%@?MobileNumber=%@",URL_UserPrizedrawInfo,MobileNumber];
        [[YHAFNetWorkingRequset sharedRequset] GET:url parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        if (data.count>0) {
                            successBLock(data[0]);
                        }else{
                            filaedBlock(@"您当前无红包记录");
                        }
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getUserBusinessCategorySuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    [[YHAFNetWorkingRequset sharedRequset] GET:URL_UserBusinessCategory parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
        if (!error) {
            if (CONFIRM_NOT_NULL(responseObject))
            {
                NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSArray *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                    successBLock(data);
                    
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}
- (void)getUserInsuranceCategorySuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_UserInsurance parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *InsuranceArr = [YHInsuranceModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(InsuranceArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
    
}

- (void)getUserInsuranceHTMLStringWithID:(NSString *)InsuranceID SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *URL = [NSString stringWithFormat:@"%@/%@",URL_userInsurance,InsuranceID];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]) {
        [[YHAFNetWorkingRequset sharedRequset] GET:URL parameters:nil finished:^(NSDictionary * responseObject, NSError *error){
            if (!error) {
                if (CONFIRM_NOT_NULL(responseObject))
                {
                    NSNumber *flag = [responseObject objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [responseObject objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[responseObject objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)putUserBusinessCategory:(NSString *)Category SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSDictionary *parameters = @{@"BusinessCategory":Category};
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_UserBusinessCategory parameters:parameters finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *info = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//开启任务
- (void)makeUserTeamTaskSuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MakeTask parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
//                       NSArray *array = [YHTeamMakeTaskModel ]
                        NSArray *arr  = [YHTeamMakeTaskModel mj_objectArrayWithKeyValuesArray:data];

                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//领取任务
- (void)getUserTeamTask:(NSDictionary *)params SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_GetTask parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *info = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//战队状态
- (void)getUserTeamStateSuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_GetTask parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *shoppingCartArr = [teamModel mj_objectArrayWithKeyValuesArray:data];
                        
                        successBLock(shoppingCartArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//member --贡献明细
- (void)getUserMemberTeamContributionSuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MakeMemberContributionsDetail parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSMutableDictionary *reseultDic = [NSMutableDictionary dictionary];
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        teamModel *model = [teamModel mj_objectWithKeyValues:data[@"group"]];
                        NSArray *Members = [YHUserContribution mj_objectArrayWithKeyValuesArray:data[@"buddy_list"]];
                        model.BuddyTotalAmount = data[@"BuddyMoney"];
                        model.UserOrderAmount= data[@"CommitMoney"];
                        [reseultDic setObject:model forKey:@"GroupInfo"];
                        [reseultDic setObject:Members forKey:@"Members"];
                        
                        successBLock(reseultDic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//member buddy小伙伴 --贡献明细
- (void)getUserMemberBuddyTeamContributionSuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MakeMemberBuddyContributionsDetail parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *Members = [YHUserContribution mj_objectArrayWithKeyValuesArray:data];
                        successBLock(Members);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getUserTeamContribution:(NSDictionary *)groupIDDic SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MakeContributionsGroup parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSMutableDictionary *reseultDic = [NSMutableDictionary dictionary];
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        teamModel *model = [teamModel mj_objectWithKeyValues:data];
                        NSArray *arr =data[@"members"];
                        NSArray *Members = [YHUserContribution mj_objectArrayWithKeyValuesArray:arr];
                        model.memberArr = Members;
                        [reseultDic setValue:model forKey:@"model"];
                        successBLock(reseultDic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//贡献明细 踢人
- (void)deleteUserTeamContribution:(NSDictionary *)groupIDDic SuccessBlock:(void(^)( NSString*successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *urlStr = [NSString stringWithFormat:@"%@?GroupId=%@&UserId=%@",URL_MakeContributionsDetail,groupIDDic[@"GroupId"],groupIDDic[@"UserId"]];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:urlStr parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *data = [result objectForKey:RESPONSE_RESULT_INFO];
               
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//贡献明细
- (void)getUserTeamLeaderContribution:(NSDictionary *)groupIDDic SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MakeContributionsGroup parameters:groupIDDic finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//Leader贡献 订单明细
- (void)getUserTeamLeaderDetailContribution:(BOOL)isTeam SuccessBlock:(void(^)(NSArray *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:isTeam==YES?URL_MakeTeamContributionsDetail: URL_MakeLeadersContributionsDetail parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *Members = [YHTeamDetailModel mj_objectArrayWithKeyValuesArray:data];

                        successBLock(Members);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)inviteTeamMember:(NSDictionary *)parameter SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserGroupInvite parameters:parameter finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)disbandTeam:(NSString *)GroupId SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *URL = [NSString stringWithFormat:@"%@?GroupId=%@",URL_UserGroup,GroupId];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:URL parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getUserAccountInfoSuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserAccount parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(data);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)joinTeam:(NSDictionary *)parameter SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_GroupInfo parameters:parameter finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//添加银行卡
- (void)userAddBankCard:(NSDictionary *)info SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserBankInfo parameters:info finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//获取银行卡
- (void)getUserBankCardSuccessBlock:(void(^)(NSArray *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserBankInfo parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                    
                        NSArray *arr  = [YHBankModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//银行卡删除
- (void)DeleteUserBankCard:(NSString *)CardId SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *URL = [NSString stringWithFormat:@"%@?CardId=%@",URL_UserBankInfo,CardId];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:URL parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//银行卡扫描
- (void)scanCardWithParameters:(NSDictionary *)Parameters SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] requestScanAPIWithParameters:Parameters finished:^(id result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:@"errorcode"];
                    if ([flag intValue] == 0){
                        NSArray *items = [result objectForKey:@"items"];
                        if (items&&items.count>0){
                            for (NSDictionary *dict in items) {
                                if ([[dict objectForKey:@"item"] isEqualToString:@"卡号"]){
                                    if ([dict objectForKey:@"itemstring"]){
                                        successBLock([dict objectForKey:@"itemstring"]);
                                        break;
                                    }
                                }
                            }
                        }

                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@",[result objectForKey:@"errormsg"]];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getDepositListSuccessBlock:(void(^)(NSArray *list))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserCashOut parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [YHDepositModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(arr);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)depositMoney:(NSDictionary *)parameters SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_UserCashOut parameters:parameters finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *resultinfo = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(resultinfo);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//消息列表
- (void)getMessageListSuccessBlock:(void(^)(NSArray *messageList))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_UserMarketInviteLog parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [YHInviteMessageModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//获取图片名
- (void)postImageWithURLpostParems: (NSArray *)postParems progress:(void(^)(NSProgress *progress))progressing SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] uploadImageToSevireURl:URL_UserUploadImage param:postParems progress:^(NSProgress *progress){
            progressing(progress);
        } finished:^(id result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *picUrl = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(picUrl[@"ImageUrl"]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
   
}

//上传合同
- (void)uploadContractImageWithURLpostSevice: (NSDictionary *)postParems SuccessBlock:(void(^)(NSArray *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] POST:URL_UserUploadOrderImage parameters:postParems finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        NSArray *arr  = [YHcontractImageModel mj_objectArrayWithKeyValuesArray:dicArr];
                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
    
}

//删除合同图片
- (void)deleteContractImageWithURLpostSevice: (NSArray *)postParems SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] DELETE:URL_UserUploadOrderImage parameters:postParems finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
    
}

//get合同图片
- (void)getContractImageWithURLpostSevice: (NSString *)postParems SuccessBlock:(void(^)(NSArray *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] GET:URL_UserUploadOrderImage parameters:@{@"ContractNo":postParems} finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr;
                        NSString *errorStr;
                        @try {
                            arr= [YHcontractImageModel mj_objectArrayWithKeyValuesArray:dic[@"ContractPhotos"]];
                            for (YHcontractImageModel *model in arr) {
                                model.ContractState = dic[@"ContractState"];
                            }
                        }
                        @catch (NSException *exception) {
                            errorStr =@"数据错误";
                        }
                        @finally {
                            if (errorStr.length>0) {
                                filaedBlock(errorStr);
                            }else
                            {
                            successBLock(arr);
                            }
                        }
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//消息删除
- (void)deleteInfomationList:(NSString *)RefNo SuccessBlock:(void(^)(NSString *successMessage ))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *URL = [NSString stringWithFormat:@"%@?RefNo=%@",URL_UserGroupInviteLog,RefNo];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:URL parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getBusinessService:(NSDictionary*)params SuccessBlock:(void(^)(NSArray *serversList))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
//    NSString * Category = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
//    NSString *str = [NSString stringWithFormat:@"%@?BusinessCategory=%@",URL_BusinessService,Category];
    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_BusinessService parameters:params finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                    NSArray *arr  = [YHCommpanyServersModel mj_objectArrayWithKeyValuesArray:dicArr];
                    successBLock(arr);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}
- (void)getCustomerServiceIDSuccessBlock:(void(^)(NSDictionary *serversIDDic))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_CustoCmerService parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getMainPageAddSuccessBlock:(void(^)(NSArray *mianImageAddArray))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
//    NSString * Category = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
//    NSString *str = [NSString stringWithFormat:@"%@?BusinessCategory=%@",URL_MainPageAd,Category];
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MainPageAd parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
}
- (void)getMainPageCategory:(NSDictionary *)catagoryDic SuccessBlock:(void(^)(NSArray *categoryDict))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    

    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_StoreMainPageCategory parameters:catagoryDic finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result)){
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSArray *dicArray = [result objectForKey:RESPONSE_RESULT_DATA];
                    successBLock(dicArray);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}

//发票管理- get
- (void)getUserInvoiceManageSuccessBlock:(void(^)(NSArray *invoicelist))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_InvoiceManage parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [YHInvoiceListModel mj_objectArrayWithKeyValuesArray:dicArr];
                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//发票管理- edit
-(void)editUserInvoiceManage:(NSDictionary *)params SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:PUT urlString:URL_InvoiceManage parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *dicstr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        successBLock(dicstr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}


//发票管理- post
-(void)postUserInvoiceManage:(NSDictionary *)params SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_InvoiceManage parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                        
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//发票管理- de le te
-(void)deleteUserInvoiceManage:(NSString *)refNo SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *url = [NSString  stringWithFormat:@"%@?RefNo=%@",URL_InvoiceManage,refNo];
//    NSString *url = CLOUD_URL(@"app/chat/order");
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                        
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//发票- yes or no
-(void)getIncludetaxInvoiceManage:(NSString *)BusinessCategory SuccessBlock:(void(^)(NSDictionary *dic))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *url = [NSString  stringWithFormat:@"%@?BusinessCategory=%@",URL_Isincludetax,BusinessCategory];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)contractIsSighedContractNo:(NSString *)ContractNo SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    NSString *url = [NSString stringWithFormat:@"%@?ContractNo=%@",URL_ContractIsSigh,ContractNo];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)downloadPDFWithUrl:(NSString *)downLoadUrl SuccessBlock:(void(^)(NSDictionary *successMessage))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_ContractIsSigh parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}


- (void)addVisitorsLoginSuccessBlock:(void(^)(NSArray *categoryDict))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MainVisitorCategory parameters:nil finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                    NSArray *arr = [YHMainCatagoryModel mj_objectArrayWithKeyValuesArray:dicArr];
                    if (arr.count>0) {
                        YHMainCatagoryModel *model = arr.firstObject;
                        model.isSelect = YES;
                        
                    }
                    successBLock(arr);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}

- (void)userScanQRCodeLogin:(NSString *)loginID SuccessBlock:(void(^)(NSString *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    NSDictionary *params = @{@"QRId":loginID.length>0?loginID:@""};
    [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_MainScanLogin parameters:params finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                    successBLock(info);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}

-(void)usercheckCertification:(NSString *)IsCheck SuccessBlock:(void(^)(NSString *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{

    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_MineUserCheck parameters:nil finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                    successBLock(info);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
         }];
 }


-(void)getUserInsuranceOrder:(NSString *)OrderNo SuccessBlock:(void(^)(NSDictionary *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *url = [NSString stringWithFormat:@"%@?ContractNo=%@",URL_userOrderInsurance,OrderNo];///@{@"ContractNo":OrderNo}
    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                    successBLock(data);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}

-(void)getTodayPriceUrlTokenSuccessBlock:(void(^)(NSDictionary *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:TodayPriceUrlToken parameters:nil finished:^(NSDictionary *result, NSError *error){
        if (!error){
            if (CONFIRM_NOT_NULL(result))
            {
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSDictionary *data = [result objectForKey:RESPONSE_RESULT_DATA];
                    successBLock(data);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}
-(void)appFeedbackWithParameters:(NSDictionary *)params SuccessBlock:(void(^)(NSDictionary *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_APPFeedBack parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getAppAdviceSuccessBlock:(void(^)(NSDictionary *dict))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_APPAdvice parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)userSearchProductWithParameter:(NSString *)param SuccessBlock:(void(^)(NSArray *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
//    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
//    NSString *catagory = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];


       NSString * url = [NSString stringWithFormat:@"%@?SearchContent=%@",URL_APPSearchProduct,[Tools URLEncodedString:param]];

    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
//                        NSArray *arr = [YhSearchModel mj_objectArrayWithKeyValuesArray:dicArr];
                      NSMutableArray*array =  [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YhSearchModel *model = [YhSearchModel mj_objectWithKeyValues:dic];
                            model.StoreName = model.Store[@"StoreName"];
                            model.StoreId = model.Store[@"StoreId"];
                            model.StorePhoto = model.Store[@"StorePhoto"];
                            model.StoreNum = model.Store[@"StoreNum"];
                            NSArray *imageArr = [Tools stringToJSON:model.GoodsSeriesPhotos];
                            if (imageArr.count>0) {
                                model.GoodsSeriesIcon = imageArr.firstObject;
                            }
                            [array addObject:model];
                        }
                        
                        successBLock(array);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)userCollectionProductWithParameter:(NSDictionary *)param SuccessBlock:(void(^)(NSString *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    
//    NSString *isStore =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
//    NSString *URL = [isStore isEqualToString:@"1"]?URL_StoreUserCollection:URL_UserCollection;
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_StoreUserCollection parameters:param finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *info = [result objectForKey:RESPONSE_RESULT_DATA];
                 
                        successBLock(info[@"RefNo"]);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)userCancelCollectionProductWithParameter:(NSString *)refNo SuccessBlock:(void(^)(NSString *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
//    URL_StoreUserCollection
//    NSString *isStore =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
//    NSString *URL = [isStore isEqualToString:@"1"]?URL_StoreUserCollection:URL_UserCollection;

    NSString *url = [NSString stringWithFormat:@"%@?RefNo=%@",URL_StoreUserCollection,refNo];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:DELETE urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *info = [result objectForKey:RESPONSE_RESULT_INFO];
                        
                        successBLock(info);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)userSearchKeyWordsSuccessBlock:(void(^)(NSArray *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
  
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    NSString *catagory = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    
    NSString *url;
//    if (phone.length<=0) {
//        url =  [NSString stringWithFormat:@"%@",URL_UserSearchKeywords];
//    }else{
        url = URL_UserSearchKeywords;
        
//    }
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
//                        NSString *str = dicArr[@"Keywords"];
//                        NSArray *result = [Tools stringToJSON:str];
                        
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
-(void)getUserCollectionProductSuccessBlock:(void(^)(NSArray *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
//    NSString *isStore =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];
//    NSString *URL = [isStore isEqualToString:@"1"]?URL_StoreUserCollection:URL_UserCollection;
    
//    NSString *url = [NSString stringWithFormat:@"%@?RefNo=%@",URL,refNo];

    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_StoreUserCollection parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *arr = [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YhSearchModel *model = [YhSearchModel mj_objectWithKeyValues:dic];
                            NSArray *imageArr = [Tools stringToJSON:model.GoodsSeriesPhotos];
                            if (imageArr.count>0) {
                                model.GoodsSeriesIcon = imageArr.firstObject;
                            }
                            [arr addObject:model];
                        }
                        
                        successBLock(arr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

-(void)getUserCollectionStoreRequestMethod:(YHMyRequestMethod)method params:(NSDictionary *)params SuccessBlock:(void(^)(NSArray *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
  
    NSString *url ;
    if (method == POST) {
        url = URL_StoreCollection;
    }else if(method == GET)
    {
        url = URL_StoreCollection;

    }else if(method == Delete)
    {
        url = [NSString stringWithFormat:@"%@?RefNo=%@",URL_StoreCollection,params[@"RefNo"]];

    }
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:method urlString:url parameters:params finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        NSArray *resultArr = [YHStoreModel mj_objectArrayWithKeyValuesArray:dicArr];
                        successBLock(resultArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//发现店铺
- (void)getFindStoreListSuccessBlock:(void(^)(NSArray *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    NSString *catagoryId = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    NSString *url = userId.length==0?[NSString stringWithFormat:@"%@?BusinessCategory=%@",URL_APPFindStore,catagoryId]:[NSString stringWithFormat:@"%@?UserId=%@&&BusinessCategory=%@",URL_APPFindStore,userId,catagoryId];
    [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error) {
        if (!error){
            if (CONFIRM_NOT_NULL(result)){
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                    NSArray *result = [YHStoreModel mj_objectArrayWithKeyValuesArray:dicArr];
                    successBLock(result);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
}

//店铺列表
- (void)getStoreListSuccessBlock:(void(^)(NSArray *Success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{

    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        NSString *catagoryID = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];

        NSString *url = userId.length==0? [NSString stringWithFormat:@"%@?BusinessCategory=%@",URL_APPStore,catagoryID]:[NSString stringWithFormat:@"%@?UserId=%@&BusinessCategory=%@",URL_APPStore,userId,catagoryID];
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:url parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *result = [YHStoreModel mj_objectArrayWithKeyValuesArray:dicArr];
                        successBLock(result);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
//店铺xia
- (void)getStoreDetailWith:(NSDictionary *)parramDic SuccessBlock:(void(^)(YHStoreDetailModel *model))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
//    NSString *url = userId.length<=0?[NSString stringWithFormat:@"%@?StoreId=%@",URL_APPStoreDetail,storeId]:[NSString stringWithFormat:@"%@?StoreId=%@&UserId=%@",URL_APPStoreDetail,storeId,userId];
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_APPStoreDetail parameters:parramDic finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        YHStoreDetailModel *model = [YHStoreDetailModel mj_objectWithKeyValues:dicArr];
                        NSMutableArray *seriesArr = [NSMutableArray array];

                        for (NSDictionary *dic in model.CategoryList) {
                            YHProductCatagoryModel*series = [YHProductCatagoryModel mj_objectWithKeyValues:dic];
                            NSMutableArray *goodsArr = [NSMutableArray array];
                            for (NSDictionary *dic in series.CategorySeries) {
                                YHProductGoodsModel*goods = [YHProductGoodsModel mj_objectWithKeyValues:dic];
                                NSArray *imageArr = [Tools stringToJSON:goods.GoodsSeriesPhotos];
                                if (imageArr.count>0) {
                                    goods.GoodsSeriesIcon = imageArr.firstObject;
                                }
                                [goodsArr addObject:goods];

                            }
                            series.GoodsArr = goodsArr ;
                            [seriesArr addObject:series];
                            
                            
                        }
                        model.SeriesArr = seriesArr;
                        successBLock(model);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//
- (void)getLogistMessageInfoWithParams:(NSDictionary *)dic SuccessBlock:(void(^)(NSArray *successArray))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
  
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_LogistContractShipping parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *array = [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YHLogistInfoModel *model = [YHLogistInfoModel mj_objectWithKeyValues:dic];
                            [array addObject:model];
                        }
//                        NSArray *modelArr = [YHLogistInfoModel mj_keyValuesArrayWithObjectArray:dicArr keys:dicArr.a];
//                        NSArray *modelArr = [YHLogistInfoModel mj_keyValuesArrayWithObjectArray:dicArr];
                        successBLock(array);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//
- (void)getRefreshTockeWith:(NSDictionary *)dic SuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:RefreshUserToken parameters:dic finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//
- (void)getStoreIDWithCatagoryIds:(NSDictionary *)dic SuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_GetStoreID parameters:dic finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dic);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

//
- (void)getCatagoryIDsSuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
//    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_GetCatagoryIDs parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
//    }else{
//        filaedBlock(@"网络异常，请检查网络");
//    }
}

- (void)getAppAgentApply:(NSDictionary *)dict SuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
  if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
    [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_AppAgentApply parameters:dict finished:^(NSDictionary *result, NSError *error) {
        if (!error){
            if (CONFIRM_NOT_NULL(result)){
                NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                if ([flag intValue] == 0){
                    NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                    successBLock(dicArr);
                }else{
                    NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                    filaedBlock(failStr);
                }
            }
        }else{
            filaedBlock([self dealWithError:error.code]);
        }
    }];
  }else{
    filaedBlock(@"网络异常，请检查网络");
  }
}

- (void)getAppVipExperienceSuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppVipExperice parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getAppVipUserSuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppUserVip parameters:nil finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getAppCheckVipCoupon:(NSDictionary *)couponDic SuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppCheckVipCoupon parameters:couponDic finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dicArr);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getAppSuperGroup:(NSDictionary *)CategoryBIdDic SuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppSuperGroup parameters:CategoryBIdDic finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        NSMutableArray *array = [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YHSuperGroupModel *model = [YHSuperGroupModel mj_objectWithKeyValues:dic];
                            [array addObject:model];
                        }
//                        NSArray *modelArr = [YHSuperGroupModel mj_keyValuesArrayWithObjectArray:dicArr];
                        successBLock(array);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getAppMYSuperGroup:(NSDictionary *)CategoryBIdDic SuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppMYSuperGroup parameters:CategoryBIdDic finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        NSMutableArray *array = [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YHSuperGroupModel *model = [YHSuperGroupModel mj_objectWithKeyValues:dic[@"SuperGroup"]];
                            YHSuperGroupInfoModel *model1 = [YHSuperGroupInfoModel mj_objectWithKeyValues:dic[@"SuperGroupDetail"]];
                            model.infoModel = model1;
                            model.OrderNo = dic[@"OrderNo"];

                            [array addObject:model];
                        }
                        //    NSArray *modelArr = [YHSuperGroupModel mj_keyValuesArrayWithObjectArray:dicArr];
                        successBLock(array);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getAppSuperGroupDetailWithSuperGroupIdS:(NSDictionary *)SuperGroupIdS SuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppSuperGroupDetai parameters:SuperGroupIdS finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *array = [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YHSuperGroupInfoModel *model = [YHSuperGroupInfoModel mj_objectWithKeyValues:dic];
                            [array addObject:model];
                        }
                        successBLock(array);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getAppMYSuperGroupDetailWithSuperGroupIdS:(NSDictionary *)SuperGroupIdS SuccessBlock:(void(^)(YHSuperGroupModel *model))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppMYSuperGroupDetai parameters:SuperGroupIdS finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dic = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *array = [NSMutableArray array];
//                        for (NSDictionary *dic in dicArr) {
                            YHSuperGroupModel *model = [YHSuperGroupModel mj_objectWithKeyValues:dic[@"SuperGroup"]];
                            YHSuperGroupInfoModel *model1 = [YHSuperGroupInfoModel mj_objectWithKeyValues:dic[@"SuperGroupDetail"]];
                            model.infoModel = model1;
                            
                            
                        
                        successBLock(model);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getAppMYLikeSuperGroupDetailWithSuperGroupIdS:(NSDictionary *)SuperGroupIdS SuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppMYLikeSuperGroupDetai parameters:SuperGroupIdS finished:^(NSDictionary *result, NSError *error) {
            if (!error){
                if (CONFIRM_NOT_NULL(result)){
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dicArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableArray *array = [NSMutableArray array];
                        for (NSDictionary *dic in dicArr) {
                            YHSuperGroupModel *model = [YHSuperGroupModel mj_objectWithKeyValues:dic];
                            [array addObject:model];
                        }
                        successBLock(array);
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getIncomeDetailListSuccessBlock:(void(^)(NSArray *list))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_InComeDetail parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dataArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSArray *arr  = [YHCityDelegateMOdel mj_objectArrayWithKeyValuesArray:dataArr];
                        successBLock(arr);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getSuperGroupPay:(NSDictionary *)params SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_AppSuperGroupPay parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *dataStr = [result objectForKey:RESPONSE_RESULT_DATA];
                        //                        NSArray *arr  = [YHDepositModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(dataStr);
                        
                    }else{
                        if (flag.integerValue==-1) {
                            NSString *failStr = [NSString stringWithFormat:@"%d%@",-1,[result objectForKey:RESPONSE_RESULT_INFO] ];
                            filaedBlock(failStr);
                        } else {
                            NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                            filaedBlock(failStr);
                        }
                       
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getSuperGroupWechatPay:(NSDictionary *)params SuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_AppSuperGroupWechatPay parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSDictionary *dataStr = [result objectForKey:RESPONSE_RESULT_DATA];
                        //                        NSArray *arr  = [YHDepositModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(dataStr);
                        
                    }else{
                        if (flag.integerValue==-1) {
                            NSString *failStr = [NSString stringWithFormat:@"%d%@",-1,[result objectForKey:RESPONSE_RESULT_INFO] ];
                            filaedBlock(failStr);
                        } else {
                            NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                            filaedBlock(failStr);
                        }
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)postSuperGroupPay:(NSDictionary *)params SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:POST urlString:URL_AppPostSuperGroupPay parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *dataStr = [result objectForKey:RESPONSE_RESULT_DATA];
                        //                        NSArray *arr  = [YHDepositModel mj_objectArrayWithKeyValuesArray:data];
                        successBLock(dataStr);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getAppAgentCashSuccessBlock:(void(^)(NSArray *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppGetAgentCash parameters:nil finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dataArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        successBLock(dataArr);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getAppUserAgentSuccessBlock:(void(^)(NSDictionary *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    NSString *userid  = Userdefault(LOGIN_USERID);
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppGetUserAgentCoupon parameters:@{@"UserId":userid.length>0?userid:@""} finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSArray *dataArr = [result objectForKey:RESPONSE_RESULT_DATA];
                        NSMutableDictionary *dictionnary = [NSMutableDictionary dictionary];
//                        if (dataArr.count==2) {
                            NSDictionary *dic = dataArr.firstObject;
                        NSString *str = @"";
                        NSString *recordStr = @"";

                            for (NSDictionary *dicttt in dataArr) {
                                NSString *str11 = dicttt[@"CategoryBName"];
                                if (dataArr.count==1) {
                                    str = [NSString stringWithFormat:@"%@",str11];

                                }else
                                {
                                    str = [NSString stringWithFormat:@"%@%@%@",recordStr,recordStr.length>0?@"/":@"",str11];

                                }
                                recordStr= str;
                            }
                         [dictionnary setObject:str forKey:@"CategoryBName"];
                            [dictionnary setObject:[Tools getHaveNum:([dic[@"CouponPrice"] doubleValue])] forKey:@"CouponPrice"];
                            [dictionnary setObject:dic[@"CouponCode"] forKey:@"CouponCode"];

//                        }else if(dataArr.count==1)
//                        {
//                            dictionnary =dataArr.firstObject;
//                        }
                       
                        successBLock(dictionnary);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}

- (void)getAppContractPDFWithparams:(NSDictionary *)params  SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppContractPDF parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *dicstr = [result objectForKey:RESPONSE_RESULT_DATA];
                      
                        
                        successBLock(dicstr);
                        
                    }else{
                        NSString *failStr = [NSString stringWithFormat:@"%@%@",[result objectForKey:RESPONSE_RESULT_INFO],Tips_RESULT_INFO];
                        filaedBlock(failStr);
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
- (void)getAppSuperGroupSubmitWithparams:(NSDictionary *)params  SuccessBlock:(void(^)(NSString *success))successBLock fialureBlock:(void(^)(NSString *errorMessages))filaedBlock{
    if ([[YHAFNetWorkingRequset sharedRequset] isNetworkAvailable]){
        [[YHAFNetWorkingRequset sharedRequset] request:GET urlString:URL_AppSuperGroupSubmit parameters:params finished:^(NSDictionary *result, NSError *error){
            if (!error){
                if (CONFIRM_NOT_NULL(result))
                {
                    NSNumber *flag = [result objectForKey:RESPONSE_RESULT_CODE];
                    if ([flag intValue] == 0){
                        NSString *dicstr = [result objectForKey:RESPONSE_RESULT_DATA];
                        
                        
                        successBLock(dicstr);
                        
                    }else{
                        if (flag.integerValue==-1) {
                            NSString *failStr = [NSString stringWithFormat:@"%@%@",@"-1",[result objectForKey:RESPONSE_RESULT_INFO]];
                            filaedBlock(failStr);
                        } else {
                            NSString *failStr = [NSString stringWithFormat:@"%@",[result objectForKey:RESPONSE_RESULT_INFO]];
                            filaedBlock(failStr);
                        }
                  
                    }
                }
            }else{
                filaedBlock([self dealWithError:error.code]);
            }
        }];
    }else{
        filaedBlock(@"网络异常，请检查网络");
    }
}
@end

