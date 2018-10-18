//
//  WSIconView.m
//  微信九宫格头像
//
//  Created by iMac on 16/11/8.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "WSIconView.h"
#import "UIImageView+WebCache.h"
//#import <SVGKit/SVGKit.h>
//#import "WXApi.h"
#import <SVGKit/SVGKit.h>
#import "chatUserModel.h"
@implementation WSIconView


-(void)setImages:(NSArray<NSDictionary *> *)images{
    
    //删除旧的图片
    for (UIView *view  in self.subviews) {
        [view removeFromSuperview];
    }
    
    switch (images.count) {
        case 0:
            [self NoneCount];
            break;
        case 1:
            [self oneCount:images.firstObject];
            break;
        case 2:
            [self twoCount:images];
            break;
        case 3:
            [self threeCount:images];
            break;
        case 4:
            [self fourCount:images];
            break;
        case 5:
            [self fiveCount:images];
            break;
        case 6:
            [self sixCount:images];
            break;
        case 7:
            [self sevenCount:images];
            break;
        case 8:
            [self eightCount:images];
            break;
        case 9:
            [self nineCount:images];
            break;
            
        default:
            break;
    }
    
}
//检验字符串
- (BOOL)checkStr:(NSString *)str{
    if(![str isKindOfClass:[NSString class]])return NO;
    if(!str)return NO;
    return  YES;
}
//创建一个图片view
- (void)viewWithImage:(NSDictionary *)dict fram:(CGRect)frame{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.layer.borderWidth = 1;
    imageV.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:imageV];
    chatUserModel *model = [chatUserModel mj_objectWithKeyValues:dict];
    NSArray *part = [model.ClientID componentsSeparatedByString:@"/"];
    if (part.count == 3) {
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.Avatar] placeholderImage:[SVGKImage imageNamed:@"dianpuicon_yuan"].UIImage];
    }else{
        if ([model.ClientID containsString:@"customer/"]) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.Avatar] placeholderImage:[UIImage imageNamed:@"kefu_logo"]];
        }else{
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.Avatar] placeholderImage:[UIImage imageNamed:@"guanfangkefu"]];
        }
    }
}
- (void)NoneCount{
    [self viewWithImage:@"" fram:self.bounds];
}
//1张图
- (void)oneCount:(NSDictionary *)url{
    [self viewWithImage:url fram:self.bounds];
}

//2张图
- (void)twoCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) * 0.5;
    CGFloat x = 0;
    CGFloat y = w * 0.5;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        x = i * w;
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//3张图
- (void)threeCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) * 0.5;
    CGFloat x = w * 0.5;
    CGFloat y = 0;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        if(i){
            y = w;
            x = (i - 1) * w;
        }
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//4张图
- (void)fourCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) * 0.5;
    CGFloat x = 0;
    CGFloat y = 0;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        x = (i % 2) * w;
        y = (i / 2) * w;
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//5张图
- (void)fiveCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) / 3;
    CGFloat x = 0;
    CGFloat y = w * 0.5;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        if(i < 2){
            x = w * 0.5 + w * i;
        }else{
            y = w * 0.5 + w;
            x = w * (i -2);
        }
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//6张图
- (void)sixCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) / 3;
    CGFloat x = 0;
    CGFloat y = w * 0.5;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        x = (i % 3) * w;
        y = (i / 3) * w + w * 0.5;
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//7张图
- (void)sevenCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) / 3;
    CGFloat x = 0;
    CGFloat y = 0;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        if(i){
            x = ((i - 1) % 3) * w;
            y = ((i - 1) / 3) * w + w;
        }else{
            x = w;
        }
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//8张图
- (void)eightCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) / 3;
    CGFloat x = 0;
    CGFloat y = 0;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        if(i > 1){
            x = ((i - 2) % 3) * w;
            y = ((i - 2) / 3) * w + w;
        }else{
            x = w * 0.5 + w * i;
        }
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}

//9张图
- (void)nineCount:(NSArray *)urls{
    CGFloat w = CGRectGetWidth(self.bounds) / 3;
    CGFloat x = 0;
    CGFloat y = 0;
    NSDictionary *url  = nil;
    for (int i = 0; i < urls.count;i++) {
        
        x = (i % 3) * w;
        y = (i / 3) * w;
        
        url = urls[i];
        [self viewWithImage:url fram:CGRectMake(x, y, w, w)];
    }
}




@end
