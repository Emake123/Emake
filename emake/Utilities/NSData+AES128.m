#import "NSData+AES128.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (AES128)

-(NSData *) PSAESEncryptWithKey:(NSString *) key
{
    NSUInteger dataLength = [self length];
    //NSLog(@"%lu",(unsigned long) dataLength);
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    char keyPtr[kCCKeySizeAES128 + 1];
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode,keyPtr, kCCKeySizeAES128, NULL,[self bytes], dataLength ,  buffer, bufferSize,  &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        //NSLog(@"%lu",(unsigned long) numBytesEncrypted);
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

-(NSData *) PSAESDecryptWithKey:(NSString *) key
{
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    char keyPtr[kCCKeySizeAES128 + 1];
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionECBMode,keyPtr, kCCKeySizeAES128, NULL,[self bytes], dataLength,  buffer, bufferSize,  &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    free(buffer);
    return nil;
}


@end
