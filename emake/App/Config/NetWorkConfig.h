//
//  NetWorkConfig.h
//  emake
//
//  Created by 袁方 on 2017/7/24.
//  Copyright © 2017年 emake. All rights reserved.
//
#ifndef NetWorkConfig_h
#define NetWorkConfig_h
//请求地址

#define CLOUD_URL(res)  [NSString stringWithFormat:@"http://mallapi.emake.cn/%@",res]//正式服务器mallapi.emake.cn
//#define CLOUD_URL(res)  [NSString stringWithFormat:@"http://mallapitest.emake.cn/%@",res]//测试服务器

//#define CLOUD_URL(res)  [NSString stringWithFormat:@"https://api.emake.cn/%@",res]// 旧 正式服务器mallapi.emake.cn
//#define CLOUD_URL(res)  [NSString stringWithFormat:@"http://git.emake.cn:3100/%@",res]//旧 测试服务器
//#define CLOUDTest_URL(res)  [NSString stringWithFormat:@"http://192.168.0.149:3100/%@",res]//测试服务器
//#define CLOUD_URL(res)  [NSString stringWithFormat:@"http://192.168.0.149:3100/%@",res]//测试服务器

#define CLOUD_ConmmonTestURL(res)  [NSString stringWithFormat:@"http://webtest.emake.cn/%@",res]//测试服务器
#define CLOUD_ConmmonURL(res)  [NSString stringWithFormat:@"https://web.emake.cn/%@",res]//正试服务器http://mall.emake.cn


//服务器统一返回字段
#define RESPONSE_RESULT_CODE                    @"ResultCode"
#define RESPONSE_RESULT_INFO                    @"ResultInfo"
#define RESPONSE_RESULT_DATA                    @"Data"

//错误信息提示
#define Tips_RESULT_INFO                    @""

//请求头字段
#define Emake_App_Version            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define HTTP_Header_Patameter        [NSString stringWithFormat:@"emake.ios.%@",Emake_App_Version]

//根据CLOUD_URL判断是正式服还是测试服
#define URLWithTestAndInform(test,inform)   [CLOUD_URL(@"")  containsString:@"mallapi.emake.cn"]?inform:test

/*------------------------------------------web链接---------------------------------------*/

//易智造 APPID
#define EmakeAppleID             @"1260429389"

//易智造 APPID
#define EmakeWexinPayID             @"wx1d7605e5f166ac0a"
//wx1d7605e5f166ac0a

//MQTT
//#define MQTT_IP                     @"192.168.0.106"

#define MQTT_IP                   URLWithTestAndInform(@"mallapitest.emake.cn",@"mallapi.emake.cn")  //git.emake.cn
#define MQTT_PORT                   1883



//分享app 下载地址
#define ShareDownloURL                      @"http://www.emake.cn/download/"

//分享产品详情 test（测试） and inform（正式）
#define ShareProductDetaiURL                     URLWithTestAndInform(@"http://webtest.emake.cn/ngoodsdetails", CLOUD_ConmmonURL(@"ngoodsdetails"))

//分享店铺详情 test（测试） and inform（正式）
#define ShareStoreDetaiURL                     URLWithTestAndInform(@"http://webtest.emake.cn/shopdetail",CLOUD_ConmmonURL(@"shopdetail"))



//使用许可、用户隐私、服务条款
#define RegisterProtcolURL  URLWithTestAndInform(CLOUD_ConmmonTestURL(@"servicepact/"),CLOUD_ConmmonURL(@"servicepact/"))
//@"http://mall.emake.cn/servicepact/" //@"https://price.emake.cn/servicepact/"

#define InsurancesInstructionURL           URLWithTestAndInform(CLOUD_ConmmonTestURL(@"user/insurance/content/"),CLOUD_ConmmonURL(@"user/insurance/content/"))
//@"http://mall.emake.cn/user/insurance/content/" // @"https://price.emake.cn/user/insurance/content/"

//订购须知
#define UserOrderinginfoURL     URLWithTestAndInform(CLOUD_ConmmonTestURL(@"orderinfo"), CLOUD_ConmmonURL(@"orderinfo"))
//订购流程
#define UserOrderingproURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"orderprocedure"), CLOUD_ConmmonURL(@"orderprocedure"))
//使用说明
#define UserInstructionURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"usinghelp/user"),CLOUD_ConmmonURL(@"usinghelp/user"))





//超级团使用说明
#define UserSuperGroupInstructionURL          URLWithTestAndInform(CLOUD_ConmmonTestURL(@"supergroup"), CLOUD_ConmmonURL(@"supergroup"))

//城市代理商规则
#define UserCityAgentRulerURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"cityagentrule"), CLOUD_ConmmonURL(@"cityagentrule"))
//会员说明
#define UserVipInstructionURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"vipinfo"), CLOUD_ConmmonURL(@"vipinfo"))
//提现规则
#define UserWithDrawRulerURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"withdrawrule"),CLOUD_ConmmonURL(@"withdrawrule"))
//城市代理商领取优惠码（代理商分享页面） +代理商userId
#define CityAgentCouponShareURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"cityagent/"), CLOUD_ConmmonURL(@"cityagent/"))
//超级团（大团 分享 :supergroupId/:userId
#define UserSuperGroupIDShareURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"supergroupshare/"), CLOUD_ConmmonURL(@"supergroupshare/"))
//我的超级团（小团）分享 :supergroupdetailId/:userId
#define UserSuperGroupInfoSahreURL             URLWithTestAndInform(CLOUD_ConmmonTestURL(@"mygroupshare/"), CLOUD_ConmmonURL(@"mygroupshare/"))

//当日售价 要拼接的地址 test（测试） and inform（正式）
#define TodayPriceUrl                   URLWithTestAndInform(CLOUD_ConmmonTestURL(@"pricelist"),@"https://web.emake.cn/pricelist")
//http://web.emake.cn/pricelist CLOUD_ConmmonURL(@"pricelist")

/*-------------------------------web链接 暂时不用的---------------------------------------*/

//合同展示URL test（测试） and inform（正式）
#define ContractDisplayURL                     URLWithTestAndInform( @"http://git.emake.cn:5000/contract", @"http://www.emake.cn:5100/contract")

//合同pdf文件 test（测试） and inform（正式）
#define UserContractPDFURL                     URLWithTestAndInform(@"http://git.emake.cn:3000/static/contractpdf", @"http://mall.emake.cn/static/contractpdf")
//资讯发现
#define DiscoverUrl                            @"http://price.emake.cn/infor"

//生成合同URL
#define CreatContractURL                         @"http://api.emake.cn"

//团队提成规则 test（测试） and inform（正式）
#define TeamActivtyInstructionURL                     URLWithTestAndInform( @"http://pricedev.emake.cn/redpacket", @"http://price.emake.cn/redpacket")

/*--------------------------------------------接口---------------------------------------*/
//修改手机号验证码
#define URL_AppVersion   CLOUD_URL(@"app/version")


//获取当日售价的token
#define RefreshUserToken                     CLOUD_URL(@"access_token")

//获取当日售价的token
#define TodayPriceUrlToken                     CLOUD_URL(@"token")

//用户名片扫描，APP端图片大小不得超过1.5MB,最好控制在1MB以内
#define URL_UserCard CLOUD_URL(@"user/card")

//用户性别
#define URL_UserInfo CLOUD_URL(@"user/info")

//获取用户资料
#define URL_User     CLOUD_URL(@"user")

//修改密码
#define URL_UserPassword  CLOUD_URL(@"user/password")

//朋友圈接口
#define URL_UserFriend         CLOUD_URL(@"user/friend")

//baner宣传
#define URL_UserAbout          CLOUD_URL(@"about")

//修改手机号验证码
//#define URL_UserVerificationcode   CLOUD_URL(@"get/verificationcode")

//修改手机号
#define URL_UserMobileNumber CLOUD_URL(@"user/mobilenumber")

//请求验证码URL
#define URL_VerificationCode   CLOUD_URL(@"get/verificationcode")//get/verificationcode

//用户注册
#define URL_UserRegist          CLOUD_URL(@"app/user/regist")

//用户设置密码
#define URL_UserResetPassword CLOUD_URL(@"user/password")

//用户忘记密码
#define URL_UserForgetPassword CLOUD_URL(@"user/password/forget")

//用户登录
#define URL_UserLoginWithVerificationCode CLOUD_URL(@"user/login")

//购物车
#define URL_MainPageImage CLOUD_URL(@"home/banner")

//购物车
#define URL_UserFindingShoppingCart              CLOUD_URL(@"app/user/shopping")

//购物车删除
#define URL_UserDeleteShoppingCart CLOUD_URL(@"app/user/shopping")

//购物车数量改变
#define URL_UserShoppingCartNumberChange CLOUD_URL(@"user/shopping")

//订单
#define URL_UserOrderManage CLOUD_URL(@"app/user/order")

//产品参数
#define URL_GoodsParams CLOUD_URL(@"goods/params")

//产品系列
#define URL_Goodsseries CLOUD_URL(@"shopping/good/seriescode")

//产品系列code
#define URL_GoodsseriesCode CLOUD_URL(@"goodsseries/SCBH15")

//新增产品
#define URL_NewProduct CLOUD_URL(@"goodsseries")

//获取<产品系列CODE>下的所有可选属性名字，，，，下拉列表
#define URL_PropertyProductList CLOUD_URL(@"app/make/series/goodsall")

//增值服务
#define URL_PropertyAddSevice                CLOUD_URL(@"app/make/addservice")
//#define URL_StorePropertyAddSevice           CLOUD_URL(@"app/make/addservice")


//商品详情
#define URL_ShoppingDetail                CLOUD_URL(@"app/make/series/detail")

//添加购物车
#define URL_AddShopping              CLOUD_URL(@"app/user/shopping")

//获取产品价格
#define URL_ShoppingPrice            CLOUD_URL(@"shopping/price")

//生成订单
#define URL_ContractOder            CLOUD_URL(@"app/user/order")

//合同是否签订
#define URL_ContractIsSigh            CLOUD_URL(@"web/make/contract/chat")

//获取订单数量
#define URL_OrderNumber            CLOUD_URL(@"user/order/count")

//用户（物流）地址接口
#define URL_UserAdress            CLOUD_URL(@"user/address")

//订单—物流—详情
#define URL_LogisticsInfo            CLOUD_URL(@"app/make/shipping/detail")

//开票类型 
#define URL_InvoiceType            CLOUD_URL(@"user/params")

//申请开票、开票记录
#define URL_InvoiceApply            CLOUD_URL(@"user/invoice")

//剩余开票金额
#define URL_InvoiceRemainAmount            CLOUD_URL(@"user/remaininvoiceamount")

//品牌
#define URL_Brand            CLOUD_URL(@"app/user/brand")
//#define URL_StoreBrand            CLOUD_URL(@"app/brand")

//保险
#define URL_UserInsurance           CLOUD_URL(@"user/insurance")

//首页获取购物车商品名称+数量+容量
#define URL_ShoppingFormat            CLOUD_URL(@"user/shopping/format")

//用户审核
#define URL_InfoUpdate           CLOUD_URL(@"user/info/update")

//用户审核
#define URL_UserBusinessCategory           CLOUD_URL(@"user/business/category")

//首页获取上周订单
#define URL_LastWeekOrder           CLOUD_URL(@"console/setlastweekorderstatistics?CallID=2")/// app/lastweek/order

//生成订单
#define URL_MakeOrder           CLOUD_URL(@"web/contract/sign")

//首页-分类列表
#define URL_ShoppingGoodCategories           CLOUD_URL(@"app/make/category/series")
#define URL_StoreShoppingGoodCategories           CLOUD_URL(@"app/store/category/series")

//首页-抽奖
#define URL_UserPrizedraw           CLOUD_URL(@"user/prizedraw")

//首页-抽奖明细
#define URL_UserPrizedrawInfo           CLOUD_URL(@"user/prizedraw/info")

//(确认订单)团队贡献
#define URL_MakeContributions           CLOUD_URL(@"user/offer/group")

//开启任务
#define URL_MakeTask           CLOUD_URL(@"task")

//团队贡献
#define URL_GetTask           CLOUD_URL(@"user/group")

//团长贡献明细
#define URL_MakeContributionsDetail           CLOUD_URL(@"group/info")

//我的团队 经销
#define URL_MakeContributionsGroup           CLOUD_URL(@"user/distributor/team")

//团圆贡献明细
#define URL_MakeMemberContributionsDetail           CLOUD_URL(@"user/group/info")

//团长 person贡献 订单明细
#define URL_MakeLeadersContributionsDetail           CLOUD_URL(@"user/market/contract")
//团长 team贡献 订单明细
#define URL_MakeTeamContributionsDetail           CLOUD_URL(@"user/team/market/contract")
//团员 buddy贡献 订单明细
#define URL_MakeMemberBuddyContributionsDetail           CLOUD_URL(@"user/buddy")

//团长邀请团员
#define URL_UserGroupInvite           CLOUD_URL(@"user/market/invite")

//团长解散团队
#define URL_UserGroup          CLOUD_URL(@"user/group")

//账户信息
#define URL_UserAccount          CLOUD_URL(@"app/agent/account")// user/account

//提现明细
#define URL_UserCashOut         CLOUD_URL(@"user/cash/out")
//收入明细
#define URL_InComeDetail         CLOUD_URL(@"app/agent/cash/in")

//加入团队
#define URL_GroupInfo         CLOUD_URL(@"user/market/invite")

//账户银行卡信息（post，get,delet）
#define URL_UserBankInfo         CLOUD_URL(@"user/bank/card")

//银行卡信息扫描
#define URL_UserBankScanAPI     @"https://api.youtu.qq.com/youtu/ocrapi/creditcardocr"

//邀请记录
#define URL_UserGroupInviteLog    CLOUD_URL(@"user/group/invite/log")

//（图片）上传本地服务器
#define URL_UserUploadImage         CLOUD_URL(@"image/file")

//（身份证图片）上传本地服务器
#define URL_UserUploadIDImage         CLOUD_URL(@"image")

//上传图片（get，post,delete）
#define URL_UserUploadOrderImage         CLOUD_URL(@"user/contract/photo")

//消息记录删除（get，post,delete）
#define URL_UserMarketInviteLog         CLOUD_URL(@"user/market/invite/log")

//企业服务列表
#define URL_BusinessService        CLOUD_URL(@"app/business/service")

//获取分配的客服工号
#define URL_CustoCmerService        CLOUD_URL(@"customer/service")

//首页banner
#define URL_MainPageAd       CLOUD_URL(@"mainpagead")

//首页分类
//#define URL_MainPageCategory      indURLWithIndustryAndStore(CLOUD_URL(@"app/mainpage/category"),CLOUDTest_URL(@"app/mainpage/category"))
#define URL_StoreMainPageCategory       CLOUD_URL(@"app/category_c")
#define URL_MainPageCategory       CLOUD_URL(@"app/mainpage/category")

//开票列表
#define URL_InvoiceManage       CLOUD_URL(@"user/invoice/manage")

//访客
#define URL_MainVisitorCategory       CLOUD_URL(@"app/business/category")


//scan login
#define URL_MainScanLogin       CLOUD_URL(@"qr/user/login")

//“IsCheck”: '1'  已查看， ‘0’ 未查看  字符串
#define URL_MineUserCheck       CLOUD_URL(@"user/check")

//shi fou开票
#define URL_Isincludetax       CLOUD_URL(@"user/isincludetax")

//shi fou开票
#define URL_userOrderInsurance       CLOUD_URL(@"web/insurance/photo")

//shi fou开票
#define URL_userInsurance       CLOUD_URL(@"user/insurance/content")

//意见反馈
#define URL_APPFeedBack       CLOUD_URL(@"app/feedback")

//搜索系列号
#define URL_APPSearchProduct       CLOUD_URL(@"app/make/search/series")

//咨询接口
#define URL_APPAdvice       CLOUD_URL(@"app/advice")

//收藏商品系列接口
#define URL_UserCollection            CLOUD_URL(@"app/make/collection")
#define URL_StoreUserCollection       CLOUD_URL(@"app/collect/make")

//收藏店铺系列接口
#define URL_StoreCollection       CLOUD_URL(@"app/collect/store")

//搜所关键产品
#define URL_UserSearchKeywords       CLOUD_URL(@"app/search/keywords")

//发现店铺
#define URL_APPFindStore         CLOUD_URL(@"app/find/store")

//所有店铺
#define URL_APPStore              CLOUD_URL(@"app/store")

//店铺详情页
#define URL_APPStoreDetail        CLOUD_URL(@"app/factory/detail")

//店铺详情页
#define URL_LogistContractShipping        CLOUD_URL(@"app/make/contract/shipping")

//storeID
#define URL_GetStoreID        CLOUD_URL(@"app/storeid")
//storeID
#define URL_GetCatagoryIDs        CLOUD_URL(@"app/category_b")

//storeID
#define URL_GetCatagoryIDs        CLOUD_URL(@"app/category_b")

//城市代理商申请
#define URL_AppAgentApply        CLOUD_URL(@"app/agent/apply")
//领取体验会员接口
#define URL_AppVipExperice        CLOUD_URL(@"app/vip/experience")

//我的会员权益
#define URL_AppUserVip       CLOUD_URL(@"app/user/vip")

//验证优惠券码是否有效
#define URL_AppCheckVipCoupon       CLOUD_URL(@"app/user/vip/coupon")

//超级团列表
#define URL_AppSuperGroup       CLOUD_URL(@"app/super/group")

//超级团列表
#define URL_AppMYSuperGroup       CLOUD_URL(@"app/my/super/group")

//超级团详情
#define URL_AppSuperGroupDetai       CLOUD_URL(@"app/super/group/detail")

//超级团详情
#define URL_AppMYSuperGroupDetai       CLOUD_URL(@"app/super/group/detail/pay")


//猜你喜欢
#define URL_AppMYLikeSuperGroupDetai       CLOUD_URL(@"app/super/group/like")

//支付宝
#define URL_AppSuperGroupPay      CLOUD_URL(@"app/alipay/order")

//微信支付
#define URL_AppSuperGroupWechatPay      CLOUD_URL(@"app/wechat/order")

//支付宝
#define URL_AppPostSuperGroupPay      CLOUD_URL(@"app/super/group/pay")


//代理商获取收入
#define URL_AppGetAgentCash      CLOUD_URL(@"app/agent/cash/in/all")

//代理商获取收入
#define URL_AppGetUserAgentCoupon     CLOUD_URL(@"app/user/agent")


//查看合同PDF
#define URL_AppContractPDF     CLOUD_URL(@"app/contractpdf")
//提交超级团订单
#define URL_AppSuperGroupSubmit     CLOUD_URL(@"app/super/group/submit")
#endif /* NetWorkConfig_h */
