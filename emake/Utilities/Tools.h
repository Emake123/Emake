//
//  Tools.h
//  emake
//
//  Created by 谷伟 on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

+(NSMutableAttributedString*)getFrontStr:(NSString *)TimeFrontStr day:(NSString *)day time:(NSString *)time isShowSecond:(BOOL)isShowSecond;

+(void)SaveLocalVipstateWithCatagory:(NSArray*)IdentityCategorys;

+(void)jumpIntoOnlyVC:(UINavigationController *)currentNav destnationViewController:(UIViewController *)destnationVC;

+ (NSString *)URLEncodedString:(NSString *)str;

//md5 加密
+ (NSString *) md5:(NSString *) str;


//json字符串转数组
+ (NSArray *)stringToJSON:(NSString *)jsonStr;

//判断字符串是否为纯数字 为yes则都是数字
+(BOOL)isNum:(NSString *)checkedNumString;

//本地沙盒音频路径
+ (NSString *)getVoicePath: (NSString *)fileName;

//判断相机图片
+(BOOL)isTakePhoto;

//
+(BOOL)isTakePhoto:(UIViewController *)vc;

//图片裁剪
+(UIImage *)image:(UIImage *)originalImage forTargetSize:(CGSize)targetSize;

//手机号判断
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//身份证判断
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString;


//获取上传图片文件名
+ (NSString *)getUploadFileName;

//获取当前时间
+ (NSString*)getCurrentTimes;

//返回时间戳
+ (NSString *)getCurrentTimeInterval;

//时间戳转字符串
+(NSString *)stringFromTimestamp:(NSString *)timestamp;

//头像地址
+ (NSString *)getHeadImageURL;

//图片裁剪  返回还是原图大小,除图片以外区域清空
+ (UIImage *)clipWithImageRect:(CGRect)imageRect clipRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

//图片裁剪   返回裁剪区域大小图片
+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

//图片上传地址
+ (NSString *)getPath: (NSString *)fileName;

+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
//计算文件字节大小
+ (NSString *)fileSizeWithInterge:(NSInteger)size;
//文件字节大小(单位：M)
+ (double)fileSize:(NSInteger)size;
//计算文字长度
+(CGSize)calcTextSize:(NSString *)text Size:(CGFloat) size;
//四舍五入
+(NSString * )getHaveNum:(double )num;

//把double类型的转换为字符串（去小数点多余的零）num(double数据) ischange（是否带单位：万）
+(NSString *)getNsstringFromDouble:(double)num isShowUNIT:(BOOL)IsChange;

//（防止）double精度丢失
+ (NSString *)stringWithDecimalNumber:(double)num ;

//获取图片名
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

//判断两个color是否相同
+(BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor;


+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

//清理网页缓存
+ (void)cleanCacheAndCookie;

//当前视图ViewController
+ (UIViewController *)currentViewController;

//当前视图NavigationController
+ (UINavigationController *)currentNavigationController;

//清空聊天数据
+ (void)clearChatFMDB;
@end