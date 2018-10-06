//
//  Tools.m
//  emake
//
//  Created by 谷伟 on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "Tools.h"
#import "YHTabBarViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TZImageManager.h"
@interface Tools ()<UIAlertViewDelegate>

@end
 
@implementation Tools

+(NSMutableAttributedString*)getFrontStr:(NSString *)TimeFrontStr day:(NSString *)day time:(NSString *)time isShowSecond:(BOOL)isShowSecond
{
    if (time.length>0) {
        NSArray *timeArr= [time componentsSeparatedByString:@":"];
        NSString *timeH = timeArr[0];
        NSString *timeM = timeArr[1];
        NSString *timeS = timeArr[2];
        
        NSString *timeStr =isShowSecond? [NSString stringWithFormat:@"%@%02ld天%02ld时%02ld分%02ld秒",TimeFrontStr,(long)day.integerValue,timeH.integerValue,timeM.integerValue,timeS.integerValue]:[NSString stringWithFormat:@"%@%02ld天%02ld时%02ld分",TimeFrontStr,(long)day.integerValue,timeH.integerValue,timeM.integerValue];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:timeStr];
        [att addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"F8695D")
                    range:NSMakeRange(TimeFrontStr.length, 2)];
        [att addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"F8695D")
                    range:NSMakeRange(TimeFrontStr.length+3, 2)];
        [att addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"F8695D")
                    range:NSMakeRange(TimeFrontStr.length+6, 2)];
        if (isShowSecond==YES) {
            [att addAttribute:NSForegroundColorAttributeName
                        value:ColorWithHexString(@"F8695D")
                        range:NSMakeRange(TimeFrontStr.length+9, 2)];
        }
      
        
        return att;
    }else
    {
        return nil;
    }
    
}
+(void)SaveLocalVipstateWithCatagory:(NSArray*)IdentityCategorys
{
   
    NSInteger CatagoryVip =0;
    NSInteger RecordCatagoryVip =0;
    
    for (int i=0;i<IdentityCategorys.count;i++) {
        NSDictionary *dic = IdentityCategorys[i];
        NSString *CategoryBName = dic[@"CategoryBName"];
        if([CategoryBName containsString:@"输配电"])
        {
            RecordCatagoryVip++;
            CatagoryVip = 2;
        }else if([CategoryBName containsString:@"食品"])
        {
            RecordCatagoryVip++;
            CatagoryVip = 1;
        }
        
    }
    if (RecordCatagoryVip==2) {
        CatagoryVip = 3;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@(CatagoryVip) forKey:CatagoryVipState];
    

}
+(void)jumpIntoOnlyVC:(UINavigationController *)currentNav destnationViewController:(UIViewController *)destnationVC
{
    NSInteger getVCindex = currentNav.viewControllers.count>1?currentNav.viewControllers.count:2;
    UIViewController *vc = currentNav.viewControllers[getVCindex-2];
    if ([vc isKindOfClass:[destnationVC class]]) {
        [currentNav popViewControllerAnimated:YES];
    }else{

        [currentNav pushViewController:destnationVC animated:YES];
    }
}

+ (NSString *)URLEncodedString:(NSString *)str
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = str;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}


+ (NSString *) md5:(NSString *) str
{
    NSString *saltStr = [NSString stringWithFormat:@"%@:emake",str];
    const char *cStr = [saltStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


//json转数组
+ (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

//判断字符串是否为纯数字
+(BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0 ) {
        if (checkedNumString.length == 1 && [checkedNumString isEqualToString:@"."]) {
            return YES;
        }
        return NO;
    }
    return YES;
}



+ (NSString *)getVoicePath: (NSString *)fileName {
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), fileName];
    return path;
}
///判断相机的权限
+(BOOL)isTakePhoto:(UIViewController *)vc{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
         UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault
handler:^(UIAlertAction * action) {
                                                                  //响应事件
                        NSLog(@"action = %@", action);
                                                                
                   NSURL * url = [NSURL  URLWithString: UIApplicationOpenSettingsURLString];
                                                                  
            if ( [[UIApplication sharedApplication] canOpenURL: url] ) {
                                                                      
                NSURL*url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                [[UIApplication sharedApplication] openURL:url];
                
                                                }
    }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", action);
                                                                 [vc dismissViewControllerAnimated:YES completion:nil];
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [vc presentViewController:alert animated:YES completion:nil];
        return NO;
    }else{
     
        return YES;
    }
}
//判断相机的权限
+(BOOL)isTakePhoto{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
             
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""c" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        return NO;
        
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self isTakePhoto];
                    });
                }
            }];
        } else {
            [self isTakePhoto];
        }
        return NO;
        
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
           
        }
        return NO;
        
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self isTakePhoto];
        }];
        return NO;
    } else {
        //        [self pushImagePickerController];
        return YES;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@" buttonIndex%d",buttonIndex);
    NSLog(@" buttonIndex%d",buttonIndex);

}
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    
    NSData* imageData;
    
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(tempImage)) {
        //返回为png图像。
        imageData = UIImagePNGRepresentation(tempImage);
    }else {
        //返回为JPEG图像。
        imageData = UIImageJPEGRepresentation(tempImage, 1.0);
    }
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    NSArray *nameAry=[fullPathToFile componentsSeparatedByString:@"/"];
    NSLog(@"===fullPathToFile===%@",fullPathToFile);
    NSLog(@"===FileName===%@",[nameAry objectAtIndex:[nameAry count]-1]);
    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}

+ (NSString *)stringWithDecimalNumber:(double)num {
    NSString *numString = [NSString stringWithFormat:@"%lf", num];
    NSDecimalNumber *decimal =    [NSDecimalNumber decimalNumberWithString:numString];
    return [decimal stringValue];
}
+(NSString *)getNsstringFromDouble:(double)num isShowUNIT:(BOOL)IsChange
{
    NSString *str = [NSString stringWithFormat:@"%lf",num];
    if (IsChange == YES) {
        
        NSString * testNumber = str;
        NSString *changeStr =[NSString stringWithFormat:@"%.2lf",num/10000];
        NSString *currentMoney = num>=10000?[NSString stringWithFormat:@"%@万",[Tools getHaveNum:changeStr.doubleValue]]:[NSString stringWithFormat:@"%@",[Tools getHaveNum:testNumber.doubleValue]];
        return currentMoney;

    }else
    {
        NSString * testNumber = str;
        NSString *currentMoney = [NSString stringWithFormat:@"%@",[Tools getHaveNum:testNumber.doubleValue]];
        return currentMoney;
    }
    
    
}
+(NSString *)getHaveNum:(double )num
{
    double num1 = num*100;
    NSString *str = [NSString stringWithFormat:@"%.2f",round(num1)/100];
    NSString *str1 = [NSString stringWithFormat:@"%@",[Tools stringWithDecimalNumber:str.doubleValue]];
    return str1;
}

+(UIImage *)image:(UIImage *)originalImage forTargetSize:(CGSize)targetSize{
    
    
    UIImage *sourceImage = originalImage;
    
    CGSize imageSize = sourceImage.size;//图片的size
    
    CGFloat imageWidth = imageSize.width;//图片宽度
    
    CGFloat imageHeight = imageSize.height;//图片高度
    
    NSInteger judge;//声明一个判断属性
    
    if( (imageHeight - imageWidth)>0) {
        
        CGFloat tempW = targetSize.width;
        
        CGFloat tempH = targetSize.height;
        
        targetSize.height= tempW;
        
        targetSize.width= tempH;
    }
    CGFloat targetWidth = targetSize.width;//获取最终的目标宽度尺寸
    
    CGFloat targetHeight = targetSize.height;//获取最终的目标高度尺寸
    
    CGFloat scaleFactor ;//先声明拉伸的系数
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint =CGPointMake(0.0,0.0);//这个是图片剪切的起点位置
    
    if( imageHeight < targetHeight && imageWidth < targetWidth) {
        
        return originalImage;
        
    }
    if ( CGSizeEqualToSize(imageSize, targetSize ) ==NO )
        
    {
        CGFloat widthFactor = targetWidth / imageWidth;
        
        CGFloat heightFactor = targetHeight / imageHeight;
        
        if(widthFactor <1&& heightFactor<1){
            
             if(widthFactor > heightFactor){
                 
                judge =1;//右部分空白
                 
                scaleFactor = heightFactor;
                 
             }else{
                 judge =2;//下部分空白
                 
                 scaleFactor = widthFactor;
             }
        }else if(widthFactor >1&& heightFactor <1){
            
            judge =3;//下部分空白
            
            scaleFactor = imageWidth / targetWidth;// 计算高度缩小系数
            
        }else if((heightFactor >1) && (widthFactor <1)){
            
            judge =4;//下边空白
            
            scaleFactor = imageHeight / targetWidth;
            
        }else{
            
        }
        scaledWidth= imageWidth * scaleFactor;
        
        scaledHeight = imageHeight * scaleFactor;
    }
    if(judge ==1){
        
        targetWidth = scaledWidth;
        
    }else if(judge ==2){
        
        targetHeight = scaledHeight;
        
    }else if(judge ==3){
        
        targetWidth  = scaledWidth;
    }else{
        
    }
    UIGraphicsBeginImageContext(targetSize);//开始剪切
    
    CGRect thumbnailRect =CGRectZero;//剪切起点(0,0)
    
    thumbnailRect.origin= thumbnailPoint;
    
    thumbnailRect.size.width= scaledWidth;
    
    thumbnailRect.size.height= scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    UIImage*newImage =UIGraphicsGetImageFromCurrentImageContext();//截图拿到图片
    
    return newImage;

}

+ (BOOL)isMobileNumber:(NSString *)mobileNum{
    
    //    电信号段:133,149,153,173,180,181,189,177,1700
    
    //    联通号段:130,131,132,155,156,185,186,145,171,175,176,1709
    
    //    移动号段:134,135,136,137,138,139,147,150,151,152,157,158,159,172,178,182,183,184,187,188,1705
    
    //    虚拟运营商:170
    
//    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|7[1-35-8]|8[0-9]|70)\\d{8}$";
    NSString *MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
    
}

+ (BOOL)judgeIdentityStringValid:(NSString *)identityString{
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
+ (NSString *)getUploadFileName{
    
    NSString *UUID = [[NSUUID UUID] UUIDString];
    
    return  UUID;
}

+ (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
        
    return currentTimeString;
    
}
+ (NSString *)getCurrentTimeInterval{
    
    NSDate *senddate = [NSDate date];
    NSString *date = [NSString stringWithFormat:@"%ld",(long)[senddate timeIntervalSince1970]];
    return date;
}

+(NSString *)stringFromTimestamp:(NSString *)timestamp{
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}


+ (NSString *)getHeadImageURL{
    
    NSString *urlString = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN_HeadImageURLString];
    return urlString;
}

//返回裁剪区域图片,返回还是原图大小,除图片以外区域清空
+ (UIImage *)clipWithImageRect:(CGRect)imageRect clipRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

{
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0);
    // 设置裁剪区域
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:clipRect];
    
    [path addClip];
    
    // 绘制图片
    
    [clipImage drawInRect:clipRect];
    
    // 获取当前图片
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//一般选用这个
//返回裁剪区域图片,返回裁剪区域大小图片
+ (UIImage *)clipWithImageRect:(CGRect)clipRect clipImage:(UIImage *)clipImage;

{
    
    UIGraphicsBeginImageContext(clipRect.size);
    
    [clipImage drawInRect:CGRectMake(0,0,clipRect.size.width,clipRect.size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  newImage;
    
}
+ (NSString *)getPath: (NSString *)fileName {
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), fileName];
    return path;
    
}

+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

+ (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fKB",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fMB",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fGB",aFloat];
    }
}
//文件字节大小(单位：M)
+ (double)fileSize:(NSInteger)size{
    double aFloat = size/(1024*1024);
    return aFloat;
}
+(CGSize)calcTextSize:(NSString *) text Size:(CGFloat) size{
    NSDictionary *attributeDic = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize contraintSize = CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX);
    return [text boundingRectWithSize:contraintSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size;
}

//判断两个color是否相同
+(BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor
{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor))
    {
        NSLog(@"颜色相同");
        return YES;
    }
    else
    {
        NSLog(@"颜色不同");
        return NO;
    }
}
//画虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
+ (void)cleanCacheAndCookie{
    
    //清除cookies
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
}
+ (UIViewController *)currentViewController
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    if ([vc isKindOfClass:[YHTabBarViewController class]])
    {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]])
    {
        vc = [(UINavigationController *)vc visibleViewController];
    }
    
    return vc;
}

+ (UINavigationController *)currentNavigationController
{
    return [self currentViewController].navigationController;
}
+ (void)clearChatFMDB{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    NSString *fileName=[NSString stringWithFormat:@"%@/%@_chat",doc,userID];
    [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
}
@end
