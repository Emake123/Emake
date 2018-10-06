//
//  OSSClient.m
//  emake
//
//  Created by apple on 2017/8/23.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "OSSClientLike.h"
#import <AliyunOSSiOS/OSSService.h>


@interface OSSClientLike(){
    
    OSSClient * client;
}
@end

@implementation OSSClientLike


+(OSSClientLike *)sharedClient{

    static OSSClientLike *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[OSSClientLike alloc] init];
    });
    [handler initOSSClient];
    return handler;
}
- (void)initOSSClient{
    
    id<OSSCredentialProvider> credential = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:@"PrEtbqO724fBsVSw8spLWtSPpaJclM"];
        if (signature != nil) {
            *error = nil;
        } else {
            // construct error object
            *error = [NSError errorWithDomain:@"<your error domain>" code:OSSClientErrorCodeSignFailed userInfo:nil];
            return nil;
        }
        return [NSString stringWithFormat:@"OSS %@:%@", @"LTAIGYyQ8ZKKH72N", signature];
    }];
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];
}

- (void)uploadObjectAsync:(UIImage *)uploadImage withFileName:(NSString *)fileName succcessBlock:(void(^)())success failBLock:(void(^)())failBlock{
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"img-emake-cn";
    put.objectKey = [NSString stringWithFormat:@"images/%@.png",fileName];
    NSData *data = UIImageJPEGRepresentation(uploadImage, 1.0);
    if (data.bytes) {
        if ([Tools fileSize:data.length] <0.3) {
            NSLog(@"图片小");
            put.uploadingData = UIImageJPEGRepresentation(uploadImage, 1.0);
        }else{
            NSLog(@"图片大");
            float pressValue = 0.3 / [Tools fileSize:data.length];
            put.uploadingData = UIImageJPEGRepresentation(uploadImage, pressValue);
        }
    }
    OSSTask * putTask = [client putObject:put];
    
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            
            NSLog(@"upload object success!");
        
            success();
            
        } else {
            
            failBlock();
            
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];


}

- (void)uploadVoiceObjectAsync:(NSString *)uploadPath withFileName:(NSString *)fileName andType:(OSSUploadType)type succcessBlock:(void(^)())success failBLock:(void(^)())failBlock{
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"voi-emake-cn";
//    put.objectKey = [NSString stringWithFormat:@"mqtt/%@.m4a",fileName];
    put.objectKey = [NSString stringWithFormat:@"mqtt/%@",fileName];

    put.contentType = @"media-type";
    put.uploadingData = [NSData dataWithContentsOfFile:uploadPath];
    //    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
    //        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    //    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
            success();
        } else {
            failBlock();
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
    
}


- (void)uploadFileObjectAsync:(NSData *)uploadData withFileName:(NSString *)fileName andType:(OSSUploadType)type succcessBlock:(void(^)())success failBLock:(void(^)())failBlock{
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    put.bucketName = @"voi-emake-cn";
    put.objectKey = [NSString stringWithFormat:@"files/%@",fileName];
    put.uploadingData = uploadData;
    //    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
    //        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    //    };
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        NSLog(@"objectKey: %@", put.objectKey);
        if (!task.error) {
            NSLog(@"upload object success!");
            success();
        } else {
            failBlock();
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];
    
}

- (void)downloadFileObjectAsyncWithFileName:(NSString *)fileName andDownloadTargetFile:(NSString *)downLoadFile succcessBlock:(void(^)())success failBLock:(void(^)())failBlock{
    
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    request.bucketName = @"voi-emake-cn";
    request.objectKey = [NSString stringWithFormat:@"files/%@",fileName];
    request.downloadToFileURL = [NSURL fileURLWithPath:downLoadFile];
    OSSTask * getTask = [client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult * getResult = task.result;
            NSLog(@"download result: %@", getResult.downloadedData);
            success();
        } else {
            failBlock();
            NSLog(@"download object failed, error: %@" ,task.error);
        }
        return nil;
    }];
}
@end
